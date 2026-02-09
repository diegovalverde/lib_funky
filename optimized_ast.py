# -*- coding: utf-8 -*-
#
# Optimized AST nodes that emit move-aware arithmetic operations.

import copy
import re
from . import funky_ast
from .funky_ast import check_symbol_definition, create_ast_anon_symbol


def _maybe_move(name):
    return str(name)


def list_concat_tail_opt(funk, left, right, result=None):
    ref = ''
    if result is None:
        result = funk.emitter.create_anon()
        ref = 'TData'

    L = left.eval()
    R = right.eval()
    L_val = _maybe_move(L)

    funk.emitter.code += """
    {ref} {result} = {L_val};
    if ({result}.array.size() + {R}.array.size() <= 8) {{
        for (const auto &__e : {R}.array) {{
            {result}.array.push_back(__e);
        }}
    }} else {{
        {result}.array.reserve({result}.array.size() + {R}.array.size());
        {result}.array.insert({result}.array.end(), {R}.array.begin(), {R}.array.end());
    }}
    """.format(ref=ref, result=result, L_val=L_val, R=R)

    return result


def list_concat_head_opt(funk, left, right, result=None):
    ref = ''
    if result is None:
        result = funk.emitter.create_anon()
        ref = 'TData'

    L = left.eval()
    R = right.eval()
    R_val = _maybe_move(R)
    result_init = "{ref} {result}".format(ref=ref, result=result) if ref != '' else "{result}".format(result=result)
    funk.emitter.code += """
    {result_init} = {R_val};
    if ({result}.array.size() + 1 <= 8) {{
        {result}.array.insert({result}.array.begin(), {L});
    }} else {{
        {result}.array.reserve({result}.array.size() + 1);
        {result}.array.insert({result}.array.begin(), {L});
    }}
    """.format(result=result, result_init=result_init, L=L, R_val=R_val)

    return result


