# -*- coding: utf-8 -*-
#
# Optimized system functions: len/flatten/sum fast paths on scalars.

from . import funky_ast


class Len(funky_ast.Len):
    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        TData {result};
        """.format(result=result)

        src = self.arg_list[0].eval()
        self.funk.emitter.code += """
        if ({src}.type != funky_type::array) {{
            {result} = TData(1);
        }} else {{
            {result} = {src}.GetLen();
        }}
        """.format(src=src, result=result)
        return result


class Flatten(funky_ast.Flatten):
    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        TData {result};
        """.format(result=result)

        src = self.arg_list[0].eval()
        self.funk.emitter.code += """
        if ({src}.type != funky_type::array) {{
            {result} = {src};
        }} else {{
            {result} = {src}.Flatten();
        }}
        """.format(src=src, result=result)
        return result


class FunkSum(funky_ast.FunkSum):
    def eval(self, result=None):
        if len(self.arg_list) != 1:
            raise Exception('=== sum takes 1 parameter')

        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
        TData {result};
        """.format(result=result)

        src = self.arg_list[0].eval()
        anon = self.funk.emitter.create_anon()
        self.funk.emitter.code += """
        if ({src}.type != funky_type::array) {{
            {result} = TData(0);
        }} else {{
            // sum
            TData {anon} = {src}.Flatten();
            {result} = std::accumulate({anon}.array.begin(), {anon}.array.end(),
                TData(0),
                [](TData acc,  TData n) -> TData{{ return (acc + n); }});
        }}
        """.format(result=result, src=src, anon=anon)

        return result
