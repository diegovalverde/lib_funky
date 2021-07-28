; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [250000 x %struct.tdata], i32, i8 }
%struct.tdata = type { i32, i8, %union.data_type }
%union.data_type = type { double }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, i32 }

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
@__FUNCTION__._print_array_info = private unnamed_addr constant [18 x i8] c"_print_array_info\00", align 1
@.str.23 = private unnamed_addr constant [16 x i8] c" Array Len: %d\0A\00", align 1
@.str.24 = private unnamed_addr constant [2 x i8] c"\09\00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.26 = private unnamed_addr constant [5 x i8] c" %d\0A\00", align 1
@.str.27 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.28 = private unnamed_addr constant [8 x i8] c"len %d\0A\00", align 1
@.str.29 = private unnamed_addr constant [17 x i8] c"%s[%d :%d] %d-d\0A\00", align 1
@.str.30 = private unnamed_addr constant [8 x i8] c"types: \00", align 1
@.str.31 = private unnamed_addr constant [5 x i8] c"%d, \00", align 1
@__FUNCTION__._funk_print_node_info = private unnamed_addr constant [22 x i8] c"_funk_print_node_info\00", align 1
@.str.32 = private unnamed_addr constant [9 x i8] c"int: %d\0A\00", align 1
@.str.33 = private unnamed_addr constant [12 x i8] c"double: %f\0A\00", align 1
@.str.34 = private unnamed_addr constant [21 x i8] c"\0Aglobal tail: %d:%d\0A\00", align 1
@.str.35 = private unnamed_addr constant [22 x i8] c"function tail: %d:%d\0A\00", align 1
@__FUNCTION__._funk_alloc_raw_tdata = private unnamed_addr constant [22 x i8] c"_funk_alloc_raw_tdata\00", align 1
@__FUNCTION__.funk_create_node = private unnamed_addr constant [17 x i8] c"funk_create_node\00", align 1
@__FUNCTION__.funk_deep_copy_node = private unnamed_addr constant [20 x i8] c"funk_deep_copy_node\00", align 1
@.str.36 = private unnamed_addr constant [20 x i8] c"-E- %s :: %s+%d %s\0A\00", align 1
@gCurrentFunction = common global [64 x i8] zeroinitializer, align 16
@.str.37 = private unnamed_addr constant [79 x i8] c"\0AINTERNAL ERROR'(IS_PTR(src, 0) && LEN(src) != tmp.len && LEN(src) != 1)':\0A\22\22\0A\00", align 1
@.str.38 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@__FUNCTION__.funk_roll = private unnamed_addr constant [10 x i8] c"funk_roll\00", align 1
@.str.39 = private unnamed_addr constant [27 x i8] c"\0AINTERNAL ERROR'!src':\0A\22\22\0A\00", align 1
@.str.40 = private unnamed_addr constant [30 x i8] c"\0AINTERNAL ERROR'!deltas':\0A\22\22\0A\00", align 1
@.str.41 = private unnamed_addr constant [37 x i8] c"\0AINTERNAL ERROR'!IS_PTR(src,0)':\0A\22\22\0A\00", align 1
@.str.42 = private unnamed_addr constant [66 x i8] c"\0AINTERNAL ERROR'delta_count != 2':\0A\22Only 2 dimensions supported\22\0A\00", align 1
@__FUNCTION__.funk_not = private unnamed_addr constant [9 x i8] c"funk_not\00", align 1
@.str.43 = private unnamed_addr constant [11 x i8] c"%d --> %d\0A\00", align 1
@.str.44 = private unnamed_addr constant [12 x i8] c"\0A %d >>>>>\0A\00", align 1
@.str.45 = private unnamed_addr constant [6 x i8] c"llll\0A\00", align 1
@__FUNCTION__._funk_sum_list = private unnamed_addr constant [15 x i8] c"_funk_sum_list\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_ptr = private unnamed_addr constant [31 x i8] c"funk_get_element_in_matrix_ptr\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_lit = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_lit\00", align 1
@.str.46 = private unnamed_addr constant [35 x i8] c"-E- %s Invalid dimensions %d x %d\0A\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_var = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_var\00", align 1
@.str.47 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@.str.48 = private unnamed_addr constant [18 x i8] c"-E- %s max depth\0A\00", align 1
@__FUNCTION__._dereference = private unnamed_addr constant [13 x i8] c"_dereference\00", align 1
@.str.49 = private unnamed_addr constant [39 x i8] c"-E- %s unknown type %d from %s +%d %s\0A\00", align 1
@__FUNCTION__.funk_get_element_in_array = private unnamed_addr constant [26 x i8] c"funk_get_element_in_array\00", align 1
@__FUNCTION__.funk_get_element_in_array_var = private unnamed_addr constant [30 x i8] c"funk_get_element_in_array_var\00", align 1
@__FUNCTION__.add_node_to_nodelist = private unnamed_addr constant [21 x i8] c"add_node_to_nodelist\00", align 1
@__FUNCTION__.funk_create_double_scalar = private unnamed_addr constant [26 x i8] c"funk_create_double_scalar\00", align 1
@__FUNCTION__.funk_create_i32_scalar = private unnamed_addr constant [23 x i8] c"funk_create_i32_scalar\00", align 1
@__FUNCTION__.funk_create_list_of_regs = private unnamed_addr constant [25 x i8] c"funk_create_list_of_regs\00", align 1
@.str.50 = private unnamed_addr constant [5 x i8] c"%3d \00", align 1
@.str.51 = private unnamed_addr constant [6 x i8] c"%5.5f\00", align 1
@.str.52 = private unnamed_addr constant [4 x i8] c"%5s\00", align 1
@.str.53 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.54 = private unnamed_addr constant [14 x i8] c"<function> %p\00", align 1
@.str.55 = private unnamed_addr constant [7 x i8] c"*-> %d\00", align 1
@.str.56 = private unnamed_addr constant [5 x i8] c"* %d\00", align 1
@.str.57 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.58 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_increment_node_data_int = private unnamed_addr constant [29 x i8] c"funk_increment_node_data_int\00", align 1
@__FUNCTION__.funk_copy_node_into_node_list = private unnamed_addr constant [30 x i8] c"funk_copy_node_into_node_list\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_set_node_value_fn_ptr = private unnamed_addr constant [27 x i8] c"funk_set_node_value_fn_ptr\00", align 1
@__FUNCTION__.funk_set_node_value_double = private unnamed_addr constant [27 x i8] c"funk_set_node_value_double\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.59 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.60 = private unnamed_addr constant [8 x i8] c"%d(%d):\00", align 1
@.str.61 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@__FUNCTION__.debug_print_arith_operation = private unnamed_addr constant [28 x i8] c"debug_print_arith_operation\00", align 1
@.str.62 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.63 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.64 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.65 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
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
@.str.66 = private unnamed_addr constant [4 x i8] c" * \00", align 1
@.str.67 = private unnamed_addr constant [4 x i8] c" / \00", align 1
@.str.68 = private unnamed_addr constant [4 x i8] c" + \00", align 1
@.str.69 = private unnamed_addr constant [4 x i8] c" - \00", align 1
@.str.70 = private unnamed_addr constant [6 x i8] c" mod \00", align 1
@.str.71 = private unnamed_addr constant [4 x i8] c" < \00", align 1
@.str.72 = private unnamed_addr constant [4 x i8] c" > \00", align 1
@.str.73 = private unnamed_addr constant [5 x i8] c" >= \00", align 1
@.str.74 = private unnamed_addr constant [5 x i8] c" == \00", align 1
@.str.75 = private unnamed_addr constant [4 x i8] c"!= \00", align 1
@.str.76 = private unnamed_addr constant [5 x i8] c" or \00", align 1
@.str.77 = private unnamed_addr constant [6 x i8] c" and \00", align 1
@.str.78 = private unnamed_addr constant [25 x i8] c"Unknown arith operation\0A\00", align 1
@__FUNCTION__._funk_arith_op_rr = private unnamed_addr constant [18 x i8] c"_funk_arith_op_rr\00", align 1
@.str.79 = private unnamed_addr constant [14 x i8] c"Invalid types\00", align 1
@.str.80 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.81 = private unnamed_addr constant [16 x i8] c"length mismatch\00", align 1
@.str.82 = private unnamed_addr constant [33 x i8] c"'%s' length mismatch %d != %d !\0A\00", align 1
@.str.83 = private unnamed_addr constant [2 x i8] c"{\00", align 1
@.str.84 = private unnamed_addr constant [5 x i8] c" \5C\0A \00", align 1
@.str.85 = private unnamed_addr constant [3 x i8] c"}\0A\00", align 1
@.str.86 = private unnamed_addr constant [7 x i8] c"CRAP!\0A\00", align 1
@__FUNCTION__.funk_eq_rr = private unnamed_addr constant [11 x i8] c"funk_eq_rr\00", align 1
@.str.87 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.88 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.89 = private unnamed_addr constant [2 x i8] c")\00", align 1
@__FUNCTION__._funk_print_node = private unnamed_addr constant [17 x i8] c"_funk_print_node\00", align 1
@.str.90 = private unnamed_addr constant [2 x i8] c",\00", align 1
@__FUNCTION__.__funk_print_node = private unnamed_addr constant [18 x i8] c"__funk_print_node\00", align 1
@.str.91 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.92 = private unnamed_addr constant [3 x i8] c"] \00", align 1
@__stdoutp = external global %struct.__sFILE*, align 8
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.93 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@.str.94 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.95 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.96 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@__FUNCTION__.funk_read_list_from_file = private unnamed_addr constant [25 x i8] c"funk_read_list_from_file\00", align 1
@__FUNCTION__.funk_get_len = private unnamed_addr constant [13 x i8] c"funk_get_len\00", align 1
@.str.97 = private unnamed_addr constant [28 x i8] c"%s Error r1 (%d) > r2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix_lit_indexes = private unnamed_addr constant [35 x i8] c"funk_create_sub_matrix_lit_indexes\00", align 1
@.str.98 = private unnamed_addr constant [28 x i8] c"%s Error c1 (%d) > c2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix = private unnamed_addr constant [23 x i8] c"funk_create_sub_matrix\00", align 1
@__FUNCTION__.funk_create_sub_array_lit_indexes = private unnamed_addr constant [34 x i8] c"funk_create_sub_array_lit_indexes\00", align 1
@__FUNCTION__.funk_create_sub_array = private unnamed_addr constant [22 x i8] c"funk_create_sub_array\00", align 1
@__FUNCTION__._funk_set_node_dimensions = private unnamed_addr constant [26 x i8] c"_funk_set_node_dimensions\00", align 1
@__FUNCTION__._flatten = private unnamed_addr constant [9 x i8] c"_flatten\00", align 1
@__FUNCTION__.reshape = private unnamed_addr constant [8 x i8] c"reshape\00", align 1
@.str.99 = private unnamed_addr constant [29 x i8] c"funk_append_element_to_list\0A\00", align 1
@__FUNCTION__.funk_append_element_to_list = private unnamed_addr constant [28 x i8] c"funk_append_element_to_list\00", align 1
@.str.100 = private unnamed_addr constant [43 x i8] c"funk_append_element_to_list [] , [] -> []\0A\00", align 1
@.str.101 = private unnamed_addr constant [16 x i8] c"%d xxxxxxxxxxx\0A\00", align 1
@.str.102 = private unnamed_addr constant [10 x i8] c"xxxxxxxx\0A\00", align 1
@__FUNCTION__.funk_prepend_element_to_list = private unnamed_addr constant [29 x i8] c"funk_prepend_element_to_list\00", align 1
@.str.103 = private unnamed_addr constant [44 x i8] c"funk_prepend_element_to_list [] , [] -> []\0A\00", align 1
@.str.104 = private unnamed_addr constant [16 x i8] c"%d ***********\0A\00", align 1
@.str.105 = private unnamed_addr constant [3 x i8] c"<~\00", align 1
@.str.106 = private unnamed_addr constant [13 x i8] c"***********\0A\00", align 1
@__FUNCTION__.funk_concatenate_lists = private unnamed_addr constant [23 x i8] c"funk_concatenate_lists\00", align 1
@.str.107 = private unnamed_addr constant [38 x i8] c"funk_concatenate_lists [] , [] -> []\0A\00", align 1
@.str.108 = private unnamed_addr constant [40 x i8] c"funk_concatenate_lists [L] ++ [] -> []\0A\00", align 1
@.str.109 = private unnamed_addr constant [40 x i8] c"funk_concatenate_lists [] ++ [R] -> []\0A\00", align 1
@.str.110 = private unnamed_addr constant [7 x i8] c"ppppp\0A\00", align 1
@.str.111 = private unnamed_addr constant [13 x i8] c" LEN: %d \0A\0A\0A\00", align 1
@.str.112 = private unnamed_addr constant [8 x i8] c" %d \0A\0A\0A\00", align 1
@.str.113 = private unnamed_addr constant [14 x i8] c"gggggggggggg\0A\00", align 1
@__FUNCTION__.funk_get_node_start = private unnamed_addr constant [20 x i8] c"funk_get_node_start\00", align 1
@__FUNCTION__.funk_get_node_pool = private unnamed_addr constant [19 x i8] c"funk_get_node_pool\00", align 1
@.str.114 = private unnamed_addr constant [21 x i8] c"-E- %s Invalid pool\0A\00", align 1
@__FUNCTION__.funk_set_tnode_array_elementEX = private unnamed_addr constant [31 x i8] c"funk_set_tnode_array_elementEX\00", align 1
@.str.115 = private unnamed_addr constant [37 x i8] c"-E- %s Index %d out of range [0:%d]\0A\00", align 1
@__FUNCTION__.funk_alloc_list_of_tnodes = private unnamed_addr constant [26 x i8] c"funk_alloc_list_of_tnodes\00", align 1
@__FUNCTION__.funk_call_fn_pointer = private unnamed_addr constant [21 x i8] c"funk_call_fn_pointer\00", align 1
@.str.116 = private unnamed_addr constant [43 x i8] c"-E- calling node which is not a function!\0A\00", align 1

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
  %29 = call %struct.tnode* @validate_node(%struct.tnode* %28, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0), i32 183)
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.59, i64 0, i64 0), i32 %13)
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
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.60, i64 0, i64 0), i32 %23, i32 %31)
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
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.61, i64 0, i64 0))
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
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  br label %53

53:                                               ; preds = %51, %46, %22
  br label %54

54:                                               ; preds = %53
  %55 = load i32, i32* %8, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, i32* %8, align 4
  br label %16

