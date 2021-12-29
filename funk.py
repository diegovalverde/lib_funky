# -*- coding: utf-8 -*-
#
# Copyright (C) 2019 Diego Valverde
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


from .funk_llvm_emitter import Emitter
from .funk_utils import *
import os
import re

try:
    from lark import Lark
except ImportError:
    import lark
from .funk_ast_transformer import TreeToAst
from . import funk_types


class FunctionScope:
    def __init__(self, name, ret_type='i32', args=None, pattern_matches=None, tail_pairs=None, empty=False):
        if pattern_matches is None:
            pattern_matches = []
        if tail_pairs is None:
            tail_pairs = []
        if args is None:
            args = []
        self.name = name
        self.clause_idx = 0  # In case there are multiple clauses this makes sure variable names can be reused
        self.args = args
        self.lhs_symbols = [] # This contains a list IR regs used
        self.tail_pairs = tail_pairs
        self.ret_val = ret_type
        self.emitter = Emitter()
        self.ret_statement = 'ret i32 0'
        self.empty = empty
        self.pattern_matches = pattern_matches
        self.label_count = 0

    def emit(self):

        if self.empty:
            return self.emitter.emit()

        args_string = ''
        for i in range(len(self.args)):
            args_string += self.args[i]
            if i + 1 != len(self.args):
                args_string += ', '

        firm = """

define {ret_val} @{name}({args}) #0 {{
""".format(ret_val=self.ret_val, name=self.name, args=args_string)

        post_amble = """

        ;; Each function has a  return statement
        {0}
}}

         """.format(self.ret_statement)

        return firm + self.emitter.emit() + post_amble


class Funk:
    def __init__(self, ll1_path=None, declarations_path=None, debug=False):

        self.debug = debug

        if self.debug: print('-I- Initializing compiler')

        function_declarations = None
        self.function_debug_name_map = {}

        try:
            if ll1_path is None:
                ll1_path = '{}/funk_ll1.lark'.format(os.path.dirname(os.path.abspath(__file__)))

            with open(ll1_path, 'r') as myfile:
                funk_grammar = myfile.read()
        except IOError:
            print('-E- File not found \'{}\''.format(ll1_path))
            exit()

        self.window = None
        self.grammar = Lark(funk_grammar)
        self.strings_count = 0  # used to declare constant strings as unique globals
        self.symbol_table = {}  # the symbol table
        self.function_scope = None  # The function scope that we are currently building
        self.functions = []
        self.empty_arg_count = 0  # essentially all of the '_' shall be uniquely identifiable
        self.preamble = \
            """
#include <funk_c_model.h>
namespace funky {
// =============================================================== ;;
//
// *** F U N K Y ! *** Runtime embedded environment
//
//
// =============================================================== ;;
"""
        self.post_amble = \
            """
} //namespace
        """

        self.emitter = None

    def create_function_scope(self, name, ret_type='%struct.tdata', args=None, tail_pairs=None, pattern_matches=None,
                              empty=False):
        if args is None:
            args = []
        if tail_pairs is None:
            tail_pairs = []
        if pattern_matches is None:
            pattern_matches = []
        scope_name = '{}'.format(name)
        self.symbol_table[scope_name] = FunctionScope(name, ret_type=ret_type, args=args, tail_pairs=tail_pairs,
                                                      empty=empty, pattern_matches=pattern_matches)
        self.functions.append(scope_name)

        return scope_name

    def set_function_scope(self, name):
        if name not in self.symbol_table:
            raise Exception('-E- Function {} not in symbol table'.format(name))

        self.function_scope = self.symbol_table[name]
        self.emitter = self.function_scope.emitter

    def emit(self):
        code = self.preamble
        for func in self.functions:
            code += self.symbol_table[func].emit()

        code += self.post_amble

        return code

    def save_c(self, path):
        f = open(path, 'w')
        f.write(self.emit())
        f.close()

    @staticmethod
    def replace_macros(src):
        macros = {}
        src_out = []
        for line in src.splitlines():
            match = re.findall('^(.*)<->(.*)', line)
            if len(match) == 0:
                src_out.append(line)
            else:
                src_out.append('')
                key, val = match[0]
                macros[key.strip()] = val.strip()

        str_out = ''
        for line in src_out:
            new_line = line
            for key in macros.keys():
                new_line = new_line.replace(key, macros[key])
            str_out += new_line + '\n'
        return str_out

    def compile(self, text):
        try:
            if self.debug:
                print ('-I- debug mode on')
            preprocessed_text = text

            # The grammar does not really allow you to put ',\n'
            # Let's just fix this in some pre-processing stage
            escapable_symbols = [',', '\\/', '-', '+', '*', '<-', '|']
            for symbol in escapable_symbols:
                preprocessed_text = preprocessed_text.replace('{}\n'.format(symbol), symbol)

            preprocessed_text = preprocessed_text.replace('assert', '___funky_assert')
            preprocessed_text = self.replace_macros(preprocessed_text)

            parse_tree = self.grammar.parse(preprocessed_text)

            ast_generator = TreeToAst(self, debug=self.debug)

            ast_generator.transform(parse_tree)

            for fn in ast_generator.function_definition_list:
                if self.debug:
                    print('-I- Emitting Function {}/{} '.format(fn, ast_generator.function_map[fn].arity))

                ast_generator.function_map[fn].eval()


        except Exception as e:
            print('ERROR!!!!')
            raise Exception(formatCompilationError(e))

    def alloc_literal_symbol(self, symbol, pool, symbol_name):
        self.emitter.code += """
        TData {symbol_name} ({val});
        """.format(symbol_name=symbol_name,  val=symbol.eval())
        return symbol_name

    def alloc_variable_list_symbol(self, p_start, p_end, expr):
        return self.emitter.alloc_variable_linked_list(p_start, p_end, expr)

    def alloc_compile_time_expr_list(self, elements, dimensions, pool, result=None):
        return self.emitter.create_list_of_regs(name='anon', dimensions=dimensions, reg_list=elements, pool=pool,
                                               result=result)

    def create_variable_symbol(self, symbol, symbol_name):
        allocation = self.emitter.alloc_tnode(symbol_name, 0, funk_types.function_pool, data_type=symbol.get_compile_type())
        self.emitter.add_comment(symbol.__repr__())
        symbol.eval(result=allocation)
        return allocation
