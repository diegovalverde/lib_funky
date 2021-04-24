; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [250000 x %struct.tdata], i32, i8 }
%struct.tdata = type { i32, i8, %union.data_type }
%union.data_type = type { double }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, i32 }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str = private unnamed_addr constant [7 x i8] c"Error\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"-E- %s\0A\00", align 1
@__FUNCTION__.get_pool_ptr = private unnamed_addr constant [13 x i8] c"get_pool_ptr\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"start: from %s:%d\0A\00", align 1
@.str.3 = private unnamed_addr constant [49 x i8] c"\0A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\0A\00", align 1
@.str.4 = private unnamed_addr constant [32 x i8] c"INTERNAL ERROR: '%s' NULL node\0A\00", align 1
@.str.5 = private unnamed_addr constant [48 x i8] c"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\0A\00", align 1
@.str.6 = private unnamed_addr constant [74 x i8] c"INTERNAL ERROR: '%s' n[%d:%d]{%p} pointer %p to memory pool is not valid\0A\00", align 1
@.str.7 = private unnamed_addr constant [41 x i8] c"-E- %s Invalid dimension %d from %s +%d\0A\00", align 1
@__FUNCTION__._funk_set_node_dimension = private unnamed_addr constant [25 x i8] c"_funk_set_node_dimension\00", align 1
@.str.8 = private unnamed_addr constant [19 x i8] c"start: from %s:%d \00", align 1
@.str.9 = private unnamed_addr constant [56 x i8] c"INTERNAL ERROR: get_node from %s +%d NULL node pointer\0A\00", align 1
@__FUNCTION__.get_node = private unnamed_addr constant [9 x i8] c"get_node\00", align 1
@.str.10 = private unnamed_addr constant [35 x i8] c"INTERNAL ERROR: called from %s:%d\0A\00", align 1
@.str.11 = private unnamed_addr constant [76 x i8] c"-E- %s:%d get_node: trying to access overwritten position %d:%d in '%s':%d\0A\00", align 1
@.str.12 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.13 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.14 = private unnamed_addr constant [9 x i8] c"%d : %d\0A\00", align 1
@.str.15 = private unnamed_addr constant [54 x i8] c"Trying to access %s[%d:%d] len:%d, pool_tail = %d/%d\0A\00", align 1
@.str.16 = private unnamed_addr constant [16 x i8] c"wrap_creation: \00", align 1
@.str.17 = private unnamed_addr constant [7 x i8] c"%s %d \00", align 1
@.str.18 = private unnamed_addr constant [13 x i8] c"wrap count: \00", align 1
@.str.19 = private unnamed_addr constant [11 x i8] c"%s%d: %d \0A\00", align 1
@__FUNCTION__._get_wrap_creation = private unnamed_addr constant [19 x i8] c"_get_wrap_creation\00", align 1
@funk_sleep.first = internal global i32 1, align 4
@.str.20 = private unnamed_addr constant [68 x i8] c"%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count %d\0A\00", align 1
@__FUNCTION__.funk_increment_pool_tail = private unnamed_addr constant [25 x i8] c"funk_increment_pool_tail\00", align 1
@.str.21 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@funk_types_str = internal global [9 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_pointer_to_pool_entry\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_pool_node_entry\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@.str.22 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.24 = private unnamed_addr constant [4 x i8] c"%p\0A\00", align 1
@.str.25 = private unnamed_addr constant [18 x i8] c"pool DIM idx: %d\0A\00", align 1
@.str.26 = private unnamed_addr constant [8 x i8] c"len %d\0A\00", align 1
@.str.27 = private unnamed_addr constant [17 x i8] c"%s[%d :%d] %d-d\0A\00", align 1
@.str.28 = private unnamed_addr constant [8 x i8] c"types: \00", align 1
@.str.29 = private unnamed_addr constant [5 x i8] c"%d, \00", align 1
@__FUNCTION__.funk_print_node_info = private unnamed_addr constant [21 x i8] c"funk_print_node_info\00", align 1
@.str.30 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.31 = private unnamed_addr constant [9 x i8] c"int: %d\0A\00", align 1
@.str.32 = private unnamed_addr constant [12 x i8] c"double: %f\0A\00", align 1
@.str.33 = private unnamed_addr constant [21 x i8] c"\0Aglobal tail: %d:%d\0A\00", align 1
@.str.34 = private unnamed_addr constant [22 x i8] c"function tail: %d:%d\0A\00", align 1
@__FUNCTION__._funk_alloc_raw_tdata = private unnamed_addr constant [22 x i8] c"_funk_alloc_raw_tdata\00", align 1
@__FUNCTION__.funk_create_node = private unnamed_addr constant [17 x i8] c"funk_create_node\00", align 1
@__FUNCTION__.funk_deep_copy_node = private unnamed_addr constant [20 x i8] c"funk_deep_copy_node\00", align 1
@.str.35 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@.str.36 = private unnamed_addr constant [36 x i8] c"-E- %s Invalid Dimension count: %d\0A\00", align 1
@__FUNCTION__.funk_roll = private unnamed_addr constant [10 x i8] c"funk_roll\00", align 1
@.str.37 = private unnamed_addr constant [20 x i8] c"-E- %s Unsupported\0A\00", align 1
@__FUNCTION__.funk_not = private unnamed_addr constant [9 x i8] c"funk_not\00", align 1
@__FUNCTION__._funk_sum_list = private unnamed_addr constant [15 x i8] c"_funk_sum_list\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_ptr = private unnamed_addr constant [31 x i8] c"funk_get_element_in_matrix_ptr\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_lit = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_lit\00", align 1
@.str.38 = private unnamed_addr constant [35 x i8] c"-E- %s Invalid dimensions %d x %d\0A\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_var = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_var\00", align 1
@.str.39 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@.str.40 = private unnamed_addr constant [18 x i8] c"-E- %s max depth\0A\00", align 1
@__FUNCTION__._dereference = private unnamed_addr constant [13 x i8] c"_dereference\00", align 1
@.str.41 = private unnamed_addr constant [39 x i8] c"-E- %s unknown type %d from %s +%d %s\0A\00", align 1
@__FUNCTION__.funk_get_element_in_array = private unnamed_addr constant [26 x i8] c"funk_get_element_in_array\00", align 1
@__FUNCTION__.funk_get_element_in_array_var = private unnamed_addr constant [30 x i8] c"funk_get_element_in_array_var\00", align 1
@__FUNCTION__.add_node_to_nodelist = private unnamed_addr constant [21 x i8] c"add_node_to_nodelist\00", align 1
@__FUNCTION__.funk_create_double_scalar = private unnamed_addr constant [26 x i8] c"funk_create_double_scalar\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@__FUNCTION__.funk_create_list_of_regs = private unnamed_addr constant [25 x i8] c"funk_create_list_of_regs\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@.str.42 = private unnamed_addr constant [5 x i8] c"%3d \00", align 1
@.str.43 = private unnamed_addr constant [6 x i8] c"%5.5f\00", align 1
@.str.44 = private unnamed_addr constant [4 x i8] c"%5s\00", align 1
@.str.45 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.46 = private unnamed_addr constant [14 x i8] c"<function> %p\00", align 1
@.str.47 = private unnamed_addr constant [7 x i8] c"*-> %d\00", align 1
@.str.48 = private unnamed_addr constant [5 x i8] c"* %d\00", align 1
@.str.49 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.50 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_increment_node_data_int = private unnamed_addr constant [29 x i8] c"funk_increment_node_data_int\00", align 1
@__FUNCTION__.funk_copy_node_into_node_list = private unnamed_addr constant [30 x i8] c"funk_copy_node_into_node_list\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_set_node_value_fn_ptr = private unnamed_addr constant [27 x i8] c"funk_set_node_value_fn_ptr\00", align 1
@__FUNCTION__.funk_set_node_value_double = private unnamed_addr constant [27 x i8] c"funk_set_node_value_double\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.51 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.52 = private unnamed_addr constant [8 x i8] c"%d(%d):\00", align 1
@.str.53 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@__FUNCTION__.debug_print_arith_operation = private unnamed_addr constant [28 x i8] c"debug_print_arith_operation\00", align 1
@.str.54 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.55 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.56 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.57 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@__FUNCTION__.funk_mul = private unnamed_addr constant [9 x i8] c"funk_mul\00", align 1
@__FUNCTION__.funk_div = private unnamed_addr constant [9 x i8] c"funk_div\00", align 1
@__FUNCTION__.funk_add = private unnamed_addr constant [9 x i8] c"funk_add\00", align 1
@__FUNCTION__.funk_sub = private unnamed_addr constant [9 x i8] c"funk_sub\00", align 1
@__FUNCTION__.funk_slt = private unnamed_addr constant [9 x i8] c"funk_slt\00", align 1
@__FUNCTION__.funk_sgt = private unnamed_addr constant [9 x i8] c"funk_sgt\00", align 1
@__FUNCTION__.funk_sge = private unnamed_addr constant [9 x i8] c"funk_sge\00", align 1
@__FUNCTION__.funk_eq = private unnamed_addr constant [8 x i8] c"funk_eq\00", align 1
@__FUNCTION__.funk_ne = private unnamed_addr constant [8 x i8] c"funk_ne\00", align 1
@__FUNCTION__.funk_or = private unnamed_addr constant [8 x i8] c"funk_or\00", align 1
@__FUNCTION__.funk_and = private unnamed_addr constant [9 x i8] c"funk_and\00", align 1
@.str.58 = private unnamed_addr constant [4 x i8] c" * \00", align 1
@.str.59 = private unnamed_addr constant [4 x i8] c" / \00", align 1
@.str.60 = private unnamed_addr constant [4 x i8] c" + \00", align 1
@.str.61 = private unnamed_addr constant [4 x i8] c" - \00", align 1
@.str.62 = private unnamed_addr constant [6 x i8] c" mod \00", align 1
@.str.63 = private unnamed_addr constant [4 x i8] c" < \00", align 1
@.str.64 = private unnamed_addr constant [4 x i8] c" > \00", align 1
@.str.65 = private unnamed_addr constant [5 x i8] c" >= \00", align 1
@.str.66 = private unnamed_addr constant [5 x i8] c" == \00", align 1
@.str.67 = private unnamed_addr constant [4 x i8] c"!= \00", align 1
@.str.68 = private unnamed_addr constant [5 x i8] c" or \00", align 1
@.str.69 = private unnamed_addr constant [6 x i8] c" and \00", align 1
@.str.70 = private unnamed_addr constant [25 x i8] c"Unknown arith operation\0A\00", align 1
@__FUNCTION__._funk_arith_op_rr = private unnamed_addr constant [18 x i8] c"_funk_arith_op_rr\00", align 1
@.str.71 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@.str.72 = private unnamed_addr constant [33 x i8] c"'%s' length mismatch %d != %d !\0A\00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.73 = private unnamed_addr constant [7 x i8] c"CRAP!\0A\00", align 1
@__FUNCTION__.funk_eq_rr = private unnamed_addr constant [11 x i8] c"funk_eq_rr\00", align 1
@.str.74 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.75 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.76 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.77 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@__FUNCTION__._funk_print_node = private unnamed_addr constant [17 x i8] c"_funk_print_node\00", align 1
@.str.78 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.79 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@.str.80 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.81 = private unnamed_addr constant [3 x i8] c" ]\00", align 1
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.82 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@.str.83 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.84 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.85 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@__FUNCTION__.funk_read_list_from_file = private unnamed_addr constant [25 x i8] c"funk_read_list_from_file\00", align 1
@.str.86 = private unnamed_addr constant [28 x i8] c"%s Error r1 (%d) > r2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix_lit_indexes = private unnamed_addr constant [35 x i8] c"funk_create_sub_matrix_lit_indexes\00", align 1
@.str.87 = private unnamed_addr constant [28 x i8] c"%s Error c1 (%d) > c2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix = private unnamed_addr constant [23 x i8] c"funk_create_sub_matrix\00", align 1
@__FUNCTION__.funk_create_sub_array_lit_indexes = private unnamed_addr constant [34 x i8] c"funk_create_sub_array_lit_indexes\00", align 1
@__FUNCTION__.funk_create_sub_array = private unnamed_addr constant [22 x i8] c"funk_create_sub_array\00", align 1
@__FUNCTION__._funk_set_node_dimensions = private unnamed_addr constant [26 x i8] c"_funk_set_node_dimensions\00", align 1
@__FUNCTION__._flatten = private unnamed_addr constant [9 x i8] c"_flatten\00", align 1
@__FUNCTION__.reshape = private unnamed_addr constant [8 x i8] c"reshape\00", align 1
@.str.88 = private unnamed_addr constant [29 x i8] c"funk_append_element_to_list\0A\00", align 1
@__FUNCTION__.funk_append_element_to_list = private unnamed_addr constant [28 x i8] c"funk_append_element_to_list\00", align 1
@.str.89 = private unnamed_addr constant [38 x i8] c"funk_concatenate_lists [] , [] -> []\0A\00", align 1
@.str.90 = private unnamed_addr constant [3 x i8] c"L\0A\00", align 1
@.str.91 = private unnamed_addr constant [3 x i8] c"R\0A\00", align 1
@.str.92 = private unnamed_addr constant [12 x i8] c"\0A!!!!!! %d\0A\00", align 1
@__FUNCTION__.funk_prepend_element_to_list = private unnamed_addr constant [29 x i8] c"funk_prepend_element_to_list\00", align 1
@__FUNCTION__.funk_concatenate_lists = private unnamed_addr constant [23 x i8] c"funk_concatenate_lists\00", align 1
@__FUNCTION__.funk_get_node_start = private unnamed_addr constant [20 x i8] c"funk_get_node_start\00", align 1
@__FUNCTION__.funk_get_node_pool = private unnamed_addr constant [19 x i8] c"funk_get_node_pool\00", align 1
@.str.93 = private unnamed_addr constant [21 x i8] c"-E- %s Invalid pool\0A\00", align 1
@__FUNCTION__.funk_set_tnode_array_elementEX = private unnamed_addr constant [31 x i8] c"funk_set_tnode_array_elementEX\00", align 1
@.str.94 = private unnamed_addr constant [37 x i8] c"-E- %s Index %d out of range [0:%d]\0A\00", align 1
@__FUNCTION__.funk_alloc_list_of_tnodes = private unnamed_addr constant [26 x i8] c"funk_alloc_list_of_tnodes\00", align 1
@__FUNCTION__.funk_call_fn_pointer = private unnamed_addr constant [21 x i8] c"funk_call_fn_pointer\00", align 1
@.str.95 = private unnamed_addr constant [43 x i8] c"-E- calling node which is not a function!\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @get_pool_enum(%struct.tpool*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.tpool*, align 8
  store %struct.tpool* %0, %struct.tpool** %3, align 8
  %4 = load %struct.tpool*, %struct.tpool** %3, align 8
  %5 = icmp eq %struct.tpool* %4, @funk_global_memory_pool
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i32 0, i32* %2, align 4
  br label %13

7:                                                ; preds = %1
  %8 = load %struct.tpool*, %struct.tpool** %3, align 8
  %9 = icmp eq %struct.tpool* %8, @funk_functions_memory_pool
  br i1 %9, label %10, label %11

10:                                               ; preds = %7
  store i32 1, i32* %2, align 4
  br label %13

11:                                               ; preds = %7
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

13:                                               ; preds = %10, %6
  %14 = load i32, i32* %2, align 4
  ret i32 %14
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noreturn
declare void @exit(i32) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tpool* @get_pool_ptr(i32) #0 {
  %2 = alloca %struct.tpool*, align 8
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = load i32, i32* %3, align 4
  switch i32 %4, label %7 [
    i32 0, label %5
    i32 1, label %6
  ]

5:                                                ; preds = %1
  store %struct.tpool* @funk_global_memory_pool, %struct.tpool** %2, align 8
  br label %9

6:                                                ; preds = %1
  store %struct.tpool* @funk_functions_memory_pool, %struct.tpool** %2, align 8
  br label %9

7:                                                ; preds = %1
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.get_pool_ptr, i64 0, i64 0))
  store %struct.tpool* null, %struct.tpool** %2, align 8
  br label %9

9:                                                ; preds = %7, %6, %5
  %10 = load %struct.tpool*, %struct.tpool** %2, align 8
  ret %struct.tpool* %10
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @validate_node(%struct.tnode*, i8*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca [80 x i8], align 16
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store i8* %1, i8** %6, align 8
  store i32 %2, i32* %7, align 4
  %9 = getelementptr inbounds [80 x i8], [80 x i8]* %8, i64 0, i64 0
  %10 = load i8*, i8** %6, align 8
  %11 = load i32, i32* %7, align 4
  %12 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk(i8* %9, i32 0, i64 80, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i8* %10, i32 %11)
  %13 = load %struct.tnode*, %struct.tnode** %5, align 8
  %14 = icmp eq %struct.tnode* %13, null
  br i1 %14, label %15, label %20

15:                                               ; preds = %3
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.3, i64 0, i64 0))
  %17 = load i8*, i8** %6, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.4, i64 0, i64 0), i8* %17)
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.5, i64 0, i64 0))
  store %struct.tnode* null, %struct.tnode** %4, align 8
  br label %51

20:                                               ; preds = %3
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 2
  %23 = load %struct.tpool*, %struct.tpool** %22, align 8
  %24 = icmp ne %struct.tpool* %23, @funk_global_memory_pool
  br i1 %24, label %25, label %49

25:                                               ; preds = %20
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 2
  %28 = load %struct.tpool*, %struct.tpool** %27, align 8
  %29 = icmp ne %struct.tpool* %28, @funk_functions_memory_pool
  br i1 %29, label %30, label %49

30:                                               ; preds = %25
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.3, i64 0, i64 0))
  %32 = load i8*, i8** %6, align 8
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = load %struct.tnode*, %struct.tnode** %5, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = add i32 %38, %41
  %43 = load %struct.tnode*, %struct.tnode** %5, align 8
  %44 = load %struct.tnode*, %struct.tnode** %5, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 2
  %46 = load %struct.tpool*, %struct.tpool** %45, align 8
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([74 x i8], [74 x i8]* @.str.6, i64 0, i64 0), i8* %32, i32 %35, i32 %42, %struct.tnode* %43, %struct.tpool* %46)
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.5, i64 0, i64 0))
  store %struct.tnode* null, %struct.tnode** %4, align 8
  br label %51

49:                                               ; preds = %25, %20
  %50 = load %struct.tnode*, %struct.tnode** %5, align 8
  store %struct.tnode* %50, %struct.tnode** %4, align 8
  br label %51

51:                                               ; preds = %49, %30, %15
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  ret %struct.tnode* %52
}

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_set_node_dimension_count(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 3
  %8 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %7, i32 0, i32 0
  store i32 %5, i32* %8, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_funk_get_node_dimension_count(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 3
  %5 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %4, i32 0, i32 0
  %6 = load i32, i32* %5, align 8
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_funk_get_node_dimension(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 3
  %9 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  store i32 %10, i32* %5, align 4
  %11 = load i32, i32* %5, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %2
  br label %28

14:                                               ; preds = %2
  %15 = load %struct.tnode*, %struct.tnode** %3, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 2
  %17 = load %struct.tpool*, %struct.tpool** %16, align 8
  %18 = getelementptr inbounds %struct.tpool, %struct.tpool* %17, i32 0, i32 0
  %19 = load i32, i32* %5, align 4
  %20 = load i32, i32* %4, align 4
  %21 = add i32 %19, %20
  %22 = urem i32 %21, 250000
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %18, i64 0, i64 %23
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 2
  %26 = bitcast %union.data_type* %25 to i32*
  %27 = load i32, i32* %26, align 8
  br label %28

28:                                               ; preds = %14, %13
  %29 = phi i32 [ 1, %13 ], [ %27, %14 ]
  store i32 %29, i32* %6, align 4
  %30 = load i32, i32* %6, align 4
  ret i32 %30
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_set_node_dimension(%struct.tnode*, i32, i32, i8*, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i8* %3, i8** %9, align 8
  store i32 %4, i32* %10, align 4
  %13 = load i32, i32* %7, align 4
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %14)
  %16 = icmp ugt i32 %13, %15
  br i1 %16, label %17, label %22

17:                                               ; preds = %5
  %18 = load i32, i32* %7, align 4
  %19 = load i8*, i8** %9, align 8
  %20 = load i32, i32* %10, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__._funk_set_node_dimension, i64 0, i64 0), i32 %18, i8* %19, i32 %20)
  call void @exit(i32 1) #6
  unreachable

22:                                               ; preds = %5
  %23 = load %struct.tnode*, %struct.tnode** %6, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 3
  %25 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  store i32 %26, i32* %11, align 4
  %27 = load i32, i32* %11, align 4
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %22
  br label %53

30:                                               ; preds = %22
  %31 = load i32, i32* %11, align 4
  %32 = load i32, i32* %7, align 4
  %33 = add i32 %31, %32
  %34 = urem i32 %33, 250000
  store i32 %34, i32* %12, align 4
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 2
  %37 = load %struct.tpool*, %struct.tpool** %36, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 0
  %39 = load i32, i32* %12, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %38, i64 0, i64 %40
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  store i32 1, i32* %42, align 8
  %43 = load i32, i32* %8, align 4
  %44 = load %struct.tnode*, %struct.tnode** %6, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 2
  %46 = load %struct.tpool*, %struct.tpool** %45, align 8
  %47 = getelementptr inbounds %struct.tpool, %struct.tpool* %46, i32 0, i32 0
  %48 = load i32, i32* %12, align 4
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %47, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 2
  %52 = bitcast %union.data_type* %51 to i32*
  store i32 %43, i32* %52, align 8
  br label %53

53:                                               ; preds = %30, %29
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tdata* @get_node(%struct.tnode*, i32, i8*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca [80 x i8], align 16
  %12 = alloca i32, align 4
  %13 = alloca %struct.tdata*, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store i8* %2, i8** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %17 = getelementptr inbounds [80 x i8], [80 x i8]* %11, i64 0, i64 0
  %18 = load i8*, i8** %8, align 8
  %19 = load i32, i32* %9, align 4
  %20 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk(i8* %17, i32 0, i64 80, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.8, i64 0, i64 0), i8* %18, i32 %19)
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = icmp eq %struct.tnode* %21, null
  br i1 %22, label %23, label %27

23:                                               ; preds = %5
  %24 = load i8*, i8** %8, align 8
  %25 = load i32, i32* %9, align 4
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.9, i64 0, i64 0), i8* %24, i32 %25)
  call void @exit(i32 1) #6
  unreachable

27:                                               ; preds = %5
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = call %struct.tnode* @validate_node(%struct.tnode* %28, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0), i32 167)
  %30 = icmp eq %struct.tnode* %29, null
  br i1 %30, label %31, label %35

31:                                               ; preds = %27
  %32 = load i8*, i8** %8, align 8
  %33 = load i32, i32* %9, align 4
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.10, i64 0, i64 0), i8* %32, i32 %33)
  call void @exit(i32 1) #6
  unreachable

35:                                               ; preds = %27
  %36 = load %struct.tnode*, %struct.tnode** %6, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = load i32, i32* %7, align 4
  %40 = add i32 %38, %39
  store i32 %40, i32* %12, align 4
  %41 = load %struct.tnode*, %struct.tnode** %6, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 2
  %43 = load %struct.tpool*, %struct.tpool** %42, align 8
  %44 = getelementptr inbounds %struct.tpool, %struct.tpool* %43, i32 0, i32 0
  %45 = load i32, i32* %12, align 4
  %46 = urem i32 %45, 250000
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %44, i64 0, i64 %47
  store %struct.tdata* %48, %struct.tdata** %13, align 8
  %49 = load i32, i32* %10, align 4
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %235