57:                                               ; preds = %16
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
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
  %7 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %6, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__._get_wrap_creation, i64 0, i64 0), i32 250, i32 1)
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
define void @_print_array_info(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 322, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  store i32 %14, i32* %6, align 4
  %15 = load i32, i32* %6, align 4
  %16 = load %struct.tnode*, %struct.tnode** %3, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 2
  %18 = load %struct.tpool*, %struct.tpool** %17, align 8
  call void @_extract_tnode_from_pool(%struct.tnode* %5, i32 %15, %struct.tpool* %18)
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.23, i64 0, i64 0), i32 %20)
  store i32 0, i32* %7, align 4
  br label %22

22:                                               ; preds = %76, %2
  %23 = load i32, i32* %7, align 4
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp ult i32 %23, %25
  br i1 %26, label %27, label %79

27:                                               ; preds = %22
  store i32 0, i32* %8, align 4
  br label %28

28:                                               ; preds = %34, %27
  %29 = load i32, i32* %8, align 4
  %30 = load i32, i32* %4, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %37

32:                                               ; preds = %28
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.24, i64 0, i64 0))
  br label %34

34:                                               ; preds = %32
  %35 = load i32, i32* %8, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %8, align 4
  br label %28

37:                                               ; preds = %28
  %38 = load i32, i32* %7, align 4
  %39 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %38, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 327, i32 1)
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = trunc i32 %41 to i8
  call void @funk_print_type(i8 zeroext %42)
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  %44 = load i32, i32* %7, align 4
  %45 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %44, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 329, i32 1)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 0
  %47 = load i32, i32* %46, align 8
  %48 = icmp eq i32 %47, 3
  br i1 %48, label %49, label %60

49:                                               ; preds = %37
  %50 = load i32, i32* %7, align 4
  %51 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %50, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 331, i32 1)
  %52 = getelementptr inbounds %struct.tdata, %struct.tdata* %51, i32 0, i32 2
  %53 = bitcast %union.data_type* %52 to i32*
  %54 = load i32, i32* %53, align 8
  store i32 %54, i32* %6, align 4
  %55 = load i32, i32* %6, align 4
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  call void @_extract_tnode_from_pool(%struct.tnode* %9, i32 %55, %struct.tpool* %57)
  %58 = load i32, i32* %4, align 4
  %59 = add nsw i32 %58, 1
  call void @_print_array_info(%struct.tnode* %9, i32 %59)
  br label %74

60:                                               ; preds = %37
  %61 = load i32, i32* %7, align 4
  %62 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %61, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 334, i32 1)
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 0
  %64 = load i32, i32* %63, align 8
  %65 = icmp eq i32 %64, 1
  br i1 %65, label %66, label %73

66:                                               ; preds = %60
  %67 = load i32, i32* %7, align 4
  %68 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %67, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._print_array_info, i64 0, i64 0), i32 335, i32 1)
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 2
  %70 = bitcast %union.data_type* %69 to i32*
  %71 = load i32, i32* %70, align 8
  %72 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.26, i64 0, i64 0), i32 %71)
  br label %73

73:                                               ; preds = %66, %60
  br label %74

74:                                               ; preds = %73, %49
  %75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  br label %76

76:                                               ; preds = %74
  %77 = load i32, i32* %7, align 4
  %78 = add i32 %77, 1
  store i32 %78, i32* %7, align 4
  br label %22

79:                                               ; preds = %22
  ret void
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
define void @_funk_print_node_info(%struct.tnode* byval(%struct.tnode) align 8) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.27, i64 0, i64 0))
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.28, i64 0, i64 0), i32 %8)
  %10 = load %struct.tnode*, %struct.tnode** %2, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %12 = load %struct.tpool*, %struct.tpool** %11, align 8
  %13 = icmp eq %struct.tpool* %12, @funk_global_memory_pool
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %16 = load %struct.tnode*, %struct.tnode** %2, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = load %struct.tnode*, %struct.tnode** %2, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load %struct.tnode*, %struct.tnode** %2, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = add i32 %21, %24
  %26 = urem i32 %25, 250000
  %27 = load %struct.tnode*, %struct.tnode** %2, align 8
  %28 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %27)
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.29, i64 0, i64 0), i8* %15, i32 %18, i32 %26, i32 %28)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.30, i64 0, i64 0))
  store i32 0, i32* %3, align 4
  br label %31

31:                                               ; preds = %44, %1
  %32 = load i32, i32* %3, align 4
  %33 = load %struct.tnode*, %struct.tnode** %2, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = icmp ult i32 %32, %35
  br i1 %36, label %37, label %47

37:                                               ; preds = %31
  %38 = load %struct.tnode*, %struct.tnode** %2, align 8
  %39 = load i32, i32* %3, align 4
  %40 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 %39, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 352, i32 1)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.31, i64 0, i64 0), i32 %42)
  br label %44

44:                                               ; preds = %37
  %45 = load i32, i32* %3, align 4
  %46 = add i32 %45, 1
  store i32 %46, i32* %3, align 4
  br label %31

47:                                               ; preds = %31
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16, i64 0, i64 0))
  store i32 0, i32* %4, align 4
  br label %49

49:                                               ; preds = %63, %47
  %50 = load i32, i32* %4, align 4
  %51 = load %struct.tnode*, %struct.tnode** %2, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = icmp ult i32 %50, %53
  br i1 %54, label %55, label %66

55:                                               ; preds = %49
  %56 = load %struct.tnode*, %struct.tnode** %2, align 8
  %57 = load i32, i32* %4, align 4
  %58 = call %struct.tdata* @get_node(%struct.tnode* %56, i32 %57, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 357, i32 1)
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 1
  %60 = load i8, i8* %59, align 4
  %61 = zext i8 %60 to i32
  %62 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.31, i64 0, i64 0), i32 %61)
  br label %63

63:                                               ; preds = %55
  %64 = load i32, i32* %4, align 4
  %65 = add i32 %64, 1
  store i32 %65, i32* %4, align 4
  br label %49

66:                                               ; preds = %49
  %67 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  %68 = load %struct.tnode*, %struct.tnode** %2, align 8
  %69 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 361, i32 1)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %70 to i32*
  %72 = load i32, i32* %71, align 8
  %73 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.32, i64 0, i64 0), i32 %72)
  %74 = load %struct.tnode*, %struct.tnode** %2, align 8
  %75 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 362, i32 1)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 2
  %77 = bitcast %union.data_type* %76 to double*
  %78 = load double, double* %77, align 8
  %79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.33, i64 0, i64 0), double %78)
  %80 = load %struct.tnode*, %struct.tnode** %2, align 8
  %81 = call %struct.tdata* @get_node(%struct.tnode* %80, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 363, i32 1)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i32, i32* %82, align 8
  %84 = trunc i32 %83 to i8
  call void @funk_print_type(i8 zeroext %84)
  %85 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  %86 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 2), align 4
  %87 = zext i8 %86 to i32
  %88 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.34, i64 0, i64 0), i32 %85, i32 %87)
  %89 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  %90 = load i8, i8* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 2), align 4
  %91 = zext i8 %90 to i32
  %92 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.35, i64 0, i64 0), i32 %89, i32 %91)
  %93 = load %struct.tnode*, %struct.tnode** %2, align 8
  %94 = call %struct.tdata* @get_node(%struct.tnode* %93, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_print_node_info, i64 0, i64 0), i32 370, i32 1)
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 0
  %96 = load i32, i32* %95, align 8
  %97 = icmp eq i32 %96, 3
  br i1 %97, label %98, label %100

98:                                               ; preds = %66
  %99 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @_print_array_info(%struct.tnode* %99, i32 0)
  br label %100

100:                                              ; preds = %98, %66
  %101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.27, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @_funk_print_node_info(%struct.tnode* byval(%struct.tnode) align 8 %3)
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
  call void @funk_increment_pool_tail(%struct.tpool* %37, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__._funk_alloc_raw_tdata, i64 0, i64 0), i32 391)
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
  %75 = call %struct.tdata* @get_node(%struct.tnode* %73, i32 %74, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 425, i32 0)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 0
  store i32 %72, i32* %76, align 8
  %77 = load %struct.tnode*, %struct.tnode** %7, align 8
  %78 = load i32, i32* %15, align 4
  %79 = load %struct.tpool*, %struct.tpool** %14, align 8
  %80 = getelementptr inbounds %struct.tpool, %struct.tpool* %79, i32 0, i32 2
  %81 = load i8, i8* %80, align 4
  call void @_set_wrap_creation(%struct.tnode* %77, i32 %78, i8 zeroext %81)
  %82 = load %struct.tpool*, %struct.tpool** %14, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %82, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 428)
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
  %97 = call %struct.tdata* @get_node(%struct.tnode* %95, i32 %96, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 435, i32 1)
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
  %109 = call %struct.tdata* @get_node(%struct.tnode* %107, i32 %108, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 439, i32 1)
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 2
  %111 = bitcast %union.data_type* %110 to double*
  store double %106, double* %111, align 8
  br label %124

112:                                              ; preds = %86
  %113 = load %struct.tnode*, %struct.tnode** %7, align 8
  %114 = load i32, i32* %15, align 4
  %115 = call %struct.tdata* @get_node(%struct.tnode* %113, i32 %114, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 443, i32 1)
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 2
  %117 = bitcast %union.data_type* %116 to i32*
  store i32 0, i32* %117, align 8
  %118 = load %struct.tnode*, %struct.tnode** %7, align 8
  %119 = load i32, i32* %15, align 4
  %120 = call %struct.tdata* @get_node(%struct.tnode* %118, i32 %119, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 444, i32 1)
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
  call void @funk_increment_pool_tail(%struct.tpool* %146, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 455)
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 466, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp eq i32 %14, 7
  br i1 %15, label %22, label %16

16:                                               ; preds = %2
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 466, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 3
  br i1 %21, label %22, label %29

22:                                               ; preds = %16, %2
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 2
  %25 = load %struct.tpool*, %struct.tpool** %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  call void @_dereference(%struct.tnode* %6, %struct.tpool* %25, i32 %28, i32 0, i32 10, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 468)
  store %struct.tnode* %6, %struct.tnode** %5, align 8
  br label %29

29:                                               ; preds = %22, %16
  %30 = load %struct.tnode*, %struct.tnode** %4, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 471, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = icmp eq i32 %33, 7
  br i1 %34, label %41, label %35

35:                                               ; preds = %29
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = call %struct.tdata* @get_node(%struct.tnode* %36, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 471, i32 1)
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  %39 = load i32, i32* %38, align 8
  %40 = icmp eq i32 %39, 3
  br i1 %40, label %41, label %45

41:                                               ; preds = %35, %29
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 4
  br label %46

45:                                               ; preds = %35
  br label %46

46:                                               ; preds = %45, %41
  %47 = phi i32 [ %44, %41 ], [ 1, %45 ]
  store i32 %47, i32* %7, align 4
  %48 = load %struct.tnode*, %struct.tnode** %3, align 8
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = load i32, i32* %50, align 4
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 2
  %54 = load %struct.tpool*, %struct.tpool** %53, align 8
  %55 = call i32 @get_pool_enum(%struct.tpool* %54)
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %56)
  %58 = trunc i32 %57 to i8
  call void @funk_create_node(%struct.tnode* %48, i32 %51, i32 %55, i32 1, i8 zeroext %58, i8* null)
  %59 = load %struct.tnode*, %struct.tnode** %4, align 8
  %60 = call %struct.tdata* @get_node(%struct.tnode* %59, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 476, i32 1)
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = icmp eq i32 %62, 7
  br i1 %63, label %70, label %64

64:                                               ; preds = %46
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = call %struct.tdata* @get_node(%struct.tnode* %65, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 476, i32 1)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  %68 = load i32, i32* %67, align 8
  %69 = icmp eq i32 %68, 3
  br i1 %69, label %70, label %84

70:                                               ; preds = %64, %46
  %71 = load %struct.tnode*, %struct.tnode** %4, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 1
  %73 = load i32, i32* %72, align 4
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %75 = load i32, i32* %74, align 4
  %76 = icmp ne i32 %73, %75
  br i1 %76, label %77, label %84

77:                                               ; preds = %70
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 1
  %80 = load i32, i32* %79, align 4
  %81 = icmp ne i32 %80, 1
  br i1 %81, label %82, label %84

82:                                               ; preds = %77
  %83 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 476, i8* getelementptr inbounds ([79 x i8], [79 x i8]* @.str.37, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

84:                                               ; preds = %77, %70, %64
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %86 = load i32, i32* %85, align 4
  %87 = load %struct.tnode*, %struct.tnode** %4, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = load i32, i32* %88, align 4
  %90 = icmp eq i32 %86, %89
  br i1 %90, label %91, label %120

91:                                               ; preds = %84
  store i32 0, i32* %8, align 4
  br label %92

92:                                               ; preds = %116, %91
  %93 = load i32, i32* %8, align 4
  %94 = load i32, i32* %7, align 4
  %95 = icmp ult i32 %93, %94
  br i1 %95, label %96, label %119

96:                                               ; preds = %92
  %97 = load %struct.tnode*, %struct.tnode** %3, align 8
  %98 = load i32, i32* %8, align 4
  %99 = call %struct.tdata* @get_node(%struct.tnode* %97, i32 %98, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 480, i32 1)
  %100 = getelementptr inbounds %struct.tdata, %struct.tdata* %99, i32 0, i32 2
  %101 = load %struct.tnode*, %struct.tnode** %5, align 8
  %102 = load i32, i32* %8, align 4
  %103 = call %struct.tdata* @get_node(%struct.tnode* %101, i32 %102, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 480, i32 1)
  %104 = getelementptr inbounds %struct.tdata, %struct.tdata* %103, i32 0, i32 2
  %105 = bitcast %union.data_type* %100 to i8*
  %106 = bitcast %union.data_type* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %105, i8* align 8 %106, i64 8, i1 false)
  %107 = load %struct.tnode*, %struct.tnode** %5, align 8
  %108 = load i32, i32* %8, align 4
  %109 = call %struct.tdata* @get_node(%struct.tnode* %107, i32 %108, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 481, i32 1)
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 0
  %111 = load i32, i32* %110, align 8
  %112 = load %struct.tnode*, %struct.tnode** %3, align 8
  %113 = load i32, i32* %8, align 4
  %114 = call %struct.tdata* @get_node(%struct.tnode* %112, i32 %113, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 481, i32 1)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 0
  store i32 %111, i32* %115, align 8
  br label %116

116:                                              ; preds = %96
  %117 = load i32, i32* %8, align 4
  %118 = add i32 %117, 1
  store i32 %118, i32* %8, align 4
  br label %92

119:                                              ; preds = %92
  br label %135

