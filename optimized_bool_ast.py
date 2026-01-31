# -*- coding: utf-8 -*-
#
# Optimized boolean comparison nodes with i32 fast path.

import copy
from . import funky_ast
from .funky_ast import Identifier, IntegerConstant, DoubleConstant, String


class OptimizedBoolBinaryOp(funky_ast.BoolBinaryOp):
    def _bool_op(self, result, op):
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
        if isinstance(a, (int, float)) or isinstance(b, (int, float)):
            self.funk.emitter.code += """
            {result} = {a} {op} {b};
            """.format(result=result, a=a, b=b, op=op)
            return result
        self.funk.emitter.code += """
            if ({a}.type == funky_type::i32 && {b}.type == funky_type::i32) {{
                {result} = TData((std::int32_t)({a}.i32 {op} {b}.i32));
            }} else {{
                {result} = {a} {op} {b};
            }}
        """.format(result=result, a=a, b=b, op=op)
        return result


class LessThan(OptimizedBoolBinaryOp, funky_ast.LessThan):
    def eval(self, result=None):
        return self._bool_op(result, '<')

    def __deepcopy__(self, memo):
        return LessThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class GreaterThan(OptimizedBoolBinaryOp, funky_ast.GreaterThan):
    def eval(self, result=None):
        return self._bool_op(result, '>')

    def __deepcopy__(self, memo):
        return GreaterThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class EqualThan(OptimizedBoolBinaryOp, funky_ast.EqualThan):
    def eval(self, result=None):
        return self._bool_op(result, '==')

    def __deepcopy__(self, memo):
        return EqualThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class NotEqualThan(OptimizedBoolBinaryOp, funky_ast.NotEqualThan):
    def eval(self, result=None):
        return self._bool_op(result, '!=')

    def __deepcopy__(self, memo):
        return NotEqualThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class GreaterOrEqualThan(OptimizedBoolBinaryOp, funky_ast.GreaterOrEqualThan):
    def eval(self, result=None):
        return self._bool_op(result, '>=')

    def __deepcopy__(self, memo):
        return GreaterOrEqualThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


class LessOrEqualThan(OptimizedBoolBinaryOp, funky_ast.LessOrEqualThan):
    def eval(self, result=None):
        return self._bool_op(result, '<=')

    def __deepcopy__(self, memo):
        return LessOrEqualThan(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))


def _is_pure(expr):
    return isinstance(expr, (Identifier, IntegerConstant, DoubleConstant, String))


class And(funky_ast.And):
    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            TData {result};""".format(result=result)

        if isinstance(self.left, list):
            self.left = self.left[0]
        if isinstance(self.right, list):
            self.right = self.right[0]

        if _is_pure(self.right):
            left_tmp = self.funk.emitter.create_anon()
            self.left.eval(result=left_tmp)
            right_expr = self.right.eval()
            self.funk.emitter.code += """
            if ({left}.type == funky_type::i32 && {left}.i32 == 0) {{
                {result} = TData(0);
            }} else {{
                TData {right_tmp}({right_expr});
                if ({left}.type == funky_type::i32 && {right_tmp}.type == funky_type::i32) {{
                    {result} = TData((std::int32_t)({left}.i32 && {right_tmp}.i32));
                }} else {{
                    {result} = {left} && {right_tmp};
                }}
            }}
            """.format(result=result, left=left_tmp, right_tmp=self.funk.emitter.create_anon(), right_expr=right_expr)
            return result

        return self.arith_op(result, '&&')


class Or(funky_ast.Or):
    def eval(self, result=None):
        if result is None:
            result = self.funk.emitter.create_anon()
            self.funk.emitter.code += """
            TData {result};""".format(result=result)

        if isinstance(self.left, list):
            self.left = self.left[0]
        if isinstance(self.right, list):
            self.right = self.right[0]

        if isinstance(self.right, IntegerConstant):
            left_tmp = self.funk.emitter.create_anon()
            self.left.eval(result=left_tmp)
            right_expr = self.right.eval()
            self.funk.emitter.code += """
            if ({left}.type == funky_type::i32 && {left}.i32 != 0) {{
                {result} = TData(1);
            }} else {{
                TData {right_tmp}({right_expr});
                if ({left}.type == funky_type::i32 && {right_tmp}.type == funky_type::i32) {{
                    {result} = TData((std::int32_t)({left}.i32 || {right_tmp}.i32));
                }} else {{
                    {result} = {left} || {right_tmp};
                }}
            }}
            """.format(result=result, left=left_tmp, right_tmp=self.funk.emitter.create_anon(), right_expr=right_expr)
            return result

        return self.arith_op(result, '||')
