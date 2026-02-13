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
}

BUILTIN_ID_BY_CALL = {
    "say": 2,
    "neg": 34,
    "len": 36,
}


class LoweringUnsupported(Exception):
    pass


class BytecodeLowerer:
    def __init__(self, funk):
        self.funk = funk
        self.function_names = sorted(list(funk.function_map.keys()))
        self.function_id = {name: idx for idx, name in enumerate(self.function_names)}
        self.strings = []
        self.string_id = {}

    def lower_program(self):
        functions = []
        for name in self.function_names:
            fn_map = self.funk.function_map[name]
            try:
                functions.append(self._lower_function(name, fn_map))
            except LoweringUnsupported as exc:
                functions.append(self._trap_function(name, fn_map, str(exc)))

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
            entry_fn = self.function_id.get("main", 0)

        return DecodedBytecode(strings=self.strings, functions=functions, entry_fn=entry_fn)

    def _lower_function(self, name, fn_map):
        if len(fn_map.clauses) == 0:
            raise LoweringUnsupported("function has no clauses")

        code = []
        for clause in fn_map.clauses:
            self._validate_clause_for_lowering(clause)
            locals_by_name = self._clause_locals(clause)
            fail_jumps = self._emit_clause_checks(code, clause)

            next_local = clause.arity
            for stmt in clause.body[:-1]:
                next_local = self._lower_statement(code, locals_by_name, next_local, stmt)

            self._lower_expr(code, locals_by_name, clause.body[-1])
            code.append(Instruction(op=OpCode.RETURN))

            next_ip = len(code)
            for jump_ins in fail_jumps:
                jump_ins.arg = next_ip

        trap_idx = self._intern_string("function '{}': no clause matched".format(name))
        code.append(Instruction(op=OpCode.TRAP, arg=trap_idx))
        return FunctionBytecode(
            name=name,
            arity=fn_map.clauses[0].arity,
            captures=0,
            code=code,
        )

    def _validate_clause_for_lowering(self, clause):
        if len(clause.tail_pairs) > 0:
            raise LoweringUnsupported("head/tail patterns are not lowered yet")
        if len(clause.body) == 0:
            raise LoweringUnsupported("empty function body")
        if clause.pattern_matches not in (None, []):
            for pm_entry in clause.pattern_matches:
                pm = pm_entry["val"]
                if type(pm).__name__ != "PatternMatchLiteral":
                    raise LoweringUnsupported("only literal pattern matches are lowered")
                if not isinstance(pm.value, (int, float)):
                    raise LoweringUnsupported("literal pattern must be int/float")

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

    def _emit_clause_checks(self, code, clause):
        fail_jumps = []
        pattern_entries = clause.pattern_matches if clause.pattern_matches else []
        for pm_entry in pattern_entries:
            pm = pm_entry["val"]
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

        if clause.preconditions is not None:
            local_view = self._clause_locals(clause)
            self._lower_expr(code, local_view, clause.preconditions)
            fail_jump = Instruction(op=OpCode.JUMP_IF_FALSE, arg=0)
            code.append(fail_jump)
            fail_jumps.append(fail_jump)
        return fail_jumps

    def _lower_statement(self, code, locals_by_name, next_local, stmt):
        type_name = type(stmt).__name__
        if type_name == "Assignment":
            if type(stmt.left).__name__ != "Identifier":
                raise LoweringUnsupported("only identifier assignment is lowered")
            name = stmt.left.name
            if name in locals_by_name:
                raise LoweringUnsupported("reassignment is not lowered yet")
            self._lower_expr(code, locals_by_name, stmt.right)
            slot = next_local
            next_local += 1
            locals_by_name[name] = slot
            code.append(Instruction(op=OpCode.STORE_LOCAL, arg=slot))
            return next_local

        self._lower_expr(code, locals_by_name, stmt)
        code.append(Instruction(op=OpCode.POP))
        return next_local

    def _trap_function(self, name, fn_map, reason):
        arity = fn_map.clauses[0].arity if len(fn_map.clauses) > 0 else 0
        trap_idx = self._intern_string("function '{}': {}".format(name, reason))
        return FunctionBytecode(
            name=name,
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
            if expr.name not in locals_by_name:
                raise LoweringUnsupported("identifier '{}' is unresolved".format(expr.name))
            code.append(Instruction(op=OpCode.LOAD_LOCAL, arg=locals_by_name[expr.name]))
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
            if callee not in self.function_id:
                raise LoweringUnsupported("call target '{}' not in current module".format(callee))
            for arg in expr.args:
                self._lower_expr(code, locals_by_name, arg)
            code.append(
                Instruction(
                    op=OpCode.CALL_FN,
                    arg=self.function_id[callee],
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
            for element in elements:
                self._lower_expr(code, locals_by_name, element)
            code.append(Instruction(op=OpCode.MK_LIST, argc=len(elements)))
            return

        raise LoweringUnsupported("expression '{}' is not lowered yet".format(type_name))

    def _intern_string(self, s):
        if s in self.string_id:
            return self.string_id[s]
        idx = len(self.strings)
        self.strings.append(s)
        self.string_id[s] = idx
        return idx