51:                                               ; preds = %35
  %52 = load %struct.tdata*, %struct.tdata** %13, align 8
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 1
  %54 = load i8, i8* %53, align 4
  %55 = zext i8 %54 to i32
  %56 = load %struct.tnode*, %struct.tnode** %6, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  %58 = load %struct.tpool*, %struct.tpool** %57, align 8
  %59 = getelementptr inbounds %struct.tpool, %struct.tpool* %58, i32 0, i32 2
  %60 = load i8, i8* %59, align 4
  %61 = zext i8 %60 to i32
  %62 = icmp slt i32 %55, %61
  br i1 %62, label %63, label %235

63:                                               ; preds = %51
  %64 = load %struct.tnode*, %struct.tnode** %6, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 0
  %66 = load i32, i32* %65, align 8
  %67 = load %struct.tnode*, %struct.tnode** %6, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 2
  %69 = load %struct.tpool*, %struct.tpool** %68, align 8
  %70 = getelementptr inbounds %struct.tpool, %struct.tpool* %69, i32 0, i32 1
  %71 = load i32, i32* %70, align 8
  %72 = icmp ule i32 %66, %71
  br i1 %72, label %73, label %235

73:                                               ; preds = %63
  %74 = load i8*, i8** %8, align 8
  %75 = load i32, i32* %9, align 4
  %76 = load i32, i32* %12, align 4
  %77 = load %struct.tdata*, %struct.tdata** %13, align 8
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %77, i32 0, i32 1
  %79 = load i8, i8* %78, align 4
  %80 = zext i8 %79 to i32
  %81 = load %struct.tnode*, %struct.tnode** %6, align 8
  %82 = getelementptr inbounds %struct.tnode, %struct.tnode* %81, i32 0, i32 2
  %83 = load %struct.tpool*, %struct.tpool** %82, align 8
  %84 = icmp eq %struct.tpool* %83, @funk_global_memory_pool
  %85 = zext i1 %84 to i64
  %86 = select i1 %84, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %87 = load %struct.tnode*, %struct.tnode** %6, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 2
  %89 = load %struct.tpool*, %struct.tpool** %88, align 8
  %90 = getelementptr inbounds %struct.tpool, %struct.tpool* %89, i32 0, i32 2
  %91 = load i8, i8* %90, align 4
  %92 = zext i8 %91 to i32
  %93 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([76 x i8], [76 x i8]* @.str.11, i64 0, i64 0), i8* %74, i32 %75, i32 %76, i32 %80, i8* %86, i32 %92)
  %94 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 2), align 4
  %95 = zext i8 %94 to i32
  %96 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 2), align 4
  %97 = zext i8 %96 to i32
  %98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.14, i64 0, i64 0), i32 %95, i32 %97)
  %99 = load %struct.tnode*, %struct.tnode** %6, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 2
  %101 = load %struct.tpool*, %struct.tpool** %100, align 8
  %102 = icmp eq %struct.tpool* %101, @funk_global_memory_pool
  %103 = zext i1 %102 to i64
  %104 = select i1 %102, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %105 = load %struct.tnode*, %struct.tnode** %6, align 8
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %105, i32 0, i32 0
  %107 = load i32, i32* %106, align 8
  %108 = load %struct.tnode*, %struct.tnode** %6, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 0
  %110 = load i32, i32* %109, align 8
  %111 = load %struct.tnode*, %struct.tnode** %6, align 8
  %112 = getelementptr inbounds %struct.tnode, %struct.tnode* %111, i32 0, i32 1
  %113 = load i32, i32* %112, align 4
  %114 = add i32 %110, %113
  %115 = urem i32 %114, 250000
  %116 = load %struct.tnode*, %struct.tnode** %6, align 8
  %117 = getelementptr inbounds %struct.tnode, %struct.tnode* %116, i32 0, i32 1
  %118 = load i32, i32* %117, align 4
  %119 = load %struct.tnode*, %struct.tnode** %6, align 8
  %120 = getelementptr inbounds %struct.tnode, %struct.tnode* %119, i32 0, i32 2
  %121 = load %struct.tpool*, %struct.tpool** %120, align 8
  %122 = getelementptr inbounds %struct.tpool, %struct.tpool* %121, i32 0, i32 1
  %123 = load i32, i32* %122, align 8
  %124 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i64 0, i64 0), i8* %104, i32 %107, i32 %115, i32 %118, i32 %123, i32 250000)
  %125 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16, i64 0, i64 0))
  store i32 0, i32* %14, align 4
  br label %126

126:                                              ; preds = %155, %73
  %127 = load i32, i32* %14, align 4
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = getelementptr inbounds %struct.tnode, %struct.tnode* %128, i32 0, i32 1
  %130 = load i32, i32* %129, align 4
  %131 = icmp ult i32 %127, %130
  br i1 %131, label %132, label %158

132:                                              ; preds = %126
  %133 = load %struct.tnode*, %struct.tnode** %6, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 2
  %135 = load %struct.tpool*, %struct.tpool** %134, align 8
  %136 = icmp eq %struct.tpool* %135, @funk_global_memory_pool
  %137 = zext i1 %136 to i64
  %138 = select i1 %136, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %139 = load %struct.tnode*, %struct.tnode** %6, align 8
  %140 = getelementptr inbounds %struct.tnode, %struct.tnode* %139, i32 0, i32 2
  %141 = load %struct.tpool*, %struct.tpool** %140, align 8
  %142 = getelementptr inbounds %struct.tpool, %struct.tpool* %141, i32 0, i32 0
  %143 = load %struct.tnode*, %struct.tnode** %6, align 8
  %144 = getelementptr inbounds %struct.tnode, %struct.tnode* %143, i32 0, i32 0
  %145 = load i32, i32* %144, align 8
  %146 = load i32, i32* %14, align 4
  %147 = add i32 %145, %146
  %148 = urem i32 %147, 250000
  %149 = zext i32 %148 to i64
  %150 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %142, i64 0, i64 %149
  %151 = getelementptr inbounds %struct.tdata, %struct.tdata* %150, i32 0, i32 1
  %152 = load i8, i8* %151, align 4
  %153 = zext i8 %152 to i32
  %154 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.17, i64 0, i64 0), i8* %138, i32 %153)
  br label %155

155:                                              ; preds = %132
  %156 = load i32, i32* %14, align 4
  %157 = add nsw i32 %156, 1
  store i32 %157, i32* %14, align 4
  br label %126

158:                                              ; preds = %126
  %159 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.18, i64 0, i64 0))
  store i32 0, i32* %15, align 4
  br label %160

160:                                              ; preds = %198, %158
  %161 = load i32, i32* %15, align 4
  %162 = load %struct.tnode*, %struct.tnode** %6, align 8
  %163 = getelementptr inbounds %struct.tnode, %struct.tnode* %162, i32 0, i32 1
  %164 = load i32, i32* %163, align 4
  %165 = add i32 %164, 40
  %166 = icmp ult i32 %161, %165
  br i1 %166, label %167, label %201

167:                                              ; preds = %160
  %168 = load %struct.tnode*, %struct.tnode** %6, align 8
  %169 = getelementptr inbounds %struct.tnode, %struct.tnode* %168, i32 0, i32 2
  %170 = load %struct.tpool*, %struct.tpool** %169, align 8
  %171 = icmp eq %struct.tpool* %170, @funk_global_memory_pool
  %172 = zext i1 %171 to i64
  %173 = select i1 %171, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %174 = load %struct.tnode*, %struct.tnode** %6, align 8
  %175 = getelementptr inbounds %struct.tnode, %struct.tnode* %174, i32 0, i32 0
  %176 = load i32, i32* %175, align 8
  %177 = load i32, i32* %15, align 4
  %178 = add i32 %176, %177
  %179 = sub i32 %178, 20
  %180 = urem i32 %179, 250000
  %181 = load %struct.tnode*, %struct.tnode** %6, align 8
  %182 = getelementptr inbounds %struct.tnode, %struct.tnode* %181, i32 0, i32 2
  %183 = load %struct.tpool*, %struct.tpool** %182, align 8
  %184 = getelementptr inbounds %struct.tpool, %struct.tpool* %183, i32 0, i32 0
  %185 = load %struct.tnode*, %struct.tnode** %6, align 8
  %186 = getelementptr inbounds %struct.tnode, %struct.tnode* %185, i32 0, i32 0
  %187 = load i32, i32* %186, align 8
  %188 = load i32, i32* %15, align 4
  %189 = add i32 %187, %188
  %190 = sub i32 %189, 20
  %191 = urem i32 %190, 250000
  %192 = zext i32 %191 to i64
  %193 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %184, i64 0, i64 %192
  %194 = getelementptr inbounds %struct.tdata, %struct.tdata* %193, i32 0, i32 1
  %195 = load i8, i8* %194, align 4
  %196 = zext i8 %195 to i32
  %197 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.19, i64 0, i64 0), i8* %173, i32 %180, i32 %196)
  br label %198

198:                                              ; preds = %167
  %199 = load i32, i32* %15, align 4
  %200 = add nsw i32 %199, 1
  store i32 %200, i32* %15, align 4
  br label %160

201:                                              ; preds = %160
  %202 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.18, i64 0, i64 0))
  store i32 0, i32* %16, align 4
  br label %203

203:                                              ; preds = %231, %201
  %204 = load i32, i32* %16, align 4
  %205 = load %struct.tnode*, %struct.tnode** %6, align 8
  %206 = getelementptr inbounds %struct.tnode, %struct.tnode* %205, i32 0, i32 1
  %207 = load i32, i32* %206, align 4
  %208 = add i32 %207, 40
  %209 = icmp ult i32 %204, %208
  br i1 %209, label %210, label %234

210:                                              ; preds = %203
  %211 = load %struct.tnode*, %struct.tnode** %6, align 8
  %212 = getelementptr inbounds %struct.tnode, %struct.tnode* %211, i32 0, i32 0
  %213 = load i32, i32* %212, align 8
  %214 = load i32, i32* %16, align 4
  %215 = add i32 %213, %214
  %216 = sub i32 %215, 20
  %217 = urem i32 %216, 250000
  %218 = load %struct.tnode*, %struct.tnode** %6, align 8
  %219 = getelementptr inbounds %struct.tnode, %struct.tnode* %218, i32 0, i32 0
  %220 = load i32, i32* %219, align 8
  %221 = load i32, i32* %16, align 4
  %222 = add i32 %220, %221
  %223 = sub i32 %222, 20
  %224 = urem i32 %223, 250000
  %225 = zext i32 %224 to i64
  %226 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 0), i64 0, i64 %225
  %227 = getelementptr inbounds %struct.tdata, %struct.tdata* %226, i32 0, i32 1
  %228 = load i8, i8* %227, align 4
  %229 = zext i8 %228 to i32
  %230 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0), i32 %217, i32 %229)
  br label %231

231:                                              ; preds = %210
  %232 = load i32, i32* %16, align 4
  %233 = add nsw i32 %232, 1
  store i32 %233, i32* %16, align 4
  br label %203

234:                                              ; preds = %203
  call void @funk_print_pool(i32 0, i32 0, i32 100)
  call void @exit(i32 1) #6
  unreachable

235:                                              ; preds = %63, %51, %35
  %236 = load %struct.tdata*, %struct.tdata** %13, align 8
  ret %struct.tdata* %236
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_pool(i32, i32, i32) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.tpool*, align 8
  %8 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %9 = load i32, i32* %4, align 4
  %10 = call %struct.tpool* @get_pool_ptr(i32 %9)
  store %struct.tpool* %10, %struct.tpool** %7, align 8
  %11 = load %struct.tpool*, %struct.tpool** %7, align 8
  %12 = getelementptr inbounds %struct.tpool, %struct.tpool* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.51, i64 0, i64 0), i32 %13)
  %15 = load i32, i32* %5, align 4
  store i32 %15, i32* %8, align 4
  br label %16

16:                                               ; preds = %54, %3
  %17 = load i32, i32* %8, align 4
  %18 = load i32, i32* %5, align 4
  %19 = load i32, i32* %6, align 4
  %20 = add nsw i32 %18, %19
  %21 = icmp slt i32 %17, %20
  br i1 %21, label %22, label %57

22:                                               ; preds = %16
  %23 = load i32, i32* %8, align 4
  %24 = load %struct.tpool*, %struct.tpool** %7, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 0
  %26 = load i32, i32* %8, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %25, i64 0, i64 %27
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = load i8, i8* %29, align 4
  %31 = zext i8 %30 to i32
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.52, i64 0, i64 0), i32 %23, i32 %31)
  %33 = load %struct.tpool*, %struct.tpool** %7, align 8
  %34 = getelementptr inbounds %struct.tpool, %struct.tpool* %33, i32 0, i32 0
  %35 = load i32, i32* %8, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %34, i64 0, i64 %36
  %38 = bitcast %struct.tdata* %37 to { i64, i64 }*
  %39 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 1
  %42 = load i64, i64* %41, align 8
  call void @funk_print_scalar_element(i64 %40, i64 %42)
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.53, i64 0, i64 0))
  %44 = load i32, i32* %8, align 4
  %45 = icmp sgt i32 %44, 0
  br i1 %45, label %46, label %53

46:                                               ; preds = %22
  %47 = load i32, i32* %8, align 4
  %48 = add nsw i32 %47, 1
  %49 = srem i32 %48, 7
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %53

51:                                               ; preds = %46
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  br label %53

53:                                               ; preds = %51, %46, %22
  br label %54

54:                                               ; preds = %53
  %55 = load i32, i32* %8, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, i32* %8, align 4
  br label %16

57:                                               ; preds = %16
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define zeroext i8 @_get_wrap_creation(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = load i32, i32* %4, align 4
  %7 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %6, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__._get_wrap_creation, i64 0, i64 0), i32 234, i32 1)
  %8 = getelementptr inbounds %struct.tdata, %struct.tdata* %7, i32 0, i32 1
  %9 = load i8, i8* %8, align 4
  ret i8 %9
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_set_wrap_creation(%struct.tnode*, i32, i8 zeroext) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8 %2, i8* %6, align 1
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = getelementptr inbounds %struct.tpool, %struct.tpool* %9, i32 0, i32 2
  %11 = load i8, i8* %10, align 4
  %12 = load %struct.tnode*, %struct.tnode** %4, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 0
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %5, align 4
  %20 = add i32 %18, %19
  %21 = urem i32 %20, 250000
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %15, i64 0, i64 %22
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  store i8 %11, i8* %24, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sleep(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* @funk_sleep.first, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  store i32 0, i32* @funk_sleep.first, align 4
  br label %9

6:                                                ; preds = %1
  %7 = load i32, i32* %2, align 4
  %8 = call i32 @"\01_sleep"(i32 %7)
  br label %9

9:                                                ; preds = %6, %5
  ret void
}

declare i32 @"\01_sleep"(i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_increment_pool_tail(%struct.tpool*, i8*, i32) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tpool*, %struct.tpool** %4, align 8
  %8 = getelementptr inbounds %struct.tpool, %struct.tpool* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 8
  %10 = add i32 %9, 1
  %11 = icmp uge i32 %10, 250000
  br i1 %11, label %12, label %33

12:                                               ; preds = %3
  %13 = load %struct.tpool*, %struct.tpool** %4, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 2
  %15 = load i8, i8* %14, align 4
  %16 = add i8 %15, 1
  store i8 %16, i8* %14, align 4
  %17 = load %struct.tpool*, %struct.tpool** %4, align 8
  %18 = icmp eq %struct.tpool* %17, @funk_global_memory_pool
  br i1 %18, label %19, label %32

19:                                               ; preds = %12
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = icmp eq %struct.tpool* %20, @funk_global_memory_pool
  %22 = zext i1 %21 to i64
  %23 = select i1 %21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %24 = load %struct.tpool*, %struct.tpool** %4, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 8
  %27 = load %struct.tpool*, %struct.tpool** %4, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 2
  %29 = load i8, i8* %28, align 4
  %30 = zext i8 %29 to i32
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_increment_pool_tail, i64 0, i64 0), i8* %23, i32 %26, i32 250000, i32 %30)
  br label %32

32:                                               ; preds = %19, %12
  br label %33

33:                                               ; preds = %32, %3
  %34 = load %struct.tpool*, %struct.tpool** %4, align 8
  %35 = getelementptr inbounds %struct.tpool, %struct.tpool* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 8
  %37 = add i32 %36, 1
  %38 = urem i32 %37, 250000
  %39 = load %struct.tpool*, %struct.tpool** %4, align 8
  %40 = getelementptr inbounds %struct.tpool, %struct.tpool* %39, i32 0, i32 1
  store i32 %38, i32* %40, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_type(i8 zeroext) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = icmp sge i32 %4, 0
  br i1 %5, label %6, label %16

6:                                                ; preds = %1
  %7 = load i8, i8* %2, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp slt i32 %8, 9
  br i1 %9, label %10, label %16

10:                                               ; preds = %6
  %11 = load i8, i8* %2, align 1
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [9 x [100 x i8]], [9 x [100 x i8]]* @funk_types_str, i64 0, i64 %12
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %13, i64 0, i64 0
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i64 0, i64 0))
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.24, i64 0, i64 0), %struct.tnode* %6)
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 3
  %10 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.25, i64 0, i64 0), i32 %11)
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.26, i64 0, i64 0), i32 %15)
  %17 = load %struct.tnode*, %struct.tnode** %2, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 2
  %19 = load %struct.tpool*, %struct.tpool** %18, align 8
  %20 = icmp eq %struct.tpool* %19, @funk_global_memory_pool
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %2, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = load %struct.tnode*, %struct.tnode** %2, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = add i32 %28, %31
  %33 = urem i32 %32, 250000
  %34 = load %struct.tnode*, %struct.tnode** %2, align 8
  %35 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %34)
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.27, i64 0, i64 0), i8* %22, i32 %25, i32 %33, i32 %35)
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.28, i64 0, i64 0))
  store i32 0, i32* %3, align 4
  br label %38

38:                                               ; preds = %51, %1
  %39 = load i32, i32* %3, align 4
  %40 = load %struct.tnode*, %struct.tnode** %2, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = load i32, i32* %41, align 4
  %43 = icmp ult i32 %39, %42
  br i1 %43, label %44, label %54

44:                                               ; preds = %38
  %45 = load %struct.tnode*, %struct.tnode** %2, align 8
  %46 = load i32, i32* %3, align 4
  %47 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 %46, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 316, i32 1)
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.29, i64 0, i64 0), i32 %49)
  br label %51

51:                                               ; preds = %44
  %52 = load i32, i32* %3, align 4
  %53 = add i32 %52, 1
  store i32 %53, i32* %3, align 4
  br label %38

54:                                               ; preds = %38
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16, i64 0, i64 0))
  store i32 0, i32* %4, align 4
  br label %56

56:                                               ; preds = %70, %54
  %57 = load i32, i32* %4, align 4
  %58 = load %struct.tnode*, %struct.tnode** %2, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = load i32, i32* %59, align 4
  %61 = icmp ult i32 %57, %60
  br i1 %61, label %62, label %73

62:                                               ; preds = %56
  %63 = load %struct.tnode*, %struct.tnode** %2, align 8
  %64 = load i32, i32* %4, align 4
  %65 = call %struct.tdata* @get_node(%struct.tnode* %63, i32 %64, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 321, i32 1)
  %66 = getelementptr inbounds %struct.tdata, %struct.tdata* %65, i32 0, i32 1
  %67 = load i8, i8* %66, align 4
  %68 = zext i8 %67 to i32
  %69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.29, i64 0, i64 0), i32 %68)
  br label %70

70:                                               ; preds = %62
  %71 = load i32, i32* %4, align 4
  %72 = add i32 %71, 1
  store i32 %72, i32* %4, align 4
  br label %56

73:                                               ; preds = %56
  %74 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  %75 = load %struct.tnode*, %struct.tnode** %2, align 8
  %76 = call %struct.tdata* @get_node(%struct.tnode* %75, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 325, i32 1)
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 2
  %78 = bitcast %union.data_type* %77 to i32*
  %79 = load i32, i32* %78, align 8
  %80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.31, i64 0, i64 0), i32 %79)
  %81 = load %struct.tnode*, %struct.tnode** %2, align 8
  %82 = call %struct.tdata* @get_node(%struct.tnode* %81, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 326, i32 1)
  %83 = getelementptr inbounds %struct.tdata, %struct.tdata* %82, i32 0, i32 2
  %84 = bitcast %union.data_type* %83 to double*
  %85 = load double, double* %84, align 8
  %86 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.32, i64 0, i64 0), double %85)
  %87 = load %struct.tnode*, %struct.tnode** %2, align 8
  %88 = call %struct.tdata* @get_node(%struct.tnode* %87, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 327, i32 1)
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 0
  %90 = load i32, i32* %89, align 8
  %91 = trunc i32 %90 to i8
  call void @funk_print_type(i8 zeroext %91)
  %92 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  %93 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 2), align 4
  %94 = zext i8 %93 to i32
  %95 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.33, i64 0, i64 0), i32 %92, i32 %94)
  %96 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  %97 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 2), align 4
  %98 = zext i8 %97 to i32
  %99 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.34, i64 0, i64 0), i32 %96, i32 %98)
  %100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_funk_alloc_raw_tdata(%struct.tpool*, i32, i32) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %9 = load %struct.tpool*, %struct.tpool** %4, align 8
  %10 = getelementptr inbounds %struct.tpool, %struct.tpool* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 8
  store i32 %11, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %12

12:                                               ; preds = %38, %3
  %13 = load i32, i32* %8, align 4
  %14 = load i32, i32* %5, align 4
  %15 = icmp ult i32 %13, %14
  br i1 %15, label %16, label %41

16:                                               ; preds = %12
  %17 = load i32, i32* %6, align 4
  %18 = load %struct.tpool*, %struct.tpool** %4, align 8
  %19 = getelementptr inbounds %struct.tpool, %struct.tpool* %18, i32 0, i32 0
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 8
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %19, i64 0, i64 %23
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  store i32 %17, i32* %25, align 8
  %26 = load %struct.tpool*, %struct.tpool** %4, align 8
  %27 = getelementptr inbounds %struct.tpool, %struct.tpool* %26, i32 0, i32 2
  %28 = load i8, i8* %27, align 4
  %29 = load %struct.tpool*, %struct.tpool** %4, align 8
  %30 = getelementptr inbounds %struct.tpool, %struct.tpool* %29, i32 0, i32 0
  %31 = load %struct.tpool*, %struct.tpool** %4, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 1
  %33 = load i32, i32* %32, align 8
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %30, i64 0, i64 %34
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 1
  store i8 %28, i8* %36, align 4
  %37 = load %struct.tpool*, %struct.tpool** %4, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %37, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_alloc_raw_tdata, i64 0, i64 0), i32 348)
  br label %38

38:                                               ; preds = %16
  %39 = load i32, i32* %8, align 4
  %40 = add i32 %39, 1
  store i32 %40, i32* %8, align 4
  br label %12

41:                                               ; preds = %12
  %42 = load i32, i32* %7, align 4
  ret i32 %42
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_node(%struct.tnode*, i32, i32, i32, i8 zeroext, i8*) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i8, align 1
  %12 = alloca i8*, align 8
  %13 = alloca i32, align 4
  %14 = alloca %struct.tpool*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store i32 %2, i32* %9, align 4
  store i32 %3, i32* %10, align 4
  store i8 %4, i8* %11, align 1
  store i8* %5, i8** %12, align 8
  %17 = load i8, i8* %11, align 1
  %18 = zext i8 %17 to i32
  %19 = icmp slt i32 %18, 2
  br i1 %19, label %20, label %21

20:                                               ; preds = %6
  br label %24

21:                                               ; preds = %6
  %22 = load i8, i8* %11, align 1
  %23 = zext i8 %22 to i32
  br label %24

24:                                               ; preds = %21, %20
  %25 = phi i32 [ 1, %20 ], [ %23, %21 ]
  %26 = trunc i32 %25 to i8
  store i8 %26, i8* %11, align 1
  %27 = load i32, i32* %8, align 4
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %24
  br label %32

30:                                               ; preds = %24
  %31 = load i32, i32* %8, align 4
  br label %32

