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


from . import funky_types
import collections
import copy
import re
from .sdl_extension import *


def list_concat_tail(funk, left, right, result=None):
    """
    This corresponds to:
        [MyArray] <~ x
    """
    ref = ''
    if result is None:
        result = funk.emitter.create_anon()
        ref = 'TData'

    L = left.eval()
    R = right.eval()

    funk.emitter.code += """
    {ref} {result} = {L};
    {result}.array.insert({result}.array.end(), {R});
    """.format(ref=ref, result=result, L=L, R=R)

    return result


def list_concat_head(funk, left, right, result=None):
    """
    This corresponds to:
        X ~> [MyArray]
    """
    ref = ''
    if result is None:
        result = funk.emitter.create_anon()
        ref = 'TData'
    L = left.eval()
    R = right.eval()

    funk.emitter.code += """
    // Concatenating head to array
    {ref} {result} = {R};
    {result}.array.insert({result}.array.begin(), {L});
    """.format(result=result, L=L, R=R, ref=ref)
    return result


def create_ast_anon_symbol(funk, right):
    if isinstance(right, IntegerConstant) or isinstance(right, DoubleConstant) or isinstance(right, String):
        anon = funk.emitter.create_anon()
        funk.emitter.create_variable(anon, right.eval())
        return anon
    else:
        return right.eval()


def check_symbol_definition(funk, arg):
    if not isinstance(arg, Identifier) and not isinstance(arg, FunctionCall):
        if isinstance(arg, Expression):
            return arg.check_undefined_variables_in_scope()
        return #arg.check_undefined_variables_in_scope()

    # ignore automatic variables
    if re.match('anon_\d+', arg.name) or arg.name == 'etc':
        return

    clause = funk.function_scope.current_function_clause

    # if it was in tail/head pair is fine
    if clause.tail_pairs is not None:
        if any([arg.name in [t['tail'] for t in clause.tail_pairs]]):
            return

    if clause.pattern_matches is not None:
        for pattern_match in [c['val'] for c in clause.pattern_matches]:
            if isinstance(pattern_match, PatternMatchLiteral):
                return

            if isinstance(pattern_match, PatternMatchListOfIdentifiers):
                if arg.name in [x.name for x in pattern_match.elements]:
                    return

    if isinstance(arg, Identifier):
        if arg.name not in clause.local_variables \
            and arg.name not in [c['val'] for c in clause.arguments] \
            and arg.name not in funk.functions \
            and '@{}'.format(arg.name) not in funk.functions:
            raise Exception(
                'row: {row} col: {col} variable \'{arg}\' was not declared in function \'{function_name}\''.format(
                    function_name=funk.function_scope.name, row=arg.row, col=arg.col, arg=arg.name
                ))
    elif isinstance(arg, FunctionCall) and arg.name not in arg.system_functions:
        if arg.name not in funk.functions \
            and '@{}'.format(arg.name) not in funk.functions \
            and arg.name not in [c['val'] for c in clause.arguments] :
            raise Exception(
                'row: {row} col: {col} function \'{arg}\' was not declare in function \'{function_name}\''.format(
                    function_name=funk.function_scope.name, row=arg.row, col=arg.col, arg=arg.name
                ))
        arg.check_undefined_variables_in_scope()


class Expression:
    def __init__(self):
        self.args = None

    def replace_symbol(self, symbol, value):
        pass

    def check_undefined_variables_in_scope(self):
        pass


class IntegerConstant:
    def __init__(self, funk, value, sign=1):
        self.value = value
        self.funk = funk
        self.sign = sign
        self.name = ''

    def replace_symbol(self, symbol, value):
        pass

    def check_undefined_variables_in_scope(self):
        pass

    def __repr__(self):
        sign = '-' if self.sign == -1 else ''
        return 'Integer({}{})'.format(sign, self.value)

    def eval(self, result=None):
        value = self.sign * int(self.value)
        if result is not None:
            self.funk.emitter.code += """

            {result} = TData({val});
            """.format(result=result, val=value)

        return value

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return IntegerConstant(self.funk, value=copy.deepcopy(self.value, memo), sign=self.sign)


class DoubleConstant:
    def __init__(self, funk, value, sign=1):
        self.value = value
        self.funk = funk
        self.sign = sign

    def replace_symbol(self, symbol, value):
        pass

    def check_undefined_variables_in_scope(self):
        pass

    def __repr__(self):
        return 'DoubleConstant({})'.format(self.value)

    def eval(self, result=None):
        value = self.sign * float(self.value)
        if result is not None:
            self.funk.emitter.code += """
            {result} = TData({val});
            """.format(result=result, val=value)

        return value

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return DoubleConstant(self.funk, value=copy.deepcopy(self.value, memo), sign=self.sign)