120:                                              ; preds = %84
  %121 = load %struct.tnode*, %struct.tnode** %3, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 1
  %123 = load i32, i32* %122, align 4
  %124 = icmp eq i32 %123, 1
  br i1 %124, label %125, label %134

125:                                              ; preds = %120
  %126 = load %struct.tnode*, %struct.tnode** %3, align 8
  %127 = call %struct.tdata* @get_node(%struct.tnode* %126, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 484, i32 0)
  %128 = getelementptr inbounds %struct.tdata, %struct.tdata* %127, i32 0, i32 0
  store i32 7, i32* %128, align 8
  %129 = call i32 @_copy_node_to_pool(%struct.tnode* %6)
  %130 = load %struct.tnode*, %struct.tnode** %3, align 8
  %131 = call %struct.tdata* @get_node(%struct.tnode* %130, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 485, i32 0)
  %132 = getelementptr inbounds %struct.tdata, %struct.tdata* %131, i32 0, i32 2
  %133 = bitcast %union.data_type* %132 to i32*
  store i32 %129, i32* %133, align 8
  br label %134

134:                                              ; preds = %125, %120
  br label %135

135:                                              ; preds = %134, %119
  %136 = load i32, i32* %7, align 4
  %137 = icmp eq i32 %136, 1
  br i1 %137, label %138, label %143

138:                                              ; preds = %135
  %139 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @_funk_set_node_dimension_count(%struct.tnode* %139, i32 0)
  %140 = load %struct.tnode*, %struct.tnode** %3, align 8
  %141 = getelementptr inbounds %struct.tnode, %struct.tnode* %140, i32 0, i32 3
  %142 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %141, i32 0, i32 1
  store i32 0, i32* %142, align 4
  br label %158

143:                                              ; preds = %135
  store i32 0, i32* %9, align 4
  br label %144

144:                                              ; preds = %155, %143
  %145 = load i32, i32* %9, align 4
  %146 = load %struct.tnode*, %struct.tnode** %5, align 8
  %147 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %146)
  %148 = icmp ult i32 %145, %147
  br i1 %148, label %149, label %158

149:                                              ; preds = %144
  %150 = load %struct.tnode*, %struct.tnode** %3, align 8
  %151 = load i32, i32* %9, align 4
  %152 = load %struct.tnode*, %struct.tnode** %5, align 8
  %153 = load i32, i32* %9, align 4
  %154 = call i32 @_funk_get_node_dimension(%struct.tnode* %152, i32 %153)
  call void @_funk_set_node_dimension(%struct.tnode* %150, i32 %151, i32 %154, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_deep_copy_node, i64 0, i64 0), i32 494)
  br label %155

155:                                              ; preds = %149
  %156 = load i32, i32* %9, align 4
  %157 = add i32 %156, 1
  store i32 %157, i32* %9, align 4
  br label %144

158:                                              ; preds = %138, %144
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
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.48, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__._dereference, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

30:                                               ; preds = %7
  %31 = load i32, i32* %15, align 4
  %32 = icmp eq i32 %31, 7
  br i1 %32, label %36, label %33

33:                                               ; preds = %30
  %34 = load i32, i32* %15, align 4
  %35 = icmp eq i32 %34, 3
  br i1 %35, label %36, label %54

36:                                               ; preds = %33, %30
  %37 = load %struct.tnode*, %struct.tnode** %8, align 8
  %38 = load %struct.tpool*, %struct.tpool** %9, align 8
  %39 = load %struct.tpool*, %struct.tpool** %9, align 8
  %40 = getelementptr inbounds %struct.tpool, %struct.tpool* %39, i32 0, i32 0
  %41 = load i32, i32* %10, align 4
  %42 = load i32, i32* %11, align 4
  %43 = add i32 %41, %42
  %44 = urem i32 %43, 250000
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %40, i64 0, i64 %45
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 2
  %48 = bitcast %union.data_type* %47 to i32*
  %49 = load i32, i32* %48, align 8
  %50 = load i32, i32* %12, align 4
  %51 = sub nsw i32 %50, 1
  %52 = load i8*, i8** %13, align 8
  %53 = load i32, i32* %14, align 4
  call void @_dereference(%struct.tnode* %37, %struct.tpool* %38, i32 %49, i32 0, i32 %51, i8* %52, i32 %53)
  br label %129

54:                                               ; preds = %33
  %55 = load i32, i32* %15, align 4
  %56 = icmp eq i32 %55, 8
  br i1 %56, label %57, label %119

57:                                               ; preds = %54
  %58 = load %struct.tpool*, %struct.tpool** %9, align 8
  %59 = load %struct.tnode*, %struct.tnode** %8, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 2
  store %struct.tpool* %58, %struct.tpool** %60, align 8
  %61 = load %struct.tpool*, %struct.tpool** %9, align 8
  %62 = getelementptr inbounds %struct.tpool, %struct.tpool* %61, i32 0, i32 0
  %63 = load i32, i32* %10, align 4
  %64 = load i32, i32* %11, align 4
  %65 = add i32 %63, %64
  %66 = add i32 %65, 0
  %67 = urem i32 %66, 250000
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %62, i64 0, i64 %68
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %70 to i32*
  %72 = load i32, i32* %71, align 8
  %73 = load %struct.tnode*, %struct.tnode** %8, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 0
  store i32 %72, i32* %74, align 8
  %75 = load %struct.tpool*, %struct.tpool** %9, align 8
  %76 = getelementptr inbounds %struct.tpool, %struct.tpool* %75, i32 0, i32 0
  %77 = load i32, i32* %10, align 4
  %78 = load i32, i32* %11, align 4
  %79 = add i32 %77, %78
  %80 = add i32 %79, 1
  %81 = urem i32 %80, 250000
  %82 = zext i32 %81 to i64
  %83 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %76, i64 0, i64 %82
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %83, i32 0, i32 2
  %85 = bitcast %union.data_type* %84 to i32*
  %86 = load i32, i32* %85, align 8
  %87 = load %struct.tnode*, %struct.tnode** %8, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  store i32 %86, i32* %88, align 4
  %89 = load %struct.tpool*, %struct.tpool** %9, align 8
  %90 = getelementptr inbounds %struct.tpool, %struct.tpool* %89, i32 0, i32 0
  %91 = load i32, i32* %10, align 4
  %92 = load i32, i32* %11, align 4
  %93 = add i32 %91, %92
  %94 = add i32 %93, 2
  %95 = urem i32 %94, 250000
  %96 = zext i32 %95 to i64
  %97 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %90, i64 0, i64 %96
  %98 = getelementptr inbounds %struct.tdata, %struct.tdata* %97, i32 0, i32 2
  %99 = bitcast %union.data_type* %98 to i32*
  %100 = load i32, i32* %99, align 8
  %101 = load %struct.tnode*, %struct.tnode** %8, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 3
  %103 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %102, i32 0, i32 0
  store i32 %100, i32* %103, align 8
  %104 = load %struct.tpool*, %struct.tpool** %9, align 8
  %105 = getelementptr inbounds %struct.tpool, %struct.tpool* %104, i32 0, i32 0
  %106 = load i32, i32* %10, align 4
  %107 = load i32, i32* %11, align 4
  %108 = add i32 %106, %107
  %109 = add i32 %108, 3
  %110 = urem i32 %109, 250000
  %111 = zext i32 %110 to i64
  %112 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %105, i64 0, i64 %111
  %113 = getelementptr inbounds %struct.tdata, %struct.tdata* %112, i32 0, i32 2
  %114 = bitcast %union.data_type* %113 to i32*
  %115 = load i32, i32* %114, align 8
  %116 = load %struct.tnode*, %struct.tnode** %8, align 8
  %117 = getelementptr inbounds %struct.tnode, %struct.tnode* %116, i32 0, i32 3
  %118 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %117, i32 0, i32 1
  store i32 %115, i32* %118, align 4
  br label %128

119:                                              ; preds = %54
  %120 = load i32, i32* %15, align 4
  %121 = load i8*, i8** %13, align 8
  %122 = load i32, i32* %14, align 4
  %123 = load %struct.tpool*, %struct.tpool** %9, align 8
  %124 = icmp eq %struct.tpool* %123, @funk_global_memory_pool
  %125 = zext i1 %124 to i64
  %126 = select i1 %124, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.13, i64 0, i64 0)
  %127 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.49, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__._dereference, i64 0, i64 0), i32 %120, i8* %121, i32 %122, i8* %126)
  call void @exit(i32 1) #6
  unreachable

128:                                              ; preds = %57
  br label %129

129:                                              ; preds = %128, %36
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #3

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
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.38, i64 0, i64 0))
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
  %12 = alloca %struct.tnode, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32*, align 8
  %15 = alloca i32, align 4
  %16 = alloca %struct.tnode, align 8
  %17 = alloca i32, align 4
  %18 = alloca %struct.tnode, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.tnode, align 8
  %22 = alloca i32, align 4
  %23 = alloca %struct.tnode, align 8
  %24 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %25 = load %struct.tnode*, %struct.tnode** %6, align 8
  %26 = icmp ne %struct.tnode* %25, null
  br i1 %26, label %29, label %27

27:                                               ; preds = %4
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 526, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.39, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

29:                                               ; preds = %4
  %30 = load %struct.tnode*, %struct.tnode** %7, align 8
  %31 = icmp ne %struct.tnode* %30, null
  br i1 %31, label %34, label %32

32:                                               ; preds = %29
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 527, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.40, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

34:                                               ; preds = %29
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 528, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = icmp eq i32 %38, 7
  br i1 %39, label %48, label %40

40:                                               ; preds = %34
  %41 = load %struct.tnode*, %struct.tnode** %6, align 8
  %42 = call %struct.tdata* @get_node(%struct.tnode* %41, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 528, i32 1)
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 8
  %45 = icmp eq i32 %44, 3
  br i1 %45, label %48, label %46

46:                                               ; preds = %40
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 528, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.41, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

48:                                               ; preds = %40, %34
  %49 = load i32, i32* %8, align 4
  %50 = icmp ne i32 %49, 2
  br i1 %50, label %51, label %53

51:                                               ; preds = %48
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 529, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.42, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

53:                                               ; preds = %48
  %54 = load %struct.tnode*, %struct.tnode** %7, align 8
  %55 = call %struct.tdata* @get_node(%struct.tnode* %54, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 531, i32 1)
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 2
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  store i32 %58, i32* %9, align 4
  %59 = load %struct.tnode*, %struct.tnode** %7, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i64 1
  %61 = call %struct.tdata* @get_node(%struct.tnode* %60, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 532, i32 1)
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 2
  %63 = bitcast %union.data_type* %62 to i32*
  %64 = load i32, i32* %63, align 8
  store i32 %64, i32* %10, align 4
  %65 = load %struct.tnode*, %struct.tnode** %6, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = load i32, i32* %66, align 4
  store i32 %67, i32* %11, align 4
  %68 = load %struct.tnode*, %struct.tnode** %6, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 2
  %70 = load %struct.tpool*, %struct.tpool** %69, align 8
  %71 = load %struct.tnode*, %struct.tnode** %6, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  call void @_dereference(%struct.tnode* %12, %struct.tpool* %70, i32 %73, i32 0, i32 10, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 537)
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %75 = load i32, i32* %74, align 4
  store i32 %75, i32* %13, align 4
  %76 = load i32, i32* %11, align 4
  %77 = load i32, i32* %13, align 4
  %78 = mul nsw i32 %76, %77
  %79 = sext i32 %78 to i64
  %80 = mul i64 %79, 4
  %81 = call i8* @malloc(i64 %80) #7
  %82 = bitcast i8* %81 to i32*
  store i32* %82, i32** %14, align 8
  store i32 0, i32* %15, align 4
  br label %83

83:                                               ; preds = %152, %53
  %84 = load i32, i32* %15, align 4
  %85 = load i32, i32* %11, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %155

87:                                               ; preds = %83
  %88 = load %struct.tnode*, %struct.tnode** %6, align 8
  %89 = load i32, i32* %15, align 4
  call void @funk_get_element_in_array(%struct.tnode* %88, %struct.tnode* %16, i32 %89)
  store i32 0, i32* %17, align 4
  br label %90

90:                                               ; preds = %148, %87
  %91 = load i32, i32* %17, align 4
  %92 = load i32, i32* %13, align 4
  %93 = icmp slt i32 %91, %92
  br i1 %93, label %94, label %151

94:                                               ; preds = %90
  %95 = load %struct.tnode*, %struct.tnode** %6, align 8
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = load %struct.tnode*, %struct.tnode** %6, align 8
  %99 = getelementptr inbounds %struct.tnode, %struct.tnode* %98, i32 0, i32 2
  %100 = load %struct.tpool*, %struct.tpool** %99, align 8
  %101 = call i32 @get_pool_enum(%struct.tpool* %100)
  call void @funk_create_node(%struct.tnode* %18, i32 %97, i32 %101, i32 7, i8 zeroext 0, i8* null)
  %102 = load i32, i32* %15, align 4
  %103 = load i32, i32* %9, align 4
  %104 = add nsw i32 %102, %103
  %105 = load i32, i32* %11, align 4
  %106 = srem i32 %104, %105
  store i32 %106, i32* %19, align 4
  %107 = load i32, i32* %17, align 4
  %108 = load i32, i32* %10, align 4
  %109 = add nsw i32 %107, %108
  %110 = load i32, i32* %13, align 4
  %111 = srem i32 %109, %110
  store i32 %111, i32* %20, align 4
  %112 = load i32, i32* %19, align 4
  %113 = icmp slt i32 %112, 0
  br i1 %113, label %114, label %118

114:                                              ; preds = %94
  %115 = load i32, i32* %11, align 4
  %116 = load i32, i32* %19, align 4
  %117 = add nsw i32 %115, %116
  br label %120

118:                                              ; preds = %94
  %119 = load i32, i32* %19, align 4
  br label %120

120:                                              ; preds = %118, %114
  %121 = phi i32 [ %117, %114 ], [ %119, %118 ]
  store i32 %121, i32* %19, align 4
  %122 = load i32, i32* %20, align 4
  %123 = icmp slt i32 %122, 0
  br i1 %123, label %124, label %128

124:                                              ; preds = %120
  %125 = load i32, i32* %13, align 4
  %126 = load i32, i32* %20, align 4
  %127 = add nsw i32 %125, %126
  br label %130

128:                                              ; preds = %120
  %129 = load i32, i32* %20, align 4
  br label %130

