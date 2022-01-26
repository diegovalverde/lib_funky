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


from .funky_emitter import Emitter
from .funky_utils import *
from .preprocessor import *
import os

try:
    from lark import Lark
except ImportError:
    import lark
from .funky_ast_transformer import TreeToAst


class FunctionScope:
    def __init__(self, name, args=None, pattern_matches=None, tail_pairs=None):
        if pattern_matches is None:
            pattern_matches = []
        if tail_pairs is None:
            tail_pairs = []
        if args is None:
            args = []
        self.name = name
        self.clause_idx = 0  # In case there are multiple clauses this makes sure variable names can be reused
        self.args = args
        self.tail_pairs = tail_pairs
        self.emitter = Emitter()
        self.pattern_matches = pattern_matches

    def emit(self):
        return self.emitter.emit()


class Funk:
    def __init__(self, ll1_path=None, debug=False):

        self.debug = debug

        if self.debug:
            print('-I- Initializing compiler')

        self.function_debug_name_map = {}

        try:
            if ll1_path is None:
                ll1_path = '{}/funky_ll1.lark'.format(os.path.dirname(os.path.abspath(__file__)))

            with open(ll1_path, 'r') as grammar_file:
                funk_grammar = grammar_file.read()
        except IOError:
            print('-E- File not found \'{}\''.format(ll1_path))
            exit()

        self.grammar = Lark(funk_grammar)
        self.symbol_table = {}  # the symbol table
        self.function_scope = None  # The function scope that we are currently building
        self.functions = []
        self.empty_arg_count = 0  # essentially all of the '_' shall be uniquely identifiable
        self.preamble = \
            """
#include <funk_c_model.h>
#include <fstream>
namespace funky {
// =============================================================== ;;
//
// *** F U N K Y ! *** Runtime embedded environment
//
//
// =============================================================== ;;
//todo: move this
void sdl_point( TData & x,  TData & y);
void sdl_rect(int x, int y, int w, int h);
void sdl_set_color(int r, int g, int b);
TData sdl_set_user_ctx(const TData & arg);

"""

        self.post_amble = \
            """
} //namespace
        """

        self.emitter = None

    def create_function_scope(self, name, args=None, tail_pairs=None, pattern_matches=None):
        if args is None:
            args = []
        if tail_pairs is None:
            tail_pairs = []
        if pattern_matches is None:
            pattern_matches = []
        scope_name = '{}'.format(name)
        self.symbol_table[scope_name] = FunctionScope(name, args=args, tail_pairs=tail_pairs,
                                                      pattern_matches=pattern_matches)
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

    def compile(self, text):
        try:
            if self.debug:
                print('-I- debug mode on')

            preprocessed_text = preprocess(text)

            parse_tree = self.grammar.parse(preprocessed_text)

            ast_generator = TreeToAst(self, debug=self.debug)

            ast_generator.transform(parse_tree)

            for fn in ast_generator.function_definition_list:
                ast_generator.function_map[fn].eval()

        except Exception as e:
            print('-E- Funky compilation error')
            raise Exception(format_compilation_error(e))