32:                                               ; preds = %30, %29
  %33 = phi i32 [ 1, %29 ], [ %31, %30 ]
  store i32 %33, i32* %13, align 4
  %34 = load i32, i32* %9, align 4
  %35 = call %struct.tpool* @get_pool_ptr(i32 %34)
  store %struct.tpool* %35, %struct.tpool** %14, align 8
  %36 = load %struct.tpool*, %struct.tpool** %14, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = load %struct.tnode*, %struct.tnode** %7, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 0
  store i32 %38, i32* %40, align 8
  %41 = load %struct.tpool*, %struct.tpool** %14, align 8
  %42 = load %struct.tnode*, %struct.tnode** %7, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  store %struct.tpool* %41, %struct.tpool** %43, align 8
  %44 = load i32, i32* %13, align 4
  %45 = load %struct.tnode*, %struct.tnode** %7, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 1
  store i32 %44, i32* %46, align 4
  %47 = load i8, i8* %11, align 1
  %48 = zext i8 %47 to i32
  %49 = icmp sge i32 %48, 2
  br i1 %49, label %50, label %59

50:                                               ; preds = %32
  %51 = load %struct.tnode*, %struct.tnode** %7, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 0
  %53 = load i32, i32* %52, align 8
  %54 = load i32, i32* %8, align 4
  %55 = add i32 %53, %54
  %56 = load %struct.tnode*, %struct.tnode** %7, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 3
  %58 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %57, i32 0, i32 1
  store i32 %55, i32* %58, align 4
  br label %63

59:                                               ; preds = %32
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 3
  %62 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %61, i32 0, i32 1
  store i32 0, i32* %62, align 4
  br label %63

63:                                               ; preds = %59, %50
  %64 = load %struct.tnode*, %struct.tnode** %7, align 8
  %65 = load i8, i8* %11, align 1
  %66 = zext i8 %65 to i32
  call void @_funk_set_node_dimension_count(%struct.tnode* %64, i32 %66)
  store i32 0, i32* %15, align 4
  br label %67

67:                                               ; preds = %125, %63
  %68 = load i32, i32* %15, align 4
  %69 = load i32, i32* %13, align 4
  %70 = icmp ult i32 %68, %69
  br i1 %70, label %71, label %128

71:                                               ; preds = %67
  %72 = load i32, i32* %10, align 4
  %73 = load %struct.tnode*, %struct.tnode** %7, align 8
  %74 = load i32, i32* %15, align 4
  %75 = call %struct.tdata* @get_node(%struct.tnode* %73, i32 %74, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 382, i32 0)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 0
  store i32 %72, i32* %76, align 8
  %77 = load %struct.tnode*, %struct.tnode** %7, align 8
  %78 = load i32, i32* %15, align 4
  %79 = load %struct.tpool*, %struct.tpool** %14, align 8
  %80 = getelementptr inbounds %struct.tpool, %struct.tpool* %79, i32 0, i32 2
  %81 = load i8, i8* %80, align 4
  call void @_set_wrap_creation(%struct.tnode* %77, i32 %78, i8 zeroext %81)
  %82 = load %struct.tpool*, %struct.tpool** %14, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %82, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 385)
  %83 = load i8*, i8** %12, align 8
  %84 = icmp eq i8* %83, null
  br i1 %84, label %85, label %86

85:                                               ; preds = %71
  br label %125

86:                                               ; preds = %71
  %87 = load i32, i32* %10, align 4
  switch i32 %87, label %123 [
    i32 1, label %88
    i32 2, label %100
    i32 4, label %112
  ]

88:                                               ; preds = %86
  %89 = load i8*, i8** %12, align 8
  %90 = bitcast i8* %89 to i32*
  %91 = load i32, i32* %15, align 4
  %92 = zext i32 %91 to i64
  %93 = getelementptr inbounds i32, i32* %90, i64 %92
  %94 = load i32, i32* %93, align 4
  %95 = load %struct.tnode*, %struct.tnode** %7, align 8
  %96 = load i32, i32* %15, align 4
  %97 = call %struct.tdata* @get_node(%struct.tnode* %95, i32 %96, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 392, i32 1)
  %98 = getelementptr inbounds %struct.tdata, %struct.tdata* %97, i32 0, i32 2
  %99 = bitcast %union.data_type* %98 to i32*
  store i32 %94, i32* %99, align 8
  br label %124

100:                                              ; preds = %86
  %101 = load i8*, i8** %12, align 8
  %102 = bitcast i8* %101 to double*
  %103 = load i32, i32* %15, align 4
  %104 = zext i32 %103 to i64
  %105 = getelementptr inbounds double, double* %102, i64 %104
  %106 = load double, double* %105, align 8
  %107 = load %struct.tnode*, %struct.tnode** %7, align 8
  %108 = load i32, i32* %15, align 4
  %109 = call %struct.tdata* @get_node(%struct.tnode* %107, i32 %108, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 396, i32 1)
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 2
  %111 = bitcast %union.data_type* %110 to double*
  store double %106, double* %111, align 8
  br label %124

112:                                              ; preds = %86
  %113 = load %struct.tnode*, %struct.tnode** %7, align 8
  %114 = load i32, i32* %15, align 4
  %115 = call %struct.tdata* @get_node(%struct.tnode* %113, i32 %114, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 400, i32 1)
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 2
  %117 = bitcast %union.data_type* %116 to i32*
  store i32 0, i32* %117, align 8
  %118 = load %struct.tnode*, %struct.tnode** %7, align 8
  %119 = load i32, i32* %15, align 4
  %120 = call %struct.tdata* @get_node(%struct.tnode* %118, i32 %119, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 401, i32 1)
  %121 = getelementptr inbounds %struct.tdata, %struct.tdata* %120, i32 0, i32 2
  %122 = bitcast %union.data_type* %121 to double*
  store double 0.000000e+00, double* %122, align 8
  br label %124

123:                                              ; preds = %86
  br label %124

124:                                              ; preds = %123, %112, %100, %88
  br label %125

125:                                              ; preds = %124, %85
  %126 = load i32, i32* %15, align 4
  %127 = add i32 %126, 1
  store i32 %127, i32* %15, align 4
  br label %67

128:                                              ; preds = %67
  %129 = load i8, i8* %11, align 1
  %130 = zext i8 %129 to i32
  %131 = icmp sge i32 %130, 2
  br i1 %131, label %132, label %151

132:                                              ; preds = %128
  store i32 0, i32* %16, align 4
  br label %133

133:                                              ; preds = %147, %132
  %134 = load i32, i32* %16, align 4
  %135 = load i8, i8* %11, align 1
  %136 = zext i8 %135 to i32
  %137 = icmp ult i32 %134, %136
  br i1 %137, label %138, label %150

138:                                              ; preds = %133
  %139 = load %struct.tnode*, %struct.tnode** %7, align 8
  %140 = load i32, i32* %13, align 4
  %141 = load i32, i32* %16, align 4
  %142 = add i32 %140, %141
  %143 = load %struct.tpool*, %struct.tpool** %14, align 8
  %144 = getelementptr inbounds %struct.tpool, %struct.tpool* %143, i32 0, i32 2
  %145 = load i8, i8* %144, align 4
  call void @_set_wrap_creation(%struct.tnode* %139, i32 %142, i8 zeroext %145)
  %146 = load %struct.tpool*, %struct.tpool** %14, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %146, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 412)
  br label %147

147:                                              ; preds = %138
  %148 = load i32, i32* %16, align 4
  %149 = add i32 %148, 1
  store i32 %149, i32* %16, align 4
  br label %133

150:                                              ; preds = %133
  br label %151

151:                                              ; preds = %150, %128
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_deep_copy_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  store %struct.tnode* %10, %struct.tnode** %5, align 8
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 423, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp eq i32 %14, 7
  br i1 %15, label %16, label %23

16:                                               ; preds = %2
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 2
  %19 = load %struct.tpool*, %struct.tpool** %18, align 8
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 0
  %22 = load i32, i32* %21, align 8
  call void @_dereference(%struct.tnode* %6, %struct.tpool* %19, i32 %22, i32 0, i32 10, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 425)
  store %struct.tnode* %6, %struct.tnode** %5, align 8
  br label %23

23:                                               ; preds = %16, %2
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 428, i32 1)
  %26 = getelementptr inbounds %struct.tdata, %struct.tdata* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = icmp eq i32 %27, 7
  br i1 %28, label %29, label %33

29:                                               ; preds = %23
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 4
  br label %34

33:                                               ; preds = %23
  br label %34

34:                                               ; preds = %33, %29
  %35 = phi i32 [ %32, %29 ], [ 1, %33 ]
  store i32 %35, i32* %7, align 4
  %36 = load %struct.tnode*, %struct.tnode** %3, align 8
  %37 = load i32, i32* %7, align 4
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 2
  %40 = load %struct.tpool*, %struct.tpool** %39, align 8
  %41 = call i32 @get_pool_enum(%struct.tpool* %40)
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %42)
  %44 = trunc i32 %43 to i8
  call void @funk_create_node(%struct.tnode* %36, i32 %37, i32 %41, i32 1, i8 zeroext %44, i8* null)
  store i32 0, i32* %8, align 4
  br label %45

45:                                               ; preds = %69, %34
  %46 = load i32, i32* %8, align 4
  %47 = load i32, i32* %7, align 4
  %48 = icmp ult i32 %46, %47
  br i1 %48, label %49, label %72

49:                                               ; preds = %45
  %50 = load %struct.tnode*, %struct.tnode** %3, align 8
  %51 = load i32, i32* %8, align 4
  %52 = call %struct.tdata* @get_node(%struct.tnode* %50, i32 %51, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 434, i32 1)
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 2
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = load i32, i32* %8, align 4
  %56 = call %struct.tdata* @get_node(%struct.tnode* %54, i32 %55, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 434, i32 1)
  %57 = getelementptr inbounds %struct.tdata, %struct.tdata* %56, i32 0, i32 2
  %58 = bitcast %union.data_type* %53 to i8*
  %59 = bitcast %union.data_type* %57 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %58, i8* align 8 %59, i64 8, i1 false)
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = load i32, i32* %8, align 4
  %62 = call %struct.tdata* @get_node(%struct.tnode* %60, i32 %61, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 435, i32 1)
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 0
  %64 = load i32, i32* %63, align 8
  %65 = load %struct.tnode*, %struct.tnode** %3, align 8
  %66 = load i32, i32* %8, align 4
  %67 = call %struct.tdata* @get_node(%struct.tnode* %65, i32 %66, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 435, i32 1)
  %68 = getelementptr inbounds %struct.tdata, %struct.tdata* %67, i32 0, i32 0
  store i32 %64, i32* %68, align 8
  br label %69

69:                                               ; preds = %49
  %70 = load i32, i32* %8, align 4
  %71 = add i32 %70, 1
  store i32 %71, i32* %8, align 4
  br label %45

72:                                               ; preds = %45
  %73 = load i32, i32* %7, align 4
  %74 = icmp eq i32 %73, 1
  br i1 %74, label %75, label %80

75:                                               ; preds = %72
  %76 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @_funk_set_node_dimension_count(%struct.tnode* %76, i32 0)
  %77 = load %struct.tnode*, %struct.tnode** %3, align 8
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 3
  %79 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %78, i32 0, i32 1
  store i32 0, i32* %79, align 4
  br label %95

80:                                               ; preds = %72
  store i32 0, i32* %9, align 4
  br label %81

81:                                               ; preds = %92, %80
  %82 = load i32, i32* %9, align 4
  %83 = load %struct.tnode*, %struct.tnode** %5, align 8
  %84 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %83)
  %85 = icmp ult i32 %82, %84
  br i1 %85, label %86, label %95

86:                                               ; preds = %81
  %87 = load %struct.tnode*, %struct.tnode** %3, align 8
  %88 = load i32, i32* %9, align 4
  %89 = load %struct.tnode*, %struct.tnode** %5, align 8
  %90 = load i32, i32* %9, align 4
  %91 = call i32 @_funk_get_node_dimension(%struct.tnode* %89, i32 %90)
  call void @_funk_set_node_dimension(%struct.tnode* %87, i32 %88, i32 %91, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 444)
  br label %92

92:                                               ; preds = %86
  %93 = load i32, i32* %9, align 4
  %94 = add i32 %93, 1
  store i32 %94, i32* %9, align 4
  br label %81

95:                                               ; preds = %75, %81
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_dereference(%struct.tnode*, %struct.tpool*, i32, i32, i32, i8*, i32) #0 {
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tpool*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %8, align 8
  store %struct.tpool* %1, %struct.tpool** %9, align 8
  store i32 %2, i32* %10, align 4
  store i32 %3, i32* %11, align 4
  store i32 %4, i32* %12, align 4
  store i8* %5, i8** %13, align 8
  store i32 %6, i32* %14, align 4
  %16 = load %struct.tpool*, %struct.tpool** %9, align 8
  %17 = getelementptr inbounds %struct.tpool, %struct.tpool* %16, i32 0, i32 0
  %18 = load i32, i32* %10, align 4
  %19 = load i32, i32* %11, align 4
  %20 = add i32 %18, %19
  %21 = urem i32 %20, 250000
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %17, i64 0, i64 %22
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  store i32 %25, i32* %15, align 4
  %26 = load i32, i32* %12, align 4
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %30

28:                                               ; preds = %7
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.40, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__._dereference, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

30:                                               ; preds = %7
  %31 = load i32, i32* %15, align 4
  %32 = icmp eq i32 %31, 7
  br i1 %32, label %33, label %51

33:                                               ; preds = %30
  %34 = load %struct.tnode*, %struct.tnode** %8, align 8
  %35 = load %struct.tpool*, %struct.tpool** %9, align 8
  %36 = load %struct.tpool*, %struct.tpool** %9, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 0
  %38 = load i32, i32* %10, align 4
  %39 = load i32, i32* %11, align 4
  %40 = add i32 %38, %39
  %41 = urem i32 %40, 250000
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %37, i64 0, i64 %42
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 2
  %45 = bitcast %union.data_type* %44 to i32*
  %46 = load i32, i32* %45, align 8
  %47 = load i32, i32* %12, align 4
  %48 = sub nsw i32 %47, 1
  %49 = load i8*, i8** %13, align 8
  %50 = load i32, i32* %14, align 4
  call void @_dereference(%struct.tnode* %34, %struct.tpool* %35, i32 %46, i32 0, i32 %48, i8* %49, i32 %50)
  br label %126

51:                                               ; preds = %30
  %52 = load i32, i32* %15, align 4
  %53 = icmp eq i32 %52, 8
  br i1 %53, label %54, label %116

54:                                               ; preds = %51
  %55 = load %struct.tpool*, %struct.tpool** %9, align 8
  %56 = load %struct.tnode*, %struct.tnode** %8, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  store %struct.tpool* %55, %struct.tpool** %57, align 8
  %58 = load %struct.tpool*, %struct.tpool** %9, align 8
  %59 = getelementptr inbounds %struct.tpool, %struct.tpool* %58, i32 0, i32 0
  %60 = load i32, i32* %10, align 4
  %61 = load i32, i32* %11, align 4
  %62 = add i32 %60, %61
  %63 = add i32 %62, 0
  %64 = urem i32 %63, 250000
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %59, i64 0, i64 %65
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 2
  %68 = bitcast %union.data_type* %67 to i32*
  %69 = load i32, i32* %68, align 8
  %70 = load %struct.tnode*, %struct.tnode** %8, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 0
  store i32 %69, i32* %71, align 8
  %72 = load %struct.tpool*, %struct.tpool** %9, align 8
  %73 = getelementptr inbounds %struct.tpool, %struct.tpool* %72, i32 0, i32 0
  %74 = load i32, i32* %10, align 4
  %75 = load i32, i32* %11, align 4
  %76 = add i32 %74, %75
  %77 = add i32 %76, 1
  %78 = urem i32 %77, 250000
  %79 = zext i32 %78 to i64
  %80 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %73, i64 0, i64 %79
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 2
  %82 = bitcast %union.data_type* %81 to i32*
  %83 = load i32, i32* %82, align 8
  %84 = load %struct.tnode*, %struct.tnode** %8, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 1
  store i32 %83, i32* %85, align 4
  %86 = load %struct.tpool*, %struct.tpool** %9, align 8
  %87 = getelementptr inbounds %struct.tpool, %struct.tpool* %86, i32 0, i32 0
  %88 = load i32, i32* %10, align 4
  %89 = load i32, i32* %11, align 4
  %90 = add i32 %88, %89
  %91 = add i32 %90, 2
  %92 = urem i32 %91, 250000
  %93 = zext i32 %92 to i64
  %94 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %87, i64 0, i64 %93
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 2
  %96 = bitcast %union.data_type* %95 to i32*
  %97 = load i32, i32* %96, align 8
  %98 = load %struct.tnode*, %struct.tnode** %8, align 8
  %99 = getelementptr inbounds %struct.tnode, %struct.tnode* %98, i32 0, i32 3
  %100 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %99, i32 0, i32 0
  store i32 %97, i32* %100, align 8
  %101 = load %struct.tpool*, %struct.tpool** %9, align 8
  %102 = getelementptr inbounds %struct.tpool, %struct.tpool* %101, i32 0, i32 0
  %103 = load i32, i32* %10, align 4
  %104 = load i32, i32* %11, align 4
  %105 = add i32 %103, %104
  %106 = add i32 %105, 3
  %107 = urem i32 %106, 250000
  %108 = zext i32 %107 to i64
  %109 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %102, i64 0, i64 %108
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 2
  %111 = bitcast %union.data_type* %110 to i32*
  %112 = load i32, i32* %111, align 8
  %113 = load %struct.tnode*, %struct.tnode** %8, align 8
  %114 = getelementptr inbounds %struct.tnode, %struct.tnode* %113, i32 0, i32 3
  %115 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %114, i32 0, i32 1
  store i32 %112, i32* %115, align 4
  br label %125

116:                                              ; preds = %51
  %117 = load i32, i32* %15, align 4
  %118 = load i8*, i8** %13, align 8
  %119 = load i32, i32* %14, align 4
  %120 = load %struct.tpool*, %struct.tpool** %9, align 8
  %121 = icmp eq %struct.tpool* %120, @funk_global_memory_pool
  %122 = zext i1 %121 to i64
  %123 = select i1 %121, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %124 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.41, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__._dereference, i64 0, i64 0), i32 %117, i8* %118, i32 %119, i8* %123)
  call void @exit(i32 1) #6
  unreachable

125:                                              ; preds = %54
  br label %126

126:                                              ; preds = %125, %33
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  %9 = load %struct.tnode*, %struct.tnode** %3, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 0
  store i32 %8, i32* %10, align 8
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 4
  %14 = load %struct.tnode*, %struct.tnode** %3, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  store i32 %13, i32* %15, align 4
  %16 = load %struct.tnode*, %struct.tnode** %3, align 8
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %17)
  call void @_funk_set_node_dimension_count(%struct.tnode* %16, i32 %18)
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 2
  %21 = load %struct.tpool*, %struct.tpool** %20, align 8
  %22 = load %struct.tnode*, %struct.tnode** %3, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 2
  store %struct.tpool* %21, %struct.tpool** %23, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 3
  %26 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  store i32 %27, i32* %5, align 4
  %28 = load i32, i32* %5, align 4
  %29 = load %struct.tnode*, %struct.tnode** %3, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 3
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 1
  store i32 %28, i32* %31, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_exit() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.35, i64 0, i64 0))
  call void @exit(i32 0) #6
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_roll(%struct.tnode*, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32*, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %19 = load i32, i32* %8, align 4
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %20)
  %22 = icmp ne i32 %19, %21
  br i1 %22, label %23, label %26

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 %24)
  call void @exit(i32 1) #6
  unreachable

26:                                               ; preds = %4
  %27 = load %struct.tnode*, %struct.tnode** %7, align 8
  %28 = call %struct.tdata* @get_node(%struct.tnode* %27, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 481, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  store i32 %31, i32* %9, align 4
  %32 = load %struct.tnode*, %struct.tnode** %7, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i64 1
  %34 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 482, i32 1)
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 2
  %36 = bitcast %union.data_type* %35 to i32*
  %37 = load i32, i32* %36, align 8
  store i32 %37, i32* %10, align 4
  %38 = load i32, i32* %8, align 4
  %39 = icmp eq i32 %38, 2
  br i1 %39, label %40, label %144

40:                                               ; preds = %26
  %41 = load %struct.tnode*, %struct.tnode** %6, align 8
  %42 = call i32 @_funk_get_node_dimension(%struct.tnode* %41, i32 0)
  store i32 %42, i32* %11, align 4
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = call i32 @_funk_get_node_dimension(%struct.tnode* %43, i32 1)
  store i32 %44, i32* %12, align 4
  %45 = load i32, i32* %11, align 4
  %46 = load i32, i32* %12, align 4
  %47 = mul nsw i32 %45, %46
  %48 = sext i32 %47 to i64
  %49 = mul i64 %48, 4
  %50 = call i8* @malloc(i64 %49) #7
  %51 = bitcast i8* %50 to i32*
  store i32* %51, i32** %13, align 8
  store i32 0, i32* %14, align 4
  br label %52

52:                                               ; preds = %119, %40
  %53 = load i32, i32* %14, align 4
  %54 = load i32, i32* %11, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %122

56:                                               ; preds = %52
  store i32 0, i32* %15, align 4
  br label %57

57:                                               ; preds = %115, %56
  %58 = load i32, i32* %15, align 4
  %59 = load i32, i32* %12, align 4
  %60 = icmp slt i32 %58, %59
  br i1 %60, label %61, label %118

61:                                               ; preds = %57
  %62 = load i32, i32* %14, align 4
  %63 = load i32, i32* %9, align 4
  %64 = add nsw i32 %62, %63
  %65 = load %struct.tnode*, %struct.tnode** %6, align 8
  %66 = call i32 @_funk_get_node_dimension(%struct.tnode* %65, i32 0)
  %67 = urem i32 %64, %66
  store i32 %67, i32* %16, align 4
  %68 = load i32, i32* %15, align 4
  %69 = load i32, i32* %10, align 4
  %70 = add nsw i32 %68, %69
  %71 = load %struct.tnode*, %struct.tnode** %6, align 8
  %72 = call i32 @_funk_get_node_dimension(%struct.tnode* %71, i32 1)
  %73 = urem i32 %70, %72
  store i32 %73, i32* %17, align 4
  %74 = load i32, i32* %16, align 4
  %75 = icmp slt i32 %74, 0
  br i1 %75, label %76, label %81

76:                                               ; preds = %61
  %77 = load %struct.tnode*, %struct.tnode** %6, align 8
  %78 = call i32 @_funk_get_node_dimension(%struct.tnode* %77, i32 0)
  %79 = load i32, i32* %16, align 4
  %80 = add i32 %78, %79
  br label %83

81:                                               ; preds = %61
  %82 = load i32, i32* %16, align 4
  br label %83

83:                                               ; preds = %81, %76
  %84 = phi i32 [ %80, %76 ], [ %82, %81 ]
  store i32 %84, i32* %16, align 4
  %85 = load i32, i32* %17, align 4
  %86 = icmp slt i32 %85, 0
  br i1 %86, label %87, label %92

87:                                               ; preds = %83
  %88 = load %struct.tnode*, %struct.tnode** %6, align 8
  %89 = call i32 @_funk_get_node_dimension(%struct.tnode* %88, i32 1)
  %90 = load i32, i32* %17, align 4
  %91 = add i32 %89, %90
  br label %94

92:                                               ; preds = %83
  %93 = load i32, i32* %17, align 4
  br label %94

