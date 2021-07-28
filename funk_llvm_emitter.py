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
from . import funky_emitter
from . import funk_ast

class Emitter(funky_emitter.Emitter):
    def __init__(self):
        self.index = 0
        self.code = ''
        self.scope_arg_map = {}
        self.scope_result_idx = None
        self.p_fn_args = None
        self.label_count = 0

    def emit(self):
        return self.code

    def alloc_tnode(self, name, value, pool, data_type):
        if name == 'anon':
            name = self.create_anon()

        self.code += """
        // create tnode '{name}' of type {type}
        struct tnode {name};
        funk_create_{type}_scalar({pool}, &{name}, {val});
        """.format(val=value, name=name, pool=funk_types.pool_str[pool], type=funk_types.to_str[data_type])

        return name

    def create_anon(self):
        name = 'anon_{}'.format(self.index)
        self.index += 1
        return name

    def alloc_literal_list(self, name, lit_list, dimensions, pool, result=None):
        if result is None:
            result = self.create_anon()
            self.code += """
        struct tnode {result};
        """.format(result=result)

        if name == 'anon':
            name = self.create_anon()

        if len(lit_list) == 0:
            self.code += """
        funk_create_empty_list_element(1, &{result});
        """.format(result=result)
            return result

        as_type = to_funk_type(lit_list[0])

        self.code += """
        // variable \'{name}\': [{lit_list}]
        {data_type} {name} = \{{list}\};
        funk_create_list_{data_type}_literal({pool}, {result}, {name},  {n});

        """.format( pool=pool, n=len(lit_list),  result=result, name=name, lit_list=', '.join(str(e) for e in lit_list), data_type=funk_types.to_str[as_type])

        return result

    def create_list_of_regs(self, name, reg_list, dimensions, pool, result=None):
        if result is None:
            result = self.create_anon()

        self.code += """
        struct tnode {result};
        """.format(result=result)

        anon=self.create_anon()

        n = len(reg_list)

        self.code += """
        // {name}
        struct tnode {anon}[] = {{ {reg_list} }};
        funk_create_list_of_regs(&{result}, {anon}, {n});

        """.format(anon=anon, reg_list=', '.join(str(e) for e in reg_list), result=result, name=name,
                   pool=funk_types.pool_str[pool], n=n)

        return result

    def print_funk(self, funk, args):
        if args is not None:
            for arg_expr in args:
                self.add_comment(arg_expr.__repr__())
                arg = arg_expr.eval()

                if isinstance(arg_expr, funk_ast.String):
                    self.code += """
        printf(\"{arg_expr} \");
        """.format(arg_expr=arg)
                else:
                    self.code += """
        funk_print_node(&{node});
        """.format(node=arg)
        self.code += 'printf("\\n");'

    def add_comment(self, comment):
        self.code += """
        //  {}""".format(comment)

    def get_element_in_array(self, node, index, result=None):
        if result is None:
            result = self.create_anon()
            self.code += """
        struct tnode {result};
        """.format(result=result)

        i = index.eval()

        self.code += """
        funk_get_element_in_array(&{node}, &{result}, {i});
        """.format(node=node, result=result, i=i)

        return result

    def exit(self, funk, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')

        self.code += """
        funk_exit();
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
        struct tnode {result};""".format(result=result)

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
        struct tnode {result};
        """.format(result=result)

        self.code += """

        funk_get_len(&{result}, &{node});
        """.format(node=node, result=result)

        return result

    def call_function(self, funk, name, arguments, result):
        anon = self.create_anon()
        if result is None:
            result = self.create_anon()

        self.code += """
        struct tnode {anon}[] = {{ {arg_list} }};
        struct tnode {result} = {name}({arity}, {anon});
                 """.format(anon=anon, name=name, arg_list=', '.join(str(e) for e in arguments),  arity=len(arguments), result=result)
        return result

    def funk_summation_function(self, funk, arguments, result, pool):
        if len(arguments) != 1:
            raise Exception('=== exit takes 1 parameter')

        if result is None:
            result = self.create_anon()

        total = self.create_anon()
        src = arguments[0].eval()
        self.code += """
        int {total} = _funk_sum_list(&{src});
        """.format(src=src, total=total)

        self.alloc_tnode(result, total, pool, funk_types.int)

        return result

    def create_sub_array(self, src, c1, c2, result=None):
        if result is None:
            result = self.create_anon()
            self.code += """
            struct tnode {result};
            """.format(result=result)

        if isinstance(c1, funk_ast.IntegerConstant) and isinstance(c2, funk_ast.IntegerConstant):
            i = c1.eval()
            j = c2.eval()
            self.code += """
                funk_create_sub_array_lit_indexes(&{src}, &{result}, {i}, {j});
                """.format(src=src, result=result, i=i, j=j)
        elif isinstance(c1, funk_ast.IntegerConstant):
            val = c1.eval()
            j = c2.eval()
            anon = self.create_anon()
            self.code += """
        struct tnode {anon};
        funk_create_i32_scalar(function_pool, &{anon}, {val});
        funk_create_sub_array(&{src}, &{result}, &{anon}, &{j});
        """.format(src=src, result=result, val=val, j=j, anon=anon)

        elif isinstance(c2, funk_ast.IntegerConstant):
            i = c1.eval()
            val = c2.eval()
            anon = self.create_anon()
            self.code += """
       struct tnode {anon};
       funk_create_i32_scalar(function_pool, &{anon}, {val});
       funk_create_sub_array(&{src}, &{result}, &{i}, &{anon});
       """.format(src=src, result=result, i=i, val=val, anon=anon)

        return result
