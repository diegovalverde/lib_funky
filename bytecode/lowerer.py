from .model import DecodedBytecode, FunctionBytecode, Instruction, OpCode


BUILTIN_ID_BY_OP = {
    "Sum": 20,
    "Sub": 21,
    "Mul": 22,
    "Div": 23,
    "Mod": 24,
    "EqualThan": 25,
    "NotEqualThan": 26,
    "LessThan": 27,
    "LessOrEqualThan": 28,
    "GreaterThan": 29,
    "GreaterOrEqualThan": 30,
    "And": 31,
    "Or": 32,
    "ListConcat": 41,
    "ListUnion": 42,
    "ListConcatTail": 43,
    "ListDifference": 44,
}

BUILTIN_ID_BY_CALL = {
    "say": 2,
    "exit": 3,
    "rand_int": 50,
    "rand_float": 51,
    "not": 33,
    "neg": 34,
    "infinity": 35,
    "len": 36,
    "abs": 37,
    "reshape": 45,
    "fread_list": 46,
    "sum": 38,
    "flatten": 39,
}

BUILTIN_ID_SLICE = 40
BUILTIN_ID_IS_LIST = 47
BUILTIN_ID_TAIL = 48
BUILTIN_ID_LIST_SIZE = 49
HOST_CALL_BY_NAME = {
    "sdl_simple": "s2d.sdl_simple",
}


class LoweringUnsupported(Exception):
    pass


