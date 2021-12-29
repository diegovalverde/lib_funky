# -*- coding: utf-8 -*-
#
# Copyright (C) 2020 Diego Valverde
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
from . import funk_ast


class Emitter:
    def __init__(self):
        self.index = 0
        self.code = ''
        self.scope_arg_map = {}
        self.scope_result_idx = None
        self.p_fn_args = None
        self.label_count = 0

    def emit(self):
        return self.code

    def create_anon(self):
        name = 'anon_{}'.format(self.index)
        self.index += 1
        return name

    def create_list_of_regs(self, name, reg_list, dimensions, pool, result=None):
        if result is None:
            result = self.create_anon()

            self.code += """
            TData {result};
            """.format(result=result)

        anon = self.create_anon()

        n = len(reg_list)

        self.code += """
        // {name}
        TData {anon}[] = {{ {reg_list} }};
        funk_create_list_of_regs(&{result}, {anon}, {n});

        """.format(anon=anon, reg_list=', '.join(str(e) for e in reg_list), result=result, name=name,
                   pool=funk_types.pool_str[pool], n=n)

        return result

    def print_funk(self, funk, args):
        if args is not None:
            l = [e.eval() for e in args]
            self.code += 'std::cout'
            for arg_expr in l:
                self.code += '<< {}'.format(arg_expr)

            self.code += '<< std::endl; '

    def add_comment(self, comment):
        self.code += """
        //  {}\n""".format(comment)

    def get_element_in_array(self, node, index, result=None):
        if result is None:
            result = self.create_anon()
            self.code += """
        TData {result};
        """.format(result=result)

        if isinstance(index, funk_ast.IntegerConstant):
            i = index.eval()
        else:
            i = 'DATA(&{index},0)->data.i32'.format(index=index.eval())

        self.code += """
        funk_get_element_in_array(&{node}, &{result}, {i});
        """.format(node=node, result=result, i=i)

        return result

    def exit(self, funk, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')

        self.code += """
        exit(0);
        """

    def fcmp_signed(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def icmp_signed(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def boolean_op(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def arith_helper(self, a, b, operation, result=None):
        self.add_comment('{} {} {}'.format(a, operation, b))

        if result is None:
            result = self.create_anon()

            self.code += """
            TData {result};""".format(result=result)

        if isinstance(a, int):
            self.code += """
        funk_{operartion}_ri(&{p_result}, &{pA},  {pB} );
            """.format(p_result=result, pA=b, pB=a, operartion=operation)
        elif isinstance(b, int):
            self.code += """
        funk_{operartion}_ri(&{p_result}, &{pA}, {pB} );
            """.format(p_result=result, pA=a, pB=b, operartion=operation)
        elif isinstance(a, float):
            self.code += """
        funk_{operartion}_rf(&{p_result}, &{pA}, {pB} );
            """.format(p_result=result, pA=b, pB=a, operartion=operation)
        elif isinstance(b, float):
            self.code += """
        funk_{operartion}_rf(&{p_result},  &{pA},  {pB} );
            """.format(p_result=result, pA=a, pB=b, operartion=operation)
        else:
            self.code += """
        funk_{operartion}_rr(&{p_result}, &{pA}, &{pB} );
            """.format(p_result=result, pA=a, pB=b, operartion=operation)

        return result

    def get_node_length(self, funk, args, result=None):
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

    def call_function(self, funk, name, arguments, result):
        anon = self.create_anon()
        declare = ''
        if result is None:
            result = self.create_anon()
            declare = 'TData'

        self.code += """
        std::vector<TData> {anon} = {{ {arg_list} }};
        {declare} {result} = funky::{name}({anon});
                 """.format(anon=anon, declare=declare, name=name, arg_list=', '.join(str(e) for e in arguments),
                            arity=len(arguments), result=result)

        return result

    def funk_summation_function(self, funk, arguments, result, pool):
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
