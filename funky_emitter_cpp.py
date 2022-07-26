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


class EmitterCpp:
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
            self.code += 'std::cout'
            for arg_expr in l:
                self.code += '<< {}'.format(arg_expr)
            self.code += '<< std::endl; '

        ref = ''
        if result is None:
            result = self.create_anon()
            ref = 'TData'

        self.code += """
           {ref} {result} = TData(1);
        """.format(ref=ref, result=result)

    def add_comment(self, comment):
        self.code += """
        //  {}\n""".format(comment)

    def exit(self, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')
        self.code += """
        exit(0);
        """

    def get_node_length(self, args, result=None):
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

    def process_function_head_tails(self,function_name, head, tail):
        self.code += """

          if ({head}.type != funky_type::array){{
             throw std::string(\"in function {function_name}: {list_arg} is not an array");
          }}
          TData  {list_arg} = {head};

          if ({list_arg}.array.size() > 0) {{
               {head} = {list_arg}.array.front();
               {list_arg}.array.erase({list_arg}.array.begin());
          }} else {{
               {head} = std::vector<TData>(); //empty list
          }}
                            """.format(function_name=function_name, head=head, list_arg=tail)

    def validate_function_pointer(self,name,function_signature):
        self.code += """
                if ({name}.type != funky_type::function){{
                    std::cout << "========================================================================================"
                    << std::endl;
                    std::cout << "FunkyRuntime Error: When running function '{function_signature}' "
                        << ":\\n\\t The input provided as '{name}' is not a function" << std::endl;
                     for (int i = 0; i < argument_list.size(); i++){{
                        std::cout << "args " << i << ": " << argument_list[i] << std::endl;
                     }}
                    std::cout << "========================================================================================"
                    << std::endl;
                    exit(1);
                }}

                if ({name}.fn == nullptr){{
                    printf("FunkyRuntime Error: '{name}' function is NULL\\n");
                    exit(1);
                }}
                    """.format(name=name, function_signature=function_signature)

    def call_function(self, name, arguments, result):
        anon = self.create_anon()
        declare = ''
        if result is None:
            result = self.create_anon()
            declare = 'TData'

        self.code += """
       std::vector<TData> {anon} = {{ {arg_list} }};
       """.format(anon=anon, arg_list=', '.join(str(e) for e in arguments if e != 'etc'))

        if 'etc' in arguments:
            arguments.remove('etc')
            self.code += """
            {anon}.insert( {anon}.end(), etc.begin(), etc.end() );
            """.format(anon=anon)


        self.code += """
        {declare} {result} = funky::{name}({anon});
                 """.format(anon=anon, declare=declare, name=name,
                            arity=len(arguments), result=result)

        return result

    def funk_summation_function(self, funk, arguments, result):
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

    def get_int(self, var):
        return '{var}.i32'.format(var=var)

    def pattern_match_double(self, var, val):
        return '(std::fabs({var}.d64 - {val}) < 1e-9)'.format(var=var, val=val)

    def pattern_match_is_array(self, var):
        return '{var}.type == funky_type::array && {var}.array.size() == 0'.format(var=var)

    def type(self, type):
        return 'funky_type::{}'.format(type)

    def throw_if(self, condition, msg):
        return """if ({condition}) {{
                throw std::string(" {msg}");
            }}""".format(condition=condition, msg=msg)

    def copy_var(self,lhs,rhs, ref=''):
        return 'TData {ref} {lhs} = {rhs};\n'.format(ref=ref, lhs=lhs, rhs=rhs)

    def check_arity(self, arity):
        return '(argument_list.size() == {clause_arity})    '.format(clause_arity=arity)

    def emit_function_signature(self, name, has_tail_recursion):
        if has_tail_recursion:
            self.code += """
            TData {fn_name}(std::vector<TData> & original_argument_list) {{
                       // copy for tail recursion
                       std::vector<TData> argument_list = original_argument_list;
                       TData __retval__(funky_type::invalid);
                       label_function_start:
                       """.format(fn_name=name)
        else:
            self.code += """
                       TData {fn_name}(std::vector<TData> & argument_list) {{
                           TData __retval__(funky_type::invalid);
               """.format(fn_name=name)

    def emit_main_preamble(self):
        self.code += """
            } // namespace funky
            int main(void) {
                try {
                    std::random_device rd;
                    g_funky_random_engine = std::default_random_engine(rd());
                            """

    def emit_main_postamble(self):
        self.code += """
                    return 0;
                    } //end of try block
                    catch (std::string e){
                        std::cerr << "-E- Funky Runtime error: " << e << std::endl;
                    }
                    catch(...){
                        std::cerr << "-E- Funky Runtime error" << std::endl;
                    }
                }  // end of main function
                namespace funky {
                """

    def emit_no_suitable_clause_found(self, name):
        self.code += """
        // No clause was hit
        std::cout << "No overload of function '{fn_name}' matches inputs" << std::endl;
        for (const auto & arg : argument_list){{
            std::cout << arg << std::endl;

        }}

        """.format(fn_name=name)

    def preamble(self, function_names):
        text= \
            """
            #include <funk_c_model.h>
            #include <fstream>
            namespace funky {
            // =============================================================== ;;
            //
            // *** F U N K Y ! *** Runtime embedded environment
            //
            //
            // =============================================================== ;;
            //todo: move this
            void sdl_point( TData & x,  TData & y);
            void sdl_rect(int x, int y, int w, int h);
            void sdl_set_color(int r, int g, int b);
            TData sdl_set_user_ctx(const TData & arg);

            """

        for name in function_names:
            text += """
                        TData {function_name}(std::vector<TData> &);
                        """.format(function_name=name)

        return text

    def postamble(self):
        return \
            """
    } //namespace
        """

    def create_variable(self, name, value=''):
        _, name = self.create_if_null(name)

        xval = ''
        if value != '':
            xval = '({})'.format(value)
        self.code += """
        TData {name}{xval};
        """.format(name=name, xval=xval)

        return name

    def create_if_null(self, node):
        ref = ''
        if node is None:
            node = self.create_anon()
            ref = 'TData'
        return ref, node

    def arith_op(self,result,a,op,b):
        ref, result = self.create_if_null(result)
        self.code += """
                   {ref} {result} = {a} {op} {b};
                """.format(result=result, ref=ref, a=a, b=b, op=op)

        return result

    def get_ranges(self, node, range_initializer, result=None):
        ref, result = self.create_if_null(result)
        anon = self.create_anon()

        self.code += """
            std::vector<TData::RangeType> {ranges} = {{ {range_initializer} }};
            {ref} {result} = {node}.GetRange({ranges});
           """.format(ref=ref, ranges=anon, result=result, node=node,
                      range_initializer=', '.join(str(e) for e in range_initializer))
        return result

    def create_array(self, array, result):
        decl, result = self.create_if_null(result)
        anon = self.create_anon()

        self.code += """
                        const std::vector<TData> {anon} = {{ {values} }};
                        {decl} {result} = TData({anon});
                        """.format(decl=decl, anon=anon, result=result,
                                   values=','.join(str(e) for e in array))
        return result

    def array_append(self, result,L,R):
        decl, result = self.create_if_null(result)
        self.code += """
         {ref} {result} = {L};
         {result}.array.insert({result}.array.end(), {R});
        """.format(result=result,ref=decl,L=L,R=R)
        return result

    def array_prepend(self,result,L,R):
        decl, result = self.create_if_null(result)

        self.code += """
        // Concatenating head to array
    {ref} {result} = {R};
    {result}.array.insert({result}.array.begin(), {L});
    """.format(result=result, L=L, R=R, ref=decl)

        return result

    def array_difference(self, result, L, R):

        ref, result = self.create_if_null(result)

        self.code += """
                   // List Union
                   // Make sure both L and R are arrays
                   if ({L}.type != funky_type::array) {{
                       throw std::string("{L} is not an array");
                   }}

                  if ({R}.type != funky_type::array) {{
                       throw std::string("{R} is not an array");
                   }}

                   auto __comparator__ = [](const TData & a, const TData & b){{
                           if (a.type != b.type)
                                throw std::string("Difference operator --: different types");

                           switch(a.type) {{
                               case funky_type::i32: return a.i32 < b.i32;
                               case funky_type::d64: return a.d64 < b.d64;
                               case funky_type::str: return a.str < b.str;
                               default: throw std::string("Difference operator --: types not supported");
                            }}
                        }};

                   {ref} {result} = TData(funky_type::array);
                   std::set_difference({L}.array.begin(), {L}.array.end(),
                       {R}.array.begin(), {R}.array.end(),
                       std::inserter({result}.array, {result}.array.begin()),
                       __comparator__);

               """.format(result=result, L=L, R=R, ref=ref)

        return result

    def array_union(self, result, L, R):
        ref, result = self.create_if_null(result)

        self.code += """
                    // List Union
                    // Make sure both L and R are arrays
                    TData {anon_l} = {L};
                    TData {anon_r} = {R};
                    if ({L}.type != funky_type::array) {{
                        const std::vector<TData> tmp = {{ {L} }};
                        {anon_l} = TData(tmp);
                    }}

                   if ({R}.type != funky_type::array) {{
                        const std::vector<TData> tmp = {{ {R} }};
                        {anon_r} = TData(tmp);
                    }}

                    {ref} {result} = {anon_l};
                    {result}.array.insert({result}.array.end(), {anon_r}.array.begin(), {anon_r}.array.end());
                """.format(result=result, L=L, R=R, ref=ref, anon_l=self.create_anon(),
                           anon_r=self.create_anon())
        return result

    def array_push(self, array, val):
        self.code += '{array}.array.push_back({val});'.format(array=array, val=val)

    def start_for_loop(self, i, start, end):
        self.code += """
                    for (int {i} = 0; {i} < ({end}-{start}); {i}++)
                    {{

                """.format(i=i, end=end, start=start)

    def end_for_loop(self):
        self.code += '} //end for loop'