94:                                               ; preds = %92, %87
  %95 = phi i32 [ %91, %87 ], [ %93, %92 ]
  store i32 %95, i32* %17, align 4
  %96 = load %struct.tnode*, %struct.tnode** %6, align 8
  %97 = load i32, i32* %14, align 4
  %98 = load i32, i32* %12, align 4
  %99 = mul nsw i32 %97, %98
  %100 = load i32, i32* %15, align 4
  %101 = add nsw i32 %99, %100
  %102 = call %struct.tdata* @get_node(%struct.tnode* %96, i32 %101, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 495, i32 1)
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 2
  %104 = bitcast %union.data_type* %103 to i32*
  %105 = load i32, i32* %104, align 8
  %106 = load i32*, i32** %13, align 8
  %107 = load i32, i32* %16, align 4
  %108 = load i32, i32* %12, align 4
  %109 = mul nsw i32 %107, %108
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds i32, i32* %106, i64 %110
  %112 = load i32, i32* %17, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds i32, i32* %111, i64 %113
  store i32 %105, i32* %114, align 4
  br label %115

115:                                              ; preds = %94
  %116 = load i32, i32* %15, align 4
  %117 = add nsw i32 %116, 1
  store i32 %117, i32* %15, align 4
  br label %57

118:                                              ; preds = %57
  br label %119

119:                                              ; preds = %118
  %120 = load i32, i32* %14, align 4
  %121 = add nsw i32 %120, 1
  store i32 %121, i32* %14, align 4
  br label %52

122:                                              ; preds = %52
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = load %struct.tnode*, %struct.tnode** %6, align 8
  %125 = getelementptr inbounds %struct.tnode, %struct.tnode* %124, i32 0, i32 1
  %126 = load i32, i32* %125, align 4
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 2
  %129 = load %struct.tpool*, %struct.tpool** %128, align 8
  %130 = icmp eq %struct.tpool* %129, @funk_global_memory_pool
  %131 = zext i1 %130 to i64
  %132 = select i1 %130, i32 1, i32 0
  %133 = load %struct.tnode*, %struct.tnode** %6, align 8
  %134 = call %struct.tdata* @get_node(%struct.tnode* %133, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 501, i32 1)
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 0
  %136 = load i32, i32* %135, align 8
  %137 = load %struct.tnode*, %struct.tnode** %6, align 8
  %138 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %137)
  %139 = trunc i32 %138 to i8
  %140 = load i32*, i32** %13, align 8
  %141 = bitcast i32* %140 to i8*
  call void @funk_create_node(%struct.tnode* %123, i32 %126, i32 %132, i32 %136, i8 zeroext %139, i8* %141)
  %142 = load i32*, i32** %13, align 8
  %143 = bitcast i32* %142 to i8*
  call void @free(i8* %143)
  br label %146

144:                                              ; preds = %26
  %145 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.37, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

146:                                              ; preds = %122
  store i32 0, i32* %18, align 4
  br label %147

147:                                              ; preds = %157, %146
  %148 = load i32, i32* %18, align 4
  %149 = load i32, i32* %8, align 4
  %150 = icmp ult i32 %148, %149
  br i1 %150, label %151, label %160

151:                                              ; preds = %147
  %152 = load %struct.tnode*, %struct.tnode** %5, align 8
  %153 = load i32, i32* %18, align 4
  %154 = load %struct.tnode*, %struct.tnode** %6, align 8
  %155 = load i32, i32* %18, align 4
  %156 = call i32 @_funk_get_node_dimension(%struct.tnode* %154, i32 %155)
  call void @_funk_set_node_dimension(%struct.tnode* %152, i32 %153, i32 %156, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 509)
  br label %157

157:                                              ; preds = %151
  %158 = load i32, i32* %18, align 4
  %159 = add i32 %158, 1
  store i32 %159, i32* %18, align 4
  br label %147

160:                                              ; preds = %147
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #4

declare void @free(i8*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_not(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  %13 = load %struct.tpool*, %struct.tpool** %12, align 8
  %14 = icmp eq %struct.tpool* %13, @funk_global_memory_pool
  %15 = zext i1 %14 to i64
  %16 = select i1 %14, i32 1, i32 0
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 518, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %21)
  %23 = trunc i32 %22 to i8
  call void @funk_create_node(%struct.tnode* %7, i32 %10, i32 %16, i32 %20, i8 zeroext %23, i8* null)
  store i32 0, i32* %5, align 4
  br label %24

24:                                               ; preds = %35, %2
  %25 = load i32, i32* %5, align 4
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %26)
  %28 = icmp ult i32 %25, %27
  br i1 %28, label %29, label %38

29:                                               ; preds = %24
  %30 = load %struct.tnode*, %struct.tnode** %3, align 8
  %31 = load i32, i32* %5, align 4
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = load i32, i32* %5, align 4
  %34 = call i32 @_funk_get_node_dimension(%struct.tnode* %32, i32 %33)
  call void @_funk_set_node_dimension(%struct.tnode* %30, i32 %31, i32 %34, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 521)
  br label %35

35:                                               ; preds = %29
  %36 = load i32, i32* %5, align 4
  %37 = add i32 %36, 1
  store i32 %37, i32* %5, align 4
  br label %24

38:                                               ; preds = %24
  store i32 0, i32* %6, align 4
  br label %39

39:                                               ; preds = %66, %38
  %40 = load i32, i32* %6, align 4
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 1
  %43 = load i32, i32* %42, align 4
  %44 = icmp ult i32 %40, %43
  br i1 %44, label %45, label %69

45:                                               ; preds = %39
  %46 = load %struct.tnode*, %struct.tnode** %4, align 8
  %47 = load i32, i32* %6, align 4
  %48 = call %struct.tdata* @get_node(%struct.tnode* %46, i32 %47, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 525, i32 1)
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 2
  %50 = bitcast %union.data_type* %49 to i32*
  %51 = load i32, i32* %50, align 8
  %52 = icmp eq i32 %51, 0
  br i1 %52, label %53, label %59

53:                                               ; preds = %45
  %54 = load %struct.tnode*, %struct.tnode** %3, align 8
  %55 = load i32, i32* %6, align 4
  %56 = call %struct.tdata* @get_node(%struct.tnode* %54, i32 %55, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 526, i32 1)
  %57 = getelementptr inbounds %struct.tdata, %struct.tdata* %56, i32 0, i32 2
  %58 = bitcast %union.data_type* %57 to i32*
  store i32 1, i32* %58, align 8
  br label %65

59:                                               ; preds = %45
  %60 = load %struct.tnode*, %struct.tnode** %3, align 8
  %61 = load i32, i32* %6, align 4
  %62 = call %struct.tdata* @get_node(%struct.tnode* %60, i32 %61, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 528, i32 1)
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 2
  %64 = bitcast %union.data_type* %63 to i32*
  store i32 0, i32* %64, align 8
  br label %65

65:                                               ; preds = %59, %53
  br label %66

66:                                               ; preds = %65
  %67 = load i32, i32* %6, align 4
  %68 = add i32 %67, 1
  store i32 %68, i32* %6, align 4
  br label %39

69:                                               ; preds = %39
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_funk_sum_list(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  store i32 0, i32* %3, align 4
  store i32 0, i32* %4, align 4
  br label %6

6:                                                ; preds = %40, %1
  %7 = load i32, i32* %4, align 4
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp ult i32 %7, %10
  br i1 %11, label %12, label %43

12:                                               ; preds = %6
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = load i32, i32* %4, align 4
  %15 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %14, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 537, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 7
  br i1 %18, label %19, label %30

19:                                               ; preds = %12
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 2
  %22 = load %struct.tpool*, %struct.tpool** %21, align 8
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = load i32, i32* %4, align 4
  call void @_dereference(%struct.tnode* %5, %struct.tpool* %22, i32 %25, i32 %26, i32 10, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 539)
  %27 = call i32 @_funk_sum_list(%struct.tnode* %5)
  %28 = load i32, i32* %3, align 4
  %29 = add nsw i32 %28, %27
  store i32 %29, i32* %3, align 4
  br label %39

30:                                               ; preds = %12
  %31 = load %struct.tnode*, %struct.tnode** %2, align 8
  %32 = load i32, i32* %4, align 4
  %33 = call %struct.tdata* @get_node(%struct.tnode* %31, i32 %32, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 543, i32 1)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 2
  %35 = bitcast %union.data_type* %34 to i32*
  %36 = load i32, i32* %35, align 8
  %37 = load i32, i32* %3, align 4
  %38 = add nsw i32 %37, %36
  store i32 %38, i32* %3, align 4
  br label %39

39:                                               ; preds = %30, %19
  br label %40

40:                                               ; preds = %39
  %41 = load i32, i32* %4, align 4
  %42 = add i32 %41, 1
  store i32 %42, i32* %4, align 4
  br label %6

43:                                               ; preds = %6
  %44 = load i32, i32* %3, align 4
  ret i32 %44
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sum_list(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  %7 = call i32 @_funk_sum_list(%struct.tnode* %6)
  store i32 %7, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  %11 = load %struct.tpool*, %struct.tpool** %10, align 8
  %12 = call i32 @get_pool_enum(%struct.tpool* %11)
  %13 = bitcast i32* %5 to i8*
  call void @funk_create_node(%struct.tnode* %8, i32 1, i32 %12, i32 1, i8 zeroext 0, i8* %13)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = call i64 @time(i64* null)
  %3 = trunc i64 %2 to i32
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  call void @srand(i32 %4)
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  store i8 0, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 2), align 4
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  store i8 0, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 2), align 4
  call void @llvm.memset.p0i8.i64(i8* align 8 bitcast (%struct.tpool* @funk_global_memory_pool to i8*), i8 0, i64 4000000, i1 false)
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_matrix_ptr(%struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode, align 8
  %10 = alloca %struct.tdata*, align 8
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %11 = load i32, i32* %7, align 4
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %13, label %19

13:                                               ; preds = %4
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = load i32, i32* %7, align 4
  %18 = add i32 %16, %17
  br label %21

19:                                               ; preds = %4
  %20 = load i32, i32* %7, align 4
  br label %21

21:                                               ; preds = %19, %13
  %22 = phi i32 [ %18, %13 ], [ %20, %19 ]
  store i32 %22, i32* %7, align 4
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = load i32, i32* %7, align 4
  %27 = urem i32 %26, %25
  store i32 %27, i32* %7, align 4
  %28 = load %struct.tnode*, %struct.tnode** %5, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 2
  %30 = load %struct.tpool*, %struct.tpool** %29, align 8
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = load i32, i32* %7, align 4
  call void @_dereference(%struct.tnode* %9, %struct.tpool* %30, i32 %33, i32 %34, i32 10, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_get_element_in_matrix_ptr, i64 0, i64 0), i32 598)
  %35 = load i32, i32* %8, align 4
  %36 = icmp slt i32 %35, 0
  br i1 %36, label %37, label %42

37:                                               ; preds = %21
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  %40 = load i32, i32* %8, align 4
  %41 = add i32 %39, %40
  br label %44

42:                                               ; preds = %21
  %43 = load i32, i32* %8, align 4
  br label %44

44:                                               ; preds = %42, %37
  %45 = phi i32 [ %41, %37 ], [ %43, %42 ]
  store i32 %45, i32* %8, align 4
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* %8, align 4
  %49 = urem i32 %48, %47
  store i32 %49, i32* %8, align 4
  store %struct.tdata* null, %struct.tdata** %10, align 8
  %50 = load i32, i32* %8, align 4
  %51 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 %50, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_get_element_in_matrix_ptr, i64 0, i64 0), i32 605, i32 1)
  store %struct.tdata* %51, %struct.tdata** %10, align 8
  %52 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_copy_node(%struct.tnode* %52, %struct.tnode* %9)
  %53 = load i32, i32* %8, align 4
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 0
  %56 = load i32, i32* %55, align 8
  %57 = add i32 %56, %53
  store i32 %57, i32* %55, align 8
  %58 = load %struct.tnode*, %struct.tnode** %6, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  store i32 1, i32* %59, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_matrix_2d_lit(%struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 613, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp eq i32 %14, 7
  br i1 %15, label %16, label %21

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = load i32, i32* %7, align 4
  %20 = load i32, i32* %8, align 4
  call void @funk_get_element_in_matrix_ptr(%struct.tnode* %17, %struct.tnode* %18, i32 %19, i32 %20)
  br label %76

21:                                               ; preds = %4
  %22 = load %struct.tnode*, %struct.tnode** %5, align 8
  %23 = call i32 @_funk_get_node_dimension(%struct.tnode* %22, i32 0)
  store i32 %23, i32* %9, align 4
  %24 = load %struct.tnode*, %struct.tnode** %5, align 8
  %25 = call i32 @_funk_get_node_dimension(%struct.tnode* %24, i32 1)
  store i32 %25, i32* %10, align 4
  %26 = load i32, i32* %9, align 4
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %31, label %28

28:                                               ; preds = %21
  %29 = load i32, i32* %10, align 4
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %36

31:                                               ; preds = %28, %21
  %32 = load i32, i32* %9, align 4
  %33 = load i32, i32* %10, align 4
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.38, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 %32, i32 %33)
  %35 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node_info(%struct.tnode* %35)
  call void @exit(i32 1) #6
  unreachable

36:                                               ; preds = %28
  %37 = load i32, i32* %7, align 4
  %38 = icmp slt i32 %37, 0
  br i1 %38, label %39, label %43

39:                                               ; preds = %36
  %40 = load i32, i32* %9, align 4
  %41 = load i32, i32* %7, align 4
  %42 = add i32 %40, %41
  br label %45

43:                                               ; preds = %36
  %44 = load i32, i32* %7, align 4
  br label %45

45:                                               ; preds = %43, %39
  %46 = phi i32 [ %42, %39 ], [ %44, %43 ]
  store i32 %46, i32* %7, align 4
  %47 = load i32, i32* %8, align 4
  %48 = icmp slt i32 %47, 0
  br i1 %48, label %49, label %53

49:                                               ; preds = %45
  %50 = load i32, i32* %10, align 4
  %51 = load i32, i32* %8, align 4
  %52 = add i32 %50, %51
  br label %55

53:                                               ; preds = %45
  %54 = load i32, i32* %8, align 4
  br label %55

55:                                               ; preds = %53, %49
  %56 = phi i32 [ %52, %49 ], [ %54, %53 ]
  store i32 %56, i32* %8, align 4
  %57 = load i32, i32* %9, align 4
  %58 = load i32, i32* %7, align 4
  %59 = urem i32 %58, %57
  store i32 %59, i32* %7, align 4
  %60 = load i32, i32* %10, align 4
  %61 = load i32, i32* %8, align 4
  %62 = urem i32 %61, %60
  store i32 %62, i32* %8, align 4
  %63 = load %struct.tnode*, %struct.tnode** %6, align 8
  %64 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_copy_node(%struct.tnode* %63, %struct.tnode* %64)
  %65 = load i32, i32* %9, align 4
  %66 = load i32, i32* %7, align 4
  %67 = mul i32 %65, %66
  %68 = load i32, i32* %8, align 4
  %69 = add i32 %67, %68
  %70 = load %struct.tnode*, %struct.tnode** %6, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 0
  %72 = load i32, i32* %71, align 8
  %73 = add i32 %72, %69
  store i32 %73, i32* %71, align 8
  %74 = load %struct.tnode*, %struct.tnode** %6, align 8
  %75 = getelementptr inbounds %struct.tnode, %struct.tnode* %74, i32 0, i32 1
  store i32 1, i32* %75, align 4
  br label %76

76:                                               ; preds = %55, %16
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_matrix_2d_var(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 650, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 652, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %20)
  br label %22

22:                                               ; preds = %16, %4
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 655, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = icmp ne i32 %26, 1
  br i1 %27, label %28, label %34

28:                                               ; preds = %22
  %29 = load %struct.tnode*, %struct.tnode** %8, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 657, i32 1)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %32)
  br label %34

34:                                               ; preds = %28, %22
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 660, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 2
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %9, align 4
  %40 = load %struct.tnode*, %struct.tnode** %8, align 8
  %41 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 661, i32 1)
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 2
  %43 = bitcast %union.data_type* %42 to i32*
  %44 = load i32, i32* %43, align 8
  store i32 %44, i32* %10, align 4
  %45 = load %struct.tnode*, %struct.tnode** %5, align 8
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  %47 = load i32, i32* %9, align 4
  %48 = load i32, i32* %10, align 4
  call void @funk_get_element_in_matrix_2d_lit(%struct.tnode* %45, %struct.tnode* %46, i32 %47, i32 %48)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_array(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = call %struct.tnode* @validate_node(%struct.tnode* %7, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 699)
  %9 = load i32, i32* %6, align 4
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %11, label %17

11:                                               ; preds = %3
  %12 = load %struct.tnode*, %struct.tnode** %4, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = load i32, i32* %6, align 4
  %16 = add i32 %14, %15
  br label %19

17:                                               ; preds = %3
  %18 = load i32, i32* %6, align 4
  br label %19

19:                                               ; preds = %17, %11
  %20 = phi i32 [ %16, %11 ], [ %18, %17 ]
  store i32 %20, i32* %6, align 4
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = load i32, i32* %22, align 4
  %24 = load i32, i32* %6, align 4
  %25 = urem i32 %24, %23
  store i32 %25, i32* %6, align 4
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = load i32, i32* %6, align 4
  %28 = call %struct.tdata* @get_node(%struct.tnode* %26, i32 %27, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 705, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = icmp eq i32 %30, 7
  br i1 %31, label %39, label %32

32:                                               ; preds = %19
  %33 = load %struct.tnode*, %struct.tnode** %4, align 8
  %34 = load i32, i32* %6, align 4
  %35 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 %34, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 705, i32 1)
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = icmp eq i32 %37, 8
  br i1 %38, label %39, label %48

39:                                               ; preds = %32, %19
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 2
  %43 = load %struct.tpool*, %struct.tpool** %42, align 8
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 0
  %46 = load i32, i32* %45, align 8
  %47 = load i32, i32* %6, align 4
  call void @_dereference(%struct.tnode* %40, %struct.tpool* %43, i32 %46, i32 %47, i32 10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 708)
  br label %86

48:                                               ; preds = %32
  %49 = load %struct.tnode*, %struct.tnode** %5, align 8
  %50 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_copy_node(%struct.tnode* %49, %struct.tnode* %50)
  %51 = load %struct.tnode*, %struct.tnode** %4, align 8
  %52 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %51)
  %53 = icmp eq i32 %52, 2
  br i1 %53, label %54, label %69

54:                                               ; preds = %48
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = call i32 @_funk_get_node_dimension(%struct.tnode* %58, i32 0)
  %60 = load i32, i32* %6, align 4
  %61 = mul i32 %59, %60
  %62 = add i32 %57, %61
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 0
  store i32 %62, i32* %64, align 8
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = call i32 @_funk_get_node_dimension(%struct.tnode* %65, i32 0)
  %67 = load %struct.tnode*, %struct.tnode** %5, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  store i32 %66, i32* %68, align 4
  br label %79

69:                                               ; preds = %48
  %70 = load %struct.tnode*, %struct.tnode** %4, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 0
  %72 = load i32, i32* %71, align 8
  %73 = load i32, i32* %6, align 4
  %74 = add i32 %72, %73
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 0
  store i32 %74, i32* %76, align 8
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 1
  store i32 1, i32* %78, align 4
  br label %79

79:                                               ; preds = %69, %54
  %80 = load %struct.tnode*, %struct.tnode** %5, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 3
  %82 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %81, i32 0, i32 1
  store i32 0, i32* %82, align 4
  %83 = load %struct.tnode*, %struct.tnode** %5, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 3
  %85 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %84, i32 0, i32 0
  store i32 0, i32* %85, align 8
  br label %86

86:                                               ; preds = %79, %39
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_array_var(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %6, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 730, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %19

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 732, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 %17)
  br label %19

19:                                               ; preds = %13, %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 735, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 2
  %23 = bitcast %union.data_type* %22 to i32*
  %24 = load i32, i32* %23, align 8
  store i32 %24, i32* %7, align 4
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = load i32, i32* %7, align 4
  call void @funk_get_element_in_array(%struct.tnode* %25, %struct.tnode* %26, i32 %27)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @add_node_to_nodelist(%struct.tnode*, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = call %struct.tnode* @validate_node(%struct.tnode* %13, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 744)
  %15 = load %struct.tnode*, %struct.tnode** %7, align 8
  %16 = call %struct.tnode* @validate_node(%struct.tnode* %15, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 745)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 747, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %22 = load i32, i32* %9, align 4
  store i32 %22, i32* %11, align 4
  br label %23

23:                                               ; preds = %70, %4
  %24 = load i32, i32* %10, align 4
  %25 = load %struct.tnode*, %struct.tnode** %6, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = icmp ult i32 %24, %27
  br i1 %28, label %29, label %33

29:                                               ; preds = %23
  %30 = load i32, i32* %11, align 4
  %31 = load i32, i32* %8, align 4
  %32 = icmp ult i32 %30, %31
  br label %33

33:                                               ; preds = %29, %23
  %34 = phi i1 [ false, %23 ], [ %32, %29 ]
  br i1 %34, label %35, label %73

35:                                               ; preds = %33
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = load i32, i32* %11, align 4
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i64 %38
  store %struct.tnode* %39, %struct.tnode** %12, align 8
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 2
  %42 = load %struct.tpool*, %struct.tpool** %41, align 8
  %43 = load %struct.tnode*, %struct.tnode** %12, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 2
  store %struct.tpool* %42, %struct.tpool** %44, align 8
  %45 = load %struct.tnode*, %struct.tnode** %6, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 0
  %47 = load i32, i32* %46, align 8
  %48 = load i32, i32* %10, align 4
  %49 = add i32 %47, %48
  %50 = load %struct.tnode*, %struct.tnode** %12, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 0
  store i32 %49, i32* %51, align 8
  %52 = load %struct.tnode*, %struct.tnode** %12, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  store i32 1, i32* %53, align 4
  %54 = load %struct.tnode*, %struct.tnode** %12, align 8
  call void @_funk_set_node_dimension_count(%struct.tnode* %54, i32 1)
  %55 = load %struct.tnode*, %struct.tnode** %6, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 3
  %57 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %56, i32 0, i32 1
  %58 = load i32, i32* %57, align 4
  %59 = load %struct.tnode*, %struct.tnode** %12, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 3
  %61 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %60, i32 0, i32 1
  store i32 %58, i32* %61, align 4
  %62 = load %struct.tnode*, %struct.tnode** %7, align 8
  %63 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 761, i32 1)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 2
  %65 = bitcast %union.data_type* %64 to i32*
  %66 = load i32, i32* %65, align 8
  %67 = add nsw i32 %66, 1
  store i32 %67, i32* %65, align 8
  %68 = load i32, i32* %10, align 4
  %69 = add i32 %68, 1
  store i32 %69, i32* %10, align 4
  br label %70

70:                                               ; preds = %35
  %71 = load i32, i32* %11, align 4
  %72 = add i32 %71, 1
  store i32 %72, i32* %11, align 4
  br label %23