class List(Expression):
    def __init__(self, funk, name, elements):
        super().__init__()
        self.funk = funk
        self.name = name
        self.elements = elements

    def __len__(self):
        return len(self.elements)

    def replace_symbol(self, symbol, value):
        for element in self.elements:
            element.replace_symbol(symbol, value)

    def check_undefined_variables_in_scope(self):
        for element in self.elements:
            element.check_undefined_variables_in_scope()

    def get_dimensions(self):
        def traverse(x, dimensions=[]):
            elements = []
            if isinstance(x, collections.Iterable):
                elements = x
            elif isinstance(x, List):
                elements = x.elements
            dimensions.append(len(elements))

            if len(elements) > 0:
                if isinstance(elements[0], List) or isinstance(elements[0], collections.Iterable):
                    return traverse(elements[0], dimensions)
            return list(reversed(dimensions))

        if len(self.elements) == 0:
            return [1]

        return traverse(self)

    def __repr__(self):
        return 'List({})'.format(self.elements)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return List(self.funk, name=self.name, value=copy.deepcopy(self.value, memo))


class CompileTimeExprList(List):

    def __init__(self, funk, name, elements):
        super().__init__(funk, name, elements)
        self.funk = funk
        self.name = name
        if isinstance(elements, collections.Iterable):
            self.elements = elements
        else:
            self.elements = [elements]

    def eval(self, result=None):
        self.check_undefined_variables_in_scope()
        array = [k.eval() for k in self.elements]

        if len(self.elements) == 1 and isinstance(self.elements[0], Range):
            decl = ''
            if result is None:
                result = self.funk.emitter.create_anon()
                decl = 'TData'

            self.funk.emitter.code += """
                {decl} {result} = {anon};
            """.format(result=result, anon=str(array[0]), decl=decl)
        else:
            return self.funk.emitter.create_array(array,result)

        return result

    def __repr__(self):
        return 'CompileTimeExprList({})'.format(self.elements)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return CompileTimeExprList(self.funk, name=self.name, elements=copy.deepcopy(self.elements, memo))


class Include:
    def __init__(self, funk, elements):
        self.funk = funk
        self.elements = elements

    def eval(self, result=None):
        for include in self.elements:
            self.funk.emitter.code += """
          #include "{filename}.h"
          """.format(filename=include)