130:                                              ; preds = %128, %124
  %131 = phi i32 [ %127, %124 ], [ %129, %128 ]
  store i32 %131, i32* %20, align 4
  %132 = load %struct.tnode*, %struct.tnode** %6, align 8
  %133 = load i32, i32* %15, align 4
  %134 = load i32, i32* %17, align 4
  call void @funk_get_element_in_matrix_2d_lit(%struct.tnode* %132, %struct.tnode* %21, i32 %133, i32 %134)
  %135 = call %struct.tdata* @get_node(%struct.tnode* %21, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 557, i32 1)
  %136 = getelementptr inbounds %struct.tdata, %struct.tdata* %135, i32 0, i32 2
  %137 = bitcast %union.data_type* %136 to i32*
  %138 = load i32, i32* %137, align 8
  %139 = load i32*, i32** %14, align 8
  %140 = load i32, i32* %19, align 4
  %141 = load i32, i32* %13, align 4
  %142 = mul nsw i32 %140, %141
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds i32, i32* %139, i64 %143
  %145 = load i32, i32* %20, align 4
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds i32, i32* %144, i64 %146
  store i32 %138, i32* %147, align 4
  br label %148

148:                                              ; preds = %130
  %149 = load i32, i32* %17, align 4
  %150 = add nsw i32 %149, 1
  store i32 %150, i32* %17, align 4
  br label %90

151:                                              ; preds = %90
  br label %152

152:                                              ; preds = %151
  %153 = load i32, i32* %15, align 4
  %154 = add nsw i32 %153, 1
  store i32 %154, i32* %15, align 4
  br label %83

155:                                              ; preds = %83
  %156 = load %struct.tnode*, %struct.tnode** %5, align 8
  %157 = load i32, i32* %11, align 4
  %158 = load %struct.tnode*, %struct.tnode** %6, align 8
  %159 = getelementptr inbounds %struct.tnode, %struct.tnode* %158, i32 0, i32 2
  %160 = load %struct.tpool*, %struct.tpool** %159, align 8
  %161 = call i32 @get_pool_enum(%struct.tpool* %160)
  call void @funk_create_node(%struct.tnode* %156, i32 %157, i32 %161, i32 7, i8 zeroext 0, i8* null)
  store i32 0, i32* %22, align 4
  br label %162

162:                                              ; preds = %205, %155
  %163 = load i32, i32* %22, align 4
  %164 = load i32, i32* %11, align 4
  %165 = icmp slt i32 %163, %164
  br i1 %165, label %166, label %208

166:                                              ; preds = %162
  %167 = load i32, i32* %13, align 4
  %168 = load %struct.tnode*, %struct.tnode** %6, align 8
  %169 = getelementptr inbounds %struct.tnode, %struct.tnode* %168, i32 0, i32 2
  %170 = load %struct.tpool*, %struct.tpool** %169, align 8
  %171 = call i32 @get_pool_enum(%struct.tpool* %170)
  call void @funk_create_node(%struct.tnode* %23, i32 %167, i32 %171, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %24, align 4
  br label %172

172:                                              ; preds = %191, %166
  %173 = load i32, i32* %24, align 4
  %174 = load i32, i32* %13, align 4
  %175 = icmp slt i32 %173, %174
  br i1 %175, label %176, label %194

176:                                              ; preds = %172
  %177 = load i32*, i32** %14, align 8
  %178 = load i32, i32* %22, align 4
  %179 = load i32, i32* %13, align 4
  %180 = mul nsw i32 %178, %179
  %181 = sext i32 %180 to i64
  %182 = getelementptr inbounds i32, i32* %177, i64 %181
  %183 = load i32, i32* %24, align 4
  %184 = sext i32 %183 to i64
  %185 = getelementptr inbounds i32, i32* %182, i64 %184
  %186 = load i32, i32* %185, align 4
  %187 = load i32, i32* %24, align 4
  %188 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 %187, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 572, i32 1)
  %189 = getelementptr inbounds %struct.tdata, %struct.tdata* %188, i32 0, i32 2
  %190 = bitcast %union.data_type* %189 to i32*
  store i32 %186, i32* %190, align 8
  br label %191

191:                                              ; preds = %176
  %192 = load i32, i32* %24, align 4
  %193 = add nsw i32 %192, 1
  store i32 %193, i32* %24, align 4
  br label %172

194:                                              ; preds = %172
  %195 = load %struct.tnode*, %struct.tnode** %5, align 8
  %196 = load i32, i32* %22, align 4
  %197 = call %struct.tdata* @get_node(%struct.tnode* %195, i32 %196, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 574, i32 0)
  %198 = getelementptr inbounds %struct.tdata, %struct.tdata* %197, i32 0, i32 0
  store i32 7, i32* %198, align 8
  %199 = call i32 @_copy_node_to_pool(%struct.tnode* %23)
  %200 = load %struct.tnode*, %struct.tnode** %5, align 8
  %201 = load i32, i32* %22, align 4
  %202 = call %struct.tdata* @get_node(%struct.tnode* %200, i32 %201, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_roll, i64 0, i64 0), i32 575, i32 0)
  %203 = getelementptr inbounds %struct.tdata, %struct.tdata* %202, i32 0, i32 2
  %204 = bitcast %union.data_type* %203 to i32*
  store i32 %199, i32* %204, align 8
  br label %205

205:                                              ; preds = %194
  %206 = load i32, i32* %22, align 4
  %207 = add nsw i32 %206, 1
  store i32 %207, i32* %22, align 4
  br label %162

208:                                              ; preds = %162
  %209 = load i32*, i32** %14, align 8
  %210 = bitcast i32* %209 to i8*
  call void @free(i8* %210)
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #4

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_array(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 799)
  %12 = load i32, i32* %6, align 4
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %20

14:                                               ; preds = %3
  %15 = load %struct.tnode*, %struct.tnode** %4, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* %6, align 4
  %19 = add i32 %17, %18
  br label %22

20:                                               ; preds = %3
  %21 = load i32, i32* %6, align 4
  br label %22

22:                                               ; preds = %20, %14
  %23 = phi i32 [ %19, %14 ], [ %21, %20 ]
  store i32 %23, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = load i32, i32* %6, align 4
  %28 = urem i32 %27, %26
  store i32 %28, i32* %6, align 4
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 806, i32 1)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = icmp eq i32 %32, 3
  br i1 %33, label %34, label %63

34:                                               ; preds = %22
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 808, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 2
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %8, align 4
  %40 = load i32, i32* %8, align 4
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 2
  %43 = load %struct.tpool*, %struct.tpool** %42, align 8
  call void @_extract_tnode_from_pool(%struct.tnode* %7, i32 %40, %struct.tpool* %43)
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = load i32, i32* %6, align 4
  %47 = add i32 %45, %46
  %48 = load %struct.tnode*, %struct.tnode** %5, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  store i32 %47, i32* %49, align 8
  %50 = load %struct.tnode*, %struct.tnode** %5, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 1
  store i32 1, i32* %51, align 4
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 2
  %54 = load %struct.tpool*, %struct.tpool** %53, align 8
  %55 = load %struct.tnode*, %struct.tnode** %5, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  store %struct.tpool* %54, %struct.tpool** %56, align 8
  %57 = load %struct.tnode*, %struct.tnode** %5, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 3
  %59 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %58, i32 0, i32 1
  store i32 0, i32* %59, align 4
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 3
  %62 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %61, i32 0, i32 0
  store i32 0, i32* %62, align 8
  br label %102

63:                                               ; preds = %22
  %64 = load %struct.tnode*, %struct.tnode** %4, align 8
  %65 = load i32, i32* %6, align 4
  %66 = call %struct.tdata* @get_node(%struct.tnode* %64, i32 %65, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 822, i32 1)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  %68 = load i32, i32* %67, align 8
  %69 = icmp eq i32 %68, 7
  br i1 %69, label %84, label %70

70:                                               ; preds = %63
  %71 = load %struct.tnode*, %struct.tnode** %4, align 8
  %72 = load i32, i32* %6, align 4
  %73 = call %struct.tdata* @get_node(%struct.tnode* %71, i32 %72, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 822, i32 1)
  %74 = getelementptr inbounds %struct.tdata, %struct.tdata* %73, i32 0, i32 0
  %75 = load i32, i32* %74, align 8
  %76 = icmp eq i32 %75, 3
  br i1 %76, label %84, label %77

77:                                               ; preds = %70
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = load i32, i32* %6, align 4
  %80 = call %struct.tdata* @get_node(%struct.tnode* %78, i32 %79, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 822, i32 1)
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 0
  %82 = load i32, i32* %81, align 8
  %83 = icmp eq i32 %82, 8
  br i1 %83, label %84, label %93

84:                                               ; preds = %77, %70, %63
  %85 = load %struct.tnode*, %struct.tnode** %5, align 8
  %86 = load %struct.tnode*, %struct.tnode** %4, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 2
  %88 = load %struct.tpool*, %struct.tpool** %87, align 8
  %89 = load %struct.tnode*, %struct.tnode** %4, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 0
  %91 = load i32, i32* %90, align 8
  %92 = load i32, i32* %6, align 4
  call void @_dereference(%struct.tnode* %85, %struct.tpool* %88, i32 %91, i32 %92, i32 10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_get_element_in_array, i64 0, i64 0), i32 825)
  br label %102

93:                                               ; preds = %77
  %94 = load %struct.tnode*, %struct.tnode** %5, align 8
  %95 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_copy_node(%struct.tnode* %94, %struct.tnode* %95)
  %96 = load %struct.tnode*, %struct.tnode** %5, align 8
  %97 = getelementptr inbounds %struct.tnode, %struct.tnode* %96, i32 0, i32 3
  %98 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %97, i32 0, i32 1
  store i32 0, i32* %98, align 4
  %99 = load %struct.tnode*, %struct.tnode** %5, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 3
  %101 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %100, i32 0, i32 0
  store i32 0, i32* %101, align 8
  br label %102

102:                                              ; preds = %34, %93, %84
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 713, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp eq i32 %14, 7
  br i1 %15, label %22, label %16

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 713, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 3
  br i1 %21, label %22, label %27

22:                                               ; preds = %16, %4
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = load i32, i32* %7, align 4
  %26 = load i32, i32* %8, align 4
  call void @funk_get_element_in_matrix_ptr(%struct.tnode* %23, %struct.tnode* %24, i32 %25, i32 %26)
  br label %82

27:                                               ; preds = %16
  %28 = load %struct.tnode*, %struct.tnode** %5, align 8
  %29 = call i32 @_funk_get_node_dimension(%struct.tnode* %28, i32 0)
  store i32 %29, i32* %9, align 4
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = call i32 @_funk_get_node_dimension(%struct.tnode* %30, i32 1)
  store i32 %31, i32* %10, align 4
  %32 = load i32, i32* %9, align 4
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %37, label %34

34:                                               ; preds = %27
  %35 = load i32, i32* %10, align 4
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %42

37:                                               ; preds = %34, %27
  %38 = load i32, i32* %9, align 4
  %39 = load i32, i32* %10, align 4
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.46, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 %38, i32 %39)
  %41 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node_info(%struct.tnode* %41)
  call void @exit(i32 1) #6
  unreachable

42:                                               ; preds = %34
  %43 = load i32, i32* %7, align 4
  %44 = icmp slt i32 %43, 0
  br i1 %44, label %45, label %49

45:                                               ; preds = %42
  %46 = load i32, i32* %9, align 4
  %47 = load i32, i32* %7, align 4
  %48 = add i32 %46, %47
  br label %51

49:                                               ; preds = %42
  %50 = load i32, i32* %7, align 4
  br label %51

51:                                               ; preds = %49, %45
  %52 = phi i32 [ %48, %45 ], [ %50, %49 ]
  store i32 %52, i32* %7, align 4
  %53 = load i32, i32* %8, align 4
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %55, label %59

55:                                               ; preds = %51
  %56 = load i32, i32* %10, align 4
  %57 = load i32, i32* %8, align 4
  %58 = add i32 %56, %57
  br label %61

59:                                               ; preds = %51
  %60 = load i32, i32* %8, align 4
  br label %61

61:                                               ; preds = %59, %55
  %62 = phi i32 [ %58, %55 ], [ %60, %59 ]
  store i32 %62, i32* %8, align 4
  %63 = load i32, i32* %9, align 4
  %64 = load i32, i32* %7, align 4
  %65 = urem i32 %64, %63
  store i32 %65, i32* %7, align 4
  %66 = load i32, i32* %10, align 4
  %67 = load i32, i32* %8, align 4
  %68 = urem i32 %67, %66
  store i32 %68, i32* %8, align 4
  %69 = load %struct.tnode*, %struct.tnode** %6, align 8
  %70 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_copy_node(%struct.tnode* %69, %struct.tnode* %70)
  %71 = load i32, i32* %9, align 4
  %72 = load i32, i32* %7, align 4
  %73 = mul i32 %71, %72
  %74 = load i32, i32* %8, align 4
  %75 = add i32 %73, %74
  %76 = load %struct.tnode*, %struct.tnode** %6, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = add i32 %78, %75
  store i32 %79, i32* %77, align 8
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  store i32 1, i32* %81, align 4
  br label %82

82:                                               ; preds = %61, %22
  ret void
}

declare void @free(i8*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_not(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode, align 8
  %7 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %8)
  %9 = load %struct.tnode*, %struct.tnode** %3, align 8
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 2
  %15 = load %struct.tpool*, %struct.tpool** %14, align 8
  %16 = call i32 @get_pool_enum(%struct.tpool* %15)
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 602, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %21)
  %23 = trunc i32 %22 to i8
  call void @funk_create_node(%struct.tnode* %9, i32 %12, i32 %16, i32 %20, i8 zeroext %23, i8* null)
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.43, i64 0, i64 0), i32 604, i32 %26)
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %28)
  store i32 0, i32* %5, align 4
  br label %29

29:                                               ; preds = %59, %2
  %30 = load i32, i32* %5, align 4
  %31 = load %struct.tnode*, %struct.tnode** %4, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = load i32, i32* %32, align 4
  %34 = icmp ult i32 %30, %33
  br i1 %34, label %35, label %62

35:                                               ; preds = %29
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = load i32, i32* %5, align 4
  call void @funk_get_element_in_array(%struct.tnode* %36, %struct.tnode* %6, i32 %37)
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  %40 = icmp ugt i32 %39, 1
  br i1 %40, label %41, label %45

41:                                               ; preds = %35
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %43 = load i32, i32* %42, align 4
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.44, i64 0, i64 0), i32 %43)
  call void @funk_print_node_info(%struct.tnode* %6)
  call void @funk_print_node(%struct.tnode* %6)
  call void @exit(i32 1) #6
  unreachable