73:                                               ; preds = %33
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_double_scalar(i32, %struct.tnode*, double) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store i32 %0, i32* %4, align 4
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = load i32, i32* %4, align 4
  %9 = bitcast double* %6 to i8*
  call void @funk_create_node(%struct.tnode* %7, i32 1, i32 %8, i32 2, i8 zeroext 0, i8* %9)
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_create_double_scalar, i64 0, i64 0), i32 770)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_int_scalar(i32, %struct.tnode*, i32) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = load i32, i32* %4, align 4
  %9 = bitcast i32* %6 to i8*
  call void @funk_create_node(%struct.tnode* %7, i32 1, i32 %8, i32 1, i8 zeroext 0, i8* %9)
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i64 0, i64 0), i32 778)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_list_of_regs(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = load i32, i32* %6, align 4
  call void @funk_get_element_in_array(%struct.tnode* %7, %struct.tnode* %8, i32 %9)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_copy_node_to_pool(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %5 = load %struct.tnode*, %struct.tnode** %2, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 2
  %7 = load %struct.tpool*, %struct.tpool** %6, align 8
  %8 = call i32 @_funk_alloc_raw_tdata(%struct.tpool* %7, i32 4, i32 8)
  store i32 %8, i32* %3, align 4
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 0
  %16 = load i32, i32* %3, align 4
  %17 = urem i32 %16, 250000
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %15, i64 0, i64 %18
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 2
  %21 = bitcast %union.data_type* %20 to i32*
  store i32 %11, i32* %21, align 8
  %22 = load %struct.tnode*, %struct.tnode** %2, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = load %struct.tnode*, %struct.tnode** %2, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  %27 = load %struct.tpool*, %struct.tpool** %26, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 0
  %29 = load i32, i32* %3, align 4
  %30 = add i32 %29, 1
  %31 = urem i32 %30, 250000
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %28, i64 0, i64 %32
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 2
  %35 = bitcast %union.data_type* %34 to i32*
  store i32 %24, i32* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %2, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 3
  %38 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %37, i32 0, i32 0
  %39 = load i32, i32* %38, align 8
  %40 = load %struct.tnode*, %struct.tnode** %2, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 2
  %42 = load %struct.tpool*, %struct.tpool** %41, align 8
  %43 = getelementptr inbounds %struct.tpool, %struct.tpool* %42, i32 0, i32 0
  %44 = load i32, i32* %3, align 4
  %45 = add i32 %44, 2
  %46 = urem i32 %45, 250000
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %43, i64 0, i64 %47
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 2
  %50 = bitcast %union.data_type* %49 to i32*
  store i32 %39, i32* %50, align 8
  %51 = load %struct.tnode*, %struct.tnode** %2, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 3
  %53 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %52, i32 0, i32 1
  %54 = load i32, i32* %53, align 4
  %55 = load %struct.tnode*, %struct.tnode** %2, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load i32, i32* %3, align 4
  %60 = add i32 %59, 3
  %61 = urem i32 %60, 250000
  %62 = zext i32 %61 to i64
  %63 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %58, i64 0, i64 %62
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 2
  %65 = bitcast %union.data_type* %64 to i32*
  store i32 %54, i32* %65, align 8
  %66 = load i32, i32* %3, align 4
  ret i32 %66
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_of_regs(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i64 0
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %12 = load %struct.tpool*, %struct.tpool** %11, align 8
  %13 = call i32 @get_pool_enum(%struct.tpool* %12)
  store i32 %13, i32* %7, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = load i32, i32* %6, align 4
  call void @funk_create_node(%struct.tnode* %14, i32 %15, i32 0, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %8, align 4
  br label %16

16:                                               ; preds = %68, %3
  %17 = load i32, i32* %8, align 4
  %18 = load i32, i32* %6, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %71

20:                                               ; preds = %16
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = load i32, i32* %8, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i64 %23
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = icmp ugt i32 %26, 1
  br i1 %27, label %28, label %43

28:                                               ; preds = %20
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = load i32, i32* %8, align 4
  %31 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %30, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 821, i32 0)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i32 7, i32* %32, align 8
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = load i32, i32* %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i64 %35
  %37 = call i32 @_copy_node_to_pool(%struct.tnode* %36)
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = load i32, i32* %8, align 4
  %40 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 %39, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 822, i32 0)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 2
  %42 = bitcast %union.data_type* %41 to i32*
  store i32 %37, i32* %42, align 8
  br label %67

43:                                               ; preds = %20
  %44 = load %struct.tnode*, %struct.tnode** %5, align 8
  %45 = load i32, i32* %8, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i64 %46
  %48 = call %struct.tdata* @get_node(%struct.tnode* %47, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 826, i32 1)
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = load %struct.tnode*, %struct.tnode** %4, align 8
  %52 = load i32, i32* %8, align 4
  %53 = call %struct.tdata* @get_node(%struct.tnode* %51, i32 %52, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 826, i32 0)
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  store i32 %50, i32* %54, align 8
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = load i32, i32* %8, align 4
  %57 = call %struct.tdata* @get_node(%struct.tnode* %55, i32 %56, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 827, i32 0)
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 2
  %59 = load %struct.tnode*, %struct.tnode** %5, align 8
  %60 = load i32, i32* %8, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i64 %61
  %63 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 827, i32 1)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 2
  %65 = bitcast %union.data_type* %58 to i8*
  %66 = bitcast %union.data_type* %64 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %65, i8* align 8 %66, i64 8, i1 false)
  br label %67

67:                                               ; preds = %43, %28
  br label %68

68:                                               ; preds = %67
  %69 = load i32, i32* %8, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %8, align 4
  br label %16

71:                                               ; preds = %16
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_i32_literal(i32, %struct.tnode*, i32*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32* %2, i32** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  %10 = load i32, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = load i32*, i32** %7, align 8
  %13 = bitcast i32* %12 to i8*
  call void @funk_create_node(%struct.tnode* %9, i32 %10, i32 %11, i32 1, i8 zeroext 0, i8* %13)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_double_literal(i32, %struct.tnode*, double*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca double*, align 8
  %8 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store double* %2, double** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  %10 = load i32, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = load double*, double** %7, align 8
  %13 = bitcast double* %12 to i8*
  call void @funk_create_node(%struct.tnode* %9, i32 %10, i32 %11, i32 2, i8 zeroext 0, i8* %13)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_2d_matrix_int_literal(i32, %struct.tnode*, i32*, i32, i32) #0 {
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, i32* %6, align 4
  store %struct.tnode* %1, %struct.tnode** %7, align 8
  store i32* %2, i32** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = load i32, i32* %9, align 4
  %13 = load i32, i32* %10, align 4
  %14 = mul nsw i32 %12, %13
  %15 = load i32, i32* %6, align 4
  %16 = load i32*, i32** %8, align 8
  %17 = bitcast i32* %16 to i8*
  call void @funk_create_node(%struct.tnode* %11, i32 %14, i32 %15, i32 1, i8 zeroext 2, i8* %17)
  %18 = load %struct.tnode*, %struct.tnode** %7, align 8
  %19 = load i32, i32* %9, align 4
  call void @_funk_set_node_dimension(%struct.tnode* %18, i32 0, i32 %19, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0), i32 851)
  %20 = load %struct.tnode*, %struct.tnode** %7, align 8
  %21 = load i32, i32* %10, align 4
  call void @_funk_set_node_dimension(%struct.tnode* %20, i32 1, i32 %21, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0), i32 852)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_scalar_element(i64, i64) #0 {
  %3 = alloca %struct.tdata, align 8
  %4 = bitcast %struct.tdata* %3 to { i64, i64 }*
  %5 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %4, i32 0, i32 0
  store i64 %0, i64* %5, align 8
  %6 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %4, i32 0, i32 1
  store i64 %1, i64* %6, align 8
  %7 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  switch i32 %8, label %36 [
    i32 1, label %9
    i32 2, label %14
    i32 4, label %19
    i32 6, label %21
    i32 7, label %26
    i32 8, label %31
  ]

9:                                                ; preds = %2
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.42, i64 0, i64 0), i32 %12)
  br label %38

14:                                               ; preds = %2
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %16 = bitcast %union.data_type* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.43, i64 0, i64 0), double %17)
  br label %38

19:                                               ; preds = %2
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.44, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.45, i64 0, i64 0))
  br label %38

21:                                               ; preds = %2
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %23 = bitcast %union.data_type* %22 to void (%struct.tnode*, i32, %struct.tnode*)**
  %24 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %23, align 8
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.46, i64 0, i64 0), void (%struct.tnode*, i32, %struct.tnode*)* %24)
  br label %38

26:                                               ; preds = %2
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.47, i64 0, i64 0), i32 %29)
  br label %38

31:                                               ; preds = %2
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %33 = bitcast %union.data_type* %32 to i32*
  %34 = load i32, i32* %33, align 8
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.48, i64 0, i64 0), i32 %34)
  br label %38

36:                                               ; preds = %2
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.44, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.49, i64 0, i64 0))
  br label %38

38:                                               ; preds = %36, %31, %26, %21, %19, %14, %9
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_node_type(%struct.tnode*, i32, i8*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp ugt i32 %9, 0
  br i1 %10, label %11, label %23

11:                                               ; preds = %3
  %12 = load i32, i32* %5, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp uge i32 %12, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %11
  %18 = load i32, i32* %5, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11, %3
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 891, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = trunc i32 %28 to i8
  %30 = load i8*, i8** %6, align 8
  store i8 %29, i8* %30, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_type(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load i32, i32* %6, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %5, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 904, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  store i32 %19, i32* %23, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_increment_node_data_int(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tdata* @get_node(%struct.tnode* %3, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_increment_node_data_int, i64 0, i64 0), i32 909, i32 1)
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 2
  %6 = bitcast %union.data_type* %5 to i32*
  %7 = load i32, i32* %6, align 8
  %8 = add nsw i32 %7, 1
  store i32 %8, i32* %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_node_into_node_list(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %6, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_copy_node_into_node_list, i64 0, i64 0), i32 916, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  store i32 %12, i32* %7, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = load i32, i32* %7, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i64 %15
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_copy_node(%struct.tnode* %16, %struct.tnode* %17)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_value_int(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 929, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 1, i32* %22, align 8
  %23 = load i32, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 930, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to i32*
  store i32 %23, i32* %28, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_value_fn_ptr(%struct.tnode*, i32, void (%struct.tnode*, i32, %struct.tnode*)*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca void (%struct.tnode*, i32, %struct.tnode*)*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store void (%struct.tnode*, i32, %struct.tnode*)* %2, void (%struct.tnode*, i32, %struct.tnode*)** %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 944, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 6, i32* %22, align 8
  %23 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 945, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to void (%struct.tnode*, i32, %struct.tnode*)**
  store void (%struct.tnode*, i32, %struct.tnode*)* %23, void (%struct.tnode*, i32, %struct.tnode*)** %28, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_value_double(%struct.tnode*, i32, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store double %2, double* %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 956, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 2, i32* %22, align 8
  %23 = load double, double* %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 957, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to double*
  store double %23, double* %28, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_value_int(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp ugt i32 %5, %8
  br i1 %9, label %10, label %16

10:                                               ; preds = %2
  %11 = load i32, i32* %4, align 4
  %12 = load %struct.tnode*, %struct.tnode** %3, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
  br label %16

16:                                               ; preds = %10, %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = load i32, i32* %4, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 966, i32 1)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 2
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i64 0, i64 0), i32 986)
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_copy_node(%struct.tnode* %7, %struct.tnode* %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = sub i32 %11, 1
  %13 = load %struct.tnode*, %struct.tnode** %3, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  store i32 %12, i32* %14, align 4
  %15 = load %struct.tnode*, %struct.tnode** %3, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %2
  %20 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @funk_create_node(%struct.tnode* %20, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  br label %28

21:                                               ; preds = %2
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = add i32 %24, 1
  %26 = load %struct.tnode*, %struct.tnode** %3, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  store i32 %25, i32* %27, align 8
  br label %28

28:                                               ; preds = %21, %19
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook(i8*, %struct.tnode*, i32) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store i8* %0, i8** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_exit_hook(i8*, %struct.tnode*) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca %struct.tnode*, align 8
  store i8* %0, i8** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @debug_print_arith_operation(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = call %struct.tnode* @validate_node(%struct.tnode* %7, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1074)
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = call %struct.tnode* @validate_node(%struct.tnode* %9, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1075)
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1076)
  %13 = load %struct.tnode*, %struct.tnode** %5, align 8
  %14 = ptrtoint %struct.tnode* %13 to i32
  %15 = call %struct.tpool* @get_pool_ptr(i32 %14)
  %16 = load %struct.tnode*, %struct.tnode** %5, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.54, i64 0, i64 0), %struct.tpool* %15, i32 %18)
  %20 = load %struct.tnode*, %struct.tnode** %5, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1080, i32 1)
  %22 = bitcast %struct.tdata* %21 to { i64, i64 }*
  %23 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 0
  %24 = load i64, i64* %23, align 8
  %25 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 1
  %26 = load i64, i64* %25, align 8
  call void @funk_print_scalar_element(i64 %24, i64 %26)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.55, i64 0, i64 0))
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = ptrtoint %struct.tnode* %28 to i32
  %30 = call %struct.tpool* @get_pool_ptr(i32 %29)
  %31 = load %struct.tnode*, %struct.tnode** %6, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.54, i64 0, i64 0), %struct.tpool* %30, i32 %33)
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1083, i32 1)
  %37 = bitcast %struct.tdata* %36 to { i64, i64 }*
  %38 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %37, i32 0, i32 0
  %39 = load i64, i64* %38, align 8
  %40 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %37, i32 0, i32 1
  %41 = load i64, i64* %40, align 8
  call void @funk_print_scalar_element(i64 %39, i64 %41)
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = ptrtoint %struct.tnode* %42 to i32
  %44 = call %struct.tpool* @get_pool_ptr(i32 %43)
  %45 = load %struct.tnode*, %struct.tnode** %4, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 0
  %47 = load i32, i32* %46, align 8
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.56, i64 0, i64 0), %struct.tpool* %44, i32 %47)
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = call %struct.tdata* @get_node(%struct.tnode* %49, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1086, i32 1)
  %51 = bitcast %struct.tdata* %50 to { i64, i64 }*
  %52 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %51, i32 0, i32 0
  %53 = load i64, i64* %52, align 8
  %54 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %51, i32 0, i32 1
  %55 = load i64, i64* %54, align 8
  call void @funk_print_scalar_element(i64 %53, i64 %55)
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.57, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fmul double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %37

21:                                               ; preds = %4
  %22 = load i32, i32* %8, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %34

24:                                               ; preds = %21
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = mul nsw i32 %27, %30
  %32 = load i8*, i8** %5, align 8
  %33 = bitcast i8* %32 to i32*
  store i32 %31, i32* %33, align 4
  br label %36

34:                                               ; preds = %21
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_mul, i64 0, i64 0))
  br label %36

36:                                               ; preds = %34, %24
  br label %37

37:                                               ; preds = %36, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fdiv double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %37

21:                                               ; preds = %4
  %22 = load i32, i32* %8, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %34

24:                                               ; preds = %21
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = sdiv i32 %27, %30
  %32 = load i8*, i8** %5, align 8
  %33 = bitcast i8* %32 to i32*
  store i32 %31, i32* %33, align 4
  br label %36

34:                                               ; preds = %21
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_div, i64 0, i64 0))
  br label %36

36:                                               ; preds = %34, %24
  br label %37

37:                                               ; preds = %36, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fadd double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %37

21:                                               ; preds = %4
  %22 = load i32, i32* %8, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %34

24:                                               ; preds = %21
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = add nsw i32 %27, %30
  %32 = load i8*, i8** %5, align 8
  %33 = bitcast i8* %32 to i32*
  store i32 %31, i32* %33, align 4
  br label %36

34:                                               ; preds = %21
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_add, i64 0, i64 0))
  br label %36

36:                                               ; preds = %34, %24
  br label %37

37:                                               ; preds = %36, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fsub double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %37

21:                                               ; preds = %4
  %22 = load i32, i32* %8, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %34

24:                                               ; preds = %21
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = sub nsw i32 %27, %30
  %32 = load i8*, i8** %5, align 8
  %33 = bitcast i8* %32 to i32*
  store i32 %31, i32* %33, align 4
  br label %36

34:                                               ; preds = %21
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sub, i64 0, i64 0))
  br label %36

36:                                               ; preds = %34, %24
  br label %37

37:                                               ; preds = %36, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i8*, i8** %6, align 8
  %10 = bitcast i8* %9 to i32*
  %11 = load i32, i32* %10, align 4
  %12 = load i8*, i8** %7, align 8
  %13 = bitcast i8* %12 to i32*
  %14 = load i32, i32* %13, align 4
  %15 = srem i32 %11, %14
  %16 = load i8*, i8** %5, align 8
  %17 = bitcast i8* %16 to i32*
  store i32 %15, i32* %17, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %23

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp olt double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = load i8*, i8** %5, align 8
  %22 = bitcast i8* %21 to i32*
  store i32 %20, i32* %22, align 4
  br label %41

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i8*, i8** %6, align 8
  %28 = bitcast i8* %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = icmp slt i32 %29, %32
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, i32 1, i32 0
  %36 = load i8*, i8** %5, align 8
  %37 = bitcast i8* %36 to i32*
  store i32 %35, i32* %37, align 4
  br label %40

38:                                               ; preds = %23
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_slt, i64 0, i64 0))
  br label %40

40:                                               ; preds = %38, %26
  br label %41

41:                                               ; preds = %40, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %23

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp ogt double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = load i8*, i8** %5, align 8
  %22 = bitcast i8* %21 to i32*
  store i32 %20, i32* %22, align 4
  br label %41

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i8*, i8** %6, align 8
  %28 = bitcast i8* %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = icmp sgt i32 %29, %32
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, i32 1, i32 0
  %36 = load i8*, i8** %5, align 8
  %37 = bitcast i8* %36 to i32*
  store i32 %35, i32* %37, align 4
  br label %40

38:                                               ; preds = %23
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sgt, i64 0, i64 0))
  br label %40

40:                                               ; preds = %38, %26
  br label %41

41:                                               ; preds = %40, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %23

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp oge double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = load i8*, i8** %5, align 8
  %22 = bitcast i8* %21 to i32*
  store i32 %20, i32* %22, align 4
  br label %41

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i8*, i8** %6, align 8
  %28 = bitcast i8* %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = icmp sge i32 %29, %32
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, i32 1, i32 0
  %36 = load i8*, i8** %5, align 8
  %37 = bitcast i8* %36 to i32*
  store i32 %35, i32* %37, align 4
  br label %40

38:                                               ; preds = %23
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sge, i64 0, i64 0))
  br label %40

40:                                               ; preds = %38, %26
  br label %41

41:                                               ; preds = %40, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %23

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp oeq double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = load i8*, i8** %5, align 8
  %22 = bitcast i8* %21 to i32*
  store i32 %20, i32* %22, align 4
  br label %41

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i8*, i8** %6, align 8
  %28 = bitcast i8* %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = icmp eq i32 %29, %32
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, i32 1, i32 0
  %36 = load i8*, i8** %5, align 8
  %37 = bitcast i8* %36 to i32*
  store i32 %35, i32* %37, align 4
  br label %40

38:                                               ; preds = %23
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_eq, i64 0, i64 0))
  br label %40

40:                                               ; preds = %38, %26
  br label %41

41:                                               ; preds = %40, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %23

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp une double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = load i8*, i8** %5, align 8
  %22 = bitcast i8* %21 to i32*
  store i32 %20, i32* %22, align 4
  br label %41

23:                                               ; preds = %4
  %24 = load i32, i32* %8, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i8*, i8** %6, align 8
  %28 = bitcast i8* %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = icmp ne i32 %29, %32
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, i32 1, i32 0
  %36 = load i8*, i8** %5, align 8
  %37 = bitcast i8* %36 to i32*
  store i32 %35, i32* %37, align 4
  br label %40

38:                                               ; preds = %23
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_ne, i64 0, i64 0))
  br label %40

40:                                               ; preds = %38, %26
  br label %41

41:                                               ; preds = %40, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_or(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %27

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = fcmp une double %14, 0.000000e+00
  br i1 %15, label %21, label %16

16:                                               ; preds = %11
  %17 = load i8*, i8** %7, align 8
  %18 = bitcast i8* %17 to double*
  %19 = load double, double* %18, align 8
  %20 = fcmp une double %19, 0.000000e+00
  br label %21

21:                                               ; preds = %16, %11
  %22 = phi i1 [ true, %11 ], [ %20, %16 ]
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i32 1, i32 0
  %25 = load i8*, i8** %5, align 8
  %26 = bitcast i8* %25 to i32*
  store i32 %24, i32* %26, align 4
  br label %49

27:                                               ; preds = %4
  %28 = load i32, i32* %8, align 4
  %29 = icmp eq i32 %28, 1
  br i1 %29, label %30, label %46

30:                                               ; preds = %27
  %31 = load i8*, i8** %6, align 8
  %32 = bitcast i8* %31 to i32*
  %33 = load i32, i32* %32, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %40, label %35

35:                                               ; preds = %30
  %36 = load i8*, i8** %7, align 8
  %37 = bitcast i8* %36 to i32*
  %38 = load i32, i32* %37, align 4
  %39 = icmp ne i32 %38, 0
  br label %40

40:                                               ; preds = %35, %30
  %41 = phi i1 [ true, %30 ], [ %39, %35 ]
  %42 = zext i1 %41 to i64
  %43 = select i1 %41, i32 1, i32 0
  %44 = load i8*, i8** %5, align 8
  %45 = bitcast i8* %44 to i32*
  store i32 %43, i32* %45, align 4
  br label %48

46:                                               ; preds = %27
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_or, i64 0, i64 0))
  br label %48

48:                                               ; preds = %46, %40
  br label %49

49:                                               ; preds = %48, %21
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_and(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 2
  br i1 %10, label %11, label %27

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = fcmp une double %14, 0.000000e+00
  br i1 %15, label %16, label %21

16:                                               ; preds = %11
  %17 = load i8*, i8** %7, align 8
  %18 = bitcast i8* %17 to double*
  %19 = load double, double* %18, align 8
  %20 = fcmp une double %19, 0.000000e+00
  br label %21

21:                                               ; preds = %16, %11
  %22 = phi i1 [ false, %11 ], [ %20, %16 ]
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i32 1, i32 0
  %25 = load i8*, i8** %5, align 8
  %26 = bitcast i8* %25 to i32*
  store i32 %24, i32* %26, align 4
  br label %49

27:                                               ; preds = %4
  %28 = load i32, i32* %8, align 4
  %29 = icmp eq i32 %28, 1
  br i1 %29, label %30, label %46

30:                                               ; preds = %27
  %31 = load i8*, i8** %6, align 8
  %32 = bitcast i8* %31 to i32*
  %33 = load i32, i32* %32, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %40

35:                                               ; preds = %30
  %36 = load i8*, i8** %7, align 8
  %37 = bitcast i8* %36 to i32*
  %38 = load i32, i32* %37, align 4
  %39 = icmp ne i32 %38, 0
  br label %40

40:                                               ; preds = %35, %30
  %41 = phi i1 [ false, %30 ], [ %39, %35 ]
  %42 = zext i1 %41 to i64
  %43 = select i1 %41, i32 1, i32 0
  %44 = load i8*, i8** %5, align 8
  %45 = bitcast i8* %44 to i32*
  store i32 %43, i32* %45, align 4
  br label %48

46:                                               ; preds = %27
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_and, i64 0, i64 0))
  br label %48

48:                                               ; preds = %46, %40
  br label %49

49:                                               ; preds = %48, %21
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_print_arith_op(void (i8*, i8*, i8*, i32)*) #0 {
  %2 = alloca void (i8*, i8*, i8*, i32)*, align 8
  store void (i8*, i8*, i8*, i32)* %0, void (i8*, i8*, i8*, i32)** %2, align 8
  %3 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %4 = icmp eq void (i8*, i8*, i8*, i32)* %3, @funk_mul
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.58, i64 0, i64 0))
  br label %75

7:                                                ; preds = %1
  %8 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %9 = icmp eq void (i8*, i8*, i8*, i32)* %8, @funk_div
  br i1 %9, label %10, label %12

10:                                               ; preds = %7
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.59, i64 0, i64 0))
  br label %74

12:                                               ; preds = %7
  %13 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %14 = icmp eq void (i8*, i8*, i8*, i32)* %13, @funk_add
  br i1 %14, label %15, label %17

15:                                               ; preds = %12
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.60, i64 0, i64 0))
  br label %73

17:                                               ; preds = %12
  %18 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %19 = icmp eq void (i8*, i8*, i8*, i32)* %18, @funk_sub
  br i1 %19, label %20, label %22

20:                                               ; preds = %17
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.61, i64 0, i64 0))
  br label %72

22:                                               ; preds = %17
  %23 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %24 = icmp eq void (i8*, i8*, i8*, i32)* %23, @funk_mod
  br i1 %24, label %25, label %27

25:                                               ; preds = %22
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.62, i64 0, i64 0))
  br label %71

27:                                               ; preds = %22
  %28 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %29 = icmp eq void (i8*, i8*, i8*, i32)* %28, @funk_slt
  br i1 %29, label %30, label %32

30:                                               ; preds = %27
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.63, i64 0, i64 0))
  br label %70

