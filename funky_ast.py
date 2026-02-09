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
from collections.abc import Iterable
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
        funk.emitter.code += """
                TData {symbol_name} ({val});
                """.format(symbol_name=anon, val=right.eval())
        return anon
    else:
        return right.eval()


def check_symbol_definition(funk, arg):
    if not isinstance(arg, Identifier) and not isinstance(arg, FunctionCall):
        if isinstance(arg, Expression):
            return arg.check_undefined_variables_in_scope()
        return #arg.check_undefined_variables_in_scope()

    # ignore automatic variables
    if re.match(r'anon_\d+', arg.name) or arg.name == 'etc':
        return

    clause = funk.function_scope.current_function_clause

    # if it was in tail/head pair is fine
    if clause.tail_pairs is not None:
        if any([arg.name in [t['tail'] for t in clause.tail_pairs]]):
            return

    if clause.pattern_matches is not None:
        for pattern_match in [c['val'] for c in clause.pattern_matches]:
            if isinstance(pattern_match,PatternMatchLiteral):
                return

            if isinstance(pattern_match,PatternMatchListOfIdentifiers):
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
            if isinstance(x, Iterable):
                elements = x
            elif isinstance(x, List):
                elements = x.elements
            dimensions.append(len(elements))

            if len(elements) > 0:
                if isinstance(elements[0], List) or isinstance(elements[0], Iterable):
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
        if isinstance(elements, Iterable):
            self.elements = [e for e in elements if e is not None]
        else:
            self.elements = [elements]

    def eval(self, result=None):

        self.check_undefined_variables_in_scope()

        decl = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            decl = 'TData'

        anon = self.funk.emitter.create_anon()

        array = [k.eval() for k in self.elements]

        if len(self.elements) == 1 and isinstance(self.elements[0], Range):
            self.funk.emitter.code += """
                {decl} {result} = {anon};
            """.format(result=result, anon=str(array[0]), decl=decl)
        else:
            self.funk.emitter.code += """
                const std::vector<TData> {anon} = {{ {values} }};
                {decl} {result} = TData({anon});
                """.format(decl=decl, anon=anon, result=result,
                           values=','.join(str(e) for e in array))

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
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
                  TData {result};
                  """.format(result=result)

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

        anon = self.funk.emitter.create_anon()
        self.funk.emitter.code += """
         std::vector<TData::RangeType> {ranges} = {{ {range_initializer} }};
         {result} = {node}.GetRange({ranges});
        """.format(ranges=anon, result=result, node=node,
                   range_initializer=', '.join(str(e) for e in range_initializer))

        return result

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
        return PatternMatchLiteral(self.funk, value=copy.deepcopy(self.value, memo))


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
        return PatternMatchListOfIdentifiers(self.funk, name=copy.deepcopy(self.name, memo))


class BinaryOp(Expression):
    def __init__(self, funk, left=None, right=None, indexes=None):
        self.name = ''
        self.funk = funk
        self.left = left
        self.right = right
        self.indexes = indexes

    def arith_op(self, result, op):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            TData {result};""".format(result=result)
        if isinstance(self.left, list):
            self.left = self.left[0]

        if isinstance(self.right, list):
            self.right = self.right[0]

        a = self.left.eval()
        b = self.right.eval()
        self.funk.emitter.code += """
            {result} = {a} {op} {b};
        """.format(result=result, a=a, b=b, op=op)

        return result

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
    def eval(self, as_type, result=None):
        lval = self.left.eval()
        rval = self.right.eval()

        return lval, rval


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

        self.funk.emitter.code += """
        TData {};
        """.format(self.left.name)
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

        """.format(e=e,result=result, array=array)

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
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            TData {result}(std::vector<TData>{{ }});
            """.format(result=result)

        if self.rhs_type == ':':
            if self.right.name == 'file':
                return self.read_from_file(result)
            else:
                return self.for_each_element(result)

        if isinstance(self.left, IntegerConstant):
            start = self.left.eval()
        else:
            start = '{}.i32'.format(self.left.eval())

        if isinstance(self.right, IntegerConstant):
            end = self.right.eval()
        else:
            end = '{}.i32'.format(self.right.eval())

        if self.lhs_type == '<':
            start += 1

        if self.rhs_type == '<=':
            end += 1

        i = self.iterator_symbol.eval()
        length = self.funk.emitter.create_anon()
        offset = self.funk.emitter.create_anon()
        self.funk.function_scope.current_function_clause.local_variables.append(self.iterator_symbol.name)

        check_symbol_definition(self.funk, self.expr)
        self.funk.function_scope.current_function_clause.local_variables.pop(-1)

        self.expr.replace_symbol(Identifier(self.funk, i), Identifier(self.funk, offset))
        self.funk.emitter.code += """
            uint32_t {length} = {end} - {start};
            for (int {i} = 0; {i} < {length}; {i}++)
            {{
                TData {offset}({start} + {i});
        """.format(result=result, i=i, start=start, end=end, offset=offset, length=length)

        expr = self.expr.eval()

        self.funk.emitter.code += """
                {result}.array.push_back({val});
            }}

        """.format(result=result, val=expr, start=start, end=end)

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
        function_is_in_signature = name in [a['val'] for a in self.funk.function_scope.current_function_clause.arguments]
        function_is_in_pattern_match_list = name in self.funk.function_scope.current_function_clause.get_list_pattern_matched_symbol_names()

        # First check if this is globally defined function
        arguments = []
        if self.args is not None:
            arguments = [create_ast_anon_symbol(self.funk, a) for a in self.args]

        for arg in self.args:
            check_symbol_definition(self.funk, arg)

        if function_is_in_signature or function_is_local_variable or function_is_in_pattern_match_list:
            self.funk.emitter.code += """
        if ({name}.type != funky_type::function){{
            std::cout << "========================================================================================" << std::endl;
            std::cout << "FunkyRuntime Error: When running function '{function_signature}':\\n\\t The input provided as '{name}' is not a function" << std::endl;
             for (int i = 0; i < argument_list.size(); i++){{
                std::cout << "args " << i << ": " << argument_list[i] << std::endl;
             }}
            std::cout << "========================================================================================" << std::endl;
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
        elif (
            name in self.funk.functions
            or '@{}'.format(name) in self.funk.functions
            or name in getattr(self.funk, 'known_functions', set())
            or '@{}'.format(name) in getattr(self.funk, 'known_functions', set())
        ):
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
        self.funk.preamble += """
        TData {function_name}(std::vector<TData> &);
        """.format(function_name=name)

    def _i32_op_symbol(self, expr):
        if isinstance(expr, Sum):
            return '+'
        if isinstance(expr, Sub):
            return '-'
        if isinstance(expr, Mul):
            return '*'
        if isinstance(expr, Div):
            return '/'
        if isinstance(expr, Mod):
            return '%'
        if isinstance(expr, And):
            return '&&'
        if isinstance(expr, Or):
            return '||'
        if isinstance(expr, GreaterThan):
            return '>'
        if isinstance(expr, EqualThan):
            return '=='
        if isinstance(expr, NotEqualThan):
            return '!='
        if isinstance(expr, LessThan):
            return '<'
        if isinstance(expr, GreaterOrEqualThan):
            return '>='
        if isinstance(expr, LessOrEqualThan):
            return '<='
        return None

    def _i32_expr_to_cpp(self, expr, arg_pos_by_name, helper_name_by_fn, allow_calls_set):
        if isinstance(expr, IntegerConstant):
            return str(expr.eval())
        if isinstance(expr, Identifier):
            if expr.name in arg_pos_by_name:
                return 'arg{idx}'.format(idx=arg_pos_by_name[expr.name])
            return None
        if isinstance(expr, FunctionCall):
            if expr.args is None:
                return None
            callee = expr.name
            if callee not in allow_calls_set:
                return None
            helper_name = helper_name_by_fn.get(callee)
            if helper_name is None:
                return None
            callee_map = getattr(self.funk, 'function_map', {}).get(callee)
            if callee_map is None or len(callee_map.clauses) == 0:
                return None
            if len(expr.args) != callee_map.clauses[0].arity:
                return None
            rendered_args = []
            for a in expr.args:
                cpp = self._i32_expr_to_cpp(a, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
                if cpp is None:
                    return None
                rendered_args.append(cpp)
            return '{helper}({args})'.format(helper=helper_name, args=', '.join(rendered_args))

        op = self._i32_op_symbol(expr)
        if op is not None:
            lhs = self._i32_expr_to_cpp(expr.left, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
            rhs = self._i32_expr_to_cpp(expr.right, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
            if lhs is None or rhs is None:
                return None
            return '({lhs} {op} {rhs})'.format(lhs=lhs, op=op, rhs=rhs)

        return None

    def _i32_arg_pos_by_name(self):
        arg_pos_by_name = {}
        for clause in self.clauses:
            for arg in clause.arguments:
                if arg['val'] == '_':
                    continue
                if arg['val'] in arg_pos_by_name and arg_pos_by_name[arg['val']] != arg['pos']:
                    return None
                arg_pos_by_name[arg['val']] = arg['pos']
        return arg_pos_by_name

    def _i32_structural_ok(self):
        if self.name == 'main':
            return False
        if len(self.clauses) == 0:
            return False
        arity = self.clauses[0].arity
        if arity <= 0:
            return False
        for clause in self.clauses:
            if clause.arity != arity or not clause.check_arity or clause.fill_etc:
                return False
            if len(clause.tail_pairs) > 0:
                return False
            if len(clause.body) != 1:
                return False
            if clause.pattern_matches is not None:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    if not isinstance(pm, PatternMatchLiteral) or pm.type != funky_types.int:
                        return False
        arg_pos_by_name = self._i32_arg_pos_by_name()
        if arg_pos_by_name is None or len(arg_pos_by_name) == 0:
            return False
        return True

    def _i32_helper_name(self):
        arity = self.clauses[0].arity
        return '__funk_i32_{name}_{arity}'.format(name=self.name, arity=arity)

    def _compute_i32_lowerable_registry(self):
        cache = getattr(self.funk, '_i32_lowering_registry', None)
        if cache is not None:
            return cache

        fn_map = getattr(self.funk, 'function_map', {})
        structural = {name for name, fmap in fn_map.items() if fmap._i32_structural_ok()}
        lowerable = set(structural)

        changed = True
        while changed:
            changed = False
            helper_name_by_fn = {name: fn_map[name]._i32_helper_name() for name in lowerable}
            for name in list(lowerable):
                fmap = fn_map[name]
                arg_pos_by_name = fmap._i32_arg_pos_by_name()
                if arg_pos_by_name is None or len(arg_pos_by_name) == 0:
                    lowerable.remove(name)
                    changed = True
                    continue
                ok = True
                for clause in fmap.clauses:
                    exprs = []
                    if clause.preconditions is not None:
                        exprs.append(clause.preconditions)
                    exprs.append(clause.body[-1])
                    for expr in exprs:
                        cpp = fmap._i32_expr_to_cpp(expr, arg_pos_by_name, helper_name_by_fn, lowerable)
                        if cpp is None:
                            ok = False
                            break
                    if not ok:
                        break
                if not ok:
                    lowerable.remove(name)
                    changed = True

        helper_name_by_fn = {name: fn_map[name]._i32_helper_name() for name in lowerable}
        registry = {
            'lowerable': lowerable,
            'helper_name_by_fn': helper_name_by_fn,
        }
        self.funk._i32_lowering_registry = registry
        return registry

    def _build_i32_lowering(self):
        if self.name == 'main':
            return None
        if not getattr(self.funk, 'enable_i32_lowering', False):
            return None
        if len(self.clauses) == 0:
            return None

        registry = self._compute_i32_lowerable_registry()
        if self.name not in registry['lowerable']:
            return None

        arity = self.clauses[0].arity
        arg_pos_by_name = self._i32_arg_pos_by_name()
        helper_name_by_fn = registry['helper_name_by_fn']
        helper_name = helper_name_by_fn[self.name]
        helper_args = ', '.join('std::int32_t arg{idx}'.format(idx=i) for i in range(arity))
        lines = []

        # Forward-declare helpers of callees in the same lowered set (supports mutual recursion).
        called_helpers = set()
        for clause in self.clauses:
            exprs = [clause.body[-1]]
            if clause.preconditions is not None:
                exprs.append(clause.preconditions)
            for expr in exprs:
                stack = [expr]
                while len(stack) > 0:
                    node = stack.pop()
                    if isinstance(node, FunctionCall):
                        callee = node.name
                        if callee != self.name and callee in helper_name_by_fn:
                            called_helpers.add(callee)
                        if node.args is not None:
                            stack.extend([a for a in node.args if a is not None])
                    else:
                        if hasattr(node, 'left') and node.left is not None:
                            stack.append(node.left)
                        if hasattr(node, 'right') and node.right is not None:
                            stack.append(node.right)
        for callee in sorted(called_helpers):
            callee_arity = self.funk.function_map[callee].clauses[0].arity
            callee_args = ', '.join('std::int32_t arg{idx}'.format(idx=i) for i in range(callee_arity))
            lines.append('static std::int32_t {name}({args});'.format(name=helper_name_by_fn[callee], args=callee_args))
        lines.append('static std::int32_t {name}({args}) {{'.format(name=helper_name, args=helper_args))

        for clause in self.clauses:
            conds = []
            if clause.pattern_matches is not None:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    if not isinstance(pm, PatternMatchLiteral) or pm.type != funky_types.int:
                        return None
                    conds.append('arg{idx} == {val}'.format(idx=pm.position, val=pm.value))

            if clause.preconditions is not None:
                guard_cpp = self._i32_expr_to_cpp(
                    clause.preconditions, arg_pos_by_name, helper_name_by_fn, registry['lowerable']
                )
                if guard_cpp is None:
                    return None
                conds.append('({guard})'.format(guard=guard_cpp))

            expr_cpp = self._i32_expr_to_cpp(
                clause.body[-1], arg_pos_by_name, helper_name_by_fn, registry['lowerable']
            )
            if expr_cpp is None:
                return None

            if len(conds) == 0:
                lines.append('    return {expr};'.format(expr=expr_cpp))
            else:
                lines.append('    if ({conds}) return {expr};'.format(conds=' && '.join(conds), expr=expr_cpp))

        lines.append('    std::fprintf(stderr, "No i32 overload for function {name}\\n");'.format(name=self.name))
        lines.append('    std::exit(1);')
        lines.append('}')

        guard = """
        if (argument_list.size() == {arity}{types_check}) {{
            __retval__ = TData({helper_name}({arg_list}));
            return __retval__;
        }}
        """.format(
            arity=arity,
            types_check=''.join(
                ' && argument_list[{i}].type == funky_type::i32'.format(i=i) for i in range(arity)
            ),
            helper_name=helper_name,
            arg_list=', '.join('argument_list[{i}].i32'.format(i=i) for i in range(arity)),
        )
        return {'helper_code': '\n'.join(lines) + '\n', 'guard_code': guard}

    def _d64_literal_cpp(self, value):
        return repr(float(value))

    def _d64_expr_to_cpp(self, expr, arg_pos_by_name, helper_name_by_fn, allow_calls_set):
        if isinstance(expr, DoubleConstant):
            return self._d64_literal_cpp(expr.eval())
        if isinstance(expr, IntegerConstant):
            return 'static_cast<double>({val})'.format(val=expr.eval())
        if isinstance(expr, Identifier):
            if expr.name in arg_pos_by_name:
                return 'arg{idx}'.format(idx=arg_pos_by_name[expr.name])
            return None
        if isinstance(expr, FunctionCall):
            if expr.args is None:
                return None
            callee = expr.name
            if callee not in allow_calls_set:
                return None
            helper_name = helper_name_by_fn.get(callee)
            if helper_name is None:
                return None
            callee_map = getattr(self.funk, 'function_map', {}).get(callee)
            if callee_map is None or len(callee_map.clauses) == 0:
                return None
            if len(expr.args) != callee_map.clauses[0].arity:
                return None
            rendered_args = []
            for a in expr.args:
                cpp = self._d64_expr_to_cpp(a, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
                if cpp is None:
                    return None
                rendered_args.append(cpp)
            return '{helper}({args})'.format(helper=helper_name, args=', '.join(rendered_args))

        op = self._i32_op_symbol(expr)
        if op is not None:
            if op == '%':
                return None
            lhs = self._d64_expr_to_cpp(expr.left, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
            rhs = self._d64_expr_to_cpp(expr.right, arg_pos_by_name, helper_name_by_fn, allow_calls_set)
            if lhs is None or rhs is None:
                return None
            return '({lhs} {op} {rhs})'.format(lhs=lhs, op=op, rhs=rhs)

        return None

    def _d64_structural_ok(self):
        if self.name == 'main':
            return False
        if len(self.clauses) == 0:
            return False
        arity = self.clauses[0].arity
        if arity <= 0:
            return False
        for clause in self.clauses:
            if clause.arity != arity or not clause.check_arity or clause.fill_etc:
                return False
            if len(clause.tail_pairs) > 0:
                return False
            if len(clause.body) != 1:
                return False
            if clause.pattern_matches is not None:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    if not isinstance(pm, PatternMatchLiteral):
                        return False
                    if pm.type not in (funky_types.int, funky_types.double):
                        return False
        arg_pos_by_name = self._i32_arg_pos_by_name()
        if arg_pos_by_name is None or len(arg_pos_by_name) == 0:
            return False
        return True

    def _d64_helper_name(self):
        arity = self.clauses[0].arity
        return '__funk_d64_{name}_{arity}'.format(name=self.name, arity=arity)

    def _compute_d64_lowerable_registry(self):
        cache = getattr(self.funk, '_d64_lowering_registry', None)
        if cache is not None:
            return cache

        fn_map = getattr(self.funk, 'function_map', {})
        structural = {name for name, fmap in fn_map.items() if fmap._d64_structural_ok()}
        lowerable = set(structural)

        changed = True
        while changed:
            changed = False
            helper_name_by_fn = {name: fn_map[name]._d64_helper_name() for name in lowerable}
            for name in list(lowerable):
                fmap = fn_map[name]
                arg_pos_by_name = fmap._i32_arg_pos_by_name()
                if arg_pos_by_name is None or len(arg_pos_by_name) == 0:
                    lowerable.remove(name)
                    changed = True
                    continue
                ok = True
                for clause in fmap.clauses:
                    exprs = []
                    if clause.preconditions is not None:
                        exprs.append(clause.preconditions)
                    exprs.append(clause.body[-1])
                    for expr in exprs:
                        cpp = fmap._d64_expr_to_cpp(expr, arg_pos_by_name, helper_name_by_fn, lowerable)
                        if cpp is None:
                            ok = False
                            break
                    if not ok:
                        break
                if not ok:
                    lowerable.remove(name)
                    changed = True

        helper_name_by_fn = {name: fn_map[name]._d64_helper_name() for name in lowerable}
        registry = {
            'lowerable': lowerable,
            'helper_name_by_fn': helper_name_by_fn,
        }
        self.funk._d64_lowering_registry = registry
        return registry

    def _build_d64_lowering(self):
        if self.name == 'main':
            return None
        if not getattr(self.funk, 'enable_d64_lowering', False):
            return None
        if len(self.clauses) == 0:
            return None

        registry = self._compute_d64_lowerable_registry()
        if self.name not in registry['lowerable']:
            return None

        arity = self.clauses[0].arity
        arg_pos_by_name = self._i32_arg_pos_by_name()
        helper_name_by_fn = registry['helper_name_by_fn']
        helper_name = helper_name_by_fn[self.name]
        helper_args = ', '.join('double arg{idx}'.format(idx=i) for i in range(arity))
        lines = []

        called_helpers = set()
        for clause in self.clauses:
            exprs = [clause.body[-1]]
            if clause.preconditions is not None:
                exprs.append(clause.preconditions)
            for expr in exprs:
                stack = [expr]
                while len(stack) > 0:
                    node = stack.pop()
                    if isinstance(node, FunctionCall):
                        callee = node.name
                        if callee != self.name and callee in helper_name_by_fn:
                            called_helpers.add(callee)
                        if node.args is not None:
                            stack.extend([a for a in node.args if a is not None])
                    else:
                        if hasattr(node, 'left') and node.left is not None:
                            stack.append(node.left)
                        if hasattr(node, 'right') and node.right is not None:
                            stack.append(node.right)
        for callee in sorted(called_helpers):
            callee_arity = self.funk.function_map[callee].clauses[0].arity
            callee_args = ', '.join('double arg{idx}'.format(idx=i) for i in range(callee_arity))
            lines.append('static double {name}({args});'.format(name=helper_name_by_fn[callee], args=callee_args))
        lines.append('static double {name}({args}) {{'.format(name=helper_name, args=helper_args))

        for clause in self.clauses:
            conds = []
            if clause.pattern_matches is not None:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    if not isinstance(pm, PatternMatchLiteral):
                        return None
                    if pm.type == funky_types.int:
                        conds.append(
                            'arg{idx} == static_cast<double>({val})'.format(idx=pm.position, val=pm.value)
                        )
                    elif pm.type == funky_types.double:
                        conds.append(
                            'arg{idx} == {val}'.format(idx=pm.position, val=self._d64_literal_cpp(pm.value))
                        )
                    else:
                        return None

            if clause.preconditions is not None:
                guard_cpp = self._d64_expr_to_cpp(
                    clause.preconditions, arg_pos_by_name, helper_name_by_fn, registry['lowerable']
                )
                if guard_cpp is None:
                    return None
                conds.append('({guard})'.format(guard=guard_cpp))

            expr_cpp = self._d64_expr_to_cpp(
                clause.body[-1], arg_pos_by_name, helper_name_by_fn, registry['lowerable']
            )
            if expr_cpp is None:
                return None

            if len(conds) == 0:
                lines.append('    return {expr};'.format(expr=expr_cpp))
            else:
                lines.append('    if ({conds}) return {expr};'.format(conds=' && '.join(conds), expr=expr_cpp))

        lines.append('    std::fprintf(stderr, "No d64 overload for function {name}\\n");'.format(name=self.name))
        lines.append('    std::exit(1);')
        lines.append('}')

        guard = """
        if (argument_list.size() == {arity}{types_check}) {{
            __retval__ = TData({helper_name}({arg_list}));
            return __retval__;
        }}
        """.format(
            arity=arity,
            types_check=''.join(
                ' && argument_list[{i}].type == funky_type::d64'.format(i=i) for i in range(arity)
            ),
            helper_name=helper_name,
            arg_list=', '.join('argument_list[{i}].d64'.format(i=i) for i in range(arity)),
        )
        return {'helper_code': '\n'.join(lines) + '\n', 'guard_code': guard}

    def _d64_array_tailrec_expr_to_cpp(self, expr, scalar_pos_by_name, head_to_array_name):
        if isinstance(expr, DoubleConstant):
            return self._d64_literal_cpp(expr.eval())
        if isinstance(expr, IntegerConstant):
            return 'static_cast<double>({val})'.format(val=expr.eval())
        if isinstance(expr, Identifier):
            if expr.name in scalar_pos_by_name:
                return 'arg{idx}'.format(idx=scalar_pos_by_name[expr.name])
            if expr.name in head_to_array_name:
                arr_name = head_to_array_name[expr.name]
                return '{arr}.array[idx].d64'.format(arr=arr_name)
            return None

        op = self._i32_op_symbol(expr)
        if op is not None:
            if op == '%':
                return None
            lhs = self._d64_array_tailrec_expr_to_cpp(expr.left, scalar_pos_by_name, head_to_array_name)
            rhs = self._d64_array_tailrec_expr_to_cpp(expr.right, scalar_pos_by_name, head_to_array_name)
            if lhs is None or rhs is None:
                return None
            return '({lhs} {op} {rhs})'.format(lhs=lhs, op=op, rhs=rhs)
        return None

    def _build_d64_array_tailrec_lowering(self):
        if self.name == 'main':
            return None
        if not getattr(self.funk, 'enable_d64_lowering', False):
            return None
        if len(self.clauses) != 2:
            return None
        if len(self.clauses[0].body) != 1 or len(self.clauses[1].body) != 1:
            return None

        arity = self.clauses[0].arity
        if arity <= 0 or self.clauses[1].arity != arity:
            return None

        # Find recursive clause: must end in self tail call and have list head/tail destructuring.
        recursive_clause = None
        base_clause = None
        for clause in self.clauses:
            insn = clause.body[-1]
            is_tail_self = isinstance(insn, FunctionCall) and insn.name == self.name and len(insn.args) == arity
            if is_tail_self and len(clause.tail_pairs) > 0:
                recursive_clause = clause
            else:
                base_clause = clause
        if recursive_clause is None or base_clause is None:
            return None

        # Map list argument positions by matching head variable names.
        list_pos_to_head_tail = {}
        for tail_pair in recursive_clause.tail_pairs:
            head_name = tail_pair['head']
            tail_name = tail_pair['tail']
            pos = None
            for argument in recursive_clause.arguments:
                if argument['val'] == head_name:
                    pos = argument['pos']
                    break
            if pos is None:
                return None
            list_pos_to_head_tail[pos] = (head_name, tail_name)
        if len(list_pos_to_head_tail) == 0:
            return None

        # Base clause must pattern-match all list positions as empty lists.
        if base_clause.pattern_matches is None:
            return None
        empty_positions = set()
        for pm in [p['val'] for p in base_clause.pattern_matches]:
            if isinstance(pm, PatternMatchEmptyList):
                empty_positions.add(pm.position)
        if set(list_pos_to_head_tail.keys()) != empty_positions:
            return None

        recursive_call = recursive_clause.body[-1]

        # Recursive call list args must pass tail symbols directly.
        for pos, (_, tail_name) in list_pos_to_head_tail.items():
            arg = recursive_call.args[pos]
            if not isinstance(arg, Identifier) or arg.name != tail_name:
                return None

        scalar_positions = [i for i in range(arity) if i not in list_pos_to_head_tail]
        if len(scalar_positions) == 0:
            return None

        scalar_pos_by_name = {}
        for argument in recursive_clause.arguments:
            pos = argument['pos']
            name = argument['val']
            if pos in scalar_positions and name != '_':
                scalar_pos_by_name[name] = pos
        if len(scalar_pos_by_name) == 0:
            return None

        # Build mapping from head symbol to array argument alias used in helper.
        head_to_array_name = {}
        for pos, (head_name, _) in list_pos_to_head_tail.items():
            head_to_array_name[head_name] = 'arr{idx}'.format(idx=pos)

        # Precondition support for loop clause is intentionally conservative.
        if recursive_clause.preconditions is not None:
            return None

        # Build scalar updates for each loop iteration from recursive tail call args.
        update_expr_by_pos = {}
        for pos in scalar_positions:
            cpp = self._d64_array_tailrec_expr_to_cpp(
                recursive_call.args[pos], scalar_pos_by_name, head_to_array_name
            )
            if cpp is None:
                return None
            update_expr_by_pos[pos] = cpp

        # Build final expression (base clause return) using final scalar values.
        base_expr_cpp = self._d64_array_tailrec_expr_to_cpp(
            base_clause.body[-1], scalar_pos_by_name, {}
        )
        if base_expr_cpp is None:
            return None

        helper_name = '__funk_d64_arrtail_{name}_{arity}'.format(name=self.name, arity=arity)
        helper_args = ', '.join('const TData &a{idx}'.format(idx=i) for i in range(arity))

        lines = []
        lines.append('static double {name}({args}) {{'.format(name=helper_name, args=helper_args))
        list_positions_sorted = sorted(list_pos_to_head_tail.keys())
        for pos in list_positions_sorted:
            lines.append('    const TData &arr{idx} = a{idx};'.format(idx=pos))
        if len(list_positions_sorted) > 0:
            first_pos = list_positions_sorted[0]
            lines.append('    const std::size_t n = arr{idx}.array.size();'.format(idx=first_pos))
            for pos in list_positions_sorted[1:]:
                lines.append('    if (arr{idx}.array.size() != n) {{'.format(idx=pos))
                lines.append('        std::fprintf(stderr, "Mismatched list lengths in {name}\\n");'.format(name=self.name))
                lines.append('        std::exit(1);')
                lines.append('    }')

        for pos in scalar_positions:
            lines.append('    double arg{idx} = a{idx}.d64;'.format(idx=pos))

        lines.append('    for (std::size_t idx = 0; idx < n; idx++) {')
        for pos in scalar_positions:
            lines.append('        const double next_arg{idx} = {expr};'.format(idx=pos, expr=update_expr_by_pos[pos]))
        for pos in scalar_positions:
            lines.append('        arg{idx} = next_arg{idx};'.format(idx=pos))
        lines.append('    }')
        lines.append('    return {expr};'.format(expr=base_expr_cpp))
        lines.append('}')

        list_type_checks = ''.join(
            ' && argument_list[{i}].type == funky_type::array && funky::is_homogeneous_d64_array(argument_list[{i}])'.format(i=i)
            for i in list_positions_sorted
        )
        scalar_type_checks = ''.join(
            ' && argument_list[{i}].type == funky_type::d64'.format(i=i)
            for i in scalar_positions
        )
        call_args = ', '.join('argument_list[{i}]'.format(i=i) for i in range(arity))
        guard = """
        if (argument_list.size() == {arity}{list_checks}{scalar_checks}) {{
            __retval__ = TData({helper_name}({call_args}));
            return __retval__;
        }}
        """.format(
            arity=arity,
            list_checks=list_type_checks,
            scalar_checks=scalar_type_checks,
            helper_name=helper_name,
            call_args=call_args
        )
        return {'helper_code': '\n'.join(lines) + '\n', 'guard_code': guard}

    def emit_main(self):
        if len(self.clauses) != 1:
            raise Exception('-E- \'emit_main\' Internal error')
        clause = self.clauses[0]

        self.funk.function_scope.current_function_clause = clause

        clause.funk.emitter.code += """
    } // namespace funky
    int main(void) {
        try {
            std::random_device rd;
            g_funky_random_engine = std::default_random_engine(rd());
                    """
        for stmt in clause.body:
            stmt.check_undefined_variables_in_scope()
            stmt.eval()
        clause.funk.emitter.code += """
            return 0;
            }
            catch (std::string e){
                std::cerr << "-E- Funky Runtime error: " << e << std::endl;
            }
            catch(...){
                std::cerr << "-E- Funky Runtime error" << std::endl;
            }
        }
        namespace funky {
        """

    def emit_function(self):
        d64_array_tailrec_lowering = self._build_d64_array_tailrec_lowering()
        i32_lowering = self._build_i32_lowering()
        d64_lowering = self._build_d64_lowering()
        if d64_array_tailrec_lowering is not None:
            self.clauses[0].funk.emitter.code += """
                {helper_code}
            """.format(helper_code=d64_array_tailrec_lowering['helper_code'])
        if i32_lowering is not None:
            self.clauses[0].funk.emitter.code += """
                {helper_code}
            """.format(helper_code=i32_lowering['helper_code'])
        if d64_lowering is not None:
            self.clauses[0].funk.emitter.code += """
                {helper_code}
            """.format(helper_code=d64_lowering['helper_code'])

        has_tail_recursion = any([insn.name == self.name and isinstance(insn, FunctionCall) for insn in
                                  [clause.body[-1] for clause in self.clauses]])

        if has_tail_recursion:
            self.clauses[0].funk.emitter.code += """

                TData {fn_name}(std::vector<TData> & original_argument_list) {{
                    // move into local storage for tail recursion rewrites
                    std::vector<TData> argument_list = std::move(original_argument_list);
                    TData __retval__(funky_type::invalid);
                    label_function_start:
                    """.format(fn_name=self.name)
        else:
            self.clauses[0].funk.emitter.code += """
                TData {fn_name}(std::vector<TData> & argument_list) {{
                    TData __retval__(funky_type::invalid);
        """.format(fn_name=self.name)

        if d64_array_tailrec_lowering is not None:
            self.clauses[0].funk.emitter.code += d64_array_tailrec_lowering['guard_code']
        if i32_lowering is not None:
            self.clauses[0].funk.emitter.code += i32_lowering['guard_code']
        if d64_lowering is not None:
            self.clauses[0].funk.emitter.code += d64_lowering['guard_code']

        for clause_index, clause in enumerate(self.clauses):

            self.funk.function_scope.current_function_clause = clause
            pattern_match_auxiliary_variables = ''
            pattern_matches = []
            has_pattern_matches = clause.pattern_matches is not None and len(clause.pattern_matches) > 0

            pattern_match_arg_positions = set()
            if has_pattern_matches:
                for pm in [p['val'] for p in clause.pattern_matches]:
                    i = pm.position
                    pattern_match_arg_positions.add(i)
                    arg_ref = '__arg{idx}_{clause_idx}'.format(idx=i, clause_idx=clause_index)
                    if isinstance(pm, PatternMatchEmptyList):
                        pattern_matches.append(
                            '{arg}.type == funky_type::array && {arg}.array.size() == 0'.format(
                                arg=arg_ref))
                    elif isinstance(pm, PatternMatchLiteral):
                        if pm.type == funky_types.int:
                            pattern_matches.append('{arg}.i32 == {val}'.format(arg=arg_ref, val=pm.value))
                        elif pm.type == funky_types.double:
                            pattern_matches.append('{arg}.d64 == {val}'.format(arg=arg_ref, val=pm.value))
                    elif isinstance(pm, PatternMatchListOfIdentifiers):
                        condition = '{arg}.array.size() =={val}'.format(arg=arg_ref, val=len(pm.elements))
                        pattern_matches.append(condition)
                        # this a list and it pattern matches elements from the list
                        for j, element in enumerate(pm.elements):
                            if isinstance(element, Identifier):
                                pattern_match_auxiliary_variables += """
                    TData {name} = {arg}.array[{j}];

                    """.format(name=element.name, arg=arg_ref, j=j)
                            if isinstance(element, IntegerConstant):
                                condition = 'TData({arg}.array[{j}] == {val}).i32 == 1'.format(
                                    arg=arg_ref, j=j, val=element.eval())

                                pattern_matches.append(condition)

            pattern_matches_string = ''
            if has_pattern_matches and len(pattern_matches) > 0:
                pattern_matches_string = '&& {} // pattern matches'.format('&& '.join(str(e) for e in pattern_matches))

            tail_pair_check = ''

            arity_check = ''

            if clause.check_arity:
                arity_check = '&& (argument_list.size() == {clause_arity})'.format(clause_arity=clause.arity)

            pattern_match_arg_refs = ''
            if len(pattern_match_arg_positions) > 0:
                pattern_match_arg_refs = '\n        ' + '\n        '.join(
                    'const TData &__arg{idx}_{clause_idx} = argument_list[{idx}];'.format(
                        idx=idx, clause_idx=clause_index)
                    for idx in sorted(pattern_match_arg_positions)
                )

            clause.funk.emitter.code += """
        {pattern_match_arg_refs}

        if ( true
             {arity_check}
             {tail_pair_check}
             {pattern_matches}
             ) {{

                {pattern_match_auxiliary_variables}
            """.format(arity_check=arity_check,
                       tail_pair_check=tail_pair_check, clause_arity=clause.arity,
                       pattern_matches=pattern_matches_string,
                       pattern_match_auxiliary_variables=pattern_match_auxiliary_variables,
                       pattern_match_arg_refs=pattern_match_arg_refs)

            if clause.fill_etc:
                clause.funk.emitter.code += """
                    // etc
                    std::vector<TData> etc{{ argument_list.begin() + {offset}, argument_list.end() }};
                    """.format(offset=clause.arguments[-1]['pos'] + 1)

            insn = clause.body[-1]
            last_insn_is_tail_recursive = insn.name == self.name and isinstance(insn, FunctionCall) and len(insn.args) == len(clause.arguments)
            for argument in clause.arguments:
                if argument['val'] != '_':
                    ref = ''
                    if len(clause.tail_pairs) == 0:
                        ref = '&'
                    clause.funk.emitter.code += """
        TData {ref} {argument} = argument_list[{i}];   """.format(argument=argument['val'], i=argument['pos'], ref=ref)

            for argument in clause.tail_pairs:
                self.funk.emitter.create_anon()
                clause.funk.emitter.code += """
       if ({head}.type != funky_type::array) {{
            throw std::string("in function {function_name}: {list_arg} is not an array");
       }}
       TData  {list_arg} = {head};

       if ({list_arg}.array.size() > 0) {{
            {head} = {list_arg}.array.front();
            {list_arg}.array.erase({list_arg}.array.begin());
       }} else {{
            {head} = std::vector<TData>(); //empty list
       }}

                     """.format(head=argument['head'], list_arg=argument['tail'], function_name=clause.name)

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
                next_args = []
                for i, arg in enumerate(clause.body[-1].args):
                    next_arg = clause.funk.emitter.create_anon()
                    clause.funk.emitter.code += """
                TData {next_arg};
                """.format(next_arg=next_arg)
                    arg.eval(result=next_arg)
                    next_args.append(next_arg)
                for i, next_arg in enumerate(next_args):
                    clause.funk.emitter.code += """
                argument_list[{i}] = {function_parameter};
                """.format(i=i, function_parameter=next_arg)
                clause.funk.emitter.code += """
                goto label_function_start;
                """
            else:
                clause.body[-1].eval(result='__retval__')

            clause.funk.emitter.code += """
             if (__retval__.type == funky_type::invalid) {{
                throw std::string(" returning invalid type in function \'{function_name}\' arity:{arity}");
            }}
            """.format(function_name=clause.name, arity=clause.arity)

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

        self.funk.emitter.code += """
        // No clause was hit
        std::cout << "No overload of function '{fn_name}' matches inputs" << std::endl;
        for (const auto & arg : argument_list){{
            std::cout << arg << std::endl;

        }}

        """.format(fn_name=self.name)

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
        return


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
        return self.fmt_str


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


class Print:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.print_funk(self.arg)


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