45:                                               ; preds = %35
  %46 = call %struct.tdata* @get_node(%struct.tnode* %6, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 625, i32 1)
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 2
  %48 = bitcast %union.data_type* %47 to i32*
  %49 = load i32, i32* %48, align 8
  %50 = icmp eq i32 %49, 0
  %51 = zext i1 %50 to i64
  %52 = select i1 %50, i32 1, i32 0
  %53 = load %struct.tnode*, %struct.tnode** %3, align 8
  %54 = load i32, i32* %5, align 4
  %55 = call %struct.tdata* @get_node(%struct.tnode* %53, i32 %54, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_not, i64 0, i64 0), i32 624, i32 1)
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 2
  %57 = bitcast %union.data_type* %56 to i32*
  store i32 %52, i32* %57, align 8
  br label %58

58:                                               ; preds = %45
  br label %59

59:                                               ; preds = %58
  %60 = load i32, i32* %5, align 4
  %61 = add i32 %60, 1
  store i32 %61, i32* %5, align 4
  br label %29

62:                                               ; preds = %29
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.45, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @__funk_print_node(%struct.tnode* byval(%struct.tnode) align 8 %3)
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

6:                                                ; preds = %47, %1
  %7 = load i32, i32* %4, align 4
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp ult i32 %7, %10
  br i1 %11, label %12, label %50

12:                                               ; preds = %6
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = load i32, i32* %4, align 4
  %15 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %14, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 637, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 7
  br i1 %18, label %26, label %19

19:                                               ; preds = %12
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = load i32, i32* %4, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 637, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = icmp eq i32 %24, 3
  br i1 %25, label %26, label %37

26:                                               ; preds = %19, %12
  %27 = load %struct.tnode*, %struct.tnode** %2, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  %29 = load %struct.tpool*, %struct.tpool** %28, align 8
  %30 = load %struct.tnode*, %struct.tnode** %2, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load i32, i32* %4, align 4
  call void @_dereference(%struct.tnode* %5, %struct.tpool* %29, i32 %32, i32 %33, i32 10, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 639)
  %34 = call i32 @_funk_sum_list(%struct.tnode* %5)
  %35 = load i32, i32* %3, align 4
  %36 = add nsw i32 %35, %34
  store i32 %36, i32* %3, align 4
  br label %46

37:                                               ; preds = %19
  %38 = load %struct.tnode*, %struct.tnode** %2, align 8
  %39 = load i32, i32* %4, align 4
  %40 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 %39, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__._funk_sum_list, i64 0, i64 0), i32 643, i32 1)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 2
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
  %44 = load i32, i32* %3, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, i32* %3, align 4
  br label %46

46:                                               ; preds = %37, %26
  br label %47

47:                                               ; preds = %46
  %48 = load i32, i32* %4, align 4
  %49 = add i32 %48, 1
  store i32 %49, i32* %4, align 4
  br label %6

50:                                               ; preds = %6
  %51 = load i32, i32* %3, align 4
  ret i32 %51
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
  call void @_dereference(%struct.tnode* %9, %struct.tpool* %30, i32 %33, i32 %34, i32 10, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_get_element_in_matrix_ptr, i64 0, i64 0), i32 698)
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
  %51 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 %50, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_get_element_in_matrix_ptr, i64 0, i64 0), i32 705, i32 1)
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 750, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 752, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.47, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %20)
  br label %22

22:                                               ; preds = %16, %4
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 755, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = icmp ne i32 %26, 1
  br i1 %27, label %28, label %34

28:                                               ; preds = %22
  %29 = load %struct.tnode*, %struct.tnode** %8, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 757, i32 1)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.47, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %32)
  br label %34

34:                                               ; preds = %28, %22
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 760, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 2
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %9, align 4
  %40 = load %struct.tnode*, %struct.tnode** %8, align 8
  %41 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 761, i32 1)
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
define void @funk_get_element_in_array_var(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %6, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 839, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %19

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 841, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.47, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 %17)
  br label %19

19:                                               ; preds = %13, %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 844, i32 1)
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
  %14 = call %struct.tnode* @validate_node(%struct.tnode* %13, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 853)
  %15 = load %struct.tnode*, %struct.tnode** %7, align 8
  %16 = call %struct.tnode* @validate_node(%struct.tnode* %15, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 854)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 856, i32 1)
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
  %63 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 870, i32 1)
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
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_create_double_scalar, i64 0, i64 0), i32 879)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_i32_scalar(i32, %struct.tnode*, i32) #0 {
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
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_i32_scalar, i64 0, i64 0), i32 887)
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
define void @funk_create_list_of_regs(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode, align 8
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i64 0
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  %13 = load %struct.tpool*, %struct.tpool** %12, align 8
  %14 = call i32 @get_pool_enum(%struct.tpool* %13)
  store i32 %14, i32* %7, align 4
  %15 = load i32, i32* %6, align 4
  %16 = load i32, i32* %7, align 4
  call void @funk_create_node(%struct.tnode* %8, i32 %15, i32 %16, i32 3, i8 zeroext 0, i8* null)
  store i32 0, i32* %9, align 4
  br label %17

17:                                               ; preds = %74, %3
  %18 = load i32, i32* %9, align 4
  %19 = load i32, i32* %6, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %77

21:                                               ; preds = %17
  %22 = load %struct.tnode*, %struct.tnode** %5, align 8
  %23 = load i32, i32* %9, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i64 %24
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = icmp ugt i32 %27, 1
  br i1 %28, label %38, label %29

29:                                               ; preds = %21
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = load i32, i32* %9, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i64 %32
  %34 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 925, i32 1)
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  %37 = icmp eq i32 %36, 3
  br i1 %37, label %38, label %51

38:                                               ; preds = %29, %21
  %39 = load i32, i32* %9, align 4
  %40 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %39, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 931, i32 0)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  store i32 3, i32* %41, align 8
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = load i32, i32* %9, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i64 %44
  %46 = call i32 @_copy_node_to_pool(%struct.tnode* %45)
  %47 = load i32, i32* %9, align 4
  %48 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %47, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 932, i32 0)
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 2
  %50 = bitcast %union.data_type* %49 to i32*
  store i32 %46, i32* %50, align 8
  br label %73

51:                                               ; preds = %29
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = load i32, i32* %9, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i64 %54
  %56 = call %struct.tdata* @get_node(%struct.tnode* %55, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 936, i32 1)
  %57 = getelementptr inbounds %struct.tdata, %struct.tdata* %56, i32 0, i32 0
  %58 = load i32, i32* %57, align 8
  %59 = load i32, i32* %9, align 4
  %60 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %59, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 936, i32 0)
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 0
  store i32 %58, i32* %61, align 8
  %62 = load i32, i32* %9, align 4
  %63 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %62, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 937, i32 0)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 2
  %65 = load %struct.tnode*, %struct.tnode** %5, align 8
  %66 = load i32, i32* %9, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i64 %67
  %69 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 937, i32 1)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %64 to i8*
  %72 = bitcast %union.data_type* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %71, i8* align 8 %72, i64 8, i1 false)
  br label %73

73:                                               ; preds = %51, %38
  br label %74

74:                                               ; preds = %73
  %75 = load i32, i32* %9, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, i32* %9, align 4
  br label %17

77:                                               ; preds = %17
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %80 = load i32, i32* %79, align 4
  %81 = load i32, i32* %7, align 4
  call void @funk_create_node(%struct.tnode* %78, i32 %80, i32 %81, i32 3, i8 zeroext 0, i8* null)
  %82 = call i32 @_copy_node_to_pool(%struct.tnode* %8)
  %83 = load %struct.tnode*, %struct.tnode** %4, align 8
  %84 = call %struct.tdata* @get_node(%struct.tnode* %83, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 943, i32 0)
  %85 = getelementptr inbounds %struct.tdata, %struct.tdata* %84, i32 0, i32 2
  %86 = bitcast %union.data_type* %85 to i32*
  store i32 %82, i32* %86, align 8
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
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.50, i64 0, i64 0), i32 %12)
  br label %38

14:                                               ; preds = %2
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %16 = bitcast %union.data_type* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.51, i64 0, i64 0), double %17)
  br label %38

19:                                               ; preds = %2
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.52, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.53, i64 0, i64 0))
  br label %38

21:                                               ; preds = %2
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %23 = bitcast %union.data_type* %22 to void (%struct.tnode*, i32, %struct.tnode*)**
  %24 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %23, align 8
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.54, i64 0, i64 0), void (%struct.tnode*, i32, %struct.tnode*)* %24)
  br label %38

26:                                               ; preds = %2
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.55, i64 0, i64 0), i32 %29)
  br label %38

31:                                               ; preds = %2
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %33 = bitcast %union.data_type* %32 to i32*
  %34 = load i32, i32* %33, align 8
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.56, i64 0, i64 0), i32 %34)
  br label %38

36:                                               ; preds = %2
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.52, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.57, i64 0, i64 0))
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11, %3
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 996, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load i32, i32* %6, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %5, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 1009, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  store i32 %19, i32* %23, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_increment_node_data_int(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tdata* @get_node(%struct.tnode* %3, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_increment_node_data_int, i64 0, i64 0), i32 1014, i32 1)
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_copy_node_into_node_list, i64 0, i64 0), i32 1021, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 1034, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 1, i32* %22, align 8
  %23 = load i32, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 1035, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 1049, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 6, i32* %22, align 8
  %23 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 1050, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 1061, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 2, i32* %22, align 8
  %23 = load double, double* %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 1062, i32 1)
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
  br label %16

16:                                               ; preds = %10, %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = load i32, i32* %4, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 1071, i32 1)
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
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i64 0, i64 0), i32 1091)
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
  %7 = load i8*, i8** %4, align 8
  %8 = call i32 (i8*, i64, i32, i64, i8*, ...) @__snprintf_chk(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i64 64, i32 0, i64 64, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21, i64 0, i64 0), i8* %7)
  ret void
}

declare i32 @__snprintf_chk(i8*, i64, i32, i64, i8*, ...) #1

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
  %8 = call %struct.tnode* @validate_node(%struct.tnode* %7, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1181)
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = call %struct.tnode* @validate_node(%struct.tnode* %9, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1182)
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1183)
  %13 = load %struct.tnode*, %struct.tnode** %5, align 8
  %14 = ptrtoint %struct.tnode* %13 to i32
  %15 = call %struct.tpool* @get_pool_ptr(i32 %14)
  %16 = load %struct.tnode*, %struct.tnode** %5, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.62, i64 0, i64 0), %struct.tpool* %15, i32 %18)
  %20 = load %struct.tnode*, %struct.tnode** %5, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1187, i32 1)
  %22 = bitcast %struct.tdata* %21 to { i64, i64 }*
  %23 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 0
  %24 = load i64, i64* %23, align 8
  %25 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 1
  %26 = load i64, i64* %25, align 8
  call void @funk_print_scalar_element(i64 %24, i64 %26)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.63, i64 0, i64 0))
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = ptrtoint %struct.tnode* %28 to i32
  %30 = call %struct.tpool* @get_pool_ptr(i32 %29)
  %31 = load %struct.tnode*, %struct.tnode** %6, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.62, i64 0, i64 0), %struct.tpool* %30, i32 %33)
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1190, i32 1)
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
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.64, i64 0, i64 0), %struct.tpool* %44, i32 %47)
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = call %struct.tdata* @get_node(%struct.tnode* %49, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 1193, i32 1)
  %51 = bitcast %struct.tdata* %50 to { i64, i64 }*
  %52 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %51, i32 0, i32 0
  %53 = load i64, i64* %52, align 8
  %54 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %51, i32 0, i32 1
  %55 = load i64, i64* %54, align 8
  call void @funk_print_scalar_element(i64 %53, i64 %55)
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.65, i64 0, i64 0))
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
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.66, i64 0, i64 0))
  br label %75

7:                                                ; preds = %1
  %8 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %9 = icmp eq void (i8*, i8*, i8*, i32)* %8, @funk_div
  br i1 %9, label %10, label %12

10:                                               ; preds = %7
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.67, i64 0, i64 0))
  br label %74

12:                                               ; preds = %7
  %13 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %14 = icmp eq void (i8*, i8*, i8*, i32)* %13, @funk_add
  br i1 %14, label %15, label %17

15:                                               ; preds = %12
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.68, i64 0, i64 0))
  br label %73

17:                                               ; preds = %12
  %18 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %19 = icmp eq void (i8*, i8*, i8*, i32)* %18, @funk_sub
  br i1 %19, label %20, label %22

20:                                               ; preds = %17
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.69, i64 0, i64 0))
  br label %72

22:                                               ; preds = %17
  %23 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %24 = icmp eq void (i8*, i8*, i8*, i32)* %23, @funk_mod
  br i1 %24, label %25, label %27

25:                                               ; preds = %22
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.70, i64 0, i64 0))
  br label %71

27:                                               ; preds = %22
  %28 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %29 = icmp eq void (i8*, i8*, i8*, i32)* %28, @funk_slt
  br i1 %29, label %30, label %32

30:                                               ; preds = %27
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.71, i64 0, i64 0))
  br label %70

32:                                               ; preds = %27
  %33 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %34 = icmp eq void (i8*, i8*, i8*, i32)* %33, @funk_sgt
  br i1 %34, label %35, label %37

35:                                               ; preds = %32
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.72, i64 0, i64 0))
  br label %69

37:                                               ; preds = %32
  %38 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %39 = icmp eq void (i8*, i8*, i8*, i32)* %38, @funk_sge
  br i1 %39, label %40, label %42

40:                                               ; preds = %37
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.73, i64 0, i64 0))
  br label %68

42:                                               ; preds = %37
  %43 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %44 = icmp eq void (i8*, i8*, i8*, i32)* %43, @funk_eq
  br i1 %44, label %45, label %47

45:                                               ; preds = %42
  %46 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.74, i64 0, i64 0))
  br label %67

47:                                               ; preds = %42
  %48 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %49 = icmp eq void (i8*, i8*, i8*, i32)* %48, @funk_ne
  br i1 %49, label %50, label %52

50:                                               ; preds = %47
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.75, i64 0, i64 0))
  br label %66

52:                                               ; preds = %47
  %53 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %54 = icmp eq void (i8*, i8*, i8*, i32)* %53, @funk_or
  br i1 %54, label %55, label %57

55:                                               ; preds = %52
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.76, i64 0, i64 0))
  br label %65

57:                                               ; preds = %52
  %58 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %2, align 8
  %59 = icmp eq void (i8*, i8*, i8*, i32)* %58, @funk_and
  br i1 %59, label %60, label %62

60:                                               ; preds = %57
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.77, i64 0, i64 0))
  br label %64