32:                                               ; preds = %27
  %33 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %34 = icmp eq void (i8*, i8*, i8*, i32)* %33, @funk_sgt
  br i1 %34, label %35, label %37

35:                                               ; preds = %32
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.64, i64 0, i64 0))
  br label %69

37:                                               ; preds = %32
  %38 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %39 = icmp eq void (i8*, i8*, i8*, i32)* %38, @funk_sge
  br i1 %39, label %40, label %42

40:                                               ; preds = %37
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.65, i64 0, i64 0))
  br label %68

42:                                               ; preds = %37
  %43 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %44 = icmp eq void (i8*, i8*, i8*, i32)* %43, @funk_eq
  br i1 %44, label %45, label %47

45:                                               ; preds = %42
  %46 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.66, i64 0, i64 0))
  br label %67

47:                                               ; preds = %42
  %48 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %49 = icmp eq void (i8*, i8*, i8*, i32)* %48, @funk_ne
  br i1 %49, label %50, label %52

50:                                               ; preds = %47
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.67, i64 0, i64 0))
  br label %66

52:                                               ; preds = %47
  %53 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %54 = icmp eq void (i8*, i8*, i8*, i32)* %53, @funk_or
  br i1 %54, label %55, label %57

55:                                               ; preds = %52
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.68, i64 0, i64 0))
  br label %65

57:                                               ; preds = %52
  %58 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %59 = icmp eq void (i8*, i8*, i8*, i32)* %58, @funk_and
  br i1 %59, label %60, label %62

60:                                               ; preds = %57
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.69, i64 0, i64 0))
  br label %64

62:                                               ; preds = %57
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.70, i64 0, i64 0))
  br label %64

64:                                               ; preds = %62, %60
  br label %65

65:                                               ; preds = %64, %55
  br label %66

66:                                               ; preds = %65, %50
  br label %67

67:                                               ; preds = %66, %45
  br label %68

68:                                               ; preds = %67, %40
  br label %69

69:                                               ; preds = %68, %35
  br label %70

70:                                               ; preds = %69, %30
  br label %71

71:                                               ; preds = %70, %25
  br label %72

72:                                               ; preds = %71, %20
  br label %73

73:                                               ; preds = %72, %15
  br label %74

74:                                               ; preds = %73, %10
  br label %75

75:                                               ; preds = %74, %5
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_arith_op_rr(%struct.tnode*, i32, %struct.tnode*, %struct.tnode*, void (i8*, i8*, i8*, i32)*) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca void (i8*, i8*, i8*, i32)*, align 8
  %11 = alloca %struct.tdata, align 8
  %12 = alloca %struct.tdata, align 8
  %13 = alloca %struct.tdata*, align 8
  %14 = alloca i8, align 1
  %15 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store %struct.tnode* %3, %struct.tnode** %9, align 8
  store void (i8*, i8*, i8*, i32)* %4, void (i8*, i8*, i8*, i32)** %10, align 8
  %16 = load %struct.tnode*, %struct.tnode** %8, align 8
  %17 = call %struct.tnode* @validate_node(%struct.tnode* %16, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1262)
  %18 = load %struct.tnode*, %struct.tnode** %9, align 8
  %19 = call %struct.tnode* @validate_node(%struct.tnode* %18, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1263)
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tnode* @validate_node(%struct.tnode* %20, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1264)
  %22 = load %struct.tnode*, %struct.tnode** %8, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1266, i32 1)
  %24 = bitcast %struct.tdata* %11 to i8*
  %25 = bitcast %struct.tdata* %23 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %24, i8* align 8 %25, i64 16, i1 false)
  %26 = load %struct.tnode*, %struct.tnode** %9, align 8
  %27 = call %struct.tdata* @get_node(%struct.tnode* %26, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1267, i32 1)
  %28 = bitcast %struct.tdata* %12 to i8*
  %29 = bitcast %struct.tdata* %27 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %28, i8* align 8 %29, i64 16, i1 false)
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = load i32, i32* %7, align 4
  %32 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 %31, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1268, i32 1)
  store %struct.tdata* %32, %struct.tdata** %13, align 8
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %34 = load i32, i32* %33, align 8
  %35 = trunc i32 %34 to i8
  store i8 %35, i8* %14, align 1
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = trunc i32 %37 to i8
  store i8 %38, i8* %15, align 1
  %39 = load i8, i8* %15, align 1
  %40 = zext i8 %39 to i32
  %41 = icmp eq i32 %40, 4
  br i1 %41, label %42, label %43

42:                                               ; preds = %5
  store i8 1, i8* %15, align 1
  br label %43

43:                                               ; preds = %42, %5
  %44 = load i8, i8* %14, align 1
  %45 = zext i8 %44 to i32
  %46 = icmp eq i32 %45, 4
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  store i8 1, i8* %14, align 1
  br label %48

48:                                               ; preds = %47, %43
  %49 = load i8, i8* %14, align 1
  %50 = zext i8 %49 to i32
  %51 = icmp eq i32 %50, 1
  br i1 %51, label %52, label %70

52:                                               ; preds = %48
  %53 = load i8, i8* %15, align 1
  %54 = zext i8 %53 to i32
  %55 = icmp eq i32 %54, 1
  br i1 %55, label %56, label %70

56:                                               ; preds = %52
  %57 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  %58 = load %struct.tdata*, %struct.tdata** %13, align 8
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 2
  %60 = bitcast %union.data_type* %59 to i32*
  %61 = bitcast i32* %60 to i8*
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %63 = bitcast %union.data_type* %62 to i32*
  %64 = bitcast i32* %63 to i8*
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %66 = bitcast %union.data_type* %65 to i32*
  %67 = bitcast i32* %66 to i8*
  call void %57(i8* %61, i8* %64, i8* %67, i32 1)
  %68 = load %struct.tdata*, %struct.tdata** %13, align 8
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i32 1, i32* %69, align 8
  br label %147

70:                                               ; preds = %52, %48
  %71 = load i8, i8* %14, align 1
  %72 = zext i8 %71 to i32
  %73 = icmp eq i32 %72, 2
  br i1 %73, label %74, label %92

74:                                               ; preds = %70
  %75 = load i8, i8* %15, align 1
  %76 = zext i8 %75 to i32
  %77 = icmp eq i32 %76, 2
  br i1 %77, label %78, label %92

78:                                               ; preds = %74
  %79 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  %80 = load %struct.tdata*, %struct.tdata** %13, align 8
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 2
  %82 = bitcast %union.data_type* %81 to double*
  %83 = bitcast double* %82 to i8*
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %85 = bitcast %union.data_type* %84 to double*
  %86 = bitcast double* %85 to i8*
  %87 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %88 = bitcast %union.data_type* %87 to double*
  %89 = bitcast double* %88 to i8*
  call void %79(i8* %83, i8* %86, i8* %89, i32 2)
  %90 = load %struct.tdata*, %struct.tdata** %13, align 8
  %91 = getelementptr inbounds %struct.tdata, %struct.tdata* %90, i32 0, i32 0
  store i32 2, i32* %91, align 8
  br label %146

92:                                               ; preds = %74, %70
  %93 = load i8, i8* %14, align 1
  %94 = zext i8 %93 to i32
  %95 = icmp eq i32 %94, 2
  br i1 %95, label %96, label %114

96:                                               ; preds = %92
  %97 = load i8, i8* %15, align 1
  %98 = zext i8 %97 to i32
  %99 = icmp eq i32 %98, 1
  br i1 %99, label %100, label %114

100:                                              ; preds = %96
  %101 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  %102 = load %struct.tdata*, %struct.tdata** %13, align 8
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 2
  %104 = bitcast %union.data_type* %103 to double*
  %105 = bitcast double* %104 to i8*
  %106 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %107 = bitcast %union.data_type* %106 to double*
  %108 = bitcast double* %107 to i8*
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %110 = bitcast %union.data_type* %109 to i32*
  %111 = bitcast i32* %110 to i8*
  call void %101(i8* %105, i8* %108, i8* %111, i32 2)
  %112 = load %struct.tdata*, %struct.tdata** %13, align 8
  %113 = getelementptr inbounds %struct.tdata, %struct.tdata* %112, i32 0, i32 0
  store i32 2, i32* %113, align 8
  br label %145

114:                                              ; preds = %96, %92
  %115 = load i8, i8* %14, align 1
  %116 = zext i8 %115 to i32
  %117 = icmp eq i32 %116, 1
  br i1 %117, label %118, label %136

118:                                              ; preds = %114
  %119 = load i8, i8* %15, align 1
  %120 = zext i8 %119 to i32
  %121 = icmp eq i32 %120, 2
  br i1 %121, label %122, label %136

122:                                              ; preds = %118
  %123 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  %124 = load %struct.tdata*, %struct.tdata** %13, align 8
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %124, i32 0, i32 2
  %126 = bitcast %union.data_type* %125 to double*
  %127 = bitcast double* %126 to i8*
  %128 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %129 = bitcast %union.data_type* %128 to i32*
  %130 = bitcast i32* %129 to i8*
  %131 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %132 = bitcast %union.data_type* %131 to double*
  %133 = bitcast double* %132 to i8*
  call void %123(i8* %127, i8* %130, i8* %133, i32 2)
  %134 = load %struct.tdata*, %struct.tdata** %13, align 8
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 0
  store i32 2, i32* %135, align 8
  br label %144

136:                                              ; preds = %118, %114
  %137 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.71, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %138 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  call void @_print_arith_op(void (i8*, i8*, i8*, i32)* %138)
  %139 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  %140 = load i8, i8* %14, align 1
  call void @funk_print_type(i8 zeroext %140)
  %141 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.55, i64 0, i64 0))
  %142 = load i8, i8* %15, align 1
  call void @funk_print_type(i8 zeroext %142)
  %143 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

144:                                              ; preds = %122
  br label %145

145:                                              ; preds = %144, %100
  br label %146

146:                                              ; preds = %145, %78
  br label %147

147:                                              ; preds = %146, %56
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_arith_op_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*, void (i8*, i8*, i8*, i32)*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca void (i8*, i8*, i8*, i32)*, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tnode, align 8
  %11 = alloca %struct.tnode, align 8
  %12 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store void (i8*, i8*, i8*, i32)* %3, void (i8*, i8*, i8*, i32)** %8, align 8
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = load %struct.tnode*, %struct.tnode** %7, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 4
  %19 = icmp ne i32 %15, %18
  br i1 %19, label %20, label %31

20:                                               ; preds = %4
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = load i32, i32* %22, align 4
  %24 = load %struct.tnode*, %struct.tnode** %7, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.72, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 %23, i32 %26)
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_print_node(%struct.tnode* %28)
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  %30 = load %struct.tnode*, %struct.tnode** %7, align 8
  call void @funk_print_node(%struct.tnode* %30)
  call void @exit(i32 1) #6
  unreachable

31:                                               ; preds = %4
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = load %struct.tnode*, %struct.tnode** %6, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 2
  %38 = load %struct.tpool*, %struct.tpool** %37, align 8
  %39 = call i32 @get_pool_enum(%struct.tpool* %38)
  call void @funk_create_node(%struct.tnode* %32, i32 %35, i32 %39, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %9, align 4
  br label %40

40:                                               ; preds = %85, %31
  %41 = load i32, i32* %9, align 4
  %42 = load %struct.tnode*, %struct.tnode** %6, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 4
  %45 = icmp ult i32 %41, %44
  br i1 %45, label %46, label %88

46:                                               ; preds = %40
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = load i32, i32* %9, align 4
  call void @funk_get_element_in_array(%struct.tnode* %47, %struct.tnode* %10, i32 %48)
  %49 = load %struct.tnode*, %struct.tnode** %7, align 8
  %50 = load i32, i32* %9, align 4
  call void @funk_get_element_in_array(%struct.tnode* %49, %struct.tnode* %11, i32 %50)
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %52 = load i32, i32* %51, align 4
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %54 = load i32, i32* %53, align 4
  %55 = icmp ne i32 %52, %54
  br i1 %55, label %56, label %58

56:                                               ; preds = %46
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.73, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

58:                                               ; preds = %46
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %60 = load i32, i32* %59, align 4
  %61 = icmp eq i32 %60, 1
  br i1 %61, label %62, label %66

62:                                               ; preds = %58
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = load i32, i32* %9, align 4
  %65 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %8, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %63, i32 %64, %struct.tnode* %10, %struct.tnode* %11, void (i8*, i8*, i8*, i32)* %65)
  br label %83

66:                                               ; preds = %58
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %70 = load %struct.tpool*, %struct.tpool** %69, align 8
  %71 = call i32 @get_pool_enum(%struct.tpool* %70)
  call void @funk_create_node(%struct.tnode* %12, i32 %68, i32 %71, i32 1, i8 zeroext 0, i8* null)
  %72 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %8, align 8
  call void @funk_arith_op_rr(%struct.tnode* %12, %struct.tnode* %10, %struct.tnode* %11, void (i8*, i8*, i8*, i32)* %72)
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = load i32, i32* %9, align 4
  %75 = call %struct.tdata* @get_node(%struct.tnode* %73, i32 %74, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1346, i32 1)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 0
  store i32 7, i32* %76, align 8
  %77 = call i32 @_copy_node_to_pool(%struct.tnode* %12)
  %78 = load %struct.tnode*, %struct.tnode** %5, align 8
  %79 = load i32, i32* %9, align 4
  %80 = call %struct.tdata* @get_node(%struct.tnode* %78, i32 %79, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1347, i32 1)
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 2
  %82 = bitcast %union.data_type* %81 to i32*
  store i32 %77, i32* %82, align 8
  br label %83

83:                                               ; preds = %66, %62
  br label %84

84:                                               ; preds = %83
  br label %85

85:                                               ; preds = %84
  %86 = load i32, i32* %9, align 4
  %87 = add i32 %86, 1
  store i32 %87, i32* %9, align 4
  br label %40

88:                                               ; preds = %40
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  store i32 %8, i32* %3, align 4
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp ugt i32 %11, 1
  br i1 %12, label %13, label %15

13:                                               ; preds = %1
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.80, i64 0, i64 0))
  br label %15

15:                                               ; preds = %13, %1
  call void @funk_create_node(%struct.tnode* %4, i32 1, i32 1, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %5, align 4
  br label %16

16:                                               ; preds = %32, %15
  %17 = load i32, i32* %5, align 4
  %18 = load i32, i32* %3, align 4
  %19 = icmp ult i32 %17, %18
  br i1 %19, label %20, label %35

20:                                               ; preds = %16
  %21 = load %struct.tnode*, %struct.tnode** %2, align 8
  %22 = load i32, i32* %5, align 4
  call void @funk_get_element_in_array(%struct.tnode* %21, %struct.tnode* %4, i32 %22)
  call void @_funk_print_node(%struct.tnode* %4)
  %23 = load i32, i32* %5, align 4
  %24 = add i32 %23, 1
  %25 = load %struct.tnode*, %struct.tnode** %2, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = icmp ne i32 %24, %27
  br i1 %28, label %29, label %31

29:                                               ; preds = %20
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.55, i64 0, i64 0))
  br label %31

31:                                               ; preds = %29, %20
  br label %32

32:                                               ; preds = %31
  %33 = load i32, i32* %5, align 4
  %34 = add i32 %33, 1
  store i32 %34, i32* %5, align 4
  br label %16

35:                                               ; preds = %16
  %36 = load %struct.tnode*, %struct.tnode** %2, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 4
  %39 = icmp ugt i32 %38, 1
  br i1 %39, label %40, label %42

40:                                               ; preds = %35
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.81, i64 0, i64 0))
  br label %42

42:                                               ; preds = %40, %35
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_div)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_mod)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_or_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_or)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_and_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_and)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_ne)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode, align 8
  %8 = alloca %struct.tnode, align 8
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %10, %struct.tnode* %11, void (i8*, i8*, i8*, i32)* @funk_eq)
  call void @funk_flatten(%struct.tnode* %8, %struct.tnode* %7)
  %12 = load %struct.tnode*, %struct.tnode** %4, align 8
  %13 = load %struct.tnode*, %struct.tnode** %5, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 2
  %15 = load %struct.tpool*, %struct.tpool** %14, align 8
  %16 = call i32 @get_pool_enum(%struct.tpool* %15)
  call void @funk_create_node(%struct.tnode* %12, i32 1, i32 %16, i32 1, i8 zeroext 0, i8* null)
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1411, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  store i32 1, i32* %20, align 8
  store i32 0, i32* %9, align 4
  br label %21

21:                                               ; preds = %39, %3
  %22 = load i32, i32* %9, align 4
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = icmp ult i32 %22, %24
  br i1 %25, label %26, label %42

26:                                               ; preds = %21
  %27 = load i32, i32* %9, align 4
  %28 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %27, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1414, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = icmp ne i32 %31, 1
  br i1 %32, label %33, label %38

33:                                               ; preds = %26
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1415, i32 1)
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 2
  %37 = bitcast %union.data_type* %36 to i32*
  store i32 0, i32* %37, align 8
  br label %42

38:                                               ; preds = %26
  br label %39

39:                                               ; preds = %38
  %40 = load i32, i32* %9, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* %9, align 4
  br label %21

42:                                               ; preds = %33, %21
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_flatten(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  %10 = load %struct.tpool*, %struct.tpool** %9, align 8
  %11 = call i32 @get_pool_enum(%struct.tpool* %10)
  call void @funk_create_node(%struct.tnode* %7, i32 1, i32 %11, i32 1, i8 zeroext 0, i8* null)
  %12 = load %struct.tnode*, %struct.tnode** %3, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  store i32 0, i32* %13, align 4
  store i32 0, i32* %6, align 4
  br label %14

14:                                               ; preds = %28, %2
  %15 = load i32, i32* %6, align 4
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 4
  %19 = icmp ult i32 %15, %18
  br i1 %19, label %20, label %31

20:                                               ; preds = %14
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = load i32, i32* %6, align 4
  call void @funk_get_element_in_array(%struct.tnode* %21, %struct.tnode* %5, i32 %22)
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = load i32, i32* %6, align 4
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = mul i32 %24, %26
  call void @_flatten(%struct.tnode* %23, %struct.tnode* %5, i32 %27)
  br label %28

28:                                               ; preds = %20
  %29 = load i32, i32* %6, align 4
  %30 = add i32 %29, 1
  store i32 %30, i32* %6, align 4
  br label %14

31:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %8 = load double, double* %6, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %7, double %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_ne)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_mod)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_div)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %8 = load double, double* %6, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %7, double %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %8 = load double, double* %6, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %7, double %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_sgt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_flt_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %8 = load double, double* %6, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %7, double %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_sgt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_sge)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_arith_op_rr(%struct.tnode* %7, %struct.tnode* %8, %struct.tnode* %9, void (i8*, i8*, i8*, i32)* @funk_sge)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %6, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %7, i32 %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_arith_op_rr(%struct.tnode* %9, %struct.tnode* %10, %struct.tnode* %7, void (i8*, i8*, i8*, i32)* @funk_eq)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.74, i64 0, i64 0))
  store i32 0, i32* %3, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, i32* %3, align 4
  %7 = load %struct.tnode*, %struct.tnode** %2, align 8
  %8 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %7)
  %9 = icmp ult i32 %6, %8
  br i1 %9, label %10, label %18

10:                                               ; preds = %5
  %11 = load %struct.tnode*, %struct.tnode** %2, align 8
  %12 = load i32, i32* %3, align 4
  %13 = call i32 @_funk_get_node_dimension(%struct.tnode* %11, i32 %12)
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.75, i64 0, i64 0), i32 %13)
  br label %15

15:                                               ; preds = %10
  %16 = load i32, i32* %3, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* %3, align 4
  br label %5

18:                                               ; preds = %5
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.76, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_print_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %5 = load %struct.tnode*, %struct.tnode** %2, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = icmp ugt i32 %7, 1
  br i1 %8, label %9, label %11

9:                                                ; preds = %1
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.77, i64 0, i64 0))
  br label %11

11:                                               ; preds = %9, %1
  store i32 0, i32* %3, align 4
  br label %12

12:                                               ; preds = %53, %11
  %13 = load i32, i32* %3, align 4
  %14 = load %struct.tnode*, %struct.tnode** %2, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = icmp ult i32 %13, %16
  br i1 %17, label %18, label %56

18:                                               ; preds = %12
  %19 = load %struct.tnode*, %struct.tnode** %2, align 8
  %20 = load i32, i32* %3, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1561, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 7
  br i1 %24, label %25, label %34

25:                                               ; preds = %18
  %26 = load %struct.tnode*, %struct.tnode** %2, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 2
  %28 = load %struct.tpool*, %struct.tpool** %27, align 8
  %29 = load %struct.tnode*, %struct.tnode** %2, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = load i32, i32* %3, align 4
  call void @_dereference(%struct.tnode* %4, %struct.tpool* %28, i32 %31, i32 %32, i32 10, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1563)
  call void @funk_print_node(%struct.tnode* %4)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  br label %43

34:                                               ; preds = %18
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = load i32, i32* %3, align 4
  %37 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 %36, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1568, i32 1)
  %38 = bitcast %struct.tdata* %37 to { i64, i64 }*
  %39 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 1
  %42 = load i64, i64* %41, align 8
  call void @funk_print_scalar_element(i64 %40, i64 %42)
  br label %43

43:                                               ; preds = %34, %25
  %44 = load i32, i32* %3, align 4
  %45 = add i32 %44, 1
  %46 = load %struct.tnode*, %struct.tnode** %2, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  %48 = load i32, i32* %47, align 4
  %49 = icmp ult i32 %45, %48
  br i1 %49, label %50, label %52

50:                                               ; preds = %43
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.78, i64 0, i64 0))
  br label %52

52:                                               ; preds = %50, %43
  br label %53

53:                                               ; preds = %52
  %54 = load i32, i32* %3, align 4
  %55 = add i32 %54, 1
  store i32 %55, i32* %3, align 4
  br label %12

56:                                               ; preds = %12
  %57 = load %struct.tnode*, %struct.tnode** %2, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = icmp ugt i32 %59, 1
  br i1 %60, label %61, label %63

61:                                               ; preds = %56
  %62 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.79, i64 0, i64 0))
  br label %63

63:                                               ; preds = %61, %56
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1600, i32 1)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %16

9:                                                ; preds = %1
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1601, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = sitofp i32 %14 to float
  store float %15, float* %2, align 4
  br label %34

16:                                               ; preds = %1
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1602, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %29

22:                                               ; preds = %16
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1603, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 2
  %26 = bitcast %union.data_type* %25 to double*
  %27 = load double, double* %26, align 8
  %28 = fptrunc double %27 to float
  store float %28, float* %2, align 4
  br label %34

29:                                               ; preds = %16
  %30 = load %struct.tnode*, %struct.tnode** %3, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1605, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i32 0, i32* %32, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.82, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

34:                                               ; preds = %22, %9
  %35 = load float, float* %2, align 4
  ret float %35
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_read_list_from_file(i32, %struct.tnode*, i8*) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca %struct.tpool*, align 8
  %8 = alloca %struct.__sFILE*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i8* %2, i8** %6, align 8
  %11 = load i32, i32* %4, align 4
  %12 = call %struct.tpool* @get_pool_ptr(i32 %11)
  store %struct.tpool* %12, %struct.tpool** %7, align 8
  %13 = load i8*, i8** %6, align 8
  %14 = call %struct.__sFILE* @"\01_fopen"(i8* %13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.83, i64 0, i64 0))
  store %struct.__sFILE* %14, %struct.__sFILE** %8, align 8
  %15 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %16 = icmp eq %struct.__sFILE* %15, null
  br i1 %16, label %17, label %20

17:                                               ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.84, i64 0, i64 0), i8* %18)
  call void @exit(i32 1) #6
  unreachable

20:                                               ; preds = %3
  store i32 0, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = load i32, i32* %4, align 4
  call void @funk_create_node(%struct.tnode* %21, i32 0, i32 %22, i32 1, i8 zeroext 0, i8* null)
  br label %23

