# -*- coding: utf-8 -*-
#
# Optimized backend compiler wiring

from .funky_compiler import Funk
from .optimized_emitter import OptimizedEmitter
from . import funky_ast
from . import optimized_ast
from . import optimized_bool_ast
from . import optimized_sys_ast


class OptimizedFunk(Funk):
    def __init__(self, ll1_path=None, debug=False):
        super().__init__(ll1_path=ll1_path,
                         debug=debug,
                         emitter_class=OptimizedEmitter,
                         c_model_header='funk_c_model_opt.h',
                         enable_i32_lowering=True,
                         enable_d64_lowering=True)

        # Patch AST classes to move-aware optimized versions
        funky_ast.Sum = optimized_ast.Sum
        funky_ast.Sub = optimized_ast.Sub
        funky_ast.Mul = optimized_ast.Mul
        funky_ast.Div = optimized_ast.Div
        funky_ast.Mod = optimized_ast.Mod
        funky_ast.ListConcat = optimized_ast.ListConcat
        funky_ast.ListConcatTail = optimized_ast.ListConcatTail
        funky_ast.ListUnion = optimized_ast.ListUnion
        funky_ast.FunctionCall = optimized_ast.FunctionCall
        funky_ast.LessThan = optimized_bool_ast.LessThan
        funky_ast.GreaterThan = optimized_bool_ast.GreaterThan
        funky_ast.EqualThan = optimized_bool_ast.EqualThan
        funky_ast.NotEqualThan = optimized_bool_ast.NotEqualThan
        funky_ast.GreaterOrEqualThan = optimized_bool_ast.GreaterOrEqualThan
        funky_ast.LessOrEqualThan = optimized_bool_ast.LessOrEqualThan
        funky_ast.And = optimized_bool_ast.And
        funky_ast.Or = optimized_bool_ast.Or
        funky_ast.Len = optimized_sys_ast.Len
        funky_ast.Flatten = optimized_sys_ast.Flatten
        funky_ast.FunkSum = optimized_sys_ast.FunkSum


class OptimizedFunkI32(OptimizedFunk):
    def __init__(self, ll1_path=None, debug=False):
        super().__init__(ll1_path=ll1_path, debug=debug)
        self.enable_i32_lowering = True
        # Keep explicit for clarity: cpp20_i32 remains typed-lowering enabled.
        self.enable_d64_lowering = True