62:                                               ; preds = %57
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.78, i64 0, i64 0))
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
  %17 = call %struct.tnode* @validate_node(%struct.tnode* %16, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1369)
  %18 = load %struct.tnode*, %struct.tnode** %9, align 8
  %19 = call %struct.tnode* @validate_node(%struct.tnode* %18, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1370)
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tnode* @validate_node(%struct.tnode* %20, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1371)
  %22 = load %struct.tnode*, %struct.tnode** %8, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1373, i32 1)
  %24 = bitcast %struct.tdata* %11 to i8*
  %25 = bitcast %struct.tdata* %23 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %24, i8* align 8 %25, i64 16, i1 false)
  %26 = load %struct.tnode*, %struct.tnode** %9, align 8
  %27 = call %struct.tdata* @get_node(%struct.tnode* %26, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1374, i32 1)
  %28 = bitcast %struct.tdata* %12 to i8*
  %29 = bitcast %struct.tdata* %27 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %28, i8* align 8 %29, i64 16, i1 false)
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = load i32, i32* %7, align 4
  %32 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 %31, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1375, i32 1)
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
  br label %148

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
  br label %147

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
  br label %146

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
  br label %145

136:                                              ; preds = %118, %114
  %137 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1404, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.79, i64 0, i64 0))
  %138 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.80, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %139 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %10, align 8
  call void @_print_arith_op(void (i8*, i8*, i8*, i32)* %139)
  %140 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  %141 = load i8, i8* %14, align 1
  call void @funk_print_type(i8 zeroext %141)
  %142 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.63, i64 0, i64 0))
  %143 = load i8, i8* %15, align 1
  call void @funk_print_type(i8 zeroext %143)
  %144 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

145:                                              ; preds = %122
  br label %146

146:                                              ; preds = %145, %100
  br label %147

147:                                              ; preds = %146, %78
  br label %148

148:                                              ; preds = %147, %56
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
  br i1 %19, label %20, label %32

20:                                               ; preds = %4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1430, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.81, i64 0, i64 0))
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = load %struct.tnode*, %struct.tnode** %7, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.82, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 %24, i32 %27)
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_print_node(%struct.tnode* %29)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
  %31 = load %struct.tnode*, %struct.tnode** %7, align 8
  call void @funk_print_node(%struct.tnode* %31)
  call void @exit(i32 1) #6
  unreachable

32:                                               ; preds = %4
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = load %struct.tnode*, %struct.tnode** %6, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 2
  %39 = load %struct.tpool*, %struct.tpool** %38, align 8
  %40 = call i32 @get_pool_enum(%struct.tpool* %39)
  call void @funk_create_node(%struct.tnode* %33, i32 %36, i32 %40, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %9, align 4
  br label %41

41:                                               ; preds = %89, %32
  %42 = load i32, i32* %9, align 4
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 1
  %45 = load i32, i32* %44, align 4
  %46 = icmp ult i32 %42, %45
  br i1 %46, label %47, label %92

47:                                               ; preds = %41
  %48 = load %struct.tnode*, %struct.tnode** %6, align 8
  %49 = load i32, i32* %9, align 4
  call void @funk_get_element_in_array(%struct.tnode* %48, %struct.tnode* %10, i32 %49)
  %50 = load %struct.tnode*, %struct.tnode** %7, align 8
  %51 = load i32, i32* %9, align 4
  call void @funk_get_element_in_array(%struct.tnode* %50, %struct.tnode* %11, i32 %51)
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %55 = load i32, i32* %54, align 4
  %56 = icmp ne i32 %53, %55
  br i1 %56, label %57, label %62

57:                                               ; preds = %47
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.83, i64 0, i64 0))
  call void @funk_print_node(%struct.tnode* %10)
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.84, i64 0, i64 0))
  call void @funk_print_node(%struct.tnode* %11)
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.85, i64 0, i64 0))
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.36, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @gCurrentFunction, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1451, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.86, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

62:                                               ; preds = %47
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %64 = load i32, i32* %63, align 4
  %65 = icmp eq i32 %64, 1
  br i1 %65, label %66, label %70

66:                                               ; preds = %62
  %67 = load %struct.tnode*, %struct.tnode** %5, align 8
  %68 = load i32, i32* %9, align 4
  %69 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %8, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %67, i32 %68, %struct.tnode* %10, %struct.tnode* %11, void (i8*, i8*, i8*, i32)* %69)
  br label %87

70:                                               ; preds = %62
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %72 = load i32, i32* %71, align 4
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %74 = load %struct.tpool*, %struct.tpool** %73, align 8
  %75 = call i32 @get_pool_enum(%struct.tpool* %74)
  call void @funk_create_node(%struct.tnode* %12, i32 %72, i32 %75, i32 1, i8 zeroext 0, i8* null)
  %76 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %8, align 8
  call void @funk_arith_op_rr(%struct.tnode* %12, %struct.tnode* %10, %struct.tnode* %11, void (i8*, i8*, i8*, i32)* %76)
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = load i32, i32* %9, align 4
  %79 = call %struct.tdata* @get_node(%struct.tnode* %77, i32 %78, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1461, i32 1)
  %80 = getelementptr inbounds %struct.tdata, %struct.tdata* %79, i32 0, i32 0
  store i32 7, i32* %80, align 8
  %81 = call i32 @_copy_node_to_pool(%struct.tnode* %12)
  %82 = load %struct.tnode*, %struct.tnode** %5, align 8
  %83 = load i32, i32* %9, align 4
  %84 = call %struct.tdata* @get_node(%struct.tnode* %82, i32 %83, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1462, i32 1)
  %85 = getelementptr inbounds %struct.tdata, %struct.tdata* %84, i32 0, i32 2
  %86 = bitcast %union.data_type* %85 to i32*
  store i32 %81, i32* %86, align 8
  br label %87

87:                                               ; preds = %70, %66
  br label %88

88:                                               ; preds = %87
  br label %89

89:                                               ; preds = %88
  %90 = load i32, i32* %9, align 4
  %91 = add i32 %90, 1
  store i32 %91, i32* %9, align 4
  br label %41

92:                                               ; preds = %41
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
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1526, i32 1)
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
  %28 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %27, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1529, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = icmp ne i32 %31, 1
  br i1 %32, label %33, label %38

33:                                               ; preds = %26
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__FUNCTION__.funk_eq_rr, i64 0, i64 0), i32 1530, i32 1)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %7, i32 %8)
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
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.87, i64 0, i64 0))
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.88, i64 0, i64 0), i32 %13)
  br label %15

15:                                               ; preds = %10
  %16 = load i32, i32* %3, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* %3, align 4
  br label %5

18:                                               ; preds = %5
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.89, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_print_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.tnode, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  store i32 0, i32* %3, align 4
  br label %7

7:                                                ; preds = %53, %1
  %8 = load i32, i32* %3, align 4
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp ult i32 %8, %11
  br i1 %12, label %13, label %56

13:                                               ; preds = %7
  %14 = load %struct.tnode*, %struct.tnode** %2, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  store i32 %16, i32* %4, align 4
  %17 = load %struct.tnode*, %struct.tnode** %2, align 8
  %18 = load i32, i32* %3, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1677, i32 1)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = icmp eq i32 %21, 3
  br i1 %22, label %23, label %34

23:                                               ; preds = %13
  %24 = load %struct.tnode*, %struct.tnode** %2, align 8
  %25 = load i32, i32* %3, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1681, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  store i32 %29, i32* %6, align 4
  %30 = load i32, i32* %6, align 4
  %31 = load %struct.tnode*, %struct.tnode** %2, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 2
  %33 = load %struct.tpool*, %struct.tpool** %32, align 8
  call void @_extract_tnode_from_pool(%struct.tnode* %5, i32 %30, %struct.tpool* %33)
  call void @funk_print_node(%struct.tnode* %5)
  br label %43

34:                                               ; preds = %13
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = load i32, i32* %3, align 4
  %37 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 %36, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__._funk_print_node, i64 0, i64 0), i32 1689, i32 1)
  %38 = bitcast %struct.tdata* %37 to { i64, i64 }*
  %39 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %38, i32 0, i32 1
  %42 = load i64, i64* %41, align 8
  call void @funk_print_scalar_element(i64 %40, i64 %42)
  br label %43

43:                                               ; preds = %34, %23
  %44 = load i32, i32* %3, align 4
  %45 = add i32 %44, 1
  %46 = load %struct.tnode*, %struct.tnode** %2, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  %48 = load i32, i32* %47, align 4
  %49 = icmp ult i32 %45, %48
  br i1 %49, label %50, label %52

50:                                               ; preds = %43
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.90, i64 0, i64 0))
  br label %52

52:                                               ; preds = %50, %43
  br label %53

53:                                               ; preds = %52
  %54 = load i32, i32* %3, align 4
  %55 = add i32 %54, 1
  store i32 %55, i32* %3, align 4
  br label %7

56:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @__funk_print_node(%struct.tnode* byval(%struct.tnode) align 8) #0 {
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
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.__funk_print_node, i64 0, i64 0), i32 1702, i32 1)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp eq i32 %12, 3
  br i1 %13, label %14, label %16

14:                                               ; preds = %1
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.91, i64 0, i64 0))
  br label %16

16:                                               ; preds = %14, %1
  call void @funk_create_node(%struct.tnode* %4, i32 1, i32 1, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %5, align 4
  br label %17

17:                                               ; preds = %31, %16
  %18 = load i32, i32* %5, align 4
  %19 = load i32, i32* %3, align 4
  %20 = icmp ult i32 %18, %19
  br i1 %20, label %21, label %34

21:                                               ; preds = %17
  %22 = load %struct.tnode*, %struct.tnode** %2, align 8
  %23 = load i32, i32* %5, align 4
  call void @funk_get_element_in_array(%struct.tnode* %22, %struct.tnode* %4, i32 %23)
  call void @_funk_print_node(%struct.tnode* %4)
  %24 = load i32, i32* %5, align 4
  %25 = add i32 %24, 1
  %26 = load i32, i32* %3, align 4
  %27 = icmp ne i32 %25, %26
  br i1 %27, label %28, label %30

28:                                               ; preds = %21
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.63, i64 0, i64 0))
  br label %30

30:                                               ; preds = %28, %21
  br label %31

31:                                               ; preds = %30
  %32 = load i32, i32* %5, align 4
  %33 = add i32 %32, 1
  store i32 %33, i32* %5, align 4
  br label %17

34:                                               ; preds = %17
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.__funk_print_node, i64 0, i64 0), i32 1716, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = icmp eq i32 %38, 3
  br i1 %39, label %40, label %42

40:                                               ; preds = %34
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.92, i64 0, i64 0))
  br label %42

42:                                               ; preds = %40, %34
  %43 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8
  %44 = call i32 @fflush(%struct.__sFILE* %43)
  ret void
}

declare i32 @fflush(%struct.__sFILE*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1727, i32 1)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %16

9:                                                ; preds = %1
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1728, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = sitofp i32 %14 to float
  store float %15, float* %2, align 4
  br label %34

16:                                               ; preds = %1
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1729, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %29

22:                                               ; preds = %16
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1730, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 2
  %26 = bitcast %union.data_type* %25 to double*
  %27 = load double, double* %26, align 8
  %28 = fptrunc double %27 to float
  store float %28, float* %2, align 4
  br label %34

29:                                               ; preds = %16
  %30 = load %struct.tnode*, %struct.tnode** %3, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1732, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i32 0, i32* %32, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.93, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
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
  %14 = call %struct.__sFILE* @"\01_fopen"(i8* %13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.94, i64 0, i64 0))
  store %struct.__sFILE* %14, %struct.__sFILE** %8, align 8
  %15 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %16 = icmp eq %struct.__sFILE* %15, null
  br i1 %16, label %17, label %20

17:                                               ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.95, i64 0, i64 0), i8* %18)
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
  %25 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %24, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.96, i64 0, i64 0), i32* %9)
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %46

27:                                               ; preds = %23
  %28 = load i32, i32* %9, align 4
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load i32, i32* %10, align 4
  %31 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %30, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1756, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 2
  %33 = bitcast %union.data_type* %32 to i32*
  store i32 %28, i32* %33, align 8
  %34 = load %struct.tnode*, %struct.tnode** %5, align 8
  %35 = load i32, i32* %10, align 4
  %36 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 %35, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1757, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  store i32 1, i32* %37, align 8
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = load i32, i32* %10, align 4
  %40 = load %struct.tpool*, %struct.tpool** %7, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 2
  %42 = load i8, i8* %41, align 4
  call void @_set_wrap_creation(%struct.tnode* %38, i32 %39, i8 zeroext %42)
  %43 = load %struct.tpool*, %struct.tpool** %7, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %43, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1759)
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
  %6 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_get_len, i64 0, i64 0), i32 1770, i32 1)
  %7 = getelementptr inbounds %struct.tdata, %struct.tdata* %6, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  %9 = icmp eq i32 %8, 4
  br i1 %9, label %10, label %12

10:                                               ; preds = %2
  %11 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %11, i32 0)
  br label %17

12:                                               ; preds = %2
  %13 = load %struct.tnode*, %struct.tnode** %3, align 8
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  call void @funk_create_i32_scalar(i32 1, %struct.tnode* %13, i32 %16)
  br label %17

17:                                               ; preds = %12, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_extended_len(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_get_len(%struct.tnode* %5, %struct.tnode* %6)
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.97, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %33, i32 %34)
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
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.98, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %41, i32 %42)
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
  %112 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %111, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1842, i32 1)
  %113 = getelementptr inbounds %struct.tdata, %struct.tdata* %112, i32 0, i32 2
  %114 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1842, i32 1)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 2
  %116 = bitcast %union.data_type* %113 to i8*
  %117 = bitcast %union.data_type* %115 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %116, i8* align 8 %117, i64 8, i1 false)
  %118 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1843, i32 1)
  %119 = getelementptr inbounds %struct.tdata, %struct.tdata* %118, i32 0, i32 0
  %120 = load i32, i32* %119, align 8
  %121 = load i32, i32* %22, align 4
  %122 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %121, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1843, i32 1)
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
  %132 = call %struct.tdata* @get_node(%struct.tnode* %130, i32 %131, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1845, i32 0)
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %132, i32 0, i32 0
  store i32 7, i32* %133, align 8
  %134 = call i32 @_copy_node_to_pool(%struct.tnode* %20)
  %135 = load %struct.tnode*, %struct.tnode** %8, align 8
  %136 = load i32, i32* %17, align 4
  %137 = call %struct.tdata* @get_node(%struct.tnode* %135, i32 %136, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1846, i32 0)
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
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1855, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %13, align 4
  %22 = load %struct.tnode*, %struct.tnode** %10, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1856, i32 1)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 2
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %14, align 4
  %27 = load %struct.tnode*, %struct.tnode** %11, align 8
  %28 = call %struct.tdata* @get_node(%struct.tnode* %27, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1857, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  store i32 %31, i32* %15, align 4
  %32 = load %struct.tnode*, %struct.tnode** %12, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1858, i32 1)
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.98, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 %42, i32 %43)
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1903, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 2
  %14 = bitcast %union.data_type* %13 to i32*
  %15 = load i32, i32* %14, align 8
  store i32 %15, i32* %9, align 4
  %16 = load %struct.tnode*, %struct.tnode** %8, align 8
  %17 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1904, i32 1)
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
  %34 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %33, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1924, i32 1)
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
  %54 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %53, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1925, i32 1)
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 2
  %56 = bitcast %union.data_type* %55 to i32*
  store i32 %52, i32* %56, align 8
  br label %80

