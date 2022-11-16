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

            self.code += str_value + "\"\\n\""

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
        let {result} = new TData();
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
             let  {list_arg} = new TData({head});

             if ({list_arg}.data.length > 0) {{
                  {head} = new TData({list_arg}.data[0]);
                  {list_arg}.data.shift();
             }} else {{
                  {head} = new TData([]); //empty list
             }}
                               """.format(function_name=function_name, head=head, list_arg=tail)

    def validate_function_pointer(self, name, function_signature):
        self.code += """
                if ({name}.type != funky_type.function){{
                    funky_console.value += "========================================================================================\\n";

                    funky_console.value += "FunkyRuntime Error: When running function '{function_signature}' ";
                    funky_console.value += ":\\n\\t The input provided as '{name}' is not a function \\n";
                     for (let i = 0; i < argument_list.length; i++){{
                        funky_console.value += "args " + i.toString() + ": " + argument_list[i].toString() + "\\n";
                     }}
                    funky_console.value += "========================================================================================\\n"


                }}

                if ({name}.data == null){{
                    funky_console.value +="FunkyRuntime Error: '{name}' function is NULL \\n";

                }}
                    """.format(name=name, function_signature=function_signature)

    def call_function(self, name, arguments, result):
        declare, result = self.create_if_null(result)

        anon = self.create_anon()
        self.code += """
              let {anon} = [ {arg_list} ];
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
        ref, result = self.create_if_null(result)

        src = arguments[0].eval()
        anon = funk.emitter.create_anon()
        self.code += """
        // sum
        let {anon} = new TData( {src}.Flatten());

        {ref} {result} = new TData( {anon}.data.reduce(function (x, y) {{return x + y;}}),
         {src}.data[0].type);

        """.format(result=result, ref=ref, src=src, anon=anon)

        return result

    def copy_var(self, lhs, rhs, ref=''):
        return 'let {lhs} = new  TData({rhs} );\n'.format(lhs=lhs, rhs=rhs)

    def get_int(self, var):
        return '{var}.data'.format(var=var)

    def pattern_match_double(self, var, val):
        return '(abs({var}.data - {val}) < 1e-9)'.format(var=var, val=val)

    def pattern_match_integer(self, var, val):
        return '((new TData({var}.data == {val})).data == 1)'.format(var=var, val=val)

    def get_element(self, var, i):
        return '{}.data[{}]'.format(var,i)

    def get_len(self, var):
        return '{var}.data.length'.format(var=var)

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

    def emit_function_signature(self, name, has_tail_recursion, is_async=False):

        tag = ''
        if is_async:
            tag = 'async'
        self.code += """
                   {tag} function {fn_name}(argument_list) {{
                     try {{
                       let __retval__ = new TData();
                       label_function_start:
           """.format(fn_name=name, tag=tag)

    def emit_function_postamble(self):
        self.code += """

         } //end of try block
                    catch (e){
                        funky_console.value += new Error().stack + "msg: " + e.message + "\\n";
                        throw e;
                    }
        } // end of function

        """

    def emit_main_preamble(self):
        self.code += """

            async function main() {
                try {
        """

    def emit_main_postamble(self):
        self.code += """
                    return 0;
                    } //end of try block
                    catch (e){
                        funky_console.value += e.message + "\\n";
                    }

                } //end of main function

                """

    def emit_no_suitable_clause_found(self, name):
        self.code += """
        // No clause was hit
        funky_console.value += "No overload of function '{fn_name}' matches inputs" + "\\n";
        for (let i = 0; i < argument_list.length; i++){{
            funky_console.value += argument_list[i]  + "\\n";
        }}

        """.format(fn_name=name)

    def preamble(self, _):
        return """
            import { RangeType, TData, funky_type} from "./lib_funky/core/js/funk_js_model.js";
            // make sure that in the index.html you include your file like:
            // script type="module" src="js/fibo.js"

            //-----------------------------------------------------------------------------------
var ctx = new TData();
var s2d_params = [510,510]

 function s2d( args){
    s2d_params[0] = args[0].data;
    s2d_params[1] = args[1].data;
    ctx.user_data = args[2];
    console.log('calling s2d and draw');
  return new TData(1);
}
var gp5 = null;
var funky_console = document.getElementById('funky_console');
        """

    def postamble(self):
        return """

        // https://github.com/processing/p5.js/wiki/Global-and-instance-mode
        const funk_p5_sketch = (sketch) => {
            sketch.setup = () => {
                console.log('creating p5 canvas...');
                sketch.createCanvas(s2d_params[0], s2d_params[1]);
                sketch.background('gray');
            };

            sketch.draw = () => {
                s2d_render([ctx]);
            };
            gp5 = sketch;
        };

        """

    def assign_variable(self, name,val):
        self.code += """
                {name} = new TData({val});
                """.format(name=name, val=val)

        return name

    def create_variable(self, name, value=''):
        _, name = self.create_if_null(name)

        self.code += """
           let {name} = new TData({value});
           """.format(name=name,value=value)
        return name

    def create_if_null(self, node):
        ref = ''
        if node is None:
            node = self.create_anon()
            ref = 'let'
        return ref, node


    def arith_op(self, result, a, op, b):
        ref, result = self.create_if_null(result)
        self.code += """
            {ref} {result} = new TData({a}).BroadCastOperation('{op}', new TData({b}));
        """.format(ref=ref, result=result, op=op, a=a, b=b)
        return result

    def get_range_initializer(self, start, end, is_range):
        return 'new RangeType( {start}, {end}, {is_range} )'.format(start=start, end=end, is_range=is_range)

    def get_ranges(self, node, range_initializer, result=None):
        ref, result = self.create_if_null(result)
        anon = self.create_anon()

        self.code += """
            let {ranges} = [ {range_initializer} ];
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
        {ref} {result} = new TData({L});
        {result}.data.push({R});
        """.format(result=result, ref=decl, L=L, R=R)
        return result

    def array_prepend(self, result, L, R):
        decl, result = self.create_if_null(result)

        self.code += """
        // Concatenating head to array
        {ref} {result} = new TData({R});
        {result}.data.unshift({L});
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
        {ref} {result} = new TData({L}.data.concat({R}.data));
        """.format(result=result, L=L, R=R, ref=decl)

        return result

    def array_push(self, array, val):
        self.code += '{array}.data.push(new TData({val}));'.format(array=array, val=val)

    def start_for_loop(self, i, start, end):
        self.code += """
                       for (let {i} = 0; {i} < ({end}-{start}); {i}++)
                       {{

                   """.format(i=i, end=end, start=start)

    def start_foreach_loop(self, e, array):
        self.code += """
             for (let i = 0; i < {array}.data.length; i++ )
              {{
                    let {e} = {array}.data[i];
           """.format(e=e, array=array)

    def end_for_loop(self):
        self.code += '} //end for loop'

    def flatten(self, result, src):
        ref, result = self.create_if_null(result)
        self.code += """
           // flatten vector
          {ref} {result} = {src}.Flatten();
           """.format(result=result, src=src, ref=ref)

        return result

    def is_equal(self, lhs, rhs):
        return '{lhs} == {rhs}'.format(lhs=lhs, rhs=rhs)

    def function_call(self, result, name, arguments):
        ref, result = self.create_if_null(result)
        anon = self.create_anon()

        self.code += """
        {ref} {result} = {name}.data([{arg_list}]);
        """.format(ref=ref, name=name, arg_list=', '.join(str(e) for e in arguments), result=result,
                   anon=anon)

        return result

    def create_function_call(self, name):
        anon = self.create_anon()
        self.code += """
               let {anon} = new TData({name});
               """.format(anon=anon, name=name)
        return anon

    def infinity(self,result):
        ref, result = self.create_if_null(result)
        self.code += """
        {ref} {result} = new TData(Math.pow(10, 1000));
        """.format(result=result,ref=ref)
        return result

    def reverse(self, result, src):
        ref, result = self.create_if_null(result)
        self.code += """
                {ref} {result} = new TData({src}.data.reverse());
                """.format(ref=ref, result=result, src=src)

        return result

    def toi32(self, result, var):
        ref, result = self.create_if_null(result)

        self.code += """
        {ref} {result};
        switch ({var}.type){{
            case funky_type.i32:{result} = {var}; break;
            case funky_type.d64: {result} = new TData(Math.floor(parseFloat({var}.data))); break;
            case funky_type.str: {result} = new TData(parseInt({var}.data)); break;
            default: {result} = new TData(funky_type.invalid); break;
        }}
        """.format(ref=ref, result=result, var=var)
        return result

    def s2d_line(self, arg_list):
        x1 = arg_list[0].eval()
        y1 = arg_list[1].eval()
        x2 = arg_list[2].eval()
        y2 = arg_list[3].eval()
        self.code += """
            // p5js line
            gp5.line({x1}.data, {y1}.data, {x2}.data, {y2}.data);

        """.format(x1=x1, y1=y1, x2=x2, y2=y2)

    def s2d_point(self, arg_list):
        x = arg_list[0].eval()
        y = arg_list[1].eval()
        self.code += """
            // p5js point
            gp5.point({x}.data, {y}.data);

        """.format(x=x, y=y)

    def s2d_rect(self,result, x,y,w,h):
        self.code += """
                gp5.rect(new TData({x}).data, new TData({y}).data, new TData({w}).data, new TData({h}).data);
                """.format(x=x, y=y, w=w, h=h)

        return result

    def s2d_color(self, result,r,g,b):
        anon = self.create_anon()
        self.code += """
                let {anon}=gp5.color(new TData({r}).data, new TData({g}).data, new TData({b}).data);
                gp5.fill({anon});
                gp5.stroke({anon});
                """.format(r=r, g=g, b=b, anon=anon)

        return result

    def rand_double(self,result, left, right):
        ref, result = self.create_if_null(result)
        anon = self.create_anon()
        self.code += """
                {ref} {result} = new TData( (Math.random() * ({max} - {min}) + {min}) );

                """.format(anon=anon, ref=ref, result=result, min=left, max=right)
        return result

    def read_user_input(self, result, file='std::cin'):
        ref, result = self.create_if_null(result)

        if file == 'std::cin':
            self.code += """
            {ref} {result} = new TData(funky_type.str);
            await funky_read_user();
            {result}.data = funky_last_input;
            """.format(ref=ref, result=result)
        else:
            self.code += """

            {ref} {result} = new TData(funky_type.str);
            if (funky_input_buffer.length > 0)
                {result}.data = funky_input_buffer.pop();
            """.format(ref=ref, result=result)

        return result

    def open_file(self, result, path, mode):

        ref, result = self.create_if_null(result)

        self.code += """
        await funky_read_file_from_server({path});


        """.format(ref=ref, result=result, path=path, mode=mode)

        return result

    def read_from_file(self,result, txt, expr):
        self.code += """
                   elements = [];
                   while (funky_input_buffer.length > 0) {{
                   """

        element = expr.eval()

        self.code += """
                       if ({element}.type != funky_type::invalid) elements.push_back({element});
                   }}
                   {result} = TData(elements);
                   """.format(element=element, result=result)

        return result

    def s2d_set_context(self,result,ctx):
        ref, result = self.create_if_null(result)
        self.code += """
                {ref} {result} = s2d_set_user_ctx({ctx});
                """.format(result=result, ctx=ctx, ref=ref)
        return result
