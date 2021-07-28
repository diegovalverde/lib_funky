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


class CEmitter(funky_emitter.Emitter):
    def __init__(self):
        self.index = 1
        self.code = ''
        self.scope_arg_map = {}
        self.scope_result_idx = None
        self.p_fn_args = None
        self.label_count = 0

    def emit(self):
        return self.code

    def allocate_result(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
        // allocate result
        struct tnode var_{0};
        """.format(p[0])

        result = 'var_{}'.format(p[0])
        return result

    def alloc_tnode(self, name, value, pool, data_type):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        if data_type in [funk_types.int, funk_types.unknown, None]:
            self.code += """
                ;; create tnode '{name}' of type {type}
                struct tnode var_{0};
                funk_create_{type}_scalar({pool}, var_{0}, {val});
                """.format(p[0], val=value, name=name, pool=pool, type=funk_types.to_str(data_type))
        return '%{}'.format(p[0])

    def alloc_literal_list(self, name, lit_list, dimensions, pool, result=None):
        if result is None:
            result = self.allocate_result()

        if len(lit_list) == 0:
            self.code += """
            funk_create_empty_list_element(1, &{result});
            """.format(result=result)
            return result

        as_type = to_funk_type(lit_list[0])

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        // variable \'{name}\': [{lit_list}]
        {data_type} var_{0}[] = \{{list}\};
        funk_create_list_{data_type}_literal({pool}, {result}, var_{0},  {n});

        """.format(p[0], pool=pool, n=len(lit_list),  result=result, name=name, lit_list=', '.join(str(e) for e in lit_list), data_type=funk_types.to_str[as_type])

        return result

    def create_list_of_regs(self, name, reg_list, dimensions, pool, result=None):
        if result is None:
            result = self.allocate_result()

        n = len(reg_list)
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        struct tnode var_{0}[] = \{{reg_list}\};
        funk_create_list_of_regs(&{result}, var_{0}, {n});

        """.format(p[0], reg_list=', '.join(str(e) for e in reg_list), result=result, A=A, name=name,  pool=pool, n=n)

        return result

    def print_funk(self, funk, args):
        if args is not None:
            for arg_expr in args:
                self.add_comment(arg_expr.__repr__())
                arg = arg_expr.eval()

                if arg[:3] != 'var':
                    self.code += """
                    printf(\"\'%s\', \", {arg_expr});
                    """.format(arg_expr=arg_expr)
                else:
                    self.code += """
                     funk_print_node(&{node});
               """.format(node=arg)


