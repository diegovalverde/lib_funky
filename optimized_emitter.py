# -*- coding: utf-8 -*-
#
# Optimized C++ emitter: keeps same AST/transformer but emits fewer temporary copies

from .funky_emitter import Emitter


class OptimizedEmitter(Emitter):
    def call_function(self, name, arguments, result):
        anon = self.create_anon()
        declare = ''
        if result is None:
            result = self.create_anon()
            declare = 'TData'

        args = [a for a in arguments if a != 'etc']
        self.code += """
       std::vector<TData> {anon};
       {anon}.reserve({count});
       """.format(anon=anon, count=len(args))

        for arg in args:
            self.code += """
       {anon}.emplace_back({arg});
       """.format(anon=anon, arg=str(arg))

        if 'etc' in arguments:
            self.code += """
            {anon}.insert({anon}.end(), etc.begin(), etc.end());
            """.format(anon=anon)

        self.code += """
        {declare} {result} = funky::{name}({anon});
                 """.format(anon=anon, declare=declare, name=name, result=result)

        return result
