# -*- coding: utf-8 -*-
#
# Copyright (C) 2022 Diego Valverde
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

import collections

from . import funky_ast

try:
    from lark import Lark, Transformer
except ImportError:
    import lark, Transformer


def flatten(x):
    if isinstance(x, collections.Iterable):
        return [a for i in x for a in flatten(i)]
    else:
        return [x]


def remove_invalid(l):
    return [x for x in l if x is not None]


class TreeToAst(Transformer):

    def __init__(self, funk, debug=False):
        self.funk = funk
        self.debug = debug
        self.function_map = {}
        self.function_definition_list = []

    def statement(self, token):
        if self.debug:
            print('--Debug-- statement', token)
        return token

    def parse_function_firm(self, firm):
        if len(firm) == 0:
            return None, None, None, None

        fn_arguments = []
        tail_pairs = []
        pattern_matches = []
        position = 0
        preconditions = None

        if isinstance(firm[-1], funky_ast.BinaryOp):
            preconditions = firm[-1]
            firm.pop()

        for arg in firm:
            if isinstance(arg, funky_ast.IntegerConstant) or isinstance(arg, funky_ast.DoubleConstant):
                arg = funky_ast.PatternMatchLiteral(self.funk, arg, position=position)

            if isinstance(arg, funky_ast.HeadTail):
                fn_arguments.append({'val': arg.head, 'pos': position})
                tail_pairs.append({'head': arg.head, 'tail': arg.tail, 'pos': position})
            elif isinstance(arg, funky_ast.PatternMatch):
                fn_arguments.append({'val': '_', 'pos': position})
                arg.position = position
                pattern_matches.append({'val':arg, 'pos': position})
            elif isinstance(arg, funky_ast.CompileTimeExprList):
                pattern_matches.append(
                    {'val': funky_ast.PatternMatchListOfIdentifiers(self.funk, arg.elements, position), 'pos': position})
            else:
                fn_arguments.append({'val': arg.name, 'pos': position})

            position += 1

        return fn_arguments, pattern_matches, tail_pairs, preconditions

    def function(self, tree):
        fn_name = tree[0].name

        special_fns = ['main', 'sdl_render']
        firm = remove_invalid(flatten(tree[1]))
        fn_arguments, pattern_matches, tail_pairs, preconditions = self.parse_function_firm(firm)
        fn_body = flatten(tree[2])
        function_key = fn_name

        clause = funky_ast.FunctionClause(self.funk, function_key, fn_body, preconditions, pattern_matches,
                                          arguments=fn_arguments, tail_pairs=tail_pairs, arity=len(firm))

        if fn_name in special_fns:
            self.function_map[function_key] = funky_ast.FunctionMap(self.funk, function_key)
            self.function_definition_list.append(function_key)
        else:
            if function_key not in self.function_map:
                self.function_definition_list.append(function_key)
                self.function_map[function_key] = funky_ast.FunctionMap(self.funk, function_key)

        self.function_map[function_key].clauses.append(clause)

    def fn_precondition(self, token):
        return token

    @staticmethod
    def function_body(token):
        return token

    @staticmethod
    def return_statement(token):
        return token[0]

    def function_call(self, token):
        if len(token) == 2:
            if isinstance(token[1], funky_ast.FunctionCall) or isinstance(token[1], funky_ast.ArrayElement):
                token[1].name = token[0].name
                return token[1]
        else:
            return token[0]

    def action_function_call_args(self, args):
        row, col = -1,-1
        if len(args) > 0 and isinstance(args[0], funky_ast.Identifier):
            row = args[0].row
            col = args[0].col
        return funky_ast.FunctionCall(self.funk, '<un-named>', flatten(args), row=row, col=col)

    def expr__(self, token):
        return flatten(token)

    def expr_handler(self, token):
        children = remove_invalid(flatten(token))

        if len(children) == 2:
            lhs = children[0]
            rhs_expr = children[1]
            rhs_expr.left = lhs
            return rhs_expr
        else:
            return children[0]

    def action_list_element(self, token):

        return self.expr_handler(token)

    def action_match_identifier(self, token):
        if len(token) == 1:
            return token[0]
        else:
            return token

    def action_match_literal(self, token):
        return funky_ast.PatternMatchLiteral(self.funk, token[0])

    def action_firm_element(self, token):
        token = remove_invalid(flatten(token))
        if len(token) == 2:
            return funky_ast.HeadTail(self.funk, head=token[0], tail=token[1])
        else:
            return self.expr_handler(token)

    def action_pop_list_head(self, token):
        return token[0]

    def action_no_function_args(self, token):
        return []

    def action_match_empty_list(self, token):
        return funky_ast.PatternMatchEmptyList(self.funk)

    def expr(self, token):
        return self.expr_handler(token)

    def boolean_expr(self, token):

        return self.expr_handler(token)

    def arith_mul(self, children):
        rhs = children[0]
        return funky_ast.Mul(self.funk, None, rhs)

    def bin_op(self, token, ast_op):
        children = remove_invalid(flatten(token))

        if len(children) == 0:
            return None
        elif len(children) == 1:
            return ast_op(self.funk, None, children[0])
        elif len(children) == 2:
            children[1].left = children[0]
            return ast_op(self.funk, None, children[1])
        elif len(children) == 3:
            children[2].left = children[1]
            return [children[0], ast_op(self.funk, None, children[2])]
        else:
            return None

    def action_push_at_tail(self, tokens):
        return funky_ast.ListConcatTail(self.funk, left=tokens[0], right=tokens[1])

    def action_list_union(self, tokens):
        return funky_ast.ListUnion(self.funk, left=tokens[0], right=tokens[1])

    def action_list_difference(self, tokens):
        return funky_ast.ListDifference(self.funk, left=tokens[0], right=tokens[1])

    def action_arith_sub(self, token):
        return self.bin_op(token, funky_ast.Sub)

    def action_arith_add(self, token):
        return self.bin_op(token, funky_ast.Sum)

    def action_arith_div(self, token):
        return self.bin_op(token, funky_ast.Div)

    def action_arith_mul(self, token):
        return self.bin_op(token, funky_ast.Mul)

    def action_arith_mod(self, token):
        return self.bin_op(token[0], funky_ast.Mod)

    def action_assignment(self, children):
        if len(children) != 2:
            raise Exception('Malformed assignment statement')

        lhs, rhs = children

        if isinstance(lhs, funky_ast.List):
            rhs.left = lhs
            rhs.direction = funky_ast.ListConcat.tail
        else:
            rhs.left = lhs

        return rhs

    def action_assignment_lhs(self, tokens):
        return tokens[0]

    def action_lhs_assignment(self, children):
        """
        lhs <- expr
        """
        rhs = children[0]
        return funky_ast.Assignment(self.funk, None, rhs)

    def action_nested_list(self, children):
        return children

    def action_list_concat_lsh(self, children):
        lhs = flatten(children)

        return funky_ast.List(self.funk, '[]', lhs)

    def action_list_concat_rhs(self, children):
        if len(children) != 2:
            raise Exception('Malformed list concatenation statement')

        return funky_ast.ListConcat(self.funk, left=children[0], right=children[1])

    def action_bool_and(self, tokens):
        if len(tokens) > 1:
            for i in range(1, len(tokens)):
                tokens[i].left = tokens[i - 1]

        return funky_ast.And(self.funk, right=tokens[-1])

    def action_bool_or(self, tokens):

        if len(tokens) > 1:
            for i in range(1, len(tokens)):
                tokens[i].left = tokens[i - 1]

        return funky_ast.Or(self.funk, right=tokens[-1])

    def action_bool_mod(self, token):
        # Note: this returns an integer (not a TNode)
        return funky_ast.Mod(self.funk, right=token[0])

    def action_bool_lt(self, token):
        if len(token) == 2:
            return funky_ast.LessThan(self.funk, left=token[0], right=token[1])
        else:
            return funky_ast.LessThan(self.funk, right=token[0])

    def action_bool_ge(self, token):
        if len(token) == 2:
            return funky_ast.GreaterOrEqualThan(self.funk, left=token[0], right=token[1])
        else:
            return funky_ast.GreaterOrEqualThan(self.funk, right=token[0])

    def action_bool_gt(self, token):
        if len(token) == 2:
            return funky_ast.GreaterThan(self.funk, left=token[0], right=token[1])
        else:
            return funky_ast.GreaterThan(self.funk, right=token[0])

    def action_bool_eq(self, token):
        if len(token) == 2:
            return funky_ast.EqualThan(self.funk, left=token[0], right=token[1])
        else:
            return funky_ast.EqualThan(self.funk, right=token[0])

    def action_bool_neq(self, token):
        if len(token) == 2:
            return funky_ast.NotEqualThan(self.funk, left=token[0], right=token[1])
        else:
            return funky_ast.NotEqualThan(self.funk, right=token[0])

    def action_rhs_bool_factor(self, token):
        if len(token) == 2 and isinstance(token[1], funky_ast.BinaryOp):

            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def action_include_external_function(self, token):
        Identifiers = remove_invalid(flatten(token))
        functions = []
        for fn in Identifiers:
            function = fn.name
            functions.append(function)
            fn_symbol = '@{}'.format(function)
            self.funk.functions.append(fn_symbol)
            self.funk.symbol_table[fn_symbol] = funky_ast.ExternalFunction(self.funk, fn_symbol)

        return funky_ast.Include(self.funk, functions)

    def more_extern_funcs(self, token):
        return token

    def boolean_binary_term(self, token):

        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def array_index(self, token):
        t = flatten(token)
        return funky_ast.ArrayElement(self.funk, '', t[0])

    def expr_rhs(self, tokens):
        if len(tokens) == 1:
            return tokens[0]
        else:
            return None

    def create_list(self, elements):
        if isinstance(elements, collections.Iterable) and len(elements) == 1 and isinstance(elements[0],
                                                                                            collections.Iterable):
            return [funky_ast.CompileTimeExprList(self.funk, 'anon', self.create_list(elements[0]))]
        else:
            return [funky_ast.CompileTimeExprList(self.funk, 'anon', elements)]

    def list(self, tokens):
        elements = tokens[0] if len(tokens) > 0 else []
        x = self.create_list(elements)
        return x

    @staticmethod
    def list_elements(token):
        return flatten(token)

    @staticmethod
    def list_initialization(token):
        return token[0]

    @staticmethod
    def fn_firm_args(token):
        return token

    @staticmethod
    def more_list_elements(token):
        return token

    @staticmethod
    def more_fn_firm_elements(token):
        return token

    @staticmethod
    def boolean_binary_term_(self, token):
        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    @staticmethod
    def bool_factor(self, token):
        return token[0]

    def factor(self, token):
        return token[0]

    def ext_fn_call_arguments(self, token):
        return flatten(token)

    def fn_call_arguments(self, token):
        return token[0]

    def term(self, children):
        if len(children) == 2:
            lhs = children[0]
            rhs_expr = children[1]
            rhs_expr.left = lhs
            return rhs_expr
        else:
            return children[0]

    def term_(self, children):
        return children[0]

    def identifier(self, token):
        return funky_ast.Identifier(self.funk, token[0].value, row=token[0].line, col=token[0].column)

    def string(self, token):
        return funky_ast.String(self.funk, token[0])

    def number(self, token):
        token[1].sign = token[0]
        return token[1]

    def action_indexed_array(self, tokens):
        tokens = flatten(tokens)

        variable = tokens.pop(0)
        if len(tokens) >= 2 and isinstance(tokens[1], funky_ast.Range) and tokens[1].left is None:
            tokens[1].left = tokens[0]
            tokens.pop(0)

        variable.indexes = tokens
        return variable

    def action_sign_negative(self, token):
        return -1

    def action_sign_positive(self, token):
        return 1

    def action_float_constant(self, token):
        return funky_ast.DoubleConstant(self.funk, token[0].value)

    def action_int_constant(self, token):
        return funky_ast.IntegerConstant(self.funk, token[0].value)

    def action_range_exclusive_rhs(self, token):
        return funky_ast.Range(self.funk, rhs=token[0], rhs_type='<')

    def action_range_inclusive_rhs(self, token):
        return funky_ast.Range(self.funk, rhs=token[0], rhs_type='<=')

    def action_auto_range(self, token):
        return funky_ast.Range(self.funk, rhs=token[0], rhs_type=':')

    def action_inclusive_range_lhs(self, token):
        identifier = token[0]
        inclusive_range = token[1]
        inclusive_range.identifier = identifier
        inclusive_range.lhs_type = '<='
        return inclusive_range

    def action_exclusive_range_lhs(self, token):
        identifier = token[0]
        exclusive_range = token[1]
        exclusive_range.identifier = identifier
        exclusive_range.lhs_type = '<'
        return exclusive_range

    def action_list_comprehension_range(self, token):
        expr = token[0]
        my_range = token[1]
        my_range.left = expr
        return my_range

    def list_comprehension_range_rhs(self, token):
        return token[0]

    def action_list_comprehension(self, token):
        """
        [expr | 0 <= i <= x , x % 2 == 0]
        """
        token[1].expr = token[0]
        return token[1].eval()

    def action_range(self, tokens):
        tokens = flatten(tokens)
        if len(tokens) == 0: return tokens

        return [self.bin_op(tokens[0], funky_ast.Range)] + tokens[1:]

    def action_comma_separated_list_element(self, tokens):
        tokens = flatten(tokens)
        if len(tokens) < 2:
            return tokens

        if isinstance(tokens[1], funky_ast.Range):
            tokens[1].left = tokens[0]
            return tokens[1:]
        else:
            return tokens