57:                                               ; preds = %27
  %58 = load %struct.tnode*, %struct.tnode** %7, align 8
  %59 = load i32, i32* %12, align 4
  %60 = load i32, i32* %15, align 4
  %61 = add i32 %59, %60
  %62 = call %struct.tdata* @get_node(%struct.tnode* %58, i32 %61, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1930, i32 1)
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 0
  %64 = load i32, i32* %63, align 8
  %65 = load i32, i32* %15, align 4
  %66 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %65, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1930, i32 1)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  store i32 %64, i32* %67, align 8
  %68 = load %struct.tnode*, %struct.tnode** %7, align 8
  %69 = load i32, i32* %12, align 4
  %70 = load i32, i32* %15, align 4
  %71 = add i32 %69, %70
  %72 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 %71, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1931, i32 1)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 2
  %74 = bitcast %union.data_type* %73 to i32*
  %75 = load i32, i32* %74, align 8
  %76 = load i32, i32* %15, align 4
  %77 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 %76, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__._funk_set_node_dimensions, i64 0, i64 0), i32 1931, i32 1)
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

9:                                                ; preds = %97, %3
  %10 = load i32, i32* %7, align 4
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp ult i32 %10, %13
  br i1 %14, label %15, label %100

15:                                               ; preds = %9
  %16 = load %struct.tnode*, %struct.tnode** %5, align 8
  %17 = load i32, i32* %7, align 4
  %18 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 %17, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1953, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 7
  br i1 %21, label %29, label %22

22:                                               ; preds = %15
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = load i32, i32* %7, align 4
  %25 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 %24, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1953, i32 1)
  %26 = getelementptr inbounds %struct.tdata, %struct.tdata* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = icmp eq i32 %27, 3
  br i1 %28, label %29, label %56

29:                                               ; preds = %22, %15
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 2
  %32 = load %struct.tpool*, %struct.tpool** %31, align 8
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = load i32, i32* %7, align 4
  call void @_dereference(%struct.tnode* %8, %struct.tpool* %32, i32 %35, i32 %36, i32 10, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1956)
  %37 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1957, i32 1)
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  %39 = load i32, i32* %38, align 8
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = load i32, i32* %6, align 4
  %42 = load i32, i32* %7, align 4
  %43 = add i32 %41, %42
  %44 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 %43, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1957, i32 0)
  %45 = getelementptr inbounds %struct.tdata, %struct.tdata* %44, i32 0, i32 0
  store i32 %39, i32* %45, align 8
  %46 = load %struct.tnode*, %struct.tnode** %4, align 8
  %47 = load i32, i32* %6, align 4
  %48 = load i32, i32* %7, align 4
  %49 = add i32 %47, %48
  %50 = call %struct.tdata* @get_node(%struct.tnode* %46, i32 %49, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1958, i32 0)
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 2
  %52 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1958, i32 1)
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 2
  %54 = bitcast %union.data_type* %51 to i8*
  %55 = bitcast %union.data_type* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %54, i8* align 8 %55, i64 8, i1 false)
  br label %80

56:                                               ; preds = %22
  %57 = load %struct.tnode*, %struct.tnode** %5, align 8
  %58 = load i32, i32* %7, align 4
  %59 = call %struct.tdata* @get_node(%struct.tnode* %57, i32 %58, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1960, i32 1)
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = load %struct.tnode*, %struct.tnode** %4, align 8
  %63 = load i32, i32* %6, align 4
  %64 = load i32, i32* %7, align 4
  %65 = add i32 %63, %64
  %66 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 %65, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1960, i32 0)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  store i32 %61, i32* %67, align 8
  %68 = load %struct.tnode*, %struct.tnode** %4, align 8
  %69 = load i32, i32* %6, align 4
  %70 = load i32, i32* %7, align 4
  %71 = add i32 %69, %70
  %72 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 %71, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1961, i32 0)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 2
  %74 = load %struct.tnode*, %struct.tnode** %5, align 8
  %75 = load i32, i32* %7, align 4
  %76 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 %75, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1961, i32 1)
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 2
  %78 = bitcast %union.data_type* %73 to i8*
  %79 = bitcast %union.data_type* %77 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %78, i8* align 8 %79, i64 8, i1 false)
  br label %80

80:                                               ; preds = %56, %29
  %81 = load %struct.tnode*, %struct.tnode** %4, align 8
  %82 = load i32, i32* %6, align 4
  %83 = load i32, i32* %7, align 4
  %84 = add i32 %82, %83
  %85 = load %struct.tnode*, %struct.tnode** %4, align 8
  %86 = getelementptr inbounds %struct.tnode, %struct.tnode* %85, i32 0, i32 2
  %87 = load %struct.tpool*, %struct.tpool** %86, align 8
  %88 = getelementptr inbounds %struct.tpool, %struct.tpool* %87, i32 0, i32 2
  %89 = load i8, i8* %88, align 4
  call void @_set_wrap_creation(%struct.tnode* %81, i32 %84, i8 zeroext %89)
  %90 = load %struct.tnode*, %struct.tnode** %4, align 8
  %91 = getelementptr inbounds %struct.tnode, %struct.tnode* %90, i32 0, i32 2
  %92 = load %struct.tpool*, %struct.tpool** %91, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %92, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__._flatten, i64 0, i64 0), i32 1964)
  %93 = load %struct.tnode*, %struct.tnode** %4, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 1
  %95 = load i32, i32* %94, align 4
  %96 = add i32 %95, 1
  store i32 %96, i32* %94, align 4
  br label %97

97:                                               ; preds = %80
  %98 = load i32, i32* %7, align 4
  %99 = add i32 %98, 1
  store i32 %99, i32* %7, align 4
  br label %9

100:                                              ; preds = %9
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
  %8 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.reshape, i64 0, i64 0), i32 2003, i32 1)
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
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.99, i64 0, i64 0))
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2029)
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = call %struct.tnode* @validate_node(%struct.tnode* %12, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2030)
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2032, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = icmp eq i32 %17, 4
  br i1 %18, label %19, label %28

19:                                               ; preds = %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2033, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 4
  br i1 %24, label %25, label %28

25:                                               ; preds = %19
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_node(%struct.tnode* %26, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.100, i64 0, i64 0))
  br label %124

28:                                               ; preds = %19, %3
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2040, i32 1)
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
  %43 = call %struct.tdata* @get_node(%struct.tnode* %42, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2041, i32 1)
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = icmp eq i32 %45, 4
  %47 = zext i1 %46 to i64
  %48 = select i1 %46, i32 0, i32 1
  %49 = add i32 %41, %48
  %50 = load %struct.tnode*, %struct.tnode** %6, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 2
  %52 = load %struct.tpool*, %struct.tpool** %51, align 8
  %53 = call i32 @get_pool_enum(%struct.tpool* %52)
  call void @funk_create_node(%struct.tnode* %29, i32 %49, i32 %53, i32 3, i8 zeroext 0, i8* null)
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %54

54:                                               ; preds = %90, %40
  %55 = load i32, i32* %8, align 4
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = load i32, i32* %57, align 4
  %59 = icmp ult i32 %55, %58
  br i1 %59, label %60, label %93

60:                                               ; preds = %54
  %61 = load %struct.tnode*, %struct.tnode** %5, align 8
  %62 = load i32, i32* %8, align 4
  %63 = call %struct.tdata* @get_node(%struct.tnode* %61, i32 %62, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2046, i32 1)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 0
  %65 = load i32, i32* %64, align 8
  %66 = icmp eq i32 %65, 4
  br i1 %66, label %67, label %68

67:                                               ; preds = %60
  br label %93

68:                                               ; preds = %60
  %69 = load %struct.tnode*, %struct.tnode** %5, align 8
  %70 = load i32, i32* %8, align 4
  %71 = call %struct.tdata* @get_node(%struct.tnode* %69, i32 %70, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2049, i32 1)
  %72 = getelementptr inbounds %struct.tdata, %struct.tdata* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = load %struct.tnode*, %struct.tnode** %4, align 8
  %75 = load i32, i32* %7, align 4
  %76 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 %75, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2049, i32 1)
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  store i32 %73, i32* %77, align 8
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = load i32, i32* %7, align 4
  %80 = call %struct.tdata* @get_node(%struct.tnode* %78, i32 %79, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2050, i32 1)
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %80, i32 0, i32 2
  %82 = load %struct.tnode*, %struct.tnode** %5, align 8
  %83 = load i32, i32* %8, align 4
  %84 = call %struct.tdata* @get_node(%struct.tnode* %82, i32 %83, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2050, i32 1)
  %85 = getelementptr inbounds %struct.tdata, %struct.tdata* %84, i32 0, i32 2
  %86 = bitcast %union.data_type* %81 to i8*
  %87 = bitcast %union.data_type* %85 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %86, i8* align 8 %87, i64 8, i1 false)
  %88 = load i32, i32* %7, align 4
  %89 = add i32 %88, 1
  store i32 %89, i32* %7, align 4
  br label %90

90:                                               ; preds = %68
  %91 = load i32, i32* %8, align 4
  %92 = add i32 %91, 1
  store i32 %92, i32* %8, align 4
  br label %54

93:                                               ; preds = %67, %54
  %94 = load %struct.tnode*, %struct.tnode** %6, align 8
  %95 = call %struct.tdata* @get_node(%struct.tnode* %94, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2055, i32 1)
  %96 = getelementptr inbounds %struct.tdata, %struct.tdata* %95, i32 0, i32 0
  %97 = load i32, i32* %96, align 8
  %98 = icmp ne i32 %97, 4
  br i1 %98, label %99, label %117

99:                                               ; preds = %93
  %100 = load %struct.tnode*, %struct.tnode** %4, align 8
  %101 = load %struct.tnode*, %struct.tnode** %4, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 1
  %103 = load i32, i32* %102, align 4
  %104 = sub i32 %103, 1
  %105 = call %struct.tdata* @get_node(%struct.tnode* %100, i32 %104, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2056, i32 0)
  %106 = getelementptr inbounds %struct.tdata, %struct.tdata* %105, i32 0, i32 0
  store i32 7, i32* %106, align 8
  %107 = load %struct.tnode*, %struct.tnode** %6, align 8
  %108 = call i32 @_copy_node_to_pool(%struct.tnode* %107)
  %109 = load %struct.tnode*, %struct.tnode** %4, align 8
  %110 = load %struct.tnode*, %struct.tnode** %4, align 8
  %111 = getelementptr inbounds %struct.tnode, %struct.tnode* %110, i32 0, i32 1
  %112 = load i32, i32* %111, align 4
  %113 = sub i32 %112, 1
  %114 = call %struct.tdata* @get_node(%struct.tnode* %109, i32 %113, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_append_element_to_list, i64 0, i64 0), i32 2057, i32 0)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 2
  %116 = bitcast %union.data_type* %115 to i32*
  store i32 %108, i32* %116, align 8
  br label %117

117:                                              ; preds = %99, %93
  %118 = load %struct.tnode*, %struct.tnode** %4, align 8
  %119 = getelementptr inbounds %struct.tnode, %struct.tnode* %118, i32 0, i32 1
  %120 = load i32, i32* %119, align 4
  %121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.101, i64 0, i64 0), i32 %120)
  %122 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %122)
  %123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.102, i64 0, i64 0))
  br label %124

124:                                              ; preds = %117, %25
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
  %10 = call %struct.tnode* @validate_node(%struct.tnode* %9, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2071)
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2072)
  %13 = load %struct.tnode*, %struct.tnode** %5, align 8
  %14 = call %struct.tdata* @get_node(%struct.tnode* %13, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2074, i32 1)
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = icmp eq i32 %16, 4
  br i1 %17, label %18, label %21

18:                                               ; preds = %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_copy_node(%struct.tnode* %19, %struct.tnode* %20)
  br label %139

21:                                               ; preds = %3
  %22 = load %struct.tnode*, %struct.tnode** %5, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2079, i32 1)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 4
  br i1 %26, label %27, label %36

27:                                               ; preds = %21
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2080, i32 1)
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = icmp eq i32 %31, 4
  br i1 %32, label %33, label %36

33:                                               ; preds = %27
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_node(%struct.tnode* %34, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.103, i64 0, i64 0))
  br label %139

36:                                               ; preds = %27, %21
  %37 = load %struct.tnode*, %struct.tnode** %4, align 8
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2087, i32 1)
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = icmp eq i32 %41, 4
  %43 = zext i1 %42 to i64
  %44 = select i1 %42, i32 0, i32 1
  %45 = load %struct.tnode*, %struct.tnode** %6, align 8
  %46 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2088, i32 1)
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = icmp eq i32 %48, 4
  br i1 %49, label %50, label %51

50:                                               ; preds = %36
  br label %55

51:                                               ; preds = %36
  %52 = load %struct.tnode*, %struct.tnode** %6, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = load i32, i32* %53, align 4
  br label %55

55:                                               ; preds = %51, %50
  %56 = phi i32 [ 0, %50 ], [ %54, %51 ]
  %57 = add i32 %44, %56
  %58 = load %struct.tnode*, %struct.tnode** %5, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 2
  %60 = load %struct.tpool*, %struct.tpool** %59, align 8
  %61 = call i32 @get_pool_enum(%struct.tpool* %60)
  call void @funk_create_node(%struct.tnode* %37, i32 %57, i32 %61, i32 3, i8 zeroext 0, i8* null)
  %62 = load %struct.tnode*, %struct.tnode** %5, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 1
  %64 = load i32, i32* %63, align 4
  %65 = icmp ugt i32 %64, 1
  br i1 %65, label %66, label %76

66:                                               ; preds = %55
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2093, i32 0)
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i32 7, i32* %69, align 8
  %70 = load %struct.tnode*, %struct.tnode** %5, align 8
  %71 = call i32 @_copy_node_to_pool(%struct.tnode* %70)
  %72 = load %struct.tnode*, %struct.tnode** %4, align 8
  %73 = call %struct.tdata* @get_node(%struct.tnode* %72, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2094, i32 0)
  %74 = getelementptr inbounds %struct.tdata, %struct.tdata* %73, i32 0, i32 2
  %75 = bitcast %union.data_type* %74 to i32*
  store i32 %71, i32* %75, align 8
  br label %99

