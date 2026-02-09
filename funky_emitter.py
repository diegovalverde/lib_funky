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


class Emitter:
    def __init__(self):
        self.index = 0  # used to create anonymous variables
        self.code = ''  # the code itself to be emitted

    def emit(self):
        return self.code

    def create_anon(self):
        name = 'anon_{}'.format(self.index)
        self.index += 1
        return name

    def print_funk(self, args):
        if args is not None:
            l = [e.eval() for e in args]
            self.code += 'std::cout'
            for arg_expr in l:
                self.code += '<< {}'.format(arg_expr)
            self.code += '<< std::endl; '

    def add_comment(self, comment):
        self.code += """
        //  {}\n""".format(comment)

    def exit(self, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')
        self.code += """
        exit(0);
        """

    def get_node_length(self, args, result=None):
        node = args[0].eval()
        if result is None:
            result = self.create_anon()
            self.code += """
        TData {result};
        """.format(result=result)

        self.code += """
        {result} = {node}.GetLen();
        """.format(node=node, result=result)

        return result

    def call_function(self, name, arguments, result):
        anon = self.create_anon()
        declare = ''
        if result is None:
            result = self.create_anon()
            declare = 'TData'

        positional_args = [e for e in arguments if e != 'etc']
        self.code += """
       std::vector<TData> {anon};
       {anon}.reserve({arity});
       """.format(anon=anon, arity=len(positional_args))

        for arg in positional_args:
            self.code += """
            {anon}.emplace_back({arg});
            """.format(anon=anon, arg=arg)

        if 'etc' in arguments:
            self.code += """
            {anon}.insert( {anon}.end(), etc.begin(), etc.end() );
            """.format(anon=anon)


        self.code += """
        {declare} {result} = funky::{name}({anon});
                 """.format(anon=anon, declare=declare, name=name,
                            arity=len(positional_args), result=result)

        return result

    def funk_summation_function(self, funk, arguments, result):
        if len(arguments) != 1:
            raise Exception('=== exit takes 1 parameter')

        ref = ''
        if result is None:
            ref = 'TData'
            result = self.create_anon()

        src = arguments[0].eval()
        anon = funk.emitter.create_anon()
        self.code += """
        // sum
        TData {anon} = {src}.Flatten();
        {ref} {result} = std::accumulate({anon}.array.begin(), {anon}.array.end(),
            TData(0),
            [](TData& acc,  TData& n) -> TData{{ return (acc + n); }});
        """.format(result=result, ref=ref, src=src, anon=anon)

        return result
