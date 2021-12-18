# -*- coding: utf-8 -*-
#
# Copyright (C) 2021 Diego Valverde
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


from . import funk_types
import collections
import copy
import types
from functools import reduce


def debug_print(funk, strings):
    arr = [StringConstant(funk, str) for str in strings]
    funk.emitter.print_funk(funk, arr)


def flatten(x):
    if isinstance(x, collections.Iterable):
        return [a for i in x for a in flatten(i)]
    elif isinstance(x, List):
        return [a for i in x.elements for a in flatten(i)]
    else:
        return [x]


def list_concat_tail(funk, left, right, result=None):
    """
    This corresponds to:
        [MyArray] <~ x
    """

    if result is None:
        result = funk.emitter.create_anon()
        funk.emitter.code += """
    struct tnode {result};
        """.format(result=result)

    funk.emitter.add_comment('Concatenating two arrays')
    if isinstance(left,List):
        L = CompileTimeExprList(funk,'list concat',left.elements).eval()
    else:
        L = left.eval()

    R = right.eval()

    funk.emitter.code += """

    {result} = funk_append_element_to_list(&{L},&{R});
    """.format(result=result, L=L, R=R)

    return result


def list_concat_head(funk, left, right, result=None):
    """
    This corresponds to:
        X ~> [MyArray]

    Note that this operation will allocate the resulting
    list in the Heap.

    """

    if result is None:
        result = funk.emitter.create_anon()

    funk.emitter.add_comment('Concatenating head to array')
    ptr_left = left.eval()

    if isinstance(ptr_left, int):
        ptr_left = funk.emitter.alloc_tnode('', ptr_left, funk_types.function_pool, funk_types.int)
    ptr_right = right.eval()

    funk.emitter.code += """
    funk_prepend_element_to_list(&{dst},&{L},&{R});
    """.format(dst=result, L=ptr_left, R=ptr_right )
    return result


def create_ast_named_symbol(name, funk, right, pool):
    symbol_name = '{}_{}_{}'.format(funk.function_scope.name, funk.function_scope.clause_idx, name)

    if symbol_name in funk.symbol_table:
        print('symbol table', funk.symbol_table)
        raise Exception('=== Variables are immutable \'{}\' '.format(name))

    if isinstance(right, List):
        funk.symbol_table[symbol_name] = right.eval()
    elif isinstance(right, IntegerConstant) or isinstance(right, DoubleConstant):
        funk.symbol_table[symbol_name] = funk.alloc_literal_symbol(right, pool, symbol_name)
    else:
        funk.symbol_table[symbol_name] = funk.create_variable_symbol(right, symbol_name)

    if isinstance(right, FunctionCall) or isinstance(right, List):
        funk.function_scope.lhs_symbols.append(funk.symbol_table[symbol_name])


def create_ast_anon_symbol(funk, right, pool):
    if isinstance(right, IntegerConstant) or isinstance(right, DoubleConstant):
        return funk.alloc_literal_symbol(right, pool, 'anon')
    else:
        return right.eval()

class Expression:
    def __init__(self):
        self.args = None
        self.pool = funk_types.function_pool

    def replace_symbol(self, symbol, value):
        pass