23:                                               ; preds = %27, %20
  %24 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %25 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %24, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.85, i64 0, i64 0), i32* %9)
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %46

27:                                               ; preds = %23
  %28 = load i32, i32* %9, align 4
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load i32, i32* %10, align 4
  %31 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %30, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1629, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 2
  %33 = bitcast %union.data_type* %32 to i32*
  store i32 %28, i32* %33, align 8
  %34 = load %struct.tnode*, %struct.tnode** %5, align 8
  %35 = load i32, i32* %10, align 4
  %36 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 %35, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1630, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  store i32 1, i32* %37, align 8
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = load i32, i32* %10, align 4
  %40 = load %struct.tpool*, %struct.tpool** %7, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 2
  %42 = load i8, i8* %41, align 4
  call void @_set_wrap_creation(%struct.tnode* %38, i32 %39, i8 zeroext %42)
  %43 = load %struct.tpool*, %struct.tpool** %7, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %43, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1632)
  %44 = load i32, i32* %10, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %10, align 4
  br label %23

46:                                               ; preds = %23
  %47 = load i32, i32* %10, align 4
  %48 = load %struct.tnode*, %struct.tnode** %5, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  store i32 %47, i32* %49, align 4
  %50 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %51 = call i32 @fclose(%struct.__sFILE* %50)
  ret void
}

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #1

declare i32 @fscanf(%struct.__sFILE*, i8*, ...) #1

declare i32 @fclose(%struct.__sFILE*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_len(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %5, i32 %8)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_matrix_lit_indexes(%struct.tnode*, %struct.tnode*, i32, i32, i32, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %struct.tnode, align 8
  %20 = alloca %struct.tnode, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca %struct.tnode, align 8
  %24 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store %struct.tnode* %1, %struct.tnode** %8, align 8
  store i32 %2, i32* %9, align 4
  store i32 %3, i32* %10, align 4
  store i32 %4, i32* %11, align 4
  store i32 %5, i32* %12, align 4
  %25 = load %struct.tnode*, %struct.tnode** %7, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  %27 = load %struct.tpool*, %struct.tpool** %26, align 8
  %28 = call i32 @get_pool_enum(%struct.tpool* %27)
  store i32 %28, i32* %13, align 4
  %29 = load i32, i32* %9, align 4
  %30 = load i32, i32* %10, align 4
  %31 = icmp sgt i32 %29, %30
  br i1 %31, label %32, label %36

32:                                               ; preds = %6
  %33 = load i32, i32* %9, align 4
  %34 = load i32, i32* %10, align 4
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.86, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %33, i32 %34)
  call void @exit(i32 1) #6
  unreachable

36:                                               ; preds = %6
  %37 = load i32, i32* %11, align 4
  %38 = load i32, i32* %12, align 4
  %39 = icmp sgt i32 %37, %38
  br i1 %39, label %40, label %44

40:                                               ; preds = %36
  %41 = load i32, i32* %11, align 4
  %42 = load i32, i32* %12, align 4
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.87, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %41, i32 %42)
  call void @exit(i32 1) #6
  unreachable

44:                                               ; preds = %36
  %45 = load i32, i32* %10, align 4
  %46 = load i32, i32* %9, align 4
  %47 = sub nsw i32 %45, %46
  %48 = add nsw i32 %47, 1
  %49 = call i32 @abs(i32 %48) #8
  store i32 %49, i32* %14, align 4
  %50 = load i32, i32* %12, align 4
  %51 = load i32, i32* %11, align 4
  %52 = sub nsw i32 %50, %51
  %53 = add nsw i32 %52, 1
  %54 = call i32 @abs(i32 %53) #8
  store i32 %54, i32* %15, align 4
  %55 = load %struct.tnode*, %struct.tnode** %8, align 8
  %56 = load i32, i32* %14, align 4
  %57 = load i32, i32* %13, align 4
  call void @funk_create_node(%struct.tnode* %55, i32 %56, i32 %57, i32 7, i8 zeroext 0, i8* null)
  %58 = load i32, i32* %9, align 4
  store i32 %58, i32* %16, align 4
  store i32 0, i32* %17, align 4
  br label %59

59:                                               ; preds = %140, %44
  %60 = load i32, i32* %16, align 4
  %61 = load i32, i32* %10, align 4
  %62 = icmp sle i32 %60, %61
  br i1 %62, label %63, label %67

63:                                               ; preds = %59
  %64 = load i32, i32* %17, align 4
  %65 = load i32, i32* %14, align 4
  %66 = icmp slt i32 %64, %65
  br label %67

67:                                               ; preds = %63, %59
  %68 = phi i1 [ false, %59 ], [ %66, %63 ]
  br i1 %68, label %69, label %145

69:                                               ; preds = %67
  %70 = load i32, i32* %16, align 4
  %71 = icmp slt i32 %70, 0
  br i1 %71, label %72, label %75

72:                                               ; preds = %69
  %73 = load i32, i32* %16, align 4
  %74 = add nsw i32 %73, 5
  br label %77

75:                                               ; preds = %69
  %76 = load i32, i32* %16, align 4
  br label %77

77:                                               ; preds = %75, %72
  %78 = phi i32 [ %74, %72 ], [ %76, %75 ]
  store i32 %78, i32* %18, align 4
  %79 = load %struct.tnode*, %struct.tnode** %7, align 8
  %80 = load i32, i32* %18, align 4
  call void @funk_get_element_in_array(%struct.tnode* %79, %struct.tnode* %19, i32 %80)
  %81 = load i32, i32* %15, align 4
  %82 = load i32, i32* %13, align 4
  call void @funk_create_node(%struct.tnode* %20, i32 %81, i32 %82, i32 7, i8 zeroext 0, i8* null)
  %83 = load i32, i32* %11, align 4
  store i32 %83, i32* %21, align 4
  store i32 0, i32* %22, align 4
  br label %84

84:                                               ; preds = %124, %77
  %85 = load i32, i32* %21, align 4
  %86 = load i32, i32* %12, align 4
  %87 = icmp sle i32 %85, %86
  br i1 %87, label %88, label %92

88:                                               ; preds = %84
  %89 = load i32, i32* %22, align 4
  %90 = load i32, i32* %15, align 4
  %91 = icmp slt i32 %89, %90
  br label %92

92:                                               ; preds = %88, %84
  %93 = phi i1 [ false, %84 ], [ %91, %88 ]
  br i1 %93, label %94, label %129

94:                                               ; preds = %92
  %95 = load i32, i32* %21, align 4
  %96 = icmp slt i32 %95, 0
  br i1 %96, label %97, label %102

97:                                               ; preds = %94
  %98 = load i32, i32* %21, align 4
  %99 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %100 = load i32, i32* %99, align 4
  %101 = add i32 %98, %100
  br label %104

102:                                              ; preds = %94
  %103 = load i32, i32* %21, align 4
  br label %104

104:                                              ; preds = %102, %97
  %105 = phi i32 [ %101, %97 ], [ %103, %102 ]
  store i32 %105, i32* %24, align 4
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %107 = load i32, i32* %106, align 4
  %108 = load i32, i32* %24, align 4
  %109 = urem i32 %108, %107
  store i32 %109, i32* %24, align 4
  %110 = load i32, i32* %24, align 4
  call void @funk_get_element_in_array(%struct.tnode* %19, %struct.tnode* %23, i32 %110)
  %111 = load i32, i32* %22, align 4
  %112 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %111, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1684, i32 1)
  %113 = getelementptr inbounds %struct.tdata, %struct.tdata* %112, i32 0, i32 2
  %114 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1684, i32 1)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 2
  %116 = bitcast %union.data_type* %113 to i8*
  %117 = bitcast %union.data_type* %115 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %116, i8* align 8 %117, i64 8, i1 false)
  %118 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1685, i32 1)
  %119 = getelementptr inbounds %struct.tdata, %struct.tdata* %118, i32 0, i32 0
  %120 = load i32, i32* %119, align 8
  %121 = load i32, i32* %22, align 4
  %122 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %121, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1685, i32 1)
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 0
  store i32 %120, i32* %123, align 8
  br label %124

124:                                              ; preds = %104
  %125 = load i32, i32* %21, align 4
  %126 = add nsw i32 %125, 1
  store i32 %126, i32* %21, align 4
  %127 = load i32, i32* %22, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, i32* %22, align 4
  br label %84

129:                                              ; preds = %92
  %130 = load %struct.tnode*, %struct.tnode** %8, align 8
  %131 = load i32, i32* %17, align 4
  %132 = call %struct.tdata* @get_node(%struct.tnode* %130, i32 %131, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1687, i32 0)
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %132, i32 0, i32 0
  store i32 7, i32* %133, align 8
  %134 = call i32 @_copy_node_to_pool(%struct.tnode* %20)
  %135 = load %struct.tnode*, %struct.tnode** %8, align 8
  %136 = load i32, i32* %17, align 4
  %137 = call %struct.tdata* @get_node(%struct.tnode* %135, i32 %136, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1688, i32 0)
  %138 = getelementptr inbounds %struct.tdata, %struct.tdata* %137, i32 0, i32 2
  %139 = bitcast %union.data_type* %138 to i32*
  store i32 %134, i32* %139, align 8
  br label %140

140:                                              ; preds = %129
  %141 = load i32, i32* %16, align 4
  %142 = add nsw i32 %141, 1
  store i32 %142, i32* %16, align 4
  %143 = load i32, i32* %17, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, i32* %17, align 4
  br label %59

145:                                              ; preds = %67
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @abs(i32) #5

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_matrix(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca %struct.tnode*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store %struct.tnode* %1, %struct.tnode** %8, align 8
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store %struct.tnode* %3, %struct.tnode** %10, align 8
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store %struct.tnode* %5, %struct.tnode** %12, align 8
  %17 = load %struct.tnode*, %struct.tnode** %9, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1697, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %13, align 4
  %22 = load %struct.tnode*, %struct.tnode** %10, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1698, i32 1)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 2
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %14, align 4
  %27 = load %struct.tnode*, %struct.tnode** %11, align 8
  %28 = call %struct.tdata* @get_node(%struct.tnode* %27, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1699, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  store i32 %31, i32* %15, align 4
  %32 = load %struct.tnode*, %struct.tnode** %12, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1700, i32 1)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 2
  %35 = bitcast %union.data_type* %34 to i32*
  %36 = load i32, i32* %35, align 8
  store i32 %36, i32* %16, align 4
  %37 = load %struct.tnode*, %struct.tnode** %7, align 8
  %38 = load %struct.tnode*, %struct.tnode** %8, align 8
  %39 = load i32, i32* %13, align 4
  %40 = load i32, i32* %14, align 4
  %41 = load i32, i32* %15, align 4
  %42 = load i32, i32* %16, align 4
  call void @funk_create_sub_matrix_lit_indexes(%struct.tnode* %37, %struct.tnode* %38, i32 %39, i32 %40, i32 %41, i32 %42)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_array_lit_indexes(%struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %14 = load i32, i32* %7, align 4
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load i32, i32* %7, align 4
  %18 = load %struct.tnode*, %struct.tnode** %5, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = add i32 %17, %20
  br label %24

22:                                               ; preds = %4
  %23 = load i32, i32* %7, align 4
  br label %24

24:                                               ; preds = %22, %16
  %25 = phi i32 [ %21, %16 ], [ %23, %22 ]
  store i32 %25, i32* %7, align 4
  %26 = load i32, i32* %8, align 4
  %27 = icmp slt i32 %26, 0
  br i1 %27, label %28, label %34

28:                                               ; preds = %24
  %29 = load i32, i32* %8, align 4
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 4
  %33 = add i32 %29, %32
  br label %36

34:                                               ; preds = %24
  %35 = load i32, i32* %8, align 4
  br label %36

36:                                               ; preds = %34, %28
  %37 = phi i32 [ %33, %28 ], [ %35, %34 ]
  store i32 %37, i32* %8, align 4
  %38 = load i32, i32* %7, align 4
  %39 = load i32, i32* %8, align 4
  %40 = icmp sgt i32 %38, %39
  br i1 %40, label %41, label %45

41:                                               ; preds = %36
  %42 = load i32, i32* %7, align 4
  %43 = load i32, i32* %8, align 4
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.87, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 %42, i32 %43)
  call void @exit(i32 1) #6
  unreachable

45:                                               ; preds = %36
  %46 = load i32, i32* %8, align 4
  %47 = load i32, i32* %7, align 4
  %48 = sub nsw i32 %46, %47
  %49 = add nsw i32 %48, 1
  %50 = call i32 @abs(i32 %49) #8
  store i32 %50, i32* %9, align 4
  %51 = load i32, i32* %9, align 4
  %52 = sext i32 %51 to i64
  %53 = mul i64 24, %52
  %54 = call i8* @malloc(i64 %53) #7
  %55 = bitcast i8* %54 to %struct.tnode*
  store %struct.tnode* %55, %struct.tnode** %10, align 8
  store i32 0, i32* %11, align 4
  %56 = load i32, i32* %7, align 4
  store i32 %56, i32* %12, align 4
  br label %57

57:                                               ; preds = %75, %45
  %58 = load i32, i32* %12, align 4
  %59 = load i32, i32* %8, align 4
  %60 = icmp sle i32 %58, %59
  br i1 %60, label %61, label %78

61:                                               ; preds = %57
  %62 = load i32, i32* %12, align 4
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  %66 = urem i32 %62, %65
  store i32 %66, i32* %13, align 4
  %67 = load %struct.tnode*, %struct.tnode** %5, align 8
  %68 = load %struct.tnode*, %struct.tnode** %10, align 8
  %69 = load i32, i32* %11, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i64 %70
  %72 = load i32, i32* %13, align 4
  call void @funk_get_element_in_array(%struct.tnode* %67, %struct.tnode* %71, i32 %72)
  %73 = load i32, i32* %11, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %11, align 4
  br label %75

75:                                               ; preds = %61
  %76 = load i32, i32* %12, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, i32* %12, align 4
  br label %57

78:                                               ; preds = %57
  %79 = load %struct.tnode*, %struct.tnode** %6, align 8
  %80 = load %struct.tnode*, %struct.tnode** %10, align 8
  %81 = load i32, i32* %9, align 4
  call void @funk_create_list_of_regs(%struct.tnode* %79, %struct.tnode* %80, i32 %81)
  %82 = load %struct.tnode*, %struct.tnode** %10, align 8
  %83 = bitcast %struct.tnode* %82 to i8*
  call void @free(i8* %83)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_array(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1745, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %14 = bitcast %union.data_type* %13 to i32*
  %15 = load i32, i32* %14, align 8
  store i32 %15, i32* %9, align 4
  %16 = load %struct.tnode*, %struct.tnode** %8, align 8
  %17 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1746, i32 1)
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 2
  %19 = bitcast %union.data_type* %18 to i32*
  %20 = load i32, i32* %19, align 8
  store i32 %20, i32* %10, align 4
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = load i32, i32* %9, align 4
  %24 = load i32, i32* %10, align 4
  call void @funk_create_sub_array_lit_indexes(%struct.tnode* %21, %struct.tnode* %22, i32 %23, i32 %24)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @_funk_set_node_dimensions(%struct.tnode*, i32, i32, i32*, i32, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.tnode, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store i32 %2, i32* %9, align 4
  store i32* %3, i32** %10, align 8
  store i32 %4, i32* %11, align 4
  store i32 %5, i32* %12, align 4
  %16 = load i32*, i32** %10, align 8
  %17 = load i32, i32* %9, align 4
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds i32, i32* %16, i64 %18
  %20 = load i32, i32* %19, align 4
  store i32 %20, i32* %14, align 4
  %21 = load i32, i32* %14, align 4
  %22 = load i32, i32* %8, align 4
  call void @funk_create_node(%struct.tnode* %13, i32 %21, i32 %22, i32 7, i8 zeroext 0, i8* null)
  store i32 0, i32* %15, align 4
  br label %23

23:                                               ; preds = %81, %6
  %24 = load i32, i32* %15, align 4
  %25 = load i32, i32* %14, align 4
  %26 = icmp ult i32 %24, %25
  br i1 %26, label %27, label %84

27:                                               ; preds = %23
  %28 = load i32, i32* %9, align 4
  %29 = add i32 %28, 1
  %30 = load i32, i32* %11, align 4
  %31 = icmp ult i32 %29, %30
  br i1 %31, label %32, label %57

32:                                               ; preds = %27
  %33 = load i32, i32* %15, align 4
  %34 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %33, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1766, i32 1)
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 0
  store i32 7, i32* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %7, align 8
  %37 = load i32, i32* %8, align 4
  %38 = load i32, i32* %9, align 4
  %39 = add i32 %38, 1
  %40 = load i32*, i32** %10, align 8
  %41 = load i32, i32* %11, align 4
  %42 = load i32, i32* %12, align 4
  %43 = load i32, i32* %15, align 4
  %44 = load i32*, i32** %10, align 8
  %45 = load i32, i32* %9, align 4
  %46 = add i32 %45, 1
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds i32, i32* %44, i64 %47
  %49 = load i32, i32* %48, align 4
  %50 = mul i32 %43, %49
  %51 = add i32 %42, %50
  %52 = call i32 @_funk_set_node_dimensions(%struct.tnode* %36, i32 %37, i32 %39, i32* %40, i32 %41, i32 %51)
  %53 = load i32, i32* %15, align 4
  %54 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %53, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1767, i32 1)
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 2
  %56 = bitcast %union.data_type* %55 to i32*
  store i32 %52, i32* %56, align 8
  br label %80

57:                                               ; preds = %27
  %58 = load %struct.tnode*, %struct.tnode** %7, align 8
  %59 = load i32, i32* %12, align 4
  %60 = load i32, i32* %15, align 4
  %61 = add i32 %59, %60
  %62 = call %struct.tdata* @get_node(%struct.tnode* %58, i32 %61, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1772, i32 1)
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 0
  %64 = load i32, i32* %63, align 8
  %65 = load i32, i32* %15, align 4
  %66 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %65, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1772, i32 1)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  store i32 %64, i32* %67, align 8
  %68 = load %struct.tnode*, %struct.tnode** %7, align 8
  %69 = load i32, i32* %12, align 4
  %70 = load i32, i32* %15, align 4
  %71 = add i32 %69, %70
  %72 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 %71, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1773, i32 1)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 2
  %74 = bitcast %union.data_type* %73 to i32*
  %75 = load i32, i32* %74, align 8
  %76 = load i32, i32* %15, align 4
  %77 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %76, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1773, i32 1)
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %77, i32 0, i32 2
  %79 = bitcast %union.data_type* %78 to i32*
  store i32 %75, i32* %79, align 8
  br label %80

80:                                               ; preds = %57, %32
  br label %81

81:                                               ; preds = %80
  %82 = load i32, i32* %15, align 4
  %83 = add i32 %82, 1
  store i32 %83, i32* %15, align 4
  br label %23

84:                                               ; preds = %23
  %85 = call i32 @_copy_node_to_pool(%struct.tnode* %13)
  ret i32 %85
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_extract_tnode_from_pool(%struct.tnode*, i32, %struct.tpool*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.tpool*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store %struct.tpool* %2, %struct.tpool** %6, align 8
  %7 = load %struct.tpool*, %struct.tpool** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  store %struct.tpool* %7, %struct.tpool** %9, align 8
  %10 = load %struct.tpool*, %struct.tpool** %6, align 8
  %11 = getelementptr inbounds %struct.tpool, %struct.tpool* %10, i32 0, i32 0
  %12 = load i32, i32* %5, align 4
  %13 = add i32 %12, 0
  %14 = urem i32 %13, 250000
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %11, i64 0, i64 %15
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %18 = bitcast %union.data_type* %17 to i32*
  %19 = load i32, i32* %18, align 8
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 0
  store i32 %19, i32* %21, align 8
  %22 = load %struct.tpool*, %struct.tpool** %6, align 8
  %23 = getelementptr inbounds %struct.tpool, %struct.tpool* %22, i32 0, i32 0
  %24 = load i32, i32* %5, align 4
  %25 = add i32 %24, 1
  %26 = urem i32 %25, 250000
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %23, i64 0, i64 %27
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  store i32 %31, i32* %33, align 4
  %34 = load %struct.tpool*, %struct.tpool** %6, align 8
  %35 = getelementptr inbounds %struct.tpool, %struct.tpool* %34, i32 0, i32 0
  %36 = load i32, i32* %5, align 4
  %37 = add i32 %36, 2
  %38 = urem i32 %37, 250000
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %35, i64 0, i64 %39
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 2
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 3
  %46 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %45, i32 0, i32 0
  store i32 %43, i32* %46, align 8
  %47 = load %struct.tpool*, %struct.tpool** %6, align 8
  %48 = getelementptr inbounds %struct.tpool, %struct.tpool* %47, i32 0, i32 0
  %49 = load i32, i32* %5, align 4
  %50 = add i32 %49, 3
  %51 = urem i32 %50, 250000
  %52 = zext i32 %51 to i64
  %53 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %48, i64 0, i64 %52
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 2
  %55 = bitcast %union.data_type* %54 to i32*
  %56 = load i32, i32* %55, align 8
  %57 = load %struct.tnode*, %struct.tnode** %4, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 3
  %59 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %58, i32 0, i32 1
  store i32 %56, i32* %59, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_flatten(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  store i32 0, i32* %7, align 4
  br label %9

9:                                                ; preds = %90, %3
  %10 = load i32, i32* %7, align 4
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp ult i32 %10, %13
  br i1 %14, label %15, label %93

15:                                               ; preds = %9
  %16 = load %struct.tnode*, %struct.tnode** %5, align 8
  %17 = load i32, i32* %7, align 4
  %18 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 %17, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1795, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 7
  br i1 %21, label %22, label %49

22:                                               ; preds = %15
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 2
  %25 = load %struct.tpool*, %struct.tpool** %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = load i32, i32* %7, align 4
  call void @_dereference(%struct.tnode* %8, %struct.tpool* %25, i32 %28, i32 %29, i32 10, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1798)
  %30 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1799, i32 1)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load %struct.tnode*, %struct.tnode** %4, align 8
  %34 = load i32, i32* %6, align 4
  %35 = load i32, i32* %7, align 4
  %36 = add i32 %34, %35
  %37 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 %36, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1799, i32 0)
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i32 %32, i32* %38, align 8
  %39 = load %struct.tnode*, %struct.tnode** %4, align 8
  %40 = load i32, i32* %6, align 4
  %41 = load i32, i32* %7, align 4
  %42 = add i32 %40, %41
  %43 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 %42, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1800, i32 0)
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 2
  %45 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1800, i32 1)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 2
  %47 = bitcast %union.data_type* %44 to i8*
  %48 = bitcast %union.data_type* %46 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %47, i8* align 8 %48, i64 8, i1 false)
  br label %73

49:                                               ; preds = %15
  %50 = load %struct.tnode*, %struct.tnode** %5, align 8
  %51 = load i32, i32* %7, align 4
  %52 = call %struct.tdata* @get_node(%struct.tnode* %50, i32 %51, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1802, i32 1)
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  %54 = load i32, i32* %53, align 8
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = load i32, i32* %6, align 4
  %57 = load i32, i32* %7, align 4
  %58 = add i32 %56, %57
  %59 = call %struct.tdata* @get_node(%struct.tnode* %55, i32 %58, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1802, i32 0)
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i32 %54, i32* %60, align 8
  %61 = load %struct.tnode*, %struct.tnode** %4, align 8
  %62 = load i32, i32* %6, align 4
  %63 = load i32, i32* %7, align 4
  %64 = add i32 %62, %63
  %65 = call %struct.tdata* @get_node(%struct.tnode* %61, i32 %64, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1803, i32 0)
  %66 = getelementptr inbounds %struct.tdata, %struct.tdata* %65, i32 0, i32 2
  %67 = load %struct.tnode*, %struct.tnode** %5, align 8
  %68 = load i32, i32* %7, align 4
  %69 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 %68, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1803, i32 1)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %66 to i8*
  %72 = bitcast %union.data_type* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %71, i8* align 8 %72, i64 8, i1 false)
  br label %73

