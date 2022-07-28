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


class EmitterJs:
    def __init__(self):
        self.index = 0  # used to create anonymous variables
        self.code = ''  # the code itself to be emitted

    def emit(self):
        return self.code

    def create_anon(self):
        name = 'anon_{}'.format(self.index)
        self.index += 1
        return name

    def print_funk(self, args, result=None):
        if args is not None:
            l = [e.eval() for e in args]
            str_value = 'funky_console.value += '
            for arg_expr in l:
                str_value += '{}.toString() +'.format(arg_expr)

            self.code += str_value[:-1] + '\n'

        ref = ''
        if result is None:
            result = self.create_anon()
            ref = 'var'

        self.code += """
           {ref} {result} = new TData(1);
        """.format(ref=ref, result=result)

    def add_comment(self, comment):
        self.code += """
        //  {}\n""".format(comment)

    def exit(self, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')
        self.code += """
        // not implemented in JS
        """

    def get_node_length(self, args, result=None):
        node = args[0].eval()
        if result is None:
            result = self.create_anon()
            self.code += """
        var {result} = new TData();
        """.format(result=result)

        self.code += """
        {result} = {node}.GetLen();
        """.format(node=node, result=result)

        return result

    def process_function_head_tails(self, function_name, head, tail):
        self.code += """

             if ({head}.type != funky_type.array){{
                throw \"in function {function_name}: {list_arg} is not an array";
             }}
             var  {list_arg} = new TData({head});

             if ({list_arg}.data.length > 0) {{
                  {head} = {list_arg}.data[0];
                  {list_arg}.data.shift();
             }} else {{
                  {head} = []; //empty list
             }}
                               """.format(function_name=function_name, head=head, list_arg=tail)

    def validate_function_pointer(self,name,function_signature):
        self.code += """
                if ({name}.type != funky_type.function){{
                    funky_console.value += "========================================================================================<br\>";

                    funky_console.value += "FunkyRuntime Error: When running function '{function_signature}' ";
                    funky_console.value += ":\\n\\t The input provided as '{name}' is not a function <br\>";
                     for (var i = 0; i < argument_list.length; i++){{
                        funky_console.value += "args " + i.toString() + ": " + argument_list[i].toString() + "<br\>";
                     }}
                    funky_console.value += "========================================================================================<br\>"


                }}

                if ({name}.fn == nil){{
                    funky_console.value +="FunkyRuntime Error: '{name}' function is NULL <br\>";

                }}
                    """.format(name=name, function_signature=function_signature)

    def call_function(self, name, arguments, result):
        declare, result = self.create_if_null(result)

        anon = self.create_anon()
        self.code += """
              var {anon} = [ {arg_list} ];
              """.format(anon=anon, arg_list=', '.join(str(e) for e in arguments if e != 'etc'))

        if 'etc' in arguments:
            arguments.remove('etc')
            self.code += """
                   {anon}.insert( {anon}.end(), etc.begin(), etc.end() );
                   """.format(anon=anon)

        self.code += """
               {declare} {result} = {name}({anon});
                        """.format(anon=anon, declare=declare, name=name,
                                   arity=len(arguments), result=result)

        return result

    def funk_summation_function(self, funk, arguments, result):
        if len(arguments) != 1:
            raise Exception('=== exit takes 1 parameter')

        ref = ''
        if result is None:
            ref = 'var'
            result = self.create_anon()

        src = arguments[0].eval()
        anon = funk.emitter.create_anon()
        self.code += """
        // sum
        {anon} = new TData( {src}.Flatten());

        {ref} {result} = new TData( {anon}.data.reduce(function (x, y) {{return x.data + y.data;}}, 0),
         {src}.data[0].type);

        """.format(result=result, ref=ref, src=src, anon=anon)

        return result

    def copy_var(self,lhs,rhs,ref=''):
        return 'var {lhs} = {rhs};\n'.format(lhs=lhs, rhs=rhs)

    def get_int(self, var):
        return '{var}.data'.format(var=var)

    def pattern_match_double(self, var, val):
        return '(abs({var}.data - {val}) < 1e-9)'.format(var=var, val=val)

    def pattern_match_is_array(self, var):
        return '{var}.type == funky_type.array && {var}.data.length == 0'.format(var=var)

    def check_arity(self, arity):
        return '(argument_list.length == {clause_arity})'.format(clause_arity=arity)

    def type(self, type):
        return 'funky_type.{}'.format(type)

    def throw_if(self, condition, msg):
        return """if ({condition}) {{
                throw "{msg}";
            }}""".format(condition=condition, msg=msg)

    def emit_function_signature(self, name, has_tail_recursion):
        self.code += """
                   function {fn_name}(argument_list) {{
                       var __retval__ = new TData();
                       label_function_start:
           """.format(fn_name=name)

    def emit_main_preamble(self):
        self.code += """

            function main() {
                try {
        """

    def emit_main_postamble(self):
        self.code += """
                    return 0;
                    } //end of try block
                    catch (e){
                        funky_console.value += e.message + "<br\>";
                    }

                } //end of main function

                """

    def emit_no_suitable_clause_found(self, name):
        self.code += """
        // No clause was hit
        funky_console.value += "No overload of function '{fn_name}' matches inputs" + "<br\>";
        for (var i = 0; i < argument_list.length; i++){{
            funky_console.value += argument_list[i]  + "<br\>";
        }}

        """.format(fn_name=name)

    def preamble(self, _):
        return """
            import { TData, funky_type } from "./funk_js_model.js";
            // make sure that in the index.html you include your file like:
            // <script type="module" src="js/fibo.js"></script>

            var funky_console = document.getElementById('funky_console')
        """

    def postamble(self):
        return ''

    def create_variable(self, name, value=''):
        _, name = self.create_if_null(name)

        self.code += """
           var {name} = new TData({value});
           """.format(name=name,value=value)
        return name

    def create_if_null(self, node):
        ref = ''
        if node is None:
            node = self.create_anon()
            ref = 'var'
        return ref, node

    def arith_op(self, result, a, op, b):
        ref, result = self.create_if_null(result)
        self.code += """
                   {ref} {result} = new TData({a} {op} {b});
                """.format(result=result, ref=ref, a=a, b=b, op=op)
        return result

    def get_ranges(self, node, range_initializer, result=None):
        ref, result = self.create_if_null(result)
        anon = self.create_anon()

        self.code += """
            var {ranges} = [ {range_initializer} ];
            {ref} {result} = {node}.GetRange({ranges});
           """.format(ref=ref, ranges=anon, result=result, node=node,
                      range_initializer=', '.join(str(e) for e in range_initializer))

        return result

    def create_array(self, array, result):

        ref, result = self.create_if_null(result)
        self.code += """
            {ref} {result} = new TData([ {values} ]);
            """.format(ref=ref, result=result,
                       values=','.join(str(e) for e in array))
        return result

    def array_append(self, result,L,R):
        decl, result = self.create_if_null(result)
        self.code += """
         {ref} {result} = {L}.data.push({R});
        """.format(result=result,ref=decl,L=L,R=R)
        return result

    def array_prepend(self, result, L, R):
        decl, result = self.create_if_null(result)

        self.code += """
        // Concatenating head to array
        {ref} {result} = {R}.data.unshift({L});
    """.format(result=result, L=L, R=R, ref=decl)

        return result

    def array_difference(self, result, L, R):
        decl, result = self.create_if_null(result)

        self.code += """
        {ref} {result} = {L}.filter(x= > !{R}.includes(x));
        """.format(result=result, L=L, R=R, ref=decl)

        return result

    def array_union(self,result, L, R):
        decl, result = self.create_if_null(result)

        self.code += """
        {ref} {result} = {L}.concat({R});
        """.format(result=result, L=L, R=R, ref=decl)

        return result

    def array_push(self, array, val):
        self.code += '{array}.data.push({val});'.format(array=array, val=val)

    def start_for_loop(self, i, start, end):
        self.code += """
                       for (var {i} = 0; {i} < ({end}-{start}); {i}++)
                       {{

                   """.format(i=i, end=end, start=start)

    def end_for_loop(self):
        self.code += '} //end for loop'

    def flatten(self, result, src):
        ref, result = self.create_if_null(result)
        self.code += """
           // flatten vector
          {ref} {result} = {src}.Flatten();
           """.format(result=result, src=src, ref=ref)

        return result