class BytecodeLowerer:
    def __init__(self, funk):
        self.funk = funk
        self.function_sigs = []
        for name, fn_map in funk.function_map.items():
            arities = sorted({clause.arity for clause in fn_map.clauses})
            for arity in arities:
                self.function_sigs.append((name, arity))
        self.function_sigs = sorted(self.function_sigs)
        self.function_id = {sig: idx for idx, sig in enumerate(self.function_sigs)}
        self.strings = []
        self.string_id = {}

    def lower_program(self):
        functions = []
        for name, arity in self.function_sigs:
            fn_map = self.funk.function_map[name]
            try:
                functions.append(self._lower_function(name, arity, fn_map))
            except LoweringUnsupported as exc:
                functions.append(self._trap_function(name, arity, fn_map, str(exc)))

        if len(functions) == 0:
            trap_idx = self._intern_string("no functions available")
            functions.append(
                FunctionBytecode(
                    name="<empty>",
                    arity=0,
                    captures=0,
                    code=[Instruction(op=OpCode.TRAP, arg=trap_idx)],
                )
            )
            entry_fn = 0
        else:
            entry_fn = self.function_id.get(("main", 0), 0)

        return DecodedBytecode(strings=self.strings, functions=functions, entry_fn=entry_fn)

    def _lower_function(self, name, target_arity, fn_map):
        if len(fn_map.clauses) == 0:
            raise LoweringUnsupported("function has no clauses")

        code = []
        for clause in fn_map.clauses:
            if clause.check_arity:
                if clause.arity != target_arity:
                    continue
            elif target_arity < clause.arity:
                continue
            self._validate_clause_for_lowering(clause)
            self._next_local = target_arity
            locals_by_name = self._clause_locals(clause)
            fail_jumps = self._emit_clause_checks(code, clause, locals_by_name)

            for stmt in clause.body[:-1]:
                self._lower_statement(code, locals_by_name, stmt)

            self._lower_expr(code, locals_by_name, clause.body[-1])
            code.append(Instruction(op=OpCode.RETURN))

            next_ip = len(code)
            for jump_ins in fail_jumps:
                jump_ins.arg = next_ip

        trap_idx = self._intern_string("function '{}': no clause matched".format(name))
        code.append(Instruction(op=OpCode.TRAP, arg=trap_idx))
        return FunctionBytecode(
            name="{}#{}".format(name, target_arity),
            arity=target_arity,
            captures=0,
            code=code,
        )

    def _validate_clause_for_lowering(self, clause):
        if clause.fill_etc:
            raise LoweringUnsupported("etc argument expansion is not lowered yet")
        if len(clause.body) == 0:
            raise LoweringUnsupported("empty function body")
        if clause.pattern_matches not in (None, []):
            for pm_entry in clause.pattern_matches:
                pm = pm_entry["val"]
                pm_type = type(pm).__name__
                if pm_type == "PatternMatchLiteral":
                    if not isinstance(pm.value, (int, float, bool)):
                        raise LoweringUnsupported("literal pattern must be int/float/bool")
                elif pm_type == "PatternMatchEmptyList":
                    continue
                elif pm_type == "PatternMatchListOfIdentifiers":
                    elements = getattr(pm, "elements", None)
                    if elements is None:
                        raise LoweringUnsupported("list pattern missing elements")
                    for element in elements:
                        elem_type = type(element).__name__
                        if elem_type not in (
                            "Identifier",
                            "IntegerConstant",
                            "DoubleConstant",
                            "Boolean",
                        ):
                            raise LoweringUnsupported(
                                "list pattern elements must be identifiers or numeric/bool literals"
                            )
                else:
                    raise LoweringUnsupported(
                        "only literal/empty-list/list-id pattern matches are lowered"
                    )

    def _clause_locals(self, clause):
        locals_by_name = {}
        for arg in clause.arguments:
            arg_name = arg["val"]
            if arg_name == "_":
                continue
            if arg_name in locals_by_name:
                raise LoweringUnsupported("duplicate argument names are not supported")
            locals_by_name[arg_name] = arg["pos"]
        return locals_by_name

    def _emit_clause_checks(self, code, clause, locals_by_name):
        fail_jumps = []
        pattern_entries = clause.pattern_matches if clause.pattern_matches else []
        for pm_entry in pattern_entries:
            pm = pm_entry["val"]
            pm_type = type(pm).__name__
            if pm_type == "PatternMatchEmptyList":
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_IS_LIST, argc=1))
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_LIST_SIZE, argc=1))
                code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=25, argc=2))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=31, argc=2))
            elif pm_type == "PatternMatchListOfIdentifiers":
                elements = getattr(pm, "elements", [])
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_IS_LIST, argc=1))
                fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
                code.append(fail_jump)
                fail_jumps.append(fail_jump)

                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_LIST_SIZE, argc=1))
                code.append(Instruction(op=OpCode.PUSH_INT, arg=len(elements)))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=25, argc=2))

                for elem_idx, element in enumerate(elements):
                    elem_type = type(element).__name__
                    code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                    code.append(Instruction(op=OpCode.PUSH_INT, arg=elem_idx))
                    code.append(Instruction(op=OpCode.GET_INDEX))
                    if elem_type == "Identifier":
                        name = element.name
                        if name == "_":
                            code.append(Instruction(op=OpCode.POP))
                            continue
                        slot = locals_by_name.get(name)
                        if slot is None:
                            slot = self._alloc_local()
                            locals_by_name[name] = slot
                        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=slot))
                        continue

                    if elem_type == "IntegerConstant":
                        code.append(
                            Instruction(op=OpCode.PUSH_INT, arg=element.sign * int(element.value))
                        )
                    elif elem_type == "DoubleConstant":
                        code.append(
                            Instruction(op=OpCode.PUSH_FLOAT, arg=element.sign * float(element.value))
                        )
                    elif elem_type == "Boolean":
                        code.append(Instruction(op=OpCode.PUSH_BOOL, arg=element.value))
                    else:
                        raise LoweringUnsupported("unsupported list pattern element type")
                    code.append(Instruction(op=OpCode.CALL_BUILTIN, id=25, argc=2))
                    lit_fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
                    code.append(lit_fail_jump)
                    fail_jumps.append(lit_fail_jump)
            else:
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pm.position))
                if isinstance(pm.value, bool):
                    code.append(Instruction(op=OpCode.PUSH_BOOL, arg=pm.value))
                elif isinstance(pm.value, int):
                    code.append(Instruction(op=OpCode.PUSH_INT, arg=pm.value))
                elif isinstance(pm.value, float):
                    code.append(Instruction(op=OpCode.PUSH_FLOAT, arg=pm.value))
                else:
                    raise LoweringUnsupported("unsupported literal pattern type")
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=25, argc=2))
            fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(fail_jump)
            fail_jumps.append(fail_jump)

        for pair in clause.tail_pairs:
            pos = pair["pos"]
            head_name = pair["head"]
            tail_name = pair["tail"]

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pos))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_IS_LIST, argc=1))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pos))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_LIST_SIZE, argc=1))
            code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=29, argc=2))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=31, argc=2))
            fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(fail_jump)
            fail_jumps.append(fail_jump)

            if tail_name != "_":
                tail_slot = locals_by_name.get(tail_name)
                if tail_slot is None:
                    tail_slot = self._alloc_local()
                    locals_by_name[tail_name] = tail_slot
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pos))
                code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_TAIL, argc=1))
                code.append(Instruction(op=OpCode.STORE_LOCAL, arg=tail_slot))

            if head_name != "_":
                head_slot = locals_by_name.get(head_name)
                if head_slot is None or head_slot == pos:
                    head_slot = self._alloc_local()
                locals_by_name[head_name] = head_slot
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=pos))
                code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
                code.append(Instruction(op=OpCode.GET_INDEX))
                code.append(Instruction(op=OpCode.STORE_LOCAL, arg=head_slot))

        if clause.preconditions is not None:
            self._lower_expr(code, locals_by_name, clause.preconditions)
            fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(fail_jump)
            fail_jumps.append(fail_jump)
        return fail_jumps

    def _alloc_local(self):
        slot = self._next_local
        self._next_local += 1
        return slot

    def _lower_statement(self, code, locals_by_name, stmt):
        type_name = type(stmt).__name__
        if type_name == "Assignment":
            if type(stmt.left).__name__ != "Identifier":
                raise LoweringUnsupported("only identifier assignment is lowered")
            name = stmt.left.name
            if name in locals_by_name:
                raise LoweringUnsupported("reassignment is not lowered yet")
            self._lower_expr(code, locals_by_name, stmt.right)
            slot = self._alloc_local()
            locals_by_name[name] = slot
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=slot))
            return

        self._lower_expr(code, locals_by_name, stmt)
        code.append(Instruction(op=OpCode.POP))
        return

    def _trap_function(self, name, target_arity, fn_map, reason):
        arity = target_arity
        trap_idx = self._intern_string("function '{}': {}".format(name, reason))
        return FunctionBytecode(
            name="{}#{}".format(name, arity),
            arity=arity,
            captures=0,
            code=[Instruction(op=OpCode.TRAP, arg=trap_idx)],
        )

    def _lower_expr(self, code, locals_by_name, expr):
        type_name = type(expr).__name__

        if type_name == "IntegerConstant":
            code.append(Instruction(op=OpCode.PUSH_INT, arg=expr.sign * int(expr.value)))
            return

        if type_name == "DoubleConstant":
            code.append(Instruction(op=OpCode.PUSH_FLOAT, arg=expr.sign * float(expr.value)))
            return

        if type_name == "Identifier":
            if expr.name in locals_by_name:
                slot = locals_by_name[expr.name]
            elif expr.name.startswith("anon_"):
                # List-comprehension lowering can surface internal iterator aliases.
                if "__range_iter" in locals_by_name:
                    slot = locals_by_name["__range_iter"]
                else:
                    raise LoweringUnsupported("identifier '{}' is unresolved".format(expr.name))
            elif any(sig_name == expr.name for sig_name, _ in self.function_sigs):
                code.append(Instruction(op=OpCode.PUSH_STRING, arg=self._intern_string(expr.name)))
                return
            else:
                raise LoweringUnsupported("identifier '{}' is unresolved".format(expr.name))
            if expr.indexes is None:
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=slot))
            else:
                indexes = [idx for idx in expr.indexes if idx is not None]
                if len(indexes) == 0:
                    code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=slot))
                else:
                    self._lower_identifier_indexes(code, locals_by_name, slot, indexes)
            return

        if type_name in BUILTIN_ID_BY_OP:
            if expr.left is None:
                raise LoweringUnsupported("{} missing left operand".format(type_name))
            self._lower_expr(code, locals_by_name, expr.left)
            self._lower_expr(code, locals_by_name, expr.right)
            code.append(
                Instruction(
                    op=OpCode.CALL_BUILTIN,
                    id=BUILTIN_ID_BY_OP[type_name],
                    argc=2,
                )
            )
            return

        if type_name == "FunctionCall":
            if expr.args is None:
                raise LoweringUnsupported("function call without args list is not supported")
            callee = expr.name
            if callee == "host_call":
                if len(expr.args) < 1:
                    raise LoweringUnsupported("host_call expects at least a host function string")
                host_name_expr = expr.args[0]
                if type(host_name_expr).__name__ != "String":
                    raise LoweringUnsupported("host_call first argument must be string literal")
                host_name = host_name_expr.fmt_str
                if host_name.startswith('"') and host_name.endswith('"') and len(host_name) >= 2:
                    host_name = host_name[1:-1]
                for arg in expr.args[1:]:
                    self._lower_expr(code, locals_by_name, arg)
                code.append(
                    Instruction(
                        op=OpCode.CALL_HOST,
                        arg=self._intern_string(host_name),
                        argc=len(expr.args) - 1,
                    )
                )
                return
            if callee in HOST_CALL_BY_NAME:
                for arg in expr.args:
                    self._lower_expr(code, locals_by_name, arg)
                code.append(
                    Instruction(
                        op=OpCode.CALL_HOST,
                        arg=self._intern_string(HOST_CALL_BY_NAME[callee]),
                        argc=len(expr.args),
                    )
                )
                return
            if callee == "len":
                if len(expr.args) != 1:
                    raise LoweringUnsupported("len expects exactly one argument")
                self._lower_expr(code, locals_by_name, expr.args[0])
                code.append(Instruction(op=OpCode.LEN))
                return
            if callee in BUILTIN_ID_BY_CALL:
                for arg in expr.args:
                    self._lower_expr(code, locals_by_name, arg)
                code.append(
                    Instruction(
                        op=OpCode.CALL_BUILTIN,
                        id=BUILTIN_ID_BY_CALL[callee],
                        argc=len(expr.args),
                    )
                )
                return
            if callee in locals_by_name:
                code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=locals_by_name[callee]))
                for arg in expr.args:
                    self._lower_expr(code, locals_by_name, arg)
                code.append(
                    Instruction(
                        op=OpCode.CALL_INDIRECT,
                        argc=len(expr.args),
                    )
                )
                return
            target_sig = (callee, len(expr.args))
            if target_sig not in self.function_id:
                raise LoweringUnsupported(
                    "call target '{}/{}' not in current module".format(callee, len(expr.args))
                )
            for arg in expr.args:
                self._lower_expr(code, locals_by_name, arg)
            code.append(
                Instruction(
                    op=OpCode.CALL_FN,
                    arg=self.function_id[target_sig],
                    argc=len(expr.args),
                )
            )
            return

        if type_name == "String":
            value = expr.fmt_str
            if value.startswith('"') and value.endswith('"') and len(value) >= 2:
                value = value[1:-1]
            code.append(Instruction(op=OpCode.PUSH_STRING, arg=self._intern_string(value)))
            return

        if type_name == "List":
            for element in expr.elements:
                self._lower_expr(code, locals_by_name, element)
            code.append(Instruction(op=OpCode.MK_LIST, argc=len(expr.elements)))
            return

        if type_name == "CompileTimeExprList":
            elements = [e for e in expr.elements if e is not None]
            if self._is_inline_range_literal_elements(elements):
                self._lower_inline_range_literal(
                    code,
                    locals_by_name,
                    start_expr=elements[0],
                    end_expr=elements[1].right,
                )
                return
            if len(elements) == 1 and type(elements[0]).__name__ in ("ExprRange", "Range"):
                if self._is_inline_range_literal_node(elements[0]):
                    self._lower_inline_range_literal(
                        code,
                        locals_by_name,
                        start_expr=elements[0].left,
                        end_expr=elements[0].right,
                    )
                    return
                self._lower_expr(code, locals_by_name, elements[0])
                return
            for element in elements:
                self._lower_expr(code, locals_by_name, element)
            code.append(Instruction(op=OpCode.MK_LIST, argc=len(elements)))
            return

        if type_name in ("ExprRange", "Range"):
            self._lower_range_comprehension(code, locals_by_name, expr)
            return

        raise LoweringUnsupported("expression '{}' is not lowered yet".format(type_name))

    def _emit_range_bounds(self, code, locals_by_name, rng):
        if rng.left is None:
            code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
        else:
            self._lower_expr(code, locals_by_name, rng.left)
        if rng.right is None:
            code.append(Instruction(op=OpCode.PUSH_INT, arg=-1))
        else:
            self._lower_expr(code, locals_by_name, rng.right)

    def _lower_identifier_indexes(self, code, locals_by_name, base_slot, indexes):
        idx = indexes[0]
        rest = indexes[1:]
        idx_type = type(idx).__name__

        if idx_type == "Range":
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=base_slot))
            self._emit_range_bounds(code, locals_by_name, idx)
            code.append(
                Instruction(
                    op=OpCode.CALL_BUILTIN,
                    id=BUILTIN_ID_SLICE,
                    argc=3,
                )
            )
            if len(rest) == 0:
                return

            sliced_slot = self._alloc_local()
            idx_slot = self._alloc_local()
            acc_slot = self._alloc_local()
            elem_slot = self._alloc_local()
            limit_slot = self._alloc_local()

            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=sliced_slot))
            code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.MK_LIST, argc=0))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=sliced_slot))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_LIST_SIZE, argc=1))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=limit_slot))

            loop_start = len(code)
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=limit_slot))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=27, argc=2))
            loop_exit = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(loop_exit)

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=sliced_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.GET_INDEX))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=elem_slot))

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
            self._lower_identifier_indexes(code, locals_by_name, elem_slot, rest)
            code.append(Instruction(op=OpCode.MK_LIST, argc=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_BY_OP["ListUnion"], argc=2))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.JUMP, arg=loop_start))

            loop_exit.arg = len(code)
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
            return

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=base_slot))
        self._lower_expr(code, locals_by_name, idx)
        code.append(Instruction(op=OpCode.GET_INDEX))
        if len(rest) == 0:
            return
        next_slot = self._alloc_local()
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=next_slot))
        self._lower_identifier_indexes(code, locals_by_name, next_slot, rest)

    def _lower_range_comprehension(self, code, locals_by_name, expr):
        iterator = expr.iterator_symbol if hasattr(expr, "iterator_symbol") else expr.identifier
        if iterator is None and hasattr(expr, "identifier"):
            iterator = expr.identifier
        if iterator is None and getattr(expr, "rhs_type", None) == ":":
            left = getattr(expr, "left", None)
            if type(left).__name__ == "Identifier":
                iterator = left
        if iterator is None or expr.expr is None:
            raise LoweringUnsupported("range expression without iterator body is not lowered yet")
        if expr.rhs_type == ":":
            if expr.right is None:
                raise LoweringUnsupported("iterator-list comprehension missing source expression")
            iterable_slot = self._alloc_local()
            idx_slot = self._alloc_local()
            elem_slot = self._alloc_local()
            limit_slot = self._alloc_local()
            acc_slot = self._alloc_local()

            self._lower_expr(code, locals_by_name, expr.right)
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=iterable_slot))
            code.append(Instruction(op=OpCode.PUSH_INT, arg=0))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=iterable_slot))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=BUILTIN_ID_LIST_SIZE, argc=1))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=limit_slot))
            code.append(Instruction(op=OpCode.MK_LIST, argc=0))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

            loop_start = len(code)
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=limit_slot))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=27, argc=2))
            loop_exit = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(loop_exit)

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=iterable_slot))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.GET_INDEX))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=elem_slot))

            body_locals = dict(locals_by_name)
            body_locals[iterator.name] = elem_slot
            self._bind_anon_iter_aliases(expr.expr, body_locals)

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
            self._lower_expr(code, body_locals, expr.expr)
            code.append(Instruction(op=OpCode.MK_LIST, argc=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=42, argc=2))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
            code.append(Instruction(op=OpCode.JUMP, arg=loop_start))

            loop_exit.arg = len(code)
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
            return
        if expr.left is None or expr.right is None:
            raise LoweringUnsupported("open-ended range comprehensions are not lowered yet")
        if expr.lhs_type not in ("<", "<=") or expr.rhs_type not in ("<", "<="):
            raise LoweringUnsupported("range comparator types are not lowered yet")

        start_slot = self._alloc_local()
        end_slot = self._alloc_local()
        idx_slot = self._alloc_local()
        acc_slot = self._alloc_local()

        # end_exclusive = right (+1 if rhs is <=)
        self._lower_expr(code, locals_by_name, expr.right)
        if expr.rhs_type == "<=":
            code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=end_slot))

        # start = left (+1 if lhs is <)
        self._lower_expr(code, locals_by_name, expr.left)
        if expr.lhs_type == "<":
            code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
            code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=start_slot))

        # idx = start
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=start_slot))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))

        # acc = []
        code.append(Instruction(op=OpCode.MK_LIST, argc=0))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

        loop_start = len(code)
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=end_slot))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=27, argc=2))
        loop_exit = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
        code.append(loop_exit)

        body_locals = dict(locals_by_name)
        for key in list(body_locals.keys()):
            if key.startswith("anon_"):
                del body_locals[key]
        iterator_names = set()
        if hasattr(expr, "iterator_symbol") and expr.iterator_symbol is not None:
            iterator_names.add(expr.iterator_symbol.name)
        if hasattr(expr, "identifier") and expr.identifier is not None:
            ident_name = expr.identifier.name
            if not ident_name.startswith("anon_") or not (
                hasattr(expr, "iterator_symbol") and expr.iterator_symbol is not None
            ):
                iterator_names.add(ident_name)
        if len(iterator_names) == 0:
            iterator_names.add(iterator.name)
        for name in iterator_names:
            if name in body_locals and body_locals[name] != idx_slot:
                continue
            body_locals[name] = idx_slot
        if "__range_iter" in locals_by_name:
            body_locals["__range_iter_outer"] = locals_by_name["__range_iter"]
        body_locals["__range_iter"] = idx_slot
        self._bind_anon_iter_aliases(expr.expr, body_locals)

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
        self._lower_expr(code, body_locals, expr.expr)
        code.append(Instruction(op=OpCode.MK_LIST, argc=1))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=42, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.JUMP, arg=loop_start))

        loop_exit.arg = len(code)
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))

    def _is_inline_range_literal_node(self, node):
        if type(node).__name__ not in ("Range", "ExprRange"):
            return False
        if getattr(node, "expr", None) is not None:
            return False
        if getattr(node, "identifier", None) is not None:
            return False
        if getattr(node, "iterator_symbol", None) is not None:
            return False
        return getattr(node, "left", None) is not None and getattr(node, "right", None) is not None

    def _is_inline_range_literal_elements(self, elements):
        if len(elements) != 2:
            return False
        tail = elements[1]
        if type(tail).__name__ not in ("Range", "ExprRange"):
            return False
        if getattr(tail, "expr", None) is not None:
            return False
        if getattr(tail, "identifier", None) is not None:
            return False
        if getattr(tail, "iterator_symbol", None) is not None:
            return False
        if getattr(tail, "left", None) is not None:
            return False
        return getattr(tail, "right", None) is not None

    def _lower_inline_range_literal(self, code, locals_by_name, start_expr, end_expr):
        if start_expr is None or end_expr is None:
            raise LoweringUnsupported("open-ended range literals are not lowered yet")

        start_slot = self._alloc_local()
        end_slot = self._alloc_local()
        idx_slot = self._alloc_local()
        acc_slot = self._alloc_local()

        self._lower_expr(code, locals_by_name, start_expr)
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=start_slot))
        self._lower_expr(code, locals_by_name, end_expr)
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=end_slot))

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=start_slot))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.MK_LIST, argc=0))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

        loop_start = len(code)
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=end_slot))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=28, argc=2))
        loop_exit = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
        code.append(loop_exit)

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.MK_LIST, argc=1))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=42, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=acc_slot))

        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.PUSH_INT, arg=1))
        code.append(Instruction(op=OpCode.CALL_BUILTIN, id=20, argc=2))
        code.append(Instruction(op=OpCode.STORE_LOCAL, arg=idx_slot))
        code.append(Instruction(op=OpCode.JUMP, arg=loop_start))

        loop_exit.arg = len(code)
        code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=acc_slot))

    def _bind_anon_iter_aliases(self, expr, locals_by_name):
        anon_names = self._collect_unbound_anon_names(expr, locals_by_name)
        if len(anon_names) == 0:
            return
        current = locals_by_name.get("__range_iter")
        outer = locals_by_name.get("__range_iter_outer")
        use_outer_first = outer is not None and len(anon_names) > 1
        for idx, name in enumerate(anon_names):
            if name in locals_by_name:
                continue
            if use_outer_first and idx == 0:
                locals_by_name[name] = outer
            elif current is not None:
                locals_by_name[name] = current

    def _collect_unbound_anon_names(self, expr, locals_by_name):
        names = []
        seen = set()

        def visit(node):
            if node is None:
                return
            node_type = type(node).__name__
            if node_type == "Identifier":
                name = node.name
                if name.startswith("anon_") and name not in locals_by_name and name not in seen:
                    seen.add(name)
                    names.append(name)
                if node.indexes is not None:
                    for idx_expr in node.indexes:
                        visit(idx_expr)
                return

            for field in ("left", "right", "expr", "identifier", "iterator_symbol"):
                if hasattr(node, field):
                    visit(getattr(node, field))
            if hasattr(node, "elements") and getattr(node, "elements") is not None:
                for element in node.elements:
                    visit(element)
            if hasattr(node, "args") and getattr(node, "args") is not None:
                for arg in node.args:
                    visit(arg)

        visit(expr)
        return names

    def _intern_string(self, s):
        if s in self.string_id:
            return self.string_id[s]
        idx = len(self.strings)
        self.strings.append(s)
        self.string_id[s] = idx
        return idx