73:                                               ; preds = %49, %22
  %74 = load %struct.tnode*, %struct.tnode** %4, align 8
  %75 = load i32, i32* %6, align 4
  %76 = load i32, i32* %7, align 4
  %77 = add i32 %75, %76
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 2
  %80 = load %struct.tpool*, %struct.tpool** %79, align 8
  %81 = getelementptr inbounds %struct.tpool, %struct.tpool* %80, i32 0, i32 2
  %82 = load i8, i8* %81, align 4
  call void @_set_wrap_creation(%struct.tnode* %74, i32 %77, i8 zeroext %82)
  %83 = load %struct.tnode*, %struct.tnode** %4, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 2
  %85 = load %struct.tpool*, %struct.tpool** %84, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %85, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1806)
  %86 = load %struct.tnode*, %struct.tnode** %4, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 1
  %88 = load i32, i32* %87, align 4
  %89 = add i32 %88, 1
  store i32 %89, i32* %87, align 4
  br label %90

90:                                               ; preds = %73
  %91 = load i32, i32* %7, align 4
  %92 = add i32 %91, 1
  store i32 %92, i32* %7, align 4
  br label %9

93:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_dimensions(%struct.tnode*, i32*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load i32*, i32** %5, align 8
  %9 = icmp eq i32* %8, null
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  br label %25

11:                                               ; preds = %3
  %12 = load %struct.tnode*, %struct.tnode** %4, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = call i32 @get_pool_enum(%struct.tpool* %14)
  store i32 %15, i32* %7, align 4
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = load i32, i32* %7, align 4
  %19 = load i32*, i32** %5, align 8
  %20 = load i32, i32* %6, align 4
  %21 = call i32 @_funk_set_node_dimensions(%struct.tnode* %17, i32 %18, i32 0, i32* %19, i32 %20, i32 0)
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 2
  %24 = load %struct.tpool*, %struct.tpool** %23, align 8
  call void @_extract_tnode_from_pool(%struct.tnode* %16, i32 %21, %struct.tpool* %24)
  br label %25

25:                                               ; preds = %11, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @reshape(%struct.tnode*, i32*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.reshape, i64 0, i64 0), i32 1845, i32 1)
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = icmp eq i32 %10, 4
  br i1 %11, label %12, label %13

12:                                               ; preds = %3
  br label %17

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = load i32*, i32** %5, align 8
  %16 = load i32, i32* %6, align 4
  call void @funk_set_node_dimensions(%struct.tnode* %14, i32* %15, i32 %16)
  br label %17

17:                                               ; preds = %13, %12
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define double @rand_double(double, double) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = call i32 @rand()
  %6 = sitofp i32 %5 to double
  %7 = fdiv double %6, 0x41DFFFFFFFC00000
  %8 = load double, double* %4, align 8
  %9 = load double, double* %3, align 8
  %10 = fsub double %8, %9
  %11 = fmul double %7, %10
  %12 = load double, double* %3, align 8
  %13 = fadd double %11, %12
  ret double %13
}

declare i32 @rand() #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_empty_list_element(i32, %struct.tnode*) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode*, align 8
  store i32 %0, i32* %3, align 4
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = load i32, i32* %3, align 4
  call void @funk_create_node(%struct.tnode* %5, i32 1, i32 %6, i32 4, i8 zeroext 0, i8* null)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_append_element_to_list(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.88, i64 0, i64 0))
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1871)
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = call %struct.tnode* @validate_node(%struct.tnode* %12, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1872)
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1874, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 4
  br i1 %18, label %19, label %28

19:                                               ; preds = %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1875, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 4
  br i1 %24, label %25, label %28

25:                                               ; preds = %19
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_node(%struct.tnode* %26, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.89, i64 0, i64 0))
  br label %123

28:                                               ; preds = %19, %3
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1882, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = icmp eq i32 %33, 4
  br i1 %34, label %35, label %36

35:                                               ; preds = %28
  br label %40

36:                                               ; preds = %28
  %37 = load %struct.tnode*, %struct.tnode** %5, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  br label %40

40:                                               ; preds = %36, %35
  %41 = phi i32 [ 0, %35 ], [ %39, %36 ]
  %42 = load %struct.tnode*, %struct.tnode** %6, align 8
  %43 = call %struct.tdata* @get_node(%struct.tnode* %42, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1883, i32 1)
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = icmp eq i32 %45, 4
  %47 = zext i1 %46 to i64
  %48 = select i1 %46, i32 0, i32 1
  %49 = add i32 %41, %48
  call void @funk_create_node(%struct.tnode* %29, i32 %49, i32 1, i32 3, i8 zeroext 0, i8* null)
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %50

50:                                               ; preds = %86, %40
  %51 = load i32, i32* %8, align 4
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = load i32, i32* %53, align 4
  %55 = icmp ult i32 %51, %54
  br i1 %55, label %56, label %89

56:                                               ; preds = %50
  %57 = load %struct.tnode*, %struct.tnode** %5, align 8
  %58 = load i32, i32* %8, align 4
  %59 = call %struct.tdata* @get_node(%struct.tnode* %57, i32 %58, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1888, i32 1)
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = icmp eq i32 %61, 4
  br i1 %62, label %63, label %64

63:                                               ; preds = %56
  br label %89

64:                                               ; preds = %56
  %65 = load %struct.tnode*, %struct.tnode** %5, align 8
  %66 = load i32, i32* %8, align 4
  %67 = call %struct.tdata* @get_node(%struct.tnode* %65, i32 %66, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1891, i32 1)
  %68 = getelementptr inbounds %struct.tdata, %struct.tdata* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = load %struct.tnode*, %struct.tnode** %4, align 8
  %71 = load i32, i32* %7, align 4
  %72 = call %struct.tdata* @get_node(%struct.tnode* %70, i32 %71, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1891, i32 1)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 0
  store i32 %69, i32* %73, align 8
  %74 = load %struct.tnode*, %struct.tnode** %4, align 8
  %75 = load i32, i32* %7, align 4
  %76 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 %75, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1892, i32 1)
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 2
  %78 = load %struct.tnode*, %struct.tnode** %5, align 8
  %79 = load i32, i32* %8, align 4
  %80 = call %struct.tdata* @get_node(%struct.tnode* %78, i32 %79, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1892, i32 1)
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 2
  %82 = bitcast %union.data_type* %77 to i8*
  %83 = bitcast %union.data_type* %81 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %82, i8* align 8 %83, i64 8, i1 false)
  %84 = load i32, i32* %7, align 4
  %85 = add i32 %84, 1
  store i32 %85, i32* %7, align 4
  br label %86

86:                                               ; preds = %64
  %87 = load i32, i32* %8, align 4
  %88 = add i32 %87, 1
  store i32 %88, i32* %8, align 4
  br label %50

89:                                               ; preds = %63, %50
  %90 = load %struct.tnode*, %struct.tnode** %6, align 8
  %91 = call %struct.tdata* @get_node(%struct.tnode* %90, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1897, i32 1)
  %92 = getelementptr inbounds %struct.tdata, %struct.tdata* %91, i32 0, i32 0
  %93 = load i32, i32* %92, align 8
  %94 = icmp ne i32 %93, 4
  br i1 %94, label %95, label %113

95:                                               ; preds = %89
  %96 = load %struct.tnode*, %struct.tnode** %4, align 8
  %97 = load %struct.tnode*, %struct.tnode** %4, align 8
  %98 = getelementptr inbounds %struct.tnode, %struct.tnode* %97, i32 0, i32 1
  %99 = load i32, i32* %98, align 4
  %100 = sub i32 %99, 1
  %101 = call %struct.tdata* @get_node(%struct.tnode* %96, i32 %100, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1898, i32 0)
  %102 = getelementptr inbounds %struct.tdata, %struct.tdata* %101, i32 0, i32 0
  store i32 7, i32* %102, align 8
  %103 = load %struct.tnode*, %struct.tnode** %6, align 8
  %104 = call i32 @_copy_node_to_pool(%struct.tnode* %103)
  %105 = load %struct.tnode*, %struct.tnode** %4, align 8
  %106 = load %struct.tnode*, %struct.tnode** %4, align 8
  %107 = getelementptr inbounds %struct.tnode, %struct.tnode* %106, i32 0, i32 1
  %108 = load i32, i32* %107, align 4
  %109 = sub i32 %108, 1
  %110 = call %struct.tdata* @get_node(%struct.tnode* %105, i32 %109, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 1899, i32 0)
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 2
  %112 = bitcast %union.data_type* %111 to i32*
  store i32 %104, i32* %112, align 8
  br label %113

113:                                              ; preds = %95, %89
  %114 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.90, i64 0, i64 0))
  %115 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node(%struct.tnode* %115)
  %116 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.91, i64 0, i64 0))
  %117 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_print_node(%struct.tnode* %117)
  %118 = load %struct.tnode*, %struct.tnode** %4, align 8
  %119 = getelementptr inbounds %struct.tnode, %struct.tnode* %118, i32 0, i32 1
  %120 = load i32, i32* %119, align 4
  %121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.92, i64 0, i64 0), i32 %120)
  %122 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %122)
  br label %123

123:                                              ; preds = %113, %25
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_prepend_element_to_list(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = call %struct.tnode* @validate_node(%struct.tnode* %9, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1913)
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1914)
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1917, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 4
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 0, i32 1
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = call %struct.tdata* @get_node(%struct.tnode* %21, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1918, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = icmp eq i32 %24, 4
  br i1 %25, label %26, label %27

26:                                               ; preds = %3
  br label %31

27:                                               ; preds = %3
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = load i32, i32* %29, align 4
  br label %31

31:                                               ; preds = %27, %26
  %32 = phi i32 [ 0, %26 ], [ %30, %27 ]
  %33 = add i32 %20, %32
  call void @funk_create_node(%struct.tnode* %13, i32 %33, i32 1, i32 3, i8 zeroext 0, i8* null)
  %34 = load %struct.tnode*, %struct.tnode** %5, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = icmp ugt i32 %36, 1
  br i1 %37, label %38, label %48

38:                                               ; preds = %31
  %39 = load %struct.tnode*, %struct.tnode** %4, align 8
  %40 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1923, i32 0)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  store i32 7, i32* %41, align 8
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = call i32 @_copy_node_to_pool(%struct.tnode* %42)
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = call %struct.tdata* @get_node(%struct.tnode* %44, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1924, i32 0)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 2
  %47 = bitcast %union.data_type* %46 to i32*
  store i32 %43, i32* %47, align 8
  br label %71

48:                                               ; preds = %31
  %49 = load %struct.tnode*, %struct.tnode** %5, align 8
  %50 = call %struct.tdata* @get_node(%struct.tnode* %49, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1925, i32 1)
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = icmp ne i32 %52, 4
  br i1 %53, label %54, label %70

54:                                               ; preds = %48
  %55 = load %struct.tnode*, %struct.tnode** %5, align 8
  %56 = call %struct.tdata* @get_node(%struct.tnode* %55, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1926, i32 1)
  %57 = getelementptr inbounds %struct.tdata, %struct.tdata* %56, i32 0, i32 0
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %4, align 8
  %60 = call %struct.tdata* @get_node(%struct.tnode* %59, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1926, i32 1)
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 0
  store i32 %58, i32* %61, align 8
  %62 = load %struct.tnode*, %struct.tnode** %4, align 8
  %63 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1927, i32 1)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 2
  %65 = load %struct.tnode*, %struct.tnode** %5, align 8
  %66 = call %struct.tdata* @get_node(%struct.tnode* %65, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1927, i32 1)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 2
  %68 = bitcast %union.data_type* %64 to i8*
  %69 = bitcast %union.data_type* %67 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %68, i8* align 8 %69, i64 8, i1 false)
  br label %70

70:                                               ; preds = %54, %48
  br label %71

71:                                               ; preds = %70, %38
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %72

72:                                               ; preds = %108, %71
  %73 = load i32, i32* %8, align 4
  %74 = load %struct.tnode*, %struct.tnode** %6, align 8
  %75 = getelementptr inbounds %struct.tnode, %struct.tnode* %74, i32 0, i32 1
  %76 = load i32, i32* %75, align 4
  %77 = icmp ult i32 %73, %76
  br i1 %77, label %78, label %111

78:                                               ; preds = %72
  %79 = load %struct.tnode*, %struct.tnode** %6, align 8
  %80 = load i32, i32* %8, align 4
  %81 = call %struct.tdata* @get_node(%struct.tnode* %79, i32 %80, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1932, i32 1)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i32, i32* %82, align 8
  %84 = icmp eq i32 %83, 4
  br i1 %84, label %85, label %86

85:                                               ; preds = %78
  br label %111

86:                                               ; preds = %78
  %87 = load %struct.tnode*, %struct.tnode** %6, align 8
  %88 = load i32, i32* %8, align 4
  %89 = call %struct.tdata* @get_node(%struct.tnode* %87, i32 %88, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1935, i32 1)
  %90 = getelementptr inbounds %struct.tdata, %struct.tdata* %89, i32 0, i32 0
  %91 = load i32, i32* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %4, align 8
  %93 = load i32, i32* %7, align 4
  %94 = call %struct.tdata* @get_node(%struct.tnode* %92, i32 %93, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1935, i32 1)
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 0
  store i32 %91, i32* %95, align 8
  %96 = load %struct.tnode*, %struct.tnode** %4, align 8
  %97 = load i32, i32* %7, align 4
  %98 = call %struct.tdata* @get_node(%struct.tnode* %96, i32 %97, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1936, i32 1)
  %99 = getelementptr inbounds %struct.tdata, %struct.tdata* %98, i32 0, i32 2
  %100 = load %struct.tnode*, %struct.tnode** %6, align 8
  %101 = load i32, i32* %8, align 4
  %102 = call %struct.tdata* @get_node(%struct.tnode* %100, i32 %101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 1936, i32 1)
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 2
  %104 = bitcast %union.data_type* %99 to i8*
  %105 = bitcast %union.data_type* %103 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %104, i8* align 8 %105, i64 8, i1 false)
  %106 = load i32, i32* %7, align 4
  %107 = add i32 %106, 1
  store i32 %107, i32* %7, align 4
  br label %108

108:                                              ; preds = %86
  %109 = load i32, i32* %8, align 4
  %110 = add i32 %109, 1
  store i32 %110, i32* %8, align 4
  br label %72

111:                                              ; preds = %85, %72
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_concatenate_lists(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1946)
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = call %struct.tnode* @validate_node(%struct.tnode* %12, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1947)
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1949, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 4
  br i1 %18, label %19, label %28

19:                                               ; preds = %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1950, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 4
  br i1 %24, label %25, label %28

25:                                               ; preds = %19
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_node(%struct.tnode* %26, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.89, i64 0, i64 0))
  br label %134

28:                                               ; preds = %19, %3
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1957, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = icmp eq i32 %33, 4
  br i1 %34, label %35, label %36

35:                                               ; preds = %28
  br label %40

36:                                               ; preds = %28
  %37 = load %struct.tnode*, %struct.tnode** %5, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  br label %40

40:                                               ; preds = %36, %35
  %41 = phi i32 [ 0, %35 ], [ %39, %36 ]
  %42 = load %struct.tnode*, %struct.tnode** %6, align 8
  %43 = call %struct.tdata* @get_node(%struct.tnode* %42, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1958, i32 1)
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = icmp eq i32 %45, 4
  br i1 %46, label %47, label %48

47:                                               ; preds = %40
  br label %52

48:                                               ; preds = %40
  %49 = load %struct.tnode*, %struct.tnode** %6, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = load i32, i32* %50, align 4
  br label %52

52:                                               ; preds = %48, %47
  %53 = phi i32 [ 0, %47 ], [ %51, %48 ]
  %54 = add i32 %41, %53
  call void @funk_create_node(%struct.tnode* %29, i32 %54, i32 1, i32 3, i8 zeroext 0, i8* null)
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %55

55:                                               ; preds = %91, %52
  %56 = load i32, i32* %8, align 4
  %57 = load %struct.tnode*, %struct.tnode** %5, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = icmp ult i32 %56, %59
  br i1 %60, label %61, label %94

61:                                               ; preds = %55
  %62 = load %struct.tnode*, %struct.tnode** %5, align 8
  %63 = load i32, i32* %8, align 4
  %64 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 %63, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1963, i32 1)
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 0
  %66 = load i32, i32* %65, align 8
  %67 = icmp eq i32 %66, 4
  br i1 %67, label %68, label %69

68:                                               ; preds = %61
  br label %94

69:                                               ; preds = %61
  %70 = load %struct.tnode*, %struct.tnode** %5, align 8
  %71 = load i32, i32* %8, align 4
  %72 = call %struct.tdata* @get_node(%struct.tnode* %70, i32 %71, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1966, i32 1)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = load %struct.tnode*, %struct.tnode** %4, align 8
  %76 = load i32, i32* %7, align 4
  %77 = call %struct.tdata* @get_node(%struct.tnode* %75, i32 %76, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1966, i32 1)
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %77, i32 0, i32 0
  store i32 %74, i32* %78, align 8
  %79 = load %struct.tnode*, %struct.tnode** %4, align 8
  %80 = load i32, i32* %7, align 4
  %81 = call %struct.tdata* @get_node(%struct.tnode* %79, i32 %80, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1967, i32 1)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 2
  %83 = load %struct.tnode*, %struct.tnode** %5, align 8
  %84 = load i32, i32* %8, align 4
  %85 = call %struct.tdata* @get_node(%struct.tnode* %83, i32 %84, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1967, i32 1)
  %86 = getelementptr inbounds %struct.tdata, %struct.tdata* %85, i32 0, i32 2
  %87 = bitcast %union.data_type* %82 to i8*
  %88 = bitcast %union.data_type* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %87, i8* align 8 %88, i64 8, i1 false)
  %89 = load i32, i32* %7, align 4
  %90 = add i32 %89, 1
  store i32 %90, i32* %7, align 4
  br label %91

91:                                               ; preds = %69
  %92 = load i32, i32* %8, align 4
  %93 = add i32 %92, 1
  store i32 %93, i32* %8, align 4
  br label %55

94:                                               ; preds = %68, %55
  store i32 0, i32* %9, align 4
  br label %95

95:                                               ; preds = %131, %94
  %96 = load i32, i32* %9, align 4
  %97 = load %struct.tnode*, %struct.tnode** %6, align 8
  %98 = getelementptr inbounds %struct.tnode, %struct.tnode* %97, i32 0, i32 1
  %99 = load i32, i32* %98, align 4
  %100 = icmp ult i32 %96, %99
  br i1 %100, label %101, label %134

101:                                              ; preds = %95
  %102 = load %struct.tnode*, %struct.tnode** %6, align 8
  %103 = load i32, i32* %9, align 4
  %104 = call %struct.tdata* @get_node(%struct.tnode* %102, i32 %103, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1973, i32 1)
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  %106 = load i32, i32* %105, align 8
  %107 = icmp eq i32 %106, 4
  br i1 %107, label %108, label %109

108:                                              ; preds = %101
  br label %134

109:                                              ; preds = %101
  %110 = load %struct.tnode*, %struct.tnode** %6, align 8
  %111 = load i32, i32* %9, align 4
  %112 = call %struct.tdata* @get_node(%struct.tnode* %110, i32 %111, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1976, i32 1)
  %113 = getelementptr inbounds %struct.tdata, %struct.tdata* %112, i32 0, i32 0
  %114 = load i32, i32* %113, align 8
  %115 = load %struct.tnode*, %struct.tnode** %4, align 8
  %116 = load i32, i32* %7, align 4
  %117 = call %struct.tdata* @get_node(%struct.tnode* %115, i32 %116, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1976, i32 1)
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %117, i32 0, i32 0
  store i32 %114, i32* %118, align 8
  %119 = load %struct.tnode*, %struct.tnode** %4, align 8
  %120 = load i32, i32* %7, align 4
  %121 = call %struct.tdata* @get_node(%struct.tnode* %119, i32 %120, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1977, i32 1)
  %122 = getelementptr inbounds %struct.tdata, %struct.tdata* %121, i32 0, i32 2
  %123 = load %struct.tnode*, %struct.tnode** %6, align 8
  %124 = load i32, i32* %9, align 4
  %125 = call %struct.tdata* @get_node(%struct.tnode* %123, i32 %124, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1977, i32 1)
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %125, i32 0, i32 2
  %127 = bitcast %union.data_type* %122 to i8*
  %128 = bitcast %union.data_type* %126 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %127, i8* align 8 %128, i64 8, i1 false)
  %129 = load i32, i32* %7, align 4
  %130 = add i32 %129, 1
  store i32 %130, i32* %7, align 4
  br label %131

131:                                              ; preds = %109
  %132 = load i32, i32* %9, align 4
  %133 = add i32 %132, 1
  store i32 %133, i32* %9, align 4
  br label %95

134:                                              ; preds = %25, %108, %95
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_start(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tnode* @validate_node(%struct.tnode* %3, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_get_node_start, i64 0, i64 0), i32 1985)
  %5 = load %struct.tnode*, %struct.tnode** %2, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_pool(%struct.tnode*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0), i32 1991)
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = icmp eq %struct.tpool* %9, @funk_global_memory_pool
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %20

12:                                               ; preds = %1
  %13 = load %struct.tnode*, %struct.tnode** %3, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 2
  %15 = load %struct.tpool*, %struct.tpool** %14, align 8
  %16 = icmp eq %struct.tpool* %15, @funk_functions_memory_pool
  br i1 %16, label %17, label %18

17:                                               ; preds = %12
  store i32 1, i32* %2, align 4
  br label %20

18:                                               ; preds = %12
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.93, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

20:                                               ; preds = %17, %11
  %21 = load i32, i32* %2, align 4
  ret i32 %21
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_tnode_array_elementEX(%struct.tnode*, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load %struct.tnode*, %struct.tnode** %6, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_set_tnode_array_elementEX, i64 0, i64 0), i32 2011, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  store i32 %14, i32* %9, align 4
  %15 = load i32, i32* %9, align 4
  %16 = load i32, i32* %8, align 4
  %17 = icmp uge i32 %15, %16
  br i1 %17, label %18, label %22

18:                                               ; preds = %4
  %19 = load i32, i32* %9, align 4
  %20 = load i32, i32* %8, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.94, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_set_tnode_array_elementEX, i64 0, i64 0), i32 %19, i32 %20)
  br label %22

22:                                               ; preds = %18, %4
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = load i32, i32* %9, align 4
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i64 %25
  %27 = load %struct.tnode*, %struct.tnode** %7, align 8
  %28 = bitcast %struct.tnode* %26 to i8*
  %29 = bitcast %struct.tnode* %27 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %28, i8* align 8 %29, i64 24, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @funk_alloc_list_of_tnodes(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = load %struct.tnode*, %struct.tnode** %2, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_alloc_list_of_tnodes, i64 0, i64 0), i32 2021, i32 1)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 2
  %7 = bitcast %union.data_type* %6 to i32*
  %8 = load i32, i32* %7, align 8
  store i32 %8, i32* %3, align 4
  %9 = load i32, i32* %3, align 4
  %10 = zext i32 %9 to i64
  %11 = mul i64 %10, 24
  %12 = call i8* @malloc(i64 %11) #7
  %13 = bitcast i8* %12 to %struct.tnode*
  ret %struct.tnode* %13
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_call_fn_pointer(%struct.tnode*, %struct.tnode*, i32, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 2031, i32 1)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp ne i32 %12, 6
  br i1 %13, label %14, label %16

14:                                               ; preds = %4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.95, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 2036, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to void (%struct.tnode*, i32, %struct.tnode*)**
  %21 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %20, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = load i32, i32* %7, align 4
  %24 = load %struct.tnode*, %struct.tnode** %8, align 8
  call void %21(%struct.tnode* %22, i32 %23, %struct.tnode* %24)
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn }
attributes #7 = { allocsize(0) }
attributes #8 = { nounwind readnone }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
