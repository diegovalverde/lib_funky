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

    funk.emitter.add_comment('Concatenating two arrays')
    if isinstance(left,List):
        ptr_left = CompileTimeExprList(funk,'list concat',left.elements).eval()
    else:
        ptr_left = left.eval()

    ptr_right = right.eval()

    #DIEGO
    #return funk.emitter.concat_list(ptr_left, ptr_right, result=result)
    return funk.emitter.append_element_to_list (ptr_left, ptr_right, result=result)


def list_concat_head(funk, left, right, result=None):
    """
    This corresponds to:
        X ~> [MyArray]

    Note that this operation will allocate the resulting
    list in the Heap.

    """

    funk.emitter.add_comment('Concatenating head to array')
    ptr_left = left.eval()

    if isinstance(ptr_left, int):
        ptr_left = funk.emitter.alloc_tnode('', ptr_left, funk_types.function_pool, funk_types.int)
    ptr_right = right.eval()

    # arr = [StringConstant(funk, str) for str in ['------- x ~> [A] ---------------------']]
    # funk.emitter.print_funk(funk, arr)

    funk.emitter.prepend_element_to_list(ptr_left, ptr_right, result=result)
    #
    # arr = [StringConstant(funk, str) for str in ['result is', result ]]
    # funk.emitter.print_funk(funk, arr)
    # funk.emitter.debug_print_node_info(funk, [StringConstant(funk, result)] )
    # arr = [StringConstant(funk, str) for str in ['-----------------------------']]
    # funk.emitter.print_funk(funk, arr)

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
            self.funk.emitter.alloc_tnode(name=result, value=value, pool=funk_types.function_pool, data_type=funk_types.int)
        # else:
        #     self.funk.emitter.alloc_tnode(name='anon', value=value, pool=funk_types.function_pool,
        #                                   data_type=funk_types.int)
            #self.funk.emitter.set_node_data_value(result, val, as_type=funk_types.int)
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
            self.funk.emitter.alloc_tnode(name=result, value=value, pool=funk_types.function_pool,
                                          data_type=funk_types.double)
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
        idx = indexes.pop()
        if len(indexes) == 0:
            return self.funk.emitter.get_element_in_array(node, idx)
        else:
            return self.funk.emitter.get_element_in_array( self.index_emit_helper(node, indexes, result), idx, result)




    def eval_node_index(self,node,result=None):
        if self.indexes is not None:
            # L[1..2]
            if len(self.indexes) == 1 and isinstance(self.indexes[0], Range):
                return self.funk.emitter.create_sub_array(node, c1=self.indexes[0].left, c2=self.indexes[0].right,
                                                      result=result)
            # M[i..j, i+1 .. j+1]
            if len(self.indexes) == 2 and isinstance(self.indexes[0], Range) and isinstance(self.indexes[1], Range):
                return self.funk.emitter.create_submatrix(node, self.indexes, result=result)
            elif len(self.indexes) > 0:
                return self.index_emit_helper(node, copy.deepcopy(self.indexes), result)
            # M[1,2]
            elif  len(self.indexes) == 2 and isinstance(self.indexes[0], IntegerConstant) and isinstance(self.indexes[1], IntegerConstant):
                return self.funk.emitter.get_element_in_array_2d_lit(node, self.indexes, result=result)
            elif len(self.indexes) == 1 and isinstance(self.indexes[0], IntegerConstant):
                # L[1]
                return self.funk.emitter.get_element_in_array(node, self.indexes, result)
            else:
                return self.funk.emitter.get_element_in_matrix(node, self.indexes, result=result)
        else:
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
        pass

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
        if isinstance(self.left, List):
            ptr_left = CompileTimeExprList(self.funk, 'list concat', self.left.elements).eval()
        else:
            ptr_left = self.left.eval()

        ptr_right = self.right.eval()

        return self.funk.emitter.concat_list(ptr_left, ptr_right, result=result)

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

        start = self.left.eval()
        end = self.right.eval()

        if self.lhs_type == '<':
            start += 1

        if self.rhs_type == '<=':
            end += 1

        self.funk.emitter.code += """
        struct tnode {result};
        {{ //start anonymous scope
            uint32_t len = {end} - {start};
            funk_create_node(&{result}, 1, function_pool, type_array, 0, NULL);
            {result}.len = len;
            struct tnode hdr, tmp;
            funk_create_node(&hdr, 2, function_pool, type_pool_node_entry, 0, NULL);
            funk_create_node(&tmp, len, function_pool, type_i32, 0, NULL);
            DATA(&{result},0)->data.i32 = hdr.start;
            DATA(&hdr,0)->data.i32 = tmp.start;
            DATA(&hdr,1)->data.i32 = len;

            for (int {i} = 0; {i} < len; {i}++)
            {{
        """.format(start=start, end=end,result=result, i=self.iterator_symbol.eval())

        if isinstance(self.expr, IntegerConstant):
            val = self.expr
            self.funk.emitter.code += """
                DATA(&tmp,i)->data.i32 = {val};
                DATA(&tmp,i)->type = type_i32;
            """.format(val=val.value*val.sign)
        elif isinstance(self.expr, DoubleConstant):
            val = self.expr
            self.funk.emitter.code += """
                DATA(&tmp,i)->data.d64 = {val};
                DATA(&tmp,i)->type = type_d64;
            """.format(val=val.value*val.sign, result=result)
        else:
            self.funk.emitter.code += """
                struct tnode __iterator__;
                funk_create_i32_scalar(function_pool,&__iterator__, i);
            """
            self.expr.replace_symbol(Identifier(self.funk,'i'), Identifier(self.funk,'__iterator__'))
            val = self.expr.eval()
            self.funk.emitter.code += """
                if (DATA(&tmp,i)->type == type_array){{
                    DATA(&tmp,i)->data.i32 = _copy_node_to_pool(&{val});
                    DATA(&tmp,i)->type = type_pool_node_entry;
                }} else {{
                    DATA(&tmp,i)->data = DATA(&{val},0)->data;
                    DATA(&tmp,i)->type = DATA(&{val},0)->type;
                }}
            """.format(val=val, result=result)
        self.funk.emitter.code += """
            }}
        }} // end anonymous scope
        """.format(val=val, result=result)

        return result

    def eval2(self, result=None, parent_tnode_list=None, parent_offset=None):

            self.funk.emitter.add_comment('START ============== ExprRange {}'.format(self.__repr__()))

            self.calculate_ranges()

            reg_start = self.reg_start

            loop_reg = self.funk.emitter.alloc_tnode('loop reg', 0, funk_types.function_pool, funk_types.int)

            list_len_reg = self.get_range_len()
            list_len_int = self.funk.emitter.get_node_data_value(list_len_reg)

            iterator_reg = self.funk.emitter.alloc_tnode('iterator_reg',
                                                         self.funk.emitter.get_node_data_value(reg_start),
                                                         funk_types.function_pool, funk_types.int)

            expr = copy.deepcopy(self.expr)
            # create a node pointer for each element in the range

            elements = self.funk.emitter.alloc_list_of_tnodes(list_len_reg)


            scope_name = self.funk.function_scope.name.replace('@', '')
            # loop
            label_loop_start = '{}_clause_{}_loop_entry__{}'.format(scope_name,
                                                                    self.funk.function_scope.clause_idx,
                                                                    self.funk.function_scope.label_count)
            self.funk.function_scope.label_count += 1

            label_exit = '{}_clause_{}_loop_exit__{}'.format(scope_name,
                                                             self.funk.function_scope.clause_idx,
                                                             self.funk.function_scope.label_count)
            self.funk.function_scope.label_count += 1

            self.funk.emitter.br(label_loop_start)

            self.funk.emitter.add_label(label_loop_start)
            #### Loop =====

            # self.funk.emitter.print_funk(self.funk, [StringConstant(self.funk, 'eval element '), StringConstant(self.funk, loop_reg)])
            if expr.__repr__() == self.iterator_symbol.__repr__():
                element_reg = self.funk.emitter.alloc_tnode(self.expr.__repr__(),
                                                            self.funk.emitter.get_node_data_value(iterator_reg),
                                                            funk_types.function_pool, funk_types.int)
            else:
                expr.replace_symbol(self.iterator_symbol, StringConstant(self.funk, iterator_reg))
                element_reg = expr.eval()

            if isinstance(element_reg, int):
                element_reg = self.funk.emitter.alloc_tnode(expr.__repr__(), element_reg, funk_types.function_pool,
                                                            funk_types.int)

            self.funk.emitter.set_tnode_array_element(tnode_list=elements, value_reg=element_reg,
                                                      iterator_reg=loop_reg,
                                                      len=list_len_int)

            self.funk.emitter.increment_node_value_int(loop_reg)
            self.funk.emitter.increment_node_value_int(iterator_reg)
            self.funk.emitter.br_cond('eq', self.funk.emitter.get_node_data_value(loop_reg, as_type=funk_types.int),
                                      list_len_int, label_exit, label_loop_start)

            self.funk.emitter.add_label(label_exit)

            # finally add the element pointers to the list
            #head = self.funk.alloc_compile_time_expr_list(elements, [1], self.pool, result=result)
            head = self.funk.emitter.create_list_of_tnodes(result=result, pool=funk_types.function_pool, n=list_len_int, reg_list=elements)
            self.funk.emitter.free_tnode_pointer(elements)
            self.funk.emitter.add_comment('END ============== ExprRange {}'.format(self.__repr__()))

            # try to flatten
            #head = self.funk.emitter.flatten_pointer_list_to_matrix(head, result=result)
            return head

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
declare void {name}(%struct.tnode*, i32,  %struct.tnode*)
                """.format(name=self.name)


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
        if name in self.funk.functions:
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

        # # Now check if this is an input argument containing a function pointer
        # i = 0
        # for arg in self.funk.function_scope.args:
        #     if arg == self.name:
        #         fn = self.funk.emitter.get_function_argument_tnode(i)
        #         return self.funk.emitter.call_fn_ptr(self.funk, 'ptr_fn({})'.format(self.name),
        #                                              fn,
        #                                              [create_ast_anon_symbol(self.funk, a,
        #                                                                 funk_types.function_pool) for a in self.args],
        #                                              result=result)
        #     i += 1

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

    def emit_pattern_matches(self, clause_idx, name, clause_pm_label, clause_precondition_label, clause_entry_label, clause_exit_label):
        # check for clause pattern matches
        if self.pattern_matches is not None and len(self.pattern_matches) != 0:
            #self.debug_print(['emitting pattern matches'])
            self.funk.emitter.add_label(clause_pm_label)
            self.funk.emitter.add_comment('{}'.format(self.pattern_matches))

            pm_count = 0
            for pattern in self.pattern_matches:
                self.funk.emitter.add_comment('{}'.format(self.arguments))
                arg = self.funk.emitter.get_function_argument_tnode(pattern.position)
                last = pm_count + 1 == len(self.pattern_matches)

                if last:
                    label_next = clause_precondition_label if self.preconditions is not None else clause_entry_label  # BUG, shall be preconditions if there are any
                else:
                    label_next = '{}_clause_{}_pattern_match_{}'.format(name, clause_idx, pm_count)

                if isinstance(pattern, PatternMatchEmptyList):
                    node_type = self.funk.emitter.get_node_type(arg)
                    self.funk.emitter.br_cond('ne', node_type, funk_types.empty_array, clause_exit_label,
                                              label_next)

                elif isinstance(pattern, PatternMatchLiteral):
                    label_match_literal_check_value = '{}_clause_{}_pattern_match_literal_check_value_{}'.format(
                        name, clause_idx, pm_count)
                    data_type = self.funk.emitter.get_node_data_type(arg)
                    self.funk.emitter.br_cond('ne', data_type, pattern.type, clause_exit_label,
                                              label_match_literal_check_value)

                    self.funk.emitter.add_label(label_match_literal_check_value)
                    value = self.funk.emitter.get_node_data_value(arg)
                    self.funk.emitter.br_cond('ne', value, pattern.value, clause_exit_label, label_next)
                elif isinstance(pattern, PatternMatchListOfIdentifiers):
                    self.funk.emitter.add_comment(
                        'Pattern match element against a list of {} elements '.format(len(pattern.elements)))
                    node_len = self.funk.emitter.get_extended_len(arg)
                    self.funk.emitter.print_funk(self.funk, [StringConstant(self.funk,'PatternMatchListOfIdentifiers, expected {} received'.format(len(pattern.elements))),
                         StringConstant(self.funk, node_len)])
                    val = self.funk.emitter.get_node_data_value(node_len)
                    self.funk.emitter.br_cond('ne', len(pattern.elements), val, clause_exit_label, label_next)

                else:
                    raise Exception('Unsupported Pattern Match type')
                if not last:
                    self.funk.emitter.add_label(label_next)
                pm_count += 1

    def emit_preconditions(self,clause_idx, clause_precondition_label,clause_entry_label,clause_exit_label ):

        if self.preconditions is not None:
            self.funk.emitter.add_label(clause_precondition_label)
            self.funk.emitter.add_comment('{}'.format(self.preconditions))
            result = self.preconditions.eval()
            self.funk.emitter.br_cond('eq', self.funk.emitter.get_node_data_value(result), 1, clause_entry_label,
                                      clause_exit_label)
        else:
            self.funk.emitter.add_comment('clause {} has no preconditions'.format(clause_idx))


class FunctionMap:
    def __init__(self, funk, name, arguments=None, tail_pairs=None, pattern_matches=None):
        if arguments is None:
            arguments = []
        if tail_pairs is None:
            tail_pairs = []
        if pattern_matches is None:
            pattern_matches = []
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
        struct tnode retval;
        funk_create_i32_scalar((arity > 0) ? get_pool_enum(argument_list[0].pool) : function_pool, &retval, -255);
        """.format(fn_name=self.name)

        for clause in self.clauses:

            clause.funk.emitter.code += """
        if (arity == {clause_arity}) {{
            """.format(clause_arity=len(clause.arguments))
            for i, argument in enumerate(clause.arguments):
                clause.funk.emitter.code += """
        struct tnode {argument} = argument_list[{i}];   """.format(argument=argument, i=i)

            if clause.preconditions is not None:
                preconditions_result = clause.preconditions.eval()
                clause.funk.emitter.code += """
            if (DATA(&{preconditions},0)->data.i32 == 1) {{
                    """.format(preconditions=preconditions_result)

            for stmt in clause.body[:-1]:
                self.funk.emitter.add_comment(stmt)
                stmt.eval()

            clause.body[-1].eval(result='retval')

            if clause.preconditions is not None:
                clause.funk.emitter.code += """
            return retval;
            } //preconditions check
            """
            else:
                clause.funk.emitter.code += """
            return retval;
            """

            clause.funk.emitter.code += """

        } //arity check
        """

        self.funk.emitter.code += """
        // No clause was hit
        printf(\"Error: {fn_name} could not function resolve overload\\n\");
        return retval;
        exit(1);

        }}
            """.format(fn_name=self.name)

    def eval(self, result=None):
        scope_name = self.funk.create_function_scope(self.name, args=self.arguments, tail_pairs=self.tail_pairs,
                                                     empty=True)

        self.funk.set_function_scope(scope_name)

        if self.name == 'main':
            self.emit_main()
        else:
            self.emit_function()
        return

        scope_name = self.funk.create_function_scope(self.name, args=self.arguments, tail_pairs=self.tail_pairs,
                                                     empty=True)

        self.funk.set_function_scope(scope_name)

        # Now implement the function
        self.funk.emitter.open_function(self.funk, self.name, len(self.arguments))

        index = 0
        for clause in self.clauses:

            clause.funk.emitter.code += """
        if (arity == {clause_arity}) {{
            """.format(clause_arity=len(clause.arguments))
            for i, argument in enumerate(clause.arguments):
                clause.funk.emitter.code += """
        struct tnode {argument} = argument_list[{i}];   """.format(argument=argument, i=i)

            if clause.preconditions is not None:
                preconditions_result = clause.preconditions.eval()
                clause.funk.emitter.code += """
            if (DATA(&{preconditions},0)->data.i32 == 1) {{
                    """.format(preconditions=preconditions_result)

            for stmt in clause.body:
                stmt.eval()

            if clause.preconditions is not None:
                clause.funk.emitter.code += """
            } //preconditions check
                """

            clause.funk.emitter.code += """
          return; //exit the function from this clause
        } //arity check
                        """

            self.funk.function_scope.clause_idx = index
            clause.emit(index)
            index += 1

        if self.name not in ['main', 'sdl_render']:
            # emit the default clause
            # this is the clause that gets executed if nothing else matches
            error_message = '\'ERROR could not find suitable pattern match for function {}/{}\''.format(self.name, len(self.arguments))
            default_clause = FunctionClause(self.funk, name=self.clauses[0].name, preconditions=None, pattern_matches='*',
                                            fn_body=[FunctionCall(self.funk, 'say', [String(self.funk, error_message)]),
                                                     FunctionCall(self.funk,'exit', [])])
            default_clause.emit(index)
        #
        self.funk.function_scope.clause_idx = 0

        self.funk.emitter.close_function(self.funk.function_scope.name)

        return scope_name


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
        return self.funk.emitter.funk_not(self.funk, self.arg_list, result=result, pool=self.pool)


class FunkRoll(Expression):
    def __init__(self, funk, arg_list):
        super().__init__()
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        return self.funk.emitter.funk_roll(self.funk, self.arg_list, result=result, pool=self.pool)


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

        return self.funk.emitter.flatten(self.funk, self.arg_list, result=result)


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