class Identifier:
    def __init__(self, funk, name, row=-1, col=-1, indexes=None, ):
        self.funk = funk
        self.indexes = indexes  # indexes for multidimensional array
        self.row = row
        self.col = col
        if name == '_':
            self.name = '_{}'.format(self.funk.empty_arg_count)
            self.funk.empty_arg_count += 1
        else:
            self.name = name

    def __repr__(self):
        string = 'Identifier({})'.format(self.name)
        if self.indexes is not None:
            string += '{}'.format(self.indexes)

        return string

    def index_emit_helper(self, node, indexes, result):
        range_initializer = []
        for idx in indexes:
            if isinstance(idx, Range):
                is_range = 'true'

                if isinstance(idx.left, IntegerConstant):
                    start = '{}'.format(idx.left.eval())
                else:
                    start = '{}.i32'.format(idx.left.eval())

                if isinstance(idx.right, IntegerConstant):
                    end = '{}'.format(idx.right.eval())
                else:
                    end = '{}.i32'.format(idx.right.eval())

            elif isinstance(idx, IntegerConstant):
                is_range = 'false'
                start = '{}'.format(idx.eval())
                end = '{}'.format(idx.eval())
            else:
                is_range = 'false'
                start = '{}.i32'.format(idx.eval())
                end = '{}.i32'.format(idx.eval())

            range_initializer.append('{{ {start}, {end}, {is_range} }}'.format(start=start, end=end, is_range=is_range))

        return self.funk.emitter.get_ranges(node, range_initializer, result)

    def eval_node_index(self, node, result=None):

        if self.indexes is not None:
            return self.index_emit_helper(node, copy.deepcopy(self.indexes), result)
        else:
            if result is not None:
                self.funk.emitter.code += """
        {result} = {node};
                """.format(result=result, node=node)
            return node

    def eval(self, result=None):
        # Check the current function that we are building
        # To see if the identifier is a function argument

        if self.name in self.funk.symbol_table:
            anon = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        TData {anon}(funky::{name});
        {anon}.str = "{name}";

        """.format(anon=anon, name=self.name)
            return anon
        else:
            return self.eval_node_index(self.name, result)

    def check_undefined_variables_in_scope(self):
        pass

    def replace_symbol(self, symbol, value):

        if self.name == symbol.name:
            self.name = value.name

        if self.indexes is not None:
            for i in range(len(self.indexes)):
                if self.indexes[i] is None:
                    continue

                if self.indexes[i].__repr__() == symbol.__repr__():
                    self.indexes[i] = value
                else:
                    self.indexes[i].replace_symbol(symbol, value)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Identifier(self.funk, name=self.name, indexes=copy.deepcopy(self.indexes, memo))


class HeadTail:
    def __init__(self, funk, head=None, tail=None):
        self.funk = funk
        self.head = head.name
        self.tail = tail.name

    def __repr__(self):
        return 'HeadTail({},{})'.format(self.head, self.tail)

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return HeadTail(self.funk, head=copy.deepcopy(self.head, memo), tail=copy.deepcopy(self.tail, memo))


class PatternMatch:
    def __init__(self, funk):
        self.funk = funk
        self.position = None
        self.name = ''

    def __repr__(self):
        return 'PatternMatch()'

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatch(self.funk)

class PatternMatchEmptyList(PatternMatch):
    def __init__(self, funk):
        PatternMatch.__init__(self, funk)
        self.funk = funk

    def __repr__(self):
        return 'PatternMatchEmptyList()'

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchEmptyList(self.funk)


class PatternMatchLiteral(PatternMatch):
    def __init__(self, funk, value, position):
        PatternMatch.__init__(self, funk)
        self.funk = funk
        self.position = position
        self.value = value.eval()

        if isinstance(value, IntegerConstant):
            self.type = funky_types.int
        elif isinstance(value, DoubleConstant):
            self.type = funky_types.double
        else:
            self.type = funky_types.invalid

    def __repr__(self):
        return 'PatternMatchLiteral({})'.format(self.value)

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchLiteral(self.funk, value=copy.deepcopy(self.value, memo), position=self.position)


class PatternMatchListOfIdentifiers(PatternMatch):
    def __init__(self, funk, elements, position):
        self.elements = elements
        self.position = position
        self.funk = funk

    def __repr__(self):
        return 'PatternMatchListOfIdentifiers({})'.format(self.elements)

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchListOfIdentifiers(self.funk,
                                             elements=copy.deepcopy(self.nameself.elements), position=self.position)


class BinaryOp(Expression):
    def __init__(self, funk, left=None, right=None, indexes=None):
        self.name = ''
        self.funk = funk
        self.left = left
        self.right = right
        self.indexes = indexes

    def arith_op(self, result, op):

        if isinstance(self.left, list):
            self.left = self.left[0]

        if isinstance(self.right, list):
            self.right = self.right[0]

        a = self.left.eval()
        b = self.right.eval()
        return self.funk.emitter.arith_op(result,a,op,b)


    def check_undefined_variables_in_scope(self):
        check_symbol_definition(self.funk, self.left)
        check_symbol_definition(self.funk, self.right)

    def replace_symbol(self, symbol, value):
        if self.left is not None:
            if self.left.__repr__() == symbol.__repr__():
                self.left = value
            else:
                self.left.replace_symbol(symbol, value)

        if self.right is not None:
            if self.right.__repr__() == symbol.__repr__():
                self.right = value
            else:
                self.right.replace_symbol(symbol, value)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return BinaryOp(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sum(BinaryOp):
    def __repr__(self):
        return 'Sum({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '+')

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Sum(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Mul(BinaryOp):
    def __repr__(self):
        return 'Mul({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '*')

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Mul(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sub(BinaryOp):
    def __repr__(self):
        return 'Sub({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '-')

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Sub(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Div(BinaryOp):
    def __repr__(self):
        return 'Div({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '/')

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Div(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Mod(BinaryOp):
    def __repr__(self):
        return 'Mod({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '%')

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Mod(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class And(BinaryOp):
    def __repr__(self):
        return 'And({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '&&')


class Or(BinaryOp):
    def __repr__(self):
        return 'Or({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '||')


class BoolBinaryOp(BinaryOp):
    def eval(self, result=None):
        left_val = self.left.eval()
        right_val = self.right.eval()

        return left_val, right_val


class GreaterThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterThan({} , {})'.format('sgt', self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '>')


class EqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'Equal({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '==')


class NotEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'NotEqual({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '!=')


class LessThan(BoolBinaryOp):
    def __repr__(self):
        return 'LessThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '<')


class GreaterOrEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterOrEqualThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '>=')


class LessOrEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'LessOrEqualThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.arith_op(result, '<=')


class ListConcat(BinaryOp):
    head = 1
    tail = 2

    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.direction = ListConcat.head
        self.name = None

    def __repr__(self):
        return 'ListConcatTail({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        if self.direction == ListConcat.tail:
            list_concat_tail(self.funk, self.left, self.right, result=result)
        else:
            list_concat_head(self.funk, self.left, self.right, result=result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return ListConcat(self.funk, left=copy.deepcopy(self.left, memo),
                          right=copy.deepcopy(self.right, memo))


class ListDifference(BinaryOp):
    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.name = ''
        self.direction = ListConcat.head

    def __repr__(self):
        return 'ListDifference({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        """
        This corresponds to:
            [A] -- [B]

        returns all unique elements in A that are not in B
        """

        ref = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            ref = 'TData'

        L = self.left.eval()
        R = self.right.eval()

        self.funk.emitter.code += """
            // List Union
            // Make sure both L and R are arrays
            if ({L}.type != funky_type::array) {{
                throw std::string("{L} is not an array");
            }}

           if ({R}.type != funky_type::array) {{
                throw std::string("{R} is not an array");
            }}

            auto __comparator__ = [](const TData & a, const TData & b){{
                    if (a.type != b.type)
                         throw std::string("Difference operator --: different types");

                    switch(a.type) {{
                        case funky_type::i32: return a.i32 < b.i32;
                        case funky_type::d64: return a.d64 < b.d64;
                        case funky_type::str: return a.str < b.str;
                        default: throw std::string("Difference operator --: types not supported");
                     }}
                 }};

            {ref} {result} = TData(funky_type::array);
            std::set_difference({L}.array.begin(), {L}.array.end(),
                {R}.array.begin(), {R}.array.end(),
                std::inserter({result}.array, {result}.array.begin()),
                __comparator__);

        """.format(result=result, L=L, R=R, ref=ref)

        return result

class ListUnion(BinaryOp):
    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.name = ''
        self.direction = ListConcat.head

    def __repr__(self):
        return 'ListUnion({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        """
        This corresponds to:
            [A] ++ [B]
        """

        ref = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            ref = 'TData'

        L = self.left.eval()
        R = self.right.eval()

        self.funk.emitter.code += """
            // List Union
            // Make sure both L and R are arrays
            TData {anon_l} = {L};
            TData {anon_r} = {R};
            if ({L}.type != funky_type::array) {{
                const std::vector<TData> tmp = {{ {L} }};
                {anon_l} = TData(tmp);
            }}

           if ({R}.type != funky_type::array) {{
                const std::vector<TData> tmp = {{ {R} }};
                {anon_r} = TData(tmp);
            }}

            {ref} {result} = {anon_l};
            {result}.array.insert({result}.array.end(), {anon_r}.array.begin(), {anon_r}.array.end());
        """.format(result=result, L=L, R=R, ref=ref, anon_l=self.funk.emitter.create_anon(),
                   anon_r=self.funk.emitter.create_anon())

        return result

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return ListUnion(self.funk, left=copy.deepcopy(self.left, memo),
                         right=copy.deepcopy(self.right, memo))


class ListConcatTail(BinaryOp):
    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.name = ''
        self.direction = ListConcat.head

    def __repr__(self):
        return 'ListConcatTail({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return list_concat_tail(self.funk, self.left, self.right, result=result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return ListConcatTail(self.funk, left=copy.deepcopy(self.left, memo),
                              right=copy.deepcopy(self.right, memo))


class Assignment(BinaryOp):
    def __repr__(self):
        return 'Assignment({} , {})'.format(self.left, self.right)

    def check_undefined_variables_in_scope(self):

        variable_name = self.left.name
        if variable_name in self.funk.function_scope.current_function_clause.local_variables:
            raise Exception(
                'row: {row} col: {col}: variable \'{variable_name}\' is already assigned a value in function \'{function_name}\''.format(
                    variable_name=variable_name, row=self.left.row, col=self.left.col,
                    function_name=self.funk.function_scope.name))

        elif variable_name in self.funk.function_scope.current_function_clause.arguments:
            raise Exception('variable \'{}\' is already defined in function\'s \'{}\' signature'.format(variable_name,
                                                                                                        self.funk.function_scope.name))
        else:
            self.funk.function_scope.current_function_clause.local_variables.append(variable_name)

    def eval(self, result=None):

        self.funk.emitter.create_variable(self.left.name)

        self.right.eval(result=self.left.name)


class Range(BinaryOp):
    def __init__(self, funk, lhs=None, rhs=None, identifier=None, expr=None, rhs_type='<', lhs_type='<'):
        self.funk = funk
        self.identifier = identifier
        self.lhs_type = lhs_type
        self.rhs_type = rhs_type
        self.expr = expr
        self.right = rhs
        self.left = lhs

    def __repr__(self):
        return 'Range({} | {} {} {} {} {})'.format(self.expr, self.left, self.lhs_type, self.identifier, self.rhs_type,
                                                   self.right)

    def compute_literal_range_limits(self):
        range_start = self.left.eval()

        if self.lhs_type == '<':
            range_start += 1

        range_end = self.right.eval()

        if self.rhs_type == '<=':
            range_end += 1

        return range_start, range_end

    def replace_symbol(self, symbol, value):
        if self.expr is not None:
            self.expr.replace_symbol(symbol, value)

        if self.left is not None:
            self.left.replace_symbol(symbol, value)

        if self.right is not None:
            self.right.replace_symbol(symbol, value)

    def eval(self):
        return ExprRange(self.funk, self.left, self.right, self.identifier, self.expr,
                         lhs_type=self.lhs_type, rhs_type=self.rhs_type)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Range(self.funk, lhs=copy.deepcopy(self.left, memo),
                     rhs=copy.deepcopy(self.right, memo),
                     identifier=copy.deepcopy(self.identifier, memo),
                     expr=copy.deepcopy(self.expr, memo),
                     rhs_type=self.rhs_type,
                     lhs_type=self.lhs_type)


class ExprRange(Range):
    def __init__(self, funk, lhs=None, rhs=None, identifier=None, expr=None, rhs_type='<', lhs_type='<'):
        self.funk = funk
        self.identifier = identifier
        self.lhs_type = lhs_type
        self.rhs_type = rhs_type
        self.expr = expr
        self.right = rhs
        self.left = lhs
        self.iterator_symbol = identifier
        self.reg_start = None
        self.reg_end = None
        self.range_register_calculation_emitted = False

    def check_undefined_variables_in_scope(self):
        pass

    def read_from_file(self, result):
        file_handler = self.left.eval()
        self.right.eval(result=file_handler)

        self.funk.emitter.code += """
        std::vector<TData> elements;
        while (!{file}.eof()) {{
        """.format(file=file_handler)

        element = self.expr.eval()

        self.funk.emitter.code += """
        if ({element}.type != funky_type::invalid) elements.push_back({element});
        }}
        {result} = TData(elements);
        """.format(element=element, result=result)

        return result

    def for_each_element(self, result):
        if self.left is not None:
            self.funk.function_scope.current_function_clause.local_variables.append(self.left.name)
        array = self.right.eval()
        e = self.left.eval()
        self.funk.emitter.code += """
            for (const auto & {e} : {array}.array )
            {{

        """.format(e=e, result=result, array=array)

        val = self.expr.eval()

        self.funk.emitter.code += """
                {result}.array.push_back({val});
            }}
        """.format(result=result, val=val)
        if self.left is not None:
            self.funk.function_scope.current_function_clause.local_variables.pop(-1)
        return result

    def eval(self, result=None, parent_TData_list=None, parent_offset=None):
        if result is None:
            result = self.funk.emitter.create_array([],result)

        if self.rhs_type == ':':
            if self.right.name == 'file':
                return self.read_from_file(result)
            else:
                return self.for_each_element(result)

        if isinstance(self.left, IntegerConstant):
            start = self.left.eval()
        else:
            start = self.funk.emitter.get_int(self.left.eval())

        if isinstance(self.right, IntegerConstant):
            end = self.right.eval()
        else:
            end = self.funk.emitter.get_int(self.right.eval())

        if self.lhs_type == '<':
            start += 1

        if self.rhs_type == '<=':
            end += 1

        i = self.iterator_symbol.eval()

        offset = self.funk.emitter.create_anon()
        self.funk.function_scope.current_function_clause.local_variables.append(self.iterator_symbol.name)

        check_symbol_definition(self.funk, self.expr)
        self.funk.function_scope.current_function_clause.local_variables.pop(-1)

        self.expr.replace_symbol(Identifier(self.funk, i), Identifier(self.funk, offset))

        self.funk.emitter.code += """

            for (int {i} = 0; {i} < ({end}-{start}); {i}++)
            {{

        """.format(i=i, end=end, start=start)

        self.funk.emitter.create_variable(name=offset, value='{} + {}'.format(start, i))

        expr = self.expr.eval()

        self.funk.emitter.array_push(result,expr)

        self.funk.emitter.code += """
            } // end for loop
        """

        return result

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return ExprRange(self.funk, lhs=copy.deepcopy(self.left, memo),
                         rhs=copy.deepcopy(self.right, memo),
                         identifier=copy.deepcopy(self.identifier, memo),
                         expr=copy.deepcopy(self.expr, memo),
                         rhs_type=self.rhs_type,
                         lhs_type=self.lhs_type)


class ExternalFunction:
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name

    def __repr__(self):
        return 'ExternalFunction({})'.format(self.name)

    def emit(self):
        return """
 TData {name}(std::vector<TData>&);
                """.format(name=self.name[1:])


class FunctionCall(Expression):
    def __init__(self, funk, name, args, row=-1, col=-1):
        super().__init__()
        self.funk = funk
        self.name = name

        # for n in [a.name for a in args]:
        #     if re.match('_\d+', n):
        #         raise Exception('\'_\' is not allowed in function calls')
        self.args = args
        self.row = row
        self.col = col
        self.system_functions = {
            'sleep': Sleep,
            'rand_int': RandInt,
            'rand_float': RandFloat,
            'say': Print,
            'info': DebugInfo,
            'len': Len,
            'flatten': Flatten,
            'sum': FunkSum,
            'abs': FunkAbs,
            'type': FunkGetType,
            'sdl_window': SDLCreateWindow,
            'sdl_rect': SDLRect,
            'sdl_point': SDLPoint,
            'sdl_line': SDLLine,
            'sdl_set_color': SDLColor,
            'sdl_render': SDLRenderFunction,
            'sdl_set_user_ctx': SDLSetUserCtx,
            'exit': Exit,
            'file': FOpen,
            'in': FReadNext,
            'toi32': ToI32,
            'reverse': Reverse,
            'infinity': Infinity,
            'reshape': ReShape,
        }

    def __repr__(self):
        return 'FunctionCall({}({}))'.format(self.name, self.args)

    def check_undefined_variables_in_scope(self):
        if self.args is not None:
            for arg in self.args:
                check_symbol_definition(self.funk, arg)

    def replace_symbol(self, symbol, value):
        if self.args is None:
            return
        for i, arg in enumerate(self.args):
            if arg is None:
                continue
            if arg.__repr__() == symbol.__repr__():
                self.args[i] = value
            else:
                arg.replace_symbol(symbol, value)

    def eval(self, result=None):
        found = False
        name = self.name

        if self.name in self.system_functions:
            p = self.system_functions[self.name](self.funk, self.args)
            return p.eval(result=result)

        function_is_local_variable = name in self.funk.function_scope.current_function_clause.local_variables
        function_is_in_signature = name in [a['val'] for a in
                                            self.funk.function_scope.current_function_clause.arguments]
        function_is_in_pattern_match_list = \
            name in self.funk.function_scope.current_function_clause.get_list_pattern_matched_symbol_names()

        # First check if this is globally defined function
        arguments = []
        if self.args is not None:
            arguments = [create_ast_anon_symbol(self.funk, a) for a in self.args]

        for arg in self.args:
            check_symbol_definition(self.funk, arg)

        if function_is_in_signature or function_is_local_variable or function_is_in_pattern_match_list:
            self.funk.emitter.code += """
        if ({name}.type != funky_type::function){{
            std::cout << "========================================================================================"
            << std::endl;
            std::cout << "FunkyRuntime Error: When running function '{function_signature}' "
                << ":\\n\\t The input provided as '{name}' is not a function" << std::endl;
             for (int i = 0; i < argument_list.size(); i++){{
                std::cout << "args " << i << ": " << argument_list[i] << std::endl;
             }}
            std::cout << "========================================================================================"
            << std::endl;
            exit(1);
        }}

        if ({name}.fn == nullptr){{
            printf("FunkyRuntime Error: '{name}' function is NULL\\n");
            exit(1);
        }}
            """.format(name=name, function_signature='{}({})'.format(self.funk.function_scope.name, ', '.join(
                str(e['val']) for e in self.funk.function_scope.current_function_clause.arguments)))

            ref = ''
            if result is None:
                result = self.funk.emitter.create_anon()
                ref = 'TData'

            anon = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            std::vector<TData> {anon} = {{ {arg_list} }};
            {ref} {result} = {name}.fn({anon});
            """.format(ref=ref, name=name, arg_list=', '.join(str(e) for e in arguments), result=result, anon=anon)
            return result
        elif name in self.funk.functions or '@{}'.format(name) in self.funk.functions:
            return self.funk.emitter.call_function(name, arguments, result=result)

        if not found:
            self.funk.forwarded_functions.append(name)
            return self.funk.emitter.call_function(name, arguments, result=result)

            raise Exception('Error row: {row} col: {col} Undeclared function \'{}\' '.format(
                self.name, row=self.row, col=self.col))

        return None

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FunctionCall(self.funk, name=self.name, args=copy.deepcopy(self.args, memo))


class FunctionClause:
    def __init__(self, funk, name, fn_body, preconditions, pattern_matches, arity=0, tail_pairs=None, arguments=None,
                 check_arity=True, fill_etc=False):
        if arguments is None:
            arguments = []
        if tail_pairs is None:
            tail_pairs = []
        self.body = fn_body
        self.name = name
        self.arity = arity
        self.check_arity = check_arity
        self.fill_etc = fill_etc
        self.arguments = arguments
        self.preconditions = preconditions
        self.pattern_matches = pattern_matches
        self.tail_pairs = tail_pairs
        self.local_variables = []
        self.funk = funk

    def get_list_pattern_matched_symbol_names(self):
        elements = []
        if self.pattern_matches is not None:
            for pm in [a['val'] for a in self.pattern_matches]:
                if isinstance(pm, PatternMatchLiteral):
                    continue

                for element in pm.elements:
                    elements.append(element.name)

        return elements


class FunctionMap:
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name
        self.clauses = []  # list of clauses

    def emit_main(self):
        if len(self.clauses) != 1:
            raise Exception('-E- \'emit_main\' Internal error')
        clause = self.clauses[0]

        self.funk.function_scope.current_function_clause = clause
        clause.funk.emitter.emit_main_preamble()

        for stmt in clause.body:
            stmt.check_undefined_variables_in_scope()
            stmt.eval()

        clause.funk.emitter.emit_main_postamble()

    def emit_function(self):
        has_tail_recursion = any([insn.name == self.name and isinstance(insn, FunctionCall) for insn in
                                  [clause.body[-1] for clause in self.clauses]])

        self.clauses[0].funk.emitter.emit_function_signature(self.name, has_tail_recursion)

        for clause in self.clauses:

            self.funk.function_scope.current_function_clause = clause
            pattern_match_auxiliary_variables = ''
            pattern_matches = []
            has_pattern_matches = clause.pattern_matches is not None and len(clause.pattern_matches) > 0

            if has_pattern_matches:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    i = pm.position
                    if isinstance(pm, PatternMatchEmptyList):
                        pattern_matches.append(self.funk.emitter.pattern_match_is_array('argument_list[{i}]'.format(i=i)))
                    elif isinstance(pm, PatternMatchLiteral):
                        if pm.type == funky_types.int:
                            pattern = '{lhs} == {rhs}'.format(lhs=self.funk.emitter.get_int('argument_list[{i}]'.format(i=i)), rhs=pm.value)
                            pattern_matches.append(pattern)
                        elif pm.type == funky_types.double:
                            pattern_matches.append(self.funk.emitter.pattern_match_double('argument_list[{i}]'.format(i=i),
                                                                                       pm.value))

                    elif isinstance(pm, PatternMatchListOfIdentifiers):
                        condition = 'argument_list[{}].array.size() =={}'.format(i, len(pm.elements))
                        pattern_matches.append(condition)
                        # this a list and it pattern matches elements from the list
                        for j, element in enumerate(pm.elements):
                            if isinstance(element, Identifier):
                                pattern_match_auxiliary_variables += self.funk.emitter.copy_var(
                                    '{name}'.format(name=element.name),
                                    'argument_list[{i}].array[{j}]'.format(i=i, j=j))

                            if isinstance(element, IntegerConstant):
                                condition = 'TData(argument_list[{i}].array[{j}] == {val}).i32 == 1'.format(
                                    i=i, j=j,
                                    val=element.eval())

                                pattern_matches.append(condition)

            pattern_matches_string = ''
            if has_pattern_matches and len(pattern_matches) > 0:
                pattern_matches_string = '&& {} // pattern matches'.format('&& '.join(str(e) for e in pattern_matches))

            tail_pair_check = ''

            arity_check = ''

            if clause.check_arity:
                arity_check = '&& {}'.format(self.funk.emitter.check_arity(clause.arity))

            clause.funk.emitter.code += """

        if (  true
             {arity_check}
             {tail_pair_check}
             {pattern_matches}
             ) {{

                {pattern_match_auxiliary_variables}
            """.format(arity_check=arity_check,
                       tail_pair_check=tail_pair_check, clause_arity=clause.arity,
                       pattern_matches=pattern_matches_string,
                       pattern_match_auxiliary_variables=pattern_match_auxiliary_variables)

            if clause.fill_etc:
                clause.funk.emitter.code += """
                    // etc
                    std::vector<TData> etc{{ argument_list.begin() + {offset}, argument_list.end() }};
                    """.format(offset=clause.arguments[-1]['pos'] + 1)

            insn = clause.body[-1]
            last_insn_is_tail_recursive = self.funk.mode == 'cpp' and \
                                          insn.name == self.name and \
                                          isinstance(insn, FunctionCall) and\
                                          len(insn.args) == len(clause.arguments)

            for argument in clause.arguments:
                if argument['val'] != '_':
                    ref = ''
                    if not last_insn_is_tail_recursive and len(clause.tail_pairs) == 0:
                        ref = '&'

                    clause.funk.emitter.code += self.funk.emitter.copy_var(argument['val'],
                                                                           'argument_list[{i}]'.format(
                                                                               i=argument['pos'],
                                                                               ref=ref))

            for argument in clause.tail_pairs:
                self.funk.emitter.create_anon()
                clause.funk.emitter.code += \
                    self.funk.emitter.throw_if(
                        '{head}.type != {array}'.format(head=argument['head'], array=self.funk.emitter.type('array')),
                        "in function {function_name}: {list_arg} is not an array".format(
                            list_arg=argument['tail'], function_name=clause.name))

                clause.funk.emitter.code += """
               TData  {list_arg} = {head};

               if ({list_arg}.array.size() > 0) {{
                    {head} = {list_arg}.array.front();
                    {list_arg}.array.erase({list_arg}.array.begin());
               }} else {{
                    {head} = std::vector<TData>(); //empty list
               }}
                     """.format(head=argument['head'], list_arg=argument['tail'])

            if clause.preconditions is not None:
                self.funk.function_scope.args = clause.arguments
                preconditions_result = clause.preconditions.eval()
                clause.funk.emitter.code += """
            if ({preconditions}.i32 == 1) {{
                    """.format(preconditions=preconditions_result)

            # go through each statement
            for stmt in clause.body[:-1]:
                self.funk.emitter.add_comment(stmt)
                stmt.check_undefined_variables_in_scope()
                stmt.eval()

            clause.body[-1].check_undefined_variables_in_scope()

            if last_insn_is_tail_recursive:
                self.funk.emitter.code += """
                // tail recursion

                """
                for i, arg in enumerate(clause.body[-1].args):
                    arg = arg.eval()
                    clause.funk.emitter.code += """
                argument_list[{i}] = {function_parameter};
                """.format(i=i, function_parameter=arg)
                clause.funk.emitter.code += """
                goto label_function_start;
                """
            else:
                clause.body[-1].eval(result='__retval__')

            clause.funk.emitter.code += \
                self.funk.emitter.throw_if('__retval__.type == {}'.format(self.funk.emitter.type('invalid')),
                                           " returning invalid type in function \'{function_name}\' arity:{arity}".format(
                                               function_name=clause.name, arity=clause.arity))

            if clause.preconditions is not None:
                clause.funk.emitter.code += """

            return __retval__;
            } //preconditions check
            """
            else:
                clause.funk.emitter.code += """
            return __retval__;
            """

            clause.funk.emitter.code += """

        } //arity check
        """

        self.funk.emitter.emit_no_suitable_clause_found(self.name)

        self.funk.emitter.code += """
        exit(1);
        return __retval__;

        }

            """

    def eval(self, result=None):
        scope_name = self.funk.create_function_scope(self.name)

        self.funk.set_function_scope(scope_name)

        if self.name == 'main':
            self.emit_main()
        else:
            self.emit_function()
        return result


class FirmEllipses:
    def __init__(self, etc=False):
        self.name = ''
        self.etc = etc
        pass

    def __repr__(self):
        return '...'.format(self.fmt_str)


class String(Expression):
    def __init__(self, funk, fmt_str):
        super().__init__()
        self.funk = funk
        self.fmt_str = '"{}"'.format(fmt_str[1:-1])
        self.name = ''

    def __repr__(self):
        return 'String({})'.format(self.fmt_str)

    def check_undefined_variables_in_scope(self):
        return

    def eval(self, result=None):
        value = self.fmt_str
        if result is not None:
            self.funk.emitter.code += """
                   {result} = TData({val});
                   """.format(result=result, val=self.fmt_str)

        return value


class FunkAbs(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        src = self.arg_list[0].eval()
        self.funk.emitter.code += """
         {ref} {result} = {src}.Abs();
        """.format(ref=ref, result=result, src=src)

        return result


class FunkSum(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.funk_summation_function(self.funk, self.arg_list, result=result)


class Flatten(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        ref = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            ref = 'const TData'

        src = self.arg_list[0].eval()
        self.funk.emitter.code += """
        // flatten vector
       {ref} {result} = {src}.Flatten();
        """.format(result=result, src=src, ref=ref)
        return result


class Len(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.get_node_length(self.arg_list, result=result)


class FunkGetType(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        ref = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            ref = 'TData'
        src = self.arg_list[0].eval()

        self.funk.emitter.code += """
        {ref} {result} = TData(static_cast<int32_t>({src}.type));
        """.format(ref=ref, result=result, src=src)


class DebugInfo:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.debug_print_node_info(self.funk, self.arg)
        return result


class Print:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        result = self.funk.emitter.print_funk(self.arg, result)
        return result


class RandInt:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.rand_int(self.funk, self.arg_list)


class RandFloat:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()
        anon = self.funk.emitter.create_anon()
        self.funk.emitter.code += """

        std::uniform_real_distribution<double> {anon}({min}, {max});
        {ref} {result} = TData({anon}(g_funky_random_engine));
        """.format(anon=anon, ref=ref, result=result, min=self.arg_list[0].eval(), max=self.arg_list[1].eval())
        return result


class FOpen:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        path = self.arg_list[0].eval()
        mode = self.arg_list[1].eval()
        if result is None:
            result = self.funk.emitter.create_anon()
        self.funk.emitter.code += """
        std::ifstream {result};
        {result}.open({path}.str.c_str());
        if (!{result}.is_open()){{
            //throw std::exception("-E- Could not open file ");
            std::cout << "-E- Could not open file " << {path}.str << std::endl;
            exit(1);
        }}
        """.format(result=result, path=path, mode=mode)

        return result


class FReadNext:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        ref = ''

        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        if len(self.arg_list) == 1:
            file = self.arg_list[0].eval()
        else:
            file = 'std::cin'

        self.funk.emitter.code += """
         {ref} {result} = TData(funky_type::str);
         {file} >> {result}.str;
        """.format(ref=ref, result=result, file=file)

        return result


class ToI32:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        ref = ''
        var = self.arg_list[0].eval()
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            TData {result};
            """.format(result=result)

        self.funk.emitter.code += """
        const bool is_number = !{var}.str.empty() && {var}.str.find_first_not_of("-0123456789") == std::string::npos;
        switch ({var}.type){{
            case funky_type::i32:{result} = {var}; break;
            case funky_type::d64: {result} = TData(static_cast<int32_t>({var}.d64)); break;
            case funky_type::str:
                 if (is_number) {{
                    {result} = TData(std::stoi({var}.str));
                }} else {{
                     {result} = TData(funky_type::invalid);
                }}
                break;
            default: {result} = TData(funky_type::invalid); break;
        }}
        """.format(ref=ref, result=result, var=var)

        return result


class Reverse:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        src = self.arg_list[0].eval()

        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        self.funk.emitter.code += """
        {ref} {v} = {src};
        std::reverse({v}.array.begin(), {v}.array.end());
        """.format(ref=ref, v=result, src=src)

        return result


class Infinity:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        self.funk.emitter.code += """
        {ref} {result} = TData(std::numeric_limits<std::int32_t>::max());
        """.format(ref=ref, result=result)

        return result


class ReShape:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result):
        L = self.arg_list[0].eval()
        w = self.arg_list[1].eval()
        h = self.arg_list[2].eval()

        if not isinstance(w, int):
            w = '{}.i32'.format(w)

        if not isinstance(h, int):
            h = '{}.i32'.format(h)

        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        self.funk.emitter.code += """
        {ref} {result} = funky::Reshape({L}, {w}, {h});
        """.format(ref=ref, result=result, L=L, w=w, h=h)

        return result


class Exit:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.exit(self.arg_list)


class Sleep:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.code += """
        {{
            std::chrono::milliseconds timespan({val}*1000);
            std::this_thread::sleep_for(timespan);
        }}
        """.format(val=self.arg_list[0].eval())
        return result