class IntegerConstant:
    def __init__(self, funk, value, sign=1):
        self.value = value
        self.funk = funk
        self.sign = sign
        self.name = ''

    def replace_symbol(self, symbol, value):
        pass

    def get_compile_type(self):
        return funk_types.int

    def __repr__(self):
        sign = '-' if self.sign == -1 else ''
        return 'Integer({}{})'.format(sign,self.value)

    def eval(self, result=None):

        value = self.sign * int(self.value)
        if result is not None:
            self.funk.emitter.code += """
            funk_create_i32_scalar(function_pool, &{result}, {val});
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

    def get_compile_type(self):
        return funk_types.double

    def __repr__(self):
        return 'DoubleConstant({})'.format(self.value)

    def eval(self, result=None):
        value = self.sign * float(self.value)
        if result is not None:
            self.funk.emitter.code += """
            funk_create_d64_scalar(function_pool, &{result}, {val});
            """.format(result=result, val=value)
        #     self.funk.emitter.alloc_tnode(name=result, value=value, pool=funk_types.function_pool,
        #                                   data_type=funk_types.double)
        else:
            self.funk.emitter.alloc_tnode(name='anon', value=value, pool=funk_types.function_pool,
                                          data_type=funk_types.double)


        return value

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return DoubleConstant(self.funk, value=copy.deepcopy(self.value, memo), sign=self.sign)


class StringConstant:
    def __init__(self, funk, value):
        self.value = value
        self.funk = funk
        self.sign = 1
        self.name = ''

    def replace_symbol(self, symbol, value):
        if symbol == self.value:
            self.value = value

    def eval(self):
        return self.value

    def __repr__(self):
        return 'StringConstant({})'.format(self.value)

    def get_compile_type(self):
        return funk_types.string

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return StringConstant(self.funk, value=copy.deepcopy(self.value, memo))


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

    def get_dimensions(self):
        def traverse(x, dimensions=[]):
            elements = []
            if isinstance(x, collections.Iterable): elements = x
            elif isinstance(x, List): elements = x.elements
            dimensions.append(len(elements))

            if len(elements) >0:
                if isinstance(elements[0],List) or isinstance(elements[0], collections.Iterable):
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


class VariableList(List):
    def __init__(self, funk, iterator, start, end, start_inclusive, end_inclusive, expr):
        self.funk = funk
        self.iterator = iterator
        self.start = start
        self.end = end
        self.start_inclusive = start_inclusive == '<='
        self.end_inclusive = end_inclusive == '<='
        self.expr = expr

    def __repr__(self):
        return 'VariableList({},{})'.format(self.start, self.end)

    def eval(self, result=None):
        start = self.start.eval()
        end = self.end.eval()

        if not self.start_inclusive:
            start = self.funk.emitter.add(start, 1)

        if not self.end_inclusive:
            end = self.funk.emitter.sub(end, 1)

        return self.funk.emitter.create_variable_range_list(self.expr, self.identifier, start, end, resut=result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return VariableList(funk=self.funk, iterator=copy.deepcopy(self.iterator, memo),
                            start=copy.deepcopy(self.start, memo),
                            end=copy.deepcopy(self.end, memo),
                            expr=copy.deepcopy(self.expr, memo),
                            start_inclusive = self.start_inclusive,
                            end_inclusive = self.end_inclusive
                            )


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

        if len(self.elements) == 1 and isinstance(self.elements[0], Range):
            return self.elements[0].eval(result=result)

        flattened_list = self.elements

        elements = []
        for element in self.elements:
            if isinstance(element, IntegerConstant):
                reg = self.funk.emitter.alloc_tnode('anon', element.eval(),
                                                              funk_types.function_pool, funk_types.int )

                elements.append(reg)
            elif isinstance(element, DoubleConstant):
                reg = self.funk.emitter.alloc_tnode('anon', element.eval(),
                                                    funk_types.function_pool, funk_types.double)

                elements.append(reg)
            else:
                ### HERE !!!!!!!
                elements.append(element.eval())#result=result))
#DIEGO
        if len(flattened_list) == 1 and isinstance(flattened_list[0], Range):
            return elements[0]
        else:
            return self.funk.alloc_compile_time_expr_list(elements, self.get_dimensions(), self.pool, result=result)

    def __repr__(self):
        return 'CompileTimeExprList({})'.format(self.elements)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return CompileTimeExprList(self.funk, name=self.name, elements=copy.deepcopy(self.elements, memo))


class Include():
    def __init__(self, funk, elements):
        self.funk = funk
        self.elements = elements

    def eval(self, result=None):
        for include in self.elements:
            self.funk.emitter.code += """
          #include "{filename}.h"
          """.format(filename=include)


class FixedSizeLiteralList(List):

    def __init__(self, funk, name, elements):
        super().__init__(funk, name, elements)
        self.funk = funk
        self.name = name
        self.elements = elements

    def eval(self, result=None):

        dimensions = self.get_dimensions()
        flattened_list = flatten(self.elements)

        literal_list = []
        for element in flattened_list:
            literal_list.append(element.eval())

        return self.funk.alloc_literal_list_symbol(literal_list, dimensions, self.pool, result=result)

    def __repr__(self):
        return 'FixedSizeLiteralList({})'.format(self.elements)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FixedSizeLiteralList(self.funk, name=self.name, elements=copy.deepcopy(self.elements, memo))


class Identifier:
    def __init__(self, funk, name, indexes=None):
        self.funk = funk
        self.indexes = indexes # indexes for multidimensional array

        if name == '_':
            self.name = '_{}'.format(self.funk.empty_arg_count)
            self.funk.empty_arg_count += 1
        else:
            self.name = name
        self.is_literal = False

    def get_compile_type(self):
        return None

    def __repr__(self):
        string = 'Identifier({})'.format(self.name)
        if self.indexes is not None:
            string += '{}'.format(self.indexes)

        return string

    def index_emit_helper(self, node, indexes, result):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
                  struct tnode {result};
                  """.format(result=result)

        list_start = []
        list_end = []
        list_is_range_type = []
        for idx in indexes:
            if isinstance(idx, Range):
                list_is_range_type.append(1)
                if isinstance(idx.left, IntegerConstant):
                    list_start.append(idx.left.eval())
                else:
                    list_start.append('DATA(&{},0)->data.i32'.format(idx.left.eval()))

                if isinstance(idx.right, IntegerConstant):
                    list_end.append(idx.right.eval())
                else:
                    list_end.append('DATA(&{},0)->data.i32'.format(idx.right.eval()))
            elif isinstance(idx, IntegerConstant):
                list_is_range_type.append(0)
                list_start.append(idx.eval())
                list_end.append(idx.eval())
            else:
                list_is_range_type.append(0)
                list_start.append('DATA(&{},0)->data.i32'.format(idx.eval()))
                list_end.append('DATA(&{},0)->data.i32'.format(idx.eval()))

        self.funk.emitter.code += """
        {{
            int start[] = {{ {list_start} }};
            int end[] = {{ {list_end} }};
            int is_range[] = {{ {list_is_range} }};
             // note that the ranges operate recursively
             // this allows doing things like sliding windows
             // for example: M[n..m, n..m] is a rectangular
             // window into a matrix

             {result} = funky_get_element_range({depth}, &{node}, start, end, is_range);
        }}
        """.format(list_start=', '.join(str(e) for e in list_start),
                   list_end=', '.join(str(e) for e in list_end),
                   depth=len(indexes), node=node, result=result,
                   list_is_range=', '.join(str(e) for e in list_is_range_type))

        return result

    def eval_node_index(self,node,result=None):

        if self.indexes is not None:
            return self.index_emit_helper(node, copy.deepcopy(self.indexes), result)
        else:
            if result is not None:
                self.funk.emitter.code += """
        {result} = {node};
                """.format(result=result,node=node)
            return node

    def pattern_match_list_of_identifiers(self, result):
        """

        foo([ x, y, z]):
            say(y)
        """
        for pm in self.funk.function_scope.pattern_matches:
            if isinstance(pm, PatternMatchListOfIdentifiers):
                for i in range(len(pm.elements)):

                    pm_element = pm.elements[i]
                    if self.name == pm_element.name:


                        list_node = self.funk.emitter.get_function_argument_tnode(pm.position)
                        element_node = self.funk.emitter.alloc_tnode('', 0, pool=funk_types.function_pool,
                                                                     data_type=funk_types.int)


                        self.funk.emitter.get_element_in_list_of_regs(dst=element_node, src=list_node, i=i)
                        # if len(element_node) != len(pm.elements) ...

                        if result is not None:
                            self.funk.emitter.copy_node(element_node, result)
                        return element_node
        return None

    def eval(self, result=None):
        # Check the current function that we are building
        # To see if the identifier is a function argument
        if self.name in self.funk.symbol_table:
            anon = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        struct tnode {anon};
        funk_create_node(&{anon}, 1,
                  function_pool, type_function,
                  0, (void *) {name});
        """.format(anon=anon, name=self.name)
            return anon
        else:
            return self.eval_node_index(self.name, result)

    def replace_symbol(self, symbol, value):

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
        self.is_literal = False

    def __repr__(self):
        return 'HeadTail({},{})'.format(self.head, self.tail)

    def eval(self, result=None):


        self.funk.emitter.code += """
        funk_copy_first_element_from_list(&{head},&{tail});
        funky_pop_first(&{tail});
        """.format(head=self.head, tail=self.tail)

        return result

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return HeadTail(self.funk, head=copy.deepcopy(self.head, memo), tail=copy.deepcopy(self.tail, memo))


class PatternMatch:
    def __init__(self, funk):
        self.funk = funk
        self.is_literal = True
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
        self.is_literal = False

    def __repr__(self):
        return 'PatternMatchEmptyList()'

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchEmptyList(self.funk)


class PatternMatchLiteral(PatternMatch):
    def __init__(self, funk, value):
        PatternMatch.__init__(self, funk)
        self.funk = funk
        self.value = value.eval()

        if isinstance(value, IntegerConstant):
            self.type = funk_types.int
        elif isinstance(value, DoubleConstant):
            self.type = funk_types.double
        else:
            self.type = funk_types.invalid

        self.is_literal = True

    def __repr__(self):
        return 'PatternMatchLiteral({})'.format(self.value)

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchLiteral(self.funk,value=copy.deepcopy(self.value, memo))

class PatternMatchIdentifier(PatternMatch):
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name
        self.is_literal = False

    def __repr__(self):
        return 'PatternMatchIdentifier({})'.format(self.name)

    def eval(self, result=None):
        pass

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return PatternMatchIdentifier(self.funk,name=copy.deepcopy(self.name, memo))

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
        return PatternMatchListOfIdentifiers(self.funk,name=copy.deepcopy(self.name, memo))

class BinaryOp(Expression):
    def __init__(self, funk, left=None, right=None, indexes=None):
        self.funk = funk
        self.left = left
        self.right = right
        self.indexes = indexes
        self.pool = funk_types.function_pool

    def replace_symbol(self, symbol, value):
        if self.left is not  None:
            if self.left.__repr__() == symbol.__repr__():
                self.left = value
            else:
                self.left.replace_symbol(symbol, value)

        if self.right is not None:
            if self.right.__repr__() == symbol.__repr__():
                self.right = value
            else:
                self.right.replace_symbol(symbol, value)

    def get_compile_type(self):
        # if either operand is float, then auto promote to float at compile time
        # if isinstance(self.right, DoubleConstant) or isinstance(self.left, DoubleConstant):
        #     return funk_types.double
        # else:
        #     return funk_types.int
        return funk_types.unknown

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return BinaryOp(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sum(BinaryOp):
    def __repr__(self):
        return 'Sum({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.arith_helper(self.left.eval(), self.right.eval(),'add', result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Sum(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class Mul(BinaryOp):
    def __repr__(self):
        return 'Mul({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.arith_helper(self.left.eval(), self.right.eval(), 'mul' ,result=result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Mul(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sub(BinaryOp):
    def __repr__(self):
        return 'Sub({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        i = self.funk.emitter.arith_helper(self.left.eval(), self.right.eval(), 'sub',result=result)
        return i

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Sub(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class Div(BinaryOp):
    def __repr__(self):
        return 'Div({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.arith_helper(self.left.eval(), self.right.eval(), 'div', result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Div(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class Mod(BinaryOp):
    def __repr__(self):
        return 'Mod({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.srem(self.left.eval(), self.right.eval(), result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Mod(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class And(BinaryOp):
    def __repr__(self):
        return 'And({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.boolean_op('and',self.left.eval(), self.right.eval(), result)

class Or(BinaryOp):
    def __repr__(self):
        return 'Or({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.boolean_op('or', self.left.eval(), self.right.eval(), result)

class BoolBinaryOp(BinaryOp):
    def eval(self, as_type, result=None):
        lval = self.left.eval()
        rval = self.right.eval()

        return lval, rval

class GreaterThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterThan({} , {})'.format('sgt',self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('ogt', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('sgt', l, r)

class EqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'Equal({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        l, r = BoolBinaryOp.eval(self, result)
        return self.funk.emitter.icmp_signed('eq', l, r)

class NotEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'NotEqual({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        l, r = BoolBinaryOp.eval(self, result)
        return self.funk.emitter.icmp_signed('ne', l, r)

class LessThan(BoolBinaryOp):
    def __repr__(self):
        return 'LessThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('flt', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('slt', l, r)

class GreaterOrEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterOrEqualThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('fge', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('sge', l, r)

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


class ListUnion(BinaryOp):
    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.direction = ListConcat.head

    def __repr__(self):
        return 'ListUnion({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        """
        This corresponds to:
            [A] ++ [B]
        """

        self.funk.emitter.add_comment('List Union')

        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        struct tnode {result};
            """.format(result=result)

        L=self.left.eval()
        R=self.right.eval()
        self.funk.emitter.code += """
            {result} = funk_concatenate_lists(&{L},&{R});
        """.format(result=result, L=L, R=R )

        return result

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return ListUnion(self.funk, left=copy.deepcopy(self.left, memo),
                     right=copy.deepcopy(self.right, memo))