76:                                               ; preds = %55
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = call %struct.tdata* @get_node(%struct.tnode* %77, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2095, i32 1)
  %79 = getelementptr inbounds %struct.tdata, %struct.tdata* %78, i32 0, i32 0
  %80 = load i32, i32* %79, align 8
  %81 = icmp ne i32 %80, 4
  br i1 %81, label %82, label %98

82:                                               ; preds = %76
  %83 = load %struct.tnode*, %struct.tnode** %5, align 8
  %84 = call %struct.tdata* @get_node(%struct.tnode* %83, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2096, i32 1)
  %85 = getelementptr inbounds %struct.tdata, %struct.tdata* %84, i32 0, i32 0
  %86 = load i32, i32* %85, align 8
  %87 = load %struct.tnode*, %struct.tnode** %4, align 8
  %88 = call %struct.tdata* @get_node(%struct.tnode* %87, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2096, i32 1)
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 0
  store i32 %86, i32* %89, align 8
  %90 = load %struct.tnode*, %struct.tnode** %4, align 8
  %91 = call %struct.tdata* @get_node(%struct.tnode* %90, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2097, i32 1)
  %92 = getelementptr inbounds %struct.tdata, %struct.tdata* %91, i32 0, i32 2
  %93 = load %struct.tnode*, %struct.tnode** %5, align 8
  %94 = call %struct.tdata* @get_node(%struct.tnode* %93, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2097, i32 1)
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 2
  %96 = bitcast %union.data_type* %92 to i8*
  %97 = bitcast %union.data_type* %95 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %96, i8* align 8 %97, i64 8, i1 false)
  br label %98

98:                                               ; preds = %82, %76
  br label %99

99:                                               ; preds = %98, %66
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %100

100:                                              ; preds = %136, %99
  %101 = load i32, i32* %8, align 4
  %102 = load %struct.tnode*, %struct.tnode** %6, align 8
  %103 = getelementptr inbounds %struct.tnode, %struct.tnode* %102, i32 0, i32 1
  %104 = load i32, i32* %103, align 4
  %105 = icmp ult i32 %101, %104
  br i1 %105, label %106, label %139

106:                                              ; preds = %100
  %107 = load %struct.tnode*, %struct.tnode** %6, align 8
  %108 = load i32, i32* %8, align 4
  %109 = call %struct.tdata* @get_node(%struct.tnode* %107, i32 %108, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2102, i32 1)
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 0
  %111 = load i32, i32* %110, align 8
  %112 = icmp eq i32 %111, 4
  br i1 %112, label %113, label %114

113:                                              ; preds = %106
  br label %139

114:                                              ; preds = %106
  %115 = load %struct.tnode*, %struct.tnode** %6, align 8
  %116 = load i32, i32* %8, align 4
  %117 = call %struct.tdata* @get_node(%struct.tnode* %115, i32 %116, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2105, i32 1)
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %117, i32 0, i32 0
  %119 = load i32, i32* %118, align 8
  %120 = load %struct.tnode*, %struct.tnode** %4, align 8
  %121 = load i32, i32* %7, align 4
  %122 = call %struct.tdata* @get_node(%struct.tnode* %120, i32 %121, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2105, i32 1)
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 0
  store i32 %119, i32* %123, align 8
  %124 = load %struct.tnode*, %struct.tnode** %4, align 8
  %125 = load i32, i32* %7, align 4
  %126 = call %struct.tdata* @get_node(%struct.tnode* %124, i32 %125, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2106, i32 1)
  %127 = getelementptr inbounds %struct.tdata, %struct.tdata* %126, i32 0, i32 2
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = load i32, i32* %8, align 4
  %130 = call %struct.tdata* @get_node(%struct.tnode* %128, i32 %129, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_prepend_element_to_list, i64 0, i64 0), i32 2106, i32 1)
  %131 = getelementptr inbounds %struct.tdata, %struct.tdata* %130, i32 0, i32 2
  %132 = bitcast %union.data_type* %127 to i8*
  %133 = bitcast %union.data_type* %131 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %132, i8* align 8 %133, i64 8, i1 false)
  %134 = load i32, i32* %7, align 4
  %135 = add i32 %134, 1
  store i32 %135, i32* %7, align 4
  br label %136

136:                                              ; preds = %114
  %137 = load i32, i32* %8, align 4
  %138 = add i32 %137, 1
  store i32 %138, i32* %8, align 4
  br label %100

139:                                              ; preds = %18, %33, %113, %100
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_first_element_from_list(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = call i32 @get_pool_enum(%struct.tpool* %9)
  call void @funk_create_node(%struct.tnode* %6, i32 1, i32 %10, i32 4, i8 zeroext 0, i8* null)
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_get_element_in_array(%struct.tnode* %11, %struct.tnode* %5, i32 0)
  %12 = load %struct.tnode*, %struct.tnode** %4, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.104, i64 0, i64 0), i32 %14)
  call void @funk_print_node(%struct.tnode* %5)
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.105, i64 0, i64 0))
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %17)
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.106, i64 0, i64 0))
  %19 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @funk_copy_node(%struct.tnode* %19, %struct.tnode* %5)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_concatenate_lists(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %12 = load %struct.tnode*, %struct.tnode** %5, align 8
  %13 = call %struct.tnode* @validate_node(%struct.tnode* %12, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2144)
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call %struct.tnode* @validate_node(%struct.tnode* %14, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2145)
  %16 = load %struct.tnode*, %struct.tnode** %5, align 8
  %17 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2147, i32 1)
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = icmp eq i32 %19, 4
  br i1 %20, label %21, label %34

21:                                               ; preds = %3
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2148, i32 1)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 4
  br i1 %26, label %27, label %34

27:                                               ; preds = %21
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 2
  %31 = load %struct.tpool*, %struct.tpool** %30, align 8
  %32 = call i32 @get_pool_enum(%struct.tpool* %31)
  call void @funk_create_node(%struct.tnode* %28, i32 1, i32 %32, i32 4, i8 zeroext 0, i8* null)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.107, i64 0, i64 0))
  br label %170

34:                                               ; preds = %21, %3
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2154, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = icmp eq i32 %38, 4
  br i1 %39, label %40, label %44

40:                                               ; preds = %34
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_copy_node(%struct.tnode* %41, %struct.tnode* %42)
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.108, i64 0, i64 0))
  br label %170

44:                                               ; preds = %34
  %45 = load %struct.tnode*, %struct.tnode** %5, align 8
  %46 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2160, i32 1)
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = icmp eq i32 %48, 4
  br i1 %49, label %50, label %54

50:                                               ; preds = %44
  %51 = load %struct.tnode*, %struct.tnode** %4, align 8
  %52 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_copy_node(%struct.tnode* %51, %struct.tnode* %52)
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.109, i64 0, i64 0))
  br label %170

54:                                               ; preds = %44
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = call %struct.tdata* @get_node(%struct.tnode* %56, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2167, i32 1)
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  %59 = load i32, i32* %58, align 8
  %60 = icmp eq i32 %59, 4
  br i1 %60, label %61, label %62

61:                                               ; preds = %54
  br label %66

62:                                               ; preds = %54
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  br label %66

66:                                               ; preds = %62, %61
  %67 = phi i32 [ 0, %61 ], [ %65, %62 ]
  %68 = load %struct.tnode*, %struct.tnode** %6, align 8
  %69 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2168, i32 1)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 0
  %71 = load i32, i32* %70, align 8
  %72 = icmp eq i32 %71, 4
  br i1 %72, label %73, label %74

73:                                               ; preds = %66
  br label %78

74:                                               ; preds = %66
  %75 = load %struct.tnode*, %struct.tnode** %6, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 1
  %77 = load i32, i32* %76, align 4
  br label %78

78:                                               ; preds = %74, %73
  %79 = phi i32 [ 0, %73 ], [ %77, %74 ]
  %80 = add i32 %67, %79
  %81 = load %struct.tnode*, %struct.tnode** %5, align 8
  %82 = getelementptr inbounds %struct.tnode, %struct.tnode* %81, i32 0, i32 2
  %83 = load %struct.tpool*, %struct.tpool** %82, align 8
  %84 = call i32 @get_pool_enum(%struct.tpool* %83)
  call void @funk_create_node(%struct.tnode* %55, i32 %80, i32 %84, i32 3, i8 zeroext 0, i8* null)
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %85

85:                                               ; preds = %117, %78
  %86 = load i32, i32* %8, align 4
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = load i32, i32* %88, align 4
  %90 = icmp ult i32 %86, %89
  br i1 %90, label %91, label %120

91:                                               ; preds = %85
  %92 = load %struct.tnode*, %struct.tnode** %5, align 8
  %93 = load i32, i32* %8, align 4
  call void @funk_get_element_in_array(%struct.tnode* %92, %struct.tnode* %9, i32 %93)
  %94 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2175, i32 1)
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 0
  %96 = load i32, i32* %95, align 8
  %97 = icmp eq i32 %96, 4
  br i1 %97, label %98, label %99

98:                                               ; preds = %91
  br label %120

99:                                               ; preds = %91
  %100 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2178, i32 1)
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 0
  %102 = load i32, i32* %101, align 8
  %103 = load %struct.tnode*, %struct.tnode** %4, align 8
  %104 = load i32, i32* %7, align 4
  %105 = call %struct.tdata* @get_node(%struct.tnode* %103, i32 %104, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2178, i32 1)
  %106 = getelementptr inbounds %struct.tdata, %struct.tdata* %105, i32 0, i32 0
  store i32 %102, i32* %106, align 8
  %107 = load %struct.tnode*, %struct.tnode** %4, align 8
  %108 = load i32, i32* %7, align 4
  %109 = call %struct.tdata* @get_node(%struct.tnode* %107, i32 %108, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2179, i32 1)
  %110 = getelementptr inbounds %struct.tdata, %struct.tdata* %109, i32 0, i32 2
  %111 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2179, i32 1)
  %112 = getelementptr inbounds %struct.tdata, %struct.tdata* %111, i32 0, i32 2
  %113 = bitcast %union.data_type* %110 to i8*
  %114 = bitcast %union.data_type* %112 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %113, i8* align 8 %114, i64 8, i1 false)
  %115 = load i32, i32* %7, align 4
  %116 = add i32 %115, 1
  store i32 %116, i32* %7, align 4
  br label %117

117:                                              ; preds = %99
  %118 = load i32, i32* %8, align 4
  %119 = add i32 %118, 1
  store i32 %119, i32* %8, align 4
  br label %85

120:                                              ; preds = %98, %85
  store i32 0, i32* %10, align 4
  br label %121

121:                                              ; preds = %153, %120
  %122 = load i32, i32* %10, align 4
  %123 = load %struct.tnode*, %struct.tnode** %6, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 1
  %125 = load i32, i32* %124, align 4
  %126 = icmp ult i32 %122, %125
  br i1 %126, label %127, label %156

127:                                              ; preds = %121
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = load i32, i32* %10, align 4
  call void @funk_get_element_in_array(%struct.tnode* %128, %struct.tnode* %11, i32 %129)
  %130 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2187, i32 1)
  %131 = getelementptr inbounds %struct.tdata, %struct.tdata* %130, i32 0, i32 0
  %132 = load i32, i32* %131, align 8
  %133 = icmp eq i32 %132, 4
  br i1 %133, label %134, label %135

134:                                              ; preds = %127
  br label %156

135:                                              ; preds = %127
  %136 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2190, i32 1)
  %137 = getelementptr inbounds %struct.tdata, %struct.tdata* %136, i32 0, i32 0
  %138 = load i32, i32* %137, align 8
  %139 = load %struct.tnode*, %struct.tnode** %4, align 8
  %140 = load i32, i32* %7, align 4
  %141 = call %struct.tdata* @get_node(%struct.tnode* %139, i32 %140, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2190, i32 1)
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %141, i32 0, i32 0
  store i32 %138, i32* %142, align 8
  %143 = load %struct.tnode*, %struct.tnode** %4, align 8
  %144 = load i32, i32* %7, align 4
  %145 = call %struct.tdata* @get_node(%struct.tnode* %143, i32 %144, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2191, i32 1)
  %146 = getelementptr inbounds %struct.tdata, %struct.tdata* %145, i32 0, i32 2
  %147 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 2191, i32 1)
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %147, i32 0, i32 2
  %149 = bitcast %union.data_type* %146 to i8*
  %150 = bitcast %union.data_type* %148 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %149, i8* align 8 %150, i64 8, i1 false)
  %151 = load i32, i32* %7, align 4
  %152 = add i32 %151, 1
  store i32 %152, i32* %7, align 4
  br label %153

153:                                              ; preds = %135
  %154 = load i32, i32* %10, align 4
  %155 = add i32 %154, 1
  store i32 %155, i32* %10, align 4
  br label %121

156:                                              ; preds = %134, %121
  %157 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.110, i64 0, i64 0))
  %158 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node(%struct.tnode* %158)
  %159 = load %struct.tnode*, %struct.tnode** %5, align 8
  %160 = getelementptr inbounds %struct.tnode, %struct.tnode* %159, i32 0, i32 1
  %161 = load i32, i32* %160, align 4
  %162 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.111, i64 0, i64 0), i32 %161)
  %163 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_print_node(%struct.tnode* %163)
  %164 = load %struct.tnode*, %struct.tnode** %6, align 8
  %165 = getelementptr inbounds %struct.tnode, %struct.tnode* %164, i32 0, i32 1
  %166 = load i32, i32* %165, align 4
  %167 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.112, i64 0, i64 0), i32 %166)
  %168 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.113, i64 0, i64 0))
  %169 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node(%struct.tnode* %169)
  br label %170

170:                                              ; preds = %156, %50, %40, %27
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_start(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tnode* @validate_node(%struct.tnode* %3, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_get_node_start, i64 0, i64 0), i32 2205)
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
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0), i32 2211)
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
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.114, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0))
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
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_set_tnode_array_elementEX, i64 0, i64 0), i32 2231, i32 1)
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
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.115, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.funk_set_tnode_array_elementEX, i64 0, i64 0), i32 %19, i32 %20)
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
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_alloc_list_of_tnodes, i64 0, i64 0), i32 2241, i32 1)
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
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 2251, i32 1)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp ne i32 %12, 6
  br i1 %13, label %14, label %16

14:                                               ; preds = %4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.116, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 2256, i32 1)
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