class OptimizedBinaryOp(funky_ast.BinaryOp):
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
        # Avoid moving arithmetic temporaries with COW arrays; it can invalidate
        # values that are still referenced by the runtime. Keep lvalue usage here.
        a_val = str(a)
        if isinstance(a, (int, float)) or isinstance(b, (int, float)):
            self.funk.emitter.code += """
            {result} = {a_val} {op} {b};
            """.format(result=result, a_val=a_val, b=b, op=op)
        else:
            self.funk.emitter.code += """
            if ({a_val}.type == funky_type::i32 && {b}.type == funky_type::i32) {{
                {result} = TData((std::int32_t)({a_val}.i32 {op} {b}.i32));
            }} else {{
                {result} = {a_val} {op} {b};
            }}
            """.format(result=result, a_val=a_val, b=b, op=op)

        return result

    def __deepcopy__(self, memo):
        return OptimizedBinaryOp(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sum(OptimizedBinaryOp, funky_ast.Sum):
    def __deepcopy__(self, memo):
        return Sum(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Mul(OptimizedBinaryOp, funky_ast.Mul):
    def __deepcopy__(self, memo):
        return Mul(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Sub(OptimizedBinaryOp, funky_ast.Sub):
    def __deepcopy__(self, memo):
        return Sub(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Div(OptimizedBinaryOp, funky_ast.Div):
    def __deepcopy__(self, memo):
        return Div(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class Mod(OptimizedBinaryOp, funky_ast.Mod):
    def __deepcopy__(self, memo):
        return Mod(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class ListConcat(funky_ast.ListConcat):
    def eval(self, result=None):
        if self.direction == funky_ast.ListConcat.tail:
            return list_concat_tail_opt(self.funk, self.left, self.right, result=result)
        return list_concat_head_opt(self.funk, self.left, self.right, result=result)


class ListConcatTail(funky_ast.ListConcatTail):
    def eval(self, result=None):
        return list_concat_tail_opt(self.funk, self.left, self.right, result=result)


class ListUnion(funky_ast.ListUnion):
    def eval(self, result=None):
        ref = ''
        if result is None:
            result = self.funk.emitter.create_anon()
            ref = 'TData'

        L = self.left.eval()
        R = self.right.eval()

        anon_l = self.funk.emitter.create_anon()
        anon_r = self.funk.emitter.create_anon()
        L_val = _maybe_move(L)
        R_val = _maybe_move(R)

        self.funk.emitter.code += """
            // List Union
            // Make sure both L and R are arrays
            TData {anon_l} = {L_val};
            TData {anon_r} = {R_val};
            if ({anon_l}.type != funky_type::array) {{
                {anon_l} = TData(std::vector<TData>{{ {L} }});
            }}

           if ({anon_r}.type != funky_type::array) {{
                {anon_r} = TData(std::vector<TData>{{ {R} }});
            }}

            {ref} {result} = std::move({anon_l});
            if ({result}.array.size() + {anon_r}.array.size() <= 8) {{
                for (const auto &__e : {anon_r}.array) {{
                    {result}.array.push_back(__e);
                }}
            }} else {{
                {result}.array.reserve({result}.array.size() + {anon_r}.array.size());
                {result}.array.insert({result}.array.end(), {anon_r}.array.begin(), {anon_r}.array.end());
            }}
        """.format(result=result, L=L, R=R, ref=ref, anon_l=anon_l, anon_r=anon_r, L_val=L_val, R_val=R_val)

        return result


class FunctionCall(funky_ast.FunctionCall):
    def eval(self, result=None):
        if self.name in self.system_functions:
            p = self.system_functions[self.name](self.funk, self.args)
            return p.eval(result=result)

        name = self.name
        function_is_local_variable = name in self.funk.function_scope.current_function_clause.local_variables
        function_is_in_signature = name in [a['val'] for a in self.funk.function_scope.current_function_clause.arguments]
        function_is_in_pattern_match_list = name in self.funk.function_scope.current_function_clause.get_list_pattern_matched_symbol_names()

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

            args_list = [a for a in arguments if a != 'etc']
            if len(args_list) == 0 and 'etc' not in arguments:
                self.funk.emitter.code += """
            {ref} {result} = funky::call0({name}.fn);
            """.format(ref=ref, name=name, result=result)
                return result
            if len(args_list) == 1 and 'etc' not in arguments:
                self.funk.emitter.code += """
            {ref} {result} = funky::call1_i32_fast({name}.fn, {arg0});
            """.format(ref=ref, name=name, result=result, arg0=args_list[0])
                return result
            if len(args_list) == 2 and 'etc' not in arguments:
                self.funk.emitter.code += """
            {ref} {result} = funky::call2_i32_fast({name}.fn, {arg0}, {arg1});
            """.format(ref=ref, name=name, result=result, arg0=args_list[0], arg1=args_list[1])
                return result
            if len(args_list) == 3 and 'etc' not in arguments:
                self.funk.emitter.code += """
            {ref} {result} = funky::call3({name}.fn, {arg0}, {arg1}, {arg2});
            """.format(ref=ref, name=name, result=result, arg0=args_list[0], arg1=args_list[1], arg2=args_list[2])
                return result
            if len(args_list) == 4 and 'etc' not in arguments:
                self.funk.emitter.code += """
            {ref} {result} = funky::call4({name}.fn, {arg0}, {arg1}, {arg2}, {arg3});
            """.format(ref=ref, name=name, result=result,
                       arg0=args_list[0], arg1=args_list[1], arg2=args_list[2], arg3=args_list[3])
                return result

            anon = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            std::vector<TData> {anon};
            {anon}.reserve({count});
            """.format(anon=anon, count=len(args_list))
            for arg in args_list:
                self.funk.emitter.code += """
            {anon}.emplace_back({arg});
            """.format(anon=anon, arg=arg)

            self.funk.emitter.code += """
            {ref} {result} = {name}.fn({anon});
            """.format(ref=ref, name=name, result=result, anon=anon)
            return result

        if name in self.funk.functions or '@{}'.format(name) in self.funk.functions:
            args_list = [a for a in arguments if a != 'etc']
            if len(args_list) == 0 and 'etc' not in arguments:
                if result is None:
                    result = self.funk.emitter.create_anon()
                    self.funk.emitter.code += "TData {result};".format(result=result)
                self.funk.emitter.code += """
            {result} = funky::call0(&funky::{name});
            """.format(result=result, name=name)
                return result
            if len(args_list) == 1 and 'etc' not in arguments:
                if result is None:
                    result = self.funk.emitter.create_anon()
                    self.funk.emitter.code += "TData {result};".format(result=result)
                self.funk.emitter.code += """
            {result} = funky::call1_i32_fast(&funky::{name}, {arg0});
            """.format(result=result, name=name, arg0=args_list[0])
                return result
            if len(args_list) == 2 and 'etc' not in arguments:
                if result is None:
                    result = self.funk.emitter.create_anon()
                    self.funk.emitter.code += "TData {result};".format(result=result)
                self.funk.emitter.code += """
            {result} = funky::call2_i32_fast(&funky::{name}, {arg0}, {arg1});
            """.format(result=result, name=name, arg0=args_list[0], arg1=args_list[1])
                return result
            if len(args_list) == 3 and 'etc' not in arguments:
                if result is None:
                    result = self.funk.emitter.create_anon()
                    self.funk.emitter.code += "TData {result};".format(result=result)
                self.funk.emitter.code += """
            {result} = funky::call3(&funky::{name}, {arg0}, {arg1}, {arg2});
            """.format(result=result, name=name, arg0=args_list[0], arg1=args_list[1], arg2=args_list[2])
                return result
            if len(args_list) == 4 and 'etc' not in arguments:
                if result is None:
                    result = self.funk.emitter.create_anon()
                    self.funk.emitter.code += "TData {result};".format(result=result)
                self.funk.emitter.code += """
            {result} = funky::call4(&funky::{name}, {arg0}, {arg1}, {arg2}, {arg3});
            """.format(result=result, name=name,
                       arg0=args_list[0], arg1=args_list[1], arg2=args_list[2], arg3=args_list[3])
                return result
            return self.funk.emitter.call_function(name, arguments, result=result)

        self.funk.forwarded_functions.append(name)
        return self.funk.emitter.call_function(name, arguments, result=result)