class ListConcatTail(BinaryOp):
    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
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

    def eval(self, result=None):
        self.funk.emitter.code += """
        struct tnode {};
        """.format(self.left.name);

        self.right.eval(result=self.left.name)
        #create_ast_named_symbol(name, self.funk, self.right, self.pool)


class Range(BinaryOp):
    def __init__(self, funk,  lhs=None, rhs=None, identifier=None, expr=None, rhs_type='<', lhs_type='<'):
        self.funk = funk
        self.identifier = identifier
        self.lhs_type = lhs_type
        self.rhs_type = rhs_type
        self.expr = expr
        self.right = rhs
        self.left = lhs

    def __repr__(self):
        return 'Range({} | {} {} {} {} {})'.format(self.expr, self.left, self.lhs_type, self.identifier, self.rhs_type, self.right)

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
        return ExprRange(self.funk,self.left, self.right, self.identifier, self.expr,
                         lhs_type= self.lhs_type, rhs_type=self.rhs_type)

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
        self.reg_start= None
        self.reg_end=None
        self.range_register_calculation_emitted = False

    def get_range_len(self):
        #self.calculate_ranges()
        return self.funk.emitter.arith_helper(self.reg_end, self.reg_start, operation='sub' )

    def calculate_ranges(self):

        reg_start = self.funk.emitter.alloc_tnode('start', 0, funk_types.function_pool,
                                                  funk_types.int)

        reg_end = self.funk.emitter.alloc_tnode('end', 0, funk_types.function_pool,
                                                funk_types.int)

        if isinstance(self.left, IntegerConstant):
            start_val = self.left.eval()
        else:
            start_val = self.funk.emitter.get_node_data_value(self.left.eval())

        if isinstance(self.right, IntegerConstant):
            end_val = self.right.eval()
        else:
            end_val = self.funk.emitter.get_node_data_value(self.right.eval())

        self.funk.emitter.set_node_data_value('start', reg_start, start_val)

        self.funk.emitter.set_node_data_value('end', reg_end, end_val)

        if self.lhs_type == '<':
            self.funk.emitter.increment_node_value_int(reg_start)

        if self.rhs_type == '<=':
            self.funk.emitter.increment_node_value_int(reg_end)

        self.reg_start = reg_start
        self.reg_end = reg_end

        self.range_register_calculation_emitted = True

    def eval(self, result=None, parent_tnode_list=None, parent_offset=None):
        if result is None or result == 'anon':
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            struct tnode {result};
            """.format(result=result)

        if isinstance(self.left, IntegerConstant):
            start = self.left.eval()
        else:
            start = 'DATA(&{},0)->data.i32'.format(self.left.eval())

        if isinstance(self.right, IntegerConstant):
            end = self.right.eval()
        else:
            end = 'DATA(&{},0)->data.i32'.format(self.right.eval())



        if self.lhs_type == '<':
            start += 1

        if self.rhs_type == '<=':
            end += 1

        i = self.iterator_symbol.eval()

        self.funk.emitter.code += """

        {{ //start anonymous scope
            uint32_t __len__ = {end} - {start};
            funk_create_node(&{result}, 1, function_pool, type_array, 0, NULL);
            {result}.len = __len__;
            struct tnode hdr, tmp;
            funk_create_node(&hdr, 2, function_pool, type_pool_node_entry, 0, NULL);
            funk_create_node(&tmp, __len__, function_pool, type_i32, 0, NULL);
            DATA(&{result},0)->data.i32 = hdr.start;
            DATA(&hdr,0)->data.i32 = tmp.start;
            DATA(&hdr,1)->data.i32 = __len__;

            for (int {i} = 0; {i} < __len__; {i}++)
            {{
        """.format(start=start, end=end,result=result, i=i)

        if isinstance(self.expr, IntegerConstant):
            val = self.expr
            self.funk.emitter.code += """
                DATA(&tmp,{i})->data.i32 = {val};
                DATA(&tmp,{i})->type = type_i32;
            """.format(val=val.value*val.sign, i=i)
        elif isinstance(self.expr, DoubleConstant):
            val = self.expr
            self.funk.emitter.code += """
                DATA(&tmp,{i})->data.d64 = {val};
                DATA(&tmp,{i})->type = type_d64;
            """.format(val=val.value*val.sign, result=result, i=i)
        else:
            iterator = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
                struct tnode {iterator};
                funk_create_i32_scalar(function_pool,&{iterator}, {start}+{i});
            """.format(i=i, start=start,iterator=iterator)

            self.expr.replace_symbol(Identifier(self.funk, i), Identifier(self.funk,iterator))
            val = self.expr.eval()
            if val == i:
                val = iterator

            self.funk.emitter.code += """
                if (DATA(&tmp,{i})->type == type_array){{
                    DATA(&tmp,{i})->data.i32 = _copy_node_to_pool(&{val});
                    DATA(&tmp,{i})->type = type_pool_node_entry;
                }} else {{
                    //??
                    DATA(&tmp,{i})->data = DATA(&{val},0)->data;
                    DATA(&tmp,{i})->type = DATA(&{val},0)->type;
                }}
            """.format(val=val, result=result, i=i)
        self.funk.emitter.code += """
            }}
        }} // end anonymous scope
        """.format(val=val, result=result)

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
 struct tnode  {name}(int,  struct tnode*);
                """.format(name=self.name[1:])


class FunctionCall(Expression):
    def __init__(self, funk, name, args):
        super().__init__()
        self.funk = funk
        self.name = name
        self.args = args
        self.system_functions = {
            'funk_set_config': SetConfigParam,
            'sleep': Sleep,
            'rand_int': RandInt,
            'rand_float': RandFloat,
            'say': Print,
            'info': DebugInfo,
            'ppool': PrintPool,
            'len': Len,
            'flatten': Flatten,
            'sum': FunkSum,
            'not': FunkNot,
            'roll': FunkRoll,
            'dim': Dim,
            'sdl_window': SDLCreateWindow,
            'sdl_rect':SDLRect,
            'sdl_point': SDLPoint,
            'sdl_line': SDLLine,
            'sdl_set_color':SDLColor,
            'sdl_render': SDLRenderFunction,
            'exit': Exit,
            'fread_list': FReadList,
            'reshape': ReShape,
        }

    def get_compile_type(self):
        if self.name in self.system_functions:
            return self.system_functions[self.name].get_compile_type()
        else:
            return None

    def __repr__(self):
        return 'FunctionCall({}({}))'.format(self.name, self.args)

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

        # First check if this is globally defined function
        if name in self.funk.functions or '@{}'.format(name) in self.funk.functions:
            arguments=[]
            if self.args is not None:
                arguments=[create_ast_anon_symbol(self.funk, a, self.pool) for a in self.args]

            return self.funk.emitter.call_function(self.funk, name, arguments, result=result)
        elif name in self.funk.function_scope.args:
            arguments = []
            if self.args is not None:
                arguments = [create_ast_anon_symbol(self.funk, a, self.pool) for a in self.args]
            self.funk.emitter.code += """
        if (DATA(&{name},0)->type != type_function){{
            printf("Error: {name} is not a function\\n");
            exit(1);
        }}

        if (DATA(&{name},0)->data.fn == NULL){{
            printf("Error: {name} function is NULL\\n");
            exit(1);
        }}
            """.format(name=name)
            return self.funk.emitter.call_function(self.funk, 'DATA(&{},0)->data.fn'.format(name), arguments, result=result)

        if not found:
            raise Exception('Undeclared function \'{}\' '.format(self.name))

        return None

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FunctionCall(self.funk, name=self.name, args=copy.deepcopy(self.args, memo))


class FunctionClause:
    def __init__(self, funk, name, fn_body, preconditions, pattern_matches, tail_pairs=None, arguments=None):
        if arguments is None:
            arguments = []
        if tail_pairs is None:
            tail_pairs = []
        self.body = fn_body
        self.name = name
        self.arguments = arguments
        self.preconditions = preconditions
        self.pattern_matches = pattern_matches
        self.tail_pairs = tail_pairs
        self.funk = funk


class FunctionMap:
    def __init__(self, funk, name, arguments=None, tail_pairs=None, pattern_matches=None):
        if arguments is None:
            arguments = []
        # if tail_pairs is None:
        #     tail_pairs = []
        # if pattern_matches is None:
        #     pattern_matches = []
        self.funk = funk
        self.name = name
        self.arity = len(arguments)
        self.clauses = []  # list of clauses
        self.arguments = arguments
        self.tail_pairs = tail_pairs
        self.pattern_matches = pattern_matches

    def emit_main(self):

        for clause in self.clauses:
            clause.funk.emitter.code += """
    int main(void) {
                    """
            for stmt in clause.body:
                stmt.eval()
        clause.funk.emitter.code += """
            return 0;
        }"""

    def emit_function(self):
        self.clauses[0].funk.emitter.code += """
    struct tnode {fn_name}(int arity,  struct tnode * argument_list) {{
        struct tnode __retval__;
        funk_create_i32_scalar((arity > 0) ? get_pool_enum(argument_list[0].pool) : function_pool, &__retval__, -255);
        """.format(fn_name=self.name)

        for clause in self.clauses:
            pattern_match_auxiliary_variables = ''
            pattern_matches = []
            has_pattern_matches = clause.pattern_matches is not None and len(clause.pattern_matches) > 0

            if has_pattern_matches:
                for pm in clause.pattern_matches:
                    i = pm.position
                    if isinstance(pm, PatternMatchEmptyList):
                        pattern_matches.append('(DATA(&argument_list[{i}],0)->type == type_empty_array)'.format(i=i))
                    elif isinstance(pm, PatternMatchLiteral):
                        if pm.type == funk_types.int:
                            pattern_matches.append('DATA(&argument_list[{}],0)->data.i32 == {}'.format(i, pm.value))
                        elif pm.type == funk_types.double:
                            pattern_matches.append('DATA(&argument_list[{}],0)->data.d64 == {}'.format(i, pm.value))
                    elif isinstance(pm,PatternMatchListOfIdentifiers):
                        condition='__get_len(argument_list + {})=={}'.format(i,len(pm.elements))
                        pattern_matches.append(condition)
                        # this a list and it pattern matches elements from the list
                        for j,element in enumerate(pm.elements):
                            if isinstance(element,Identifier):
                                pattern_match_auxiliary_variables += """
                    struct tnode {name};
                    funk_get_element_in_array(argument_list+{i},&{name},{j});
                    """.format(name=element.name, i=i,j=j)
                            if isinstance(element,IntegerConstant):


                                condition ='funky_cmp_element_in_array_int(&argument_list[{i}], {j}, {val}) == 1'.format(i=i, j =j, val=element.eval())

                                pattern_matches.append(condition)

            pattern_matches_string = ''
            if has_pattern_matches and len(pattern_matches) > 0:
                pattern_matches_string = '&& {} // pattern matches'.format('&& '.join(str(e) for e in pattern_matches))

            arity = len(clause.arguments)
            # TODO: ERROR FIX THIS SHIT!
            if self.name == 'next_board':
                arity = len(clause.pattern_matches) + len(clause.arguments)

            if arity == 0 and clause.pattern_matches is not None:
                arity = len(clause.pattern_matches)

            tail_pair_check = ''
            if False:#len(clause.tail_pairs) > 0:
                tail_pair_check =  '&& '+'&& '.join(['(DATA(argument_list+{i},0)->type == type_array)'.format(i=clause.arguments.index(tail[0])) for tail in clause.tail_pairs])
            clause.funk.emitter.code += """
        if (arity == {clause_arity}
            {pattern_matches}
            {tail_pair_check}
            ) {{
            {pattern_match_auxiliary_variables}
            """.format(tail_pair_check=tail_pair_check, clause_arity=arity,pattern_matches=pattern_matches_string,pattern_match_auxiliary_variables=pattern_match_auxiliary_variables)

            for i, argument in enumerate(clause.arguments):
                if argument != '_':
                    clause.funk.emitter.code += """
        struct tnode {argument} = argument_list[{i}];   """.format(argument=argument, i=i)

            for i, argument in enumerate(clause.tail_pairs):
                anon = self.funk.emitter.create_anon()
                clause.funk.emitter.code += """

       struct tnode {prev_tail} = {head};
       struct tnode {tail};
       funk_create_empty_list_element(get_pool_enum({prev_tail}.pool), &{tail});

       {head} = funky_pop_first(&{tail}, &{prev_tail}   ); //tail

                     """.format(prev_tail=anon, head=argument[0], tail=argument[1])

            if clause.preconditions is not None:
                self.funk.function_scope.args = clause.arguments
                preconditions_result = clause.preconditions.eval()
                clause.funk.emitter.code += """
            if (DATA(&{preconditions},0)->data.i32 == 1) {{
                    """.format(preconditions=preconditions_result)



            for stmt in clause.body[:-1]:
                self.funk.emitter.add_comment(stmt)
                stmt.eval()

            clause.body[-1].eval(result='__retval__')

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
        printf("No overload of function '{fn_name}' matches inputs:\\n");
        for (int i = 0; i < arity; i++){{
            funk_print_node(argument_list+i);
            printf("\\n");
        }}
        printf("\\n");
        """.format(fn_name=self.name)



        self.funk.emitter.code += """
        exit(1);
        return __retval__;

        }
            """

    def eval(self, result=None):
        scope_name = self.funk.create_function_scope(self.name, args=self.arguments, tail_pairs=self.tail_pairs,
                                                     empty=True)

        self.funk.set_function_scope(scope_name)

        if self.name == 'main':
            self.emit_main()
        else:
            self.emit_function()
        return



class String(Expression):
    def __init__(self, funk, fmt_str):
        super().__init__()
        self.funk = funk
        self.fmt_str = '{}'.format(fmt_str[1:-1])
        self.name = ''

    def __repr__(self):
        return 'String({})'.format(self.fmt_str)

    def eval(self, result=None):
        return self.fmt_str


class FunkNot(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        struct tnode {result};
            """.format(result=result)

        src= self.arg_list[0].eval()

        self.funk.emitter.code += """
        {result} = funk_not(&{src});
        """.format(result=result, src=src)

        return result


class FunkRoll(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        struct tnode {result};
            """.format(result=result)

        src = self.arg_list[0].eval()

        deltas = []
        for delta in self.arg_list[1:]:
            if isinstance(delta, IntegerConstant):
                deltas.append(self.funk.emitter.alloc_tnode('anon', delta.eval(),
                                                        funk_types.function_pool, funk_types.int))
            else:
                deltas.append(delta.eval())

        # deltas = [ delta.eval() for delta in self.arg_list[1:]]

        self.funk.emitter.code += """
     struct tnode {anon}[] = {{ {deltas} }};
    {result} = funk_roll(  &{src}, {anon}, {delta_count});
        """.format(anon=self.funk.emitter.create_anon(), result=result, src=src, deltas=', '.join(str(e) for e in deltas), delta_count=len(deltas))

        return result


class FunkSum(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.funk_summation_function(self.funk, self.arg_list, result=result, pool=self.pool)


class Flatten(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        struct tnode {result};
            """.format(result=result)

        src = self.arg_list[0].eval()
        self.funk.emitter.code += """
        funk_flatten(&{result}, &{src});
        """.format(result=result, src=src)
        return result


class Len(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):

        return self.funk.emitter.get_node_length(self.funk, self.arg_list, result=result)

class Dim(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.print_dim(self.funk, self.arg_list)

class DebugInfo:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.debug_print_node_info(self.funk, self.arg)


class PrintPool:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.debug_print_pool(self.funk, self.arg)


class Print:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.print_funk(self.funk, self.arg)

class RandInt:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.rand_int(self.funk, self.arg_list)

class RandFloat:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.double

    def eval(self, result=None):
        return self.funk.emitter.rand_double(self.funk, self.arg_list, result=result)

class SetConfigParam:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.set_config_parameter(self.arg_list)

class FReadList:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result):
        return self.funk.emitter.fread_list(self.funk, self.arg_list, result)

class ReShape:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result):
        return self.funk.emitter.reshape(self.funk, self.arg_list, result)

class Exit:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.exit(self.funk, self.arg_list)

class Sleep:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.sleep(self.funk, self.arg_list)

class SDLCreateWindow:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_create_window(self.funk, self.arg_list)

class SDLRenderFunction:
    """
        Requires Simple2D to be installed.
        https://github.com/simple2d/simple2d

        """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_render_callback(self.funk, self.arg_list)

class SDLLine:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_line(self.funk, self.arg_list)

class SDLPoint:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_point(self.funk, self.arg_list)

class SDLRect:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_rect(self.funk, self.arg_list)

class SDLColor:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.sdl_set_color(self.funk, self.arg_list)
