; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [250000 x %struct.tdata], i32, i8 }
%struct.tdata = type { i32, i8, %union.data_type }
%union.data_type = type { double }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions, %struct.tsiblings }
%struct.tdimensions = type { i32, i32 }
%struct.tsiblings = type { i32, i32 }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str = private unnamed_addr constant [8 x i8] c"-E- %s\0A\00", align 1
@__FUNCTION__.get_pool_ptr = private unnamed_addr constant [13 x i8] c"get_pool_ptr\00", align 1
@.str.1 = private unnamed_addr constant [49 x i8] c"\0A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\0A\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"INTERNAL ERROR: '%s' NULL node\0A\00", align 1
@.str.3 = private unnamed_addr constant [48 x i8] c"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\0A\00", align 1
@.str.4 = private unnamed_addr constant [74 x i8] c"INTERNAL ERROR: '%s' n[%d:%d]{%p} pointer %p to memory pool is not valid\0A\00", align 1
@.str.5 = private unnamed_addr constant [30 x i8] c"-E- %s Invalid dimension %d \0A\00", align 1
@__FUNCTION__._funk_set_node_dimension = private unnamed_addr constant [25 x i8] c"_funk_set_node_dimension\00", align 1
@.str.6 = private unnamed_addr constant [38 x i8] c"INTERNAL ERROR: %s NULL node pointer\0A\00", align 1
@__FUNCTION__.get_node = private unnamed_addr constant [9 x i8] c"get_node\00", align 1
@.str.7 = private unnamed_addr constant [35 x i8] c"INTERNAL ERROR: called from %s:%d\0A\00", align 1
@.str.8 = private unnamed_addr constant [79 x i8] c"-E- %s:%d get_node: attemping to access overwritten position %d:%d in '%s':%d\0A\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.11 = private unnamed_addr constant [11 x i8] c"%s[%d:%d]\0A\00", align 1
@__FUNCTION__._get_wrap_creation = private unnamed_addr constant [19 x i8] c"_get_wrap_creation\00", align 1
@__FUNCTION__._set_wrap_creation = private unnamed_addr constant [19 x i8] c"_set_wrap_creation\00", align 1
@funk_sleep.first = internal global i32 1, align 4
@.str.12 = private unnamed_addr constant [68 x i8] c"%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count %d\0A\00", align 1
@__FUNCTION__.funk_increment_pool_tail = private unnamed_addr constant [25 x i8] c"funk_increment_pool_tail\00", align 1
@g_debug_continue = internal global i32 0, align 4
@.str.13 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@funk_types_str = internal global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@.str.14 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.15 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.16 = private unnamed_addr constant [4 x i8] c"%p\0A\00", align 1
@.str.17 = private unnamed_addr constant [18 x i8] c"pool DIM idx: %d\0A\00", align 1
@.str.18 = private unnamed_addr constant [17 x i8] c"%s[%d :%d] %d-d\0A\00", align 1
@.str.19 = private unnamed_addr constant [9 x i8] c"int: %d\0A\00", align 1
@__FUNCTION__.funk_print_node_info = private unnamed_addr constant [21 x i8] c"funk_print_node_info\00", align 1
@.str.20 = private unnamed_addr constant [12 x i8] c"double: %f\0A\00", align 1
@__FUNCTION__.funk_create_node = private unnamed_addr constant [17 x i8] c"funk_create_node\00", align 1
@__FUNCTION__.funk_clone_node = private unnamed_addr constant [16 x i8] c"funk_clone_node\00", align 1
@.str.21 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@__FUNCTION__.funk_sum_list = private unnamed_addr constant [14 x i8] c"funk_sum_list\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_lit = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_lit\00", align 1
@.str.22 = private unnamed_addr constant [35 x i8] c"-E- %s Invalid dimensions %d x %d\0A\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_var = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_var\00", align 1
@.str.23 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_get_element_in_array_lit = private unnamed_addr constant [30 x i8] c"funk_get_element_in_array_lit\00", align 1
@__FUNCTION__.funk_get_element_in_array_var = private unnamed_addr constant [30 x i8] c"funk_get_element_in_array_var\00", align 1
@__FUNCTION__.add_node_to_nodelist = private unnamed_addr constant [21 x i8] c"add_node_to_nodelist\00", align 1
@__FUNCTION__.funk_regroup_list = private unnamed_addr constant [18 x i8] c"funk_regroup_list\00", align 1
@__FUNCTION__.funk_regroup_list_r = private unnamed_addr constant [20 x i8] c"funk_regroup_list_r\00", align 1
@.str.24 = private unnamed_addr constant [6 x i8] c"YYYY\0A\00", align 1
@__FUNCTION__.funk_create_double_scalar = private unnamed_addr constant [26 x i8] c"funk_create_double_scalar\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@__FUNCTION__.funk_create_list_of_regs = private unnamed_addr constant [25 x i8] c"funk_create_list_of_regs\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@.str.25 = private unnamed_addr constant [6 x i8] c" %3d \00", align 1
@.str.26 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.27 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.28 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.29 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.30 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_increment_node_data_int = private unnamed_addr constant [29 x i8] c"funk_increment_node_data_int\00", align 1
@__FUNCTION__.funk_copy_node_into_node_list = private unnamed_addr constant [30 x i8] c"funk_copy_node_into_node_list\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_set_node_value_fn_ptr = private unnamed_addr constant [27 x i8] c"funk_set_node_value_fn_ptr\00", align 1
@__FUNCTION__.funk_set_node_value_double = private unnamed_addr constant [27 x i8] c"funk_set_node_value_double\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.31 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.32 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@__FUNCTION__.debug_print_arith_operation = private unnamed_addr constant [28 x i8] c"debug_print_arith_operation\00", align 1
@.str.33 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.34 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.35 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.36 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
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
@__FUNCTION__._funk_arith_op_rr = private unnamed_addr constant [18 x i8] c"_funk_arith_op_rr\00", align 1
@.str.37 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.38 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@.str.39 = private unnamed_addr constant [14 x i8] c"-E- funk_mul\0A\00", align 1
@.str.40 = private unnamed_addr constant [14 x i8] c"-E- funk_div\0A\00", align 1
@.str.41 = private unnamed_addr constant [14 x i8] c"-E- funk_add\0A\00", align 1
@.str.42 = private unnamed_addr constant [14 x i8] c"-E- funk_sub\0A\00", align 1
@.str.43 = private unnamed_addr constant [14 x i8] c"-E- funk_mod\0A\00", align 1
@.str.44 = private unnamed_addr constant [14 x i8] c"-E- funk_slt\0A\00", align 1
@.str.45 = private unnamed_addr constant [14 x i8] c"-E- funk_sgt\0A\00", align 1
@.str.46 = private unnamed_addr constant [14 x i8] c"-E- funk_sge\0A\00", align 1
@.str.47 = private unnamed_addr constant [13 x i8] c"-E- funk_eq\0A\00", align 1
@.str.48 = private unnamed_addr constant [13 x i8] c"-E- funk_or\0A\00", align 1
@.str.49 = private unnamed_addr constant [101 x i8] c"\0A-E- cannot perform arithmetic operation in operand A of dimension %d and operand B of dimension %d\0A\00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.50 = private unnamed_addr constant [30 x i8] c"-E- invalid dimensions %d %d\0A\00", align 1
@.str.51 = private unnamed_addr constant [59 x i8] c"-E- Arithmetic operation in %d is not currently supported\0A\00", align 1
@.str.52 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.53 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@__FUNCTION__.funk_print_dimension = private unnamed_addr constant [21 x i8] c"funk_print_dimension\00", align 1
@.str.54 = private unnamed_addr constant [2 x i8] c")\00", align 1
@__FUNCTION__.funk_print_node = private unnamed_addr constant [16 x i8] c"funk_print_node\00", align 1
@.str.55 = private unnamed_addr constant [10 x i8] c"%d x %d \0A\00", align 1
@.str.56 = private unnamed_addr constant [40 x i8] c" [...] %d-dimensional with %d elements\0A\00", align 1
@.str.57 = private unnamed_addr constant [65 x i8] c"%s Error cannot address as a matrix since node has %d dimensions\00", align 1
@__FUNCTION__.print_2d_array_element_reg_reg = private unnamed_addr constant [31 x i8] c"print_2d_array_element_reg_reg\00", align 1
@__FUNCTION__.print_2d_array_element_int_int = private unnamed_addr constant [31 x i8] c"print_2d_array_element_int_int\00", align 1
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.58 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@.str.59 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.60 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.61 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@__FUNCTION__.funk_read_list_from_file = private unnamed_addr constant [25 x i8] c"funk_read_list_from_file\00", align 1
@.str.62 = private unnamed_addr constant [28 x i8] c"%s Error r1 (%d) > r2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix_lit_indexes = private unnamed_addr constant [35 x i8] c"funk_create_sub_matrix_lit_indexes\00", align 1
@.str.63 = private unnamed_addr constant [28 x i8] c"%s Error c1 (%d) > c2 (%d)\0A\00", align 1
@.str.64 = private unnamed_addr constant [46 x i8] c"Error: %s shall have 2 dimensions and not %d\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix = private unnamed_addr constant [23 x i8] c"funk_create_sub_matrix\00", align 1
@__FUNCTION__.funk_create_sub_array_lit_indexes = private unnamed_addr constant [34 x i8] c"funk_create_sub_array_lit_indexes\00", align 1
@.str.65 = private unnamed_addr constant [46 x i8] c"Error: %s shall have 1 dimensions and not %d\0A\00", align 1
@__FUNCTION__.funk_create_sub_array = private unnamed_addr constant [22 x i8] c"funk_create_sub_array\00", align 1
@__FUNCTION__.funk_set_node_dimensions = private unnamed_addr constant [25 x i8] c"funk_set_node_dimensions\00", align 1
@__FUNCTION__.funk_set_node_dimensions_2d = private unnamed_addr constant [28 x i8] c"funk_set_node_dimensions_2d\00", align 1
@__FUNCTION__.reshape = private unnamed_addr constant [8 x i8] c"reshape\00", align 1
@__FUNCTION__.funk_concatenate_lists = private unnamed_addr constant [23 x i8] c"funk_concatenate_lists\00", align 1
@.str.66 = private unnamed_addr constant [38 x i8] c"funk_concatenate_lists [] , [] -> []\0A\00", align 1
@__FUNCTION__.funk_get_node_start = private unnamed_addr constant [20 x i8] c"funk_get_node_start\00", align 1
@__FUNCTION__.funk_get_node_pool = private unnamed_addr constant [19 x i8] c"funk_get_node_pool\00", align 1
@.str.67 = private unnamed_addr constant [21 x i8] c"-E- %s Invalid pool\0A\00", align 1
@__FUNCTION__.funk_set_node_len = private unnamed_addr constant [18 x i8] c"funk_set_node_len\00", align 1
@__FUNCTION__.funk_set_node_pool = private unnamed_addr constant [19 x i8] c"funk_set_node_pool\00", align 1
@__FUNCTION__.funk_set_node_start = private unnamed_addr constant [20 x i8] c"funk_set_node_start\00", align 1
@__FUNCTION__.funk_alloc_tnode_array_from_range_regs = private unnamed_addr constant [39 x i8] c"funk_alloc_tnode_array_from_range_regs\00", align 1
@.str.68 = private unnamed_addr constant [36 x i8] c"-E- %s Invalid range from %d to %d\0A\00", align 1
@__FUNCTION__.funk_alloc_tnode_array_from_range_len = private unnamed_addr constant [38 x i8] c"funk_alloc_tnode_array_from_range_len\00", align 1
@__FUNCTION__.funk_set_tnode_array_element = private unnamed_addr constant [29 x i8] c"funk_set_tnode_array_element\00", align 1
@.str.69 = private unnamed_addr constant [37 x i8] c"-E- %s Index %d out of range [0:%d]\0A\00", align 1
@__FUNCTION__.funk_alloc_list_of_tnodes = private unnamed_addr constant [26 x i8] c"funk_alloc_list_of_tnodes\00", align 1
@__FUNCTION__.funk_call_fn_pointer = private unnamed_addr constant [21 x i8] c"funk_call_fn_pointer\00", align 1
@.str.70 = private unnamed_addr constant [43 x i8] c"-E- calling node which is not a function!\0A\00", align 1

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
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.get_pool_ptr, i64 0, i64 0))
  store %struct.tpool* null, %struct.tpool** %2, align 8
  br label %9

9:                                                ; preds = %7, %6, %5
  %10 = load %struct.tpool*, %struct.tpool** %2, align 8
  ret %struct.tpool* %10
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @validate_node(%struct.tnode*, i8*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i8*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i8* %1, i8** %5, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  %7 = icmp eq %struct.tnode* %6, null
  br i1 %7, label %8, label %13

8:                                                ; preds = %2
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.1, i64 0, i64 0))
  %10 = load i8*, i8** %5, align 8
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.2, i64 0, i64 0), i8* %10)
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.3, i64 0, i64 0))
  store %struct.tnode* null, %struct.tnode** %3, align 8
  br label %44

13:                                               ; preds = %2
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 2
  %16 = load %struct.tpool*, %struct.tpool** %15, align 8
  %17 = icmp ne %struct.tpool* %16, @funk_global_memory_pool
  br i1 %17, label %18, label %42

18:                                               ; preds = %13
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 2
  %21 = load %struct.tpool*, %struct.tpool** %20, align 8
  %22 = icmp ne %struct.tpool* %21, @funk_functions_memory_pool
  br i1 %22, label %23, label %42

23:                                               ; preds = %18
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.1, i64 0, i64 0))
  %25 = load i8*, i8** %5, align 8
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = add i32 %31, %34
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = load %struct.tnode*, %struct.tnode** %4, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 2
  %39 = load %struct.tpool*, %struct.tpool** %38, align 8
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([74 x i8], [74 x i8]* @.str.4, i64 0, i64 0), i8* %25, i32 %28, i32 %35, %struct.tnode* %36, %struct.tpool* %39)
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.3, i64 0, i64 0))
  store %struct.tnode* null, %struct.tnode** %3, align 8
  br label %44

42:                                               ; preds = %18, %13
  %43 = load %struct.tnode*, %struct.tnode** %4, align 8
  store %struct.tnode* %43, %struct.tnode** %3, align 8
  br label %44

44:                                               ; preds = %42, %23, %8
  %45 = load %struct.tnode*, %struct.tnode** %3, align 8
  ret %struct.tnode* %45
}

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
define i32 @_funk_get_node_dimension(%struct.tnode*, i32, i8*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store i32 %1, i32* %6, align 4
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 3
  %13 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  store i32 %14, i32* %9, align 4
  %15 = load i32, i32* %9, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %4
  br label %32

18:                                               ; preds = %4
  %19 = load %struct.tnode*, %struct.tnode** %5, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 2
  %21 = load %struct.tpool*, %struct.tpool** %20, align 8
  %22 = getelementptr inbounds %struct.tpool, %struct.tpool* %21, i32 0, i32 0
  %23 = load i32, i32* %9, align 4
  %24 = load i32, i32* %6, align 4
  %25 = add i32 %23, %24
  %26 = urem i32 %25, 250000
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %22, i64 0, i64 %27
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  br label %32

32:                                               ; preds = %18, %17
  %33 = phi i32 [ 1, %17 ], [ %31, %18 ]
  store i32 %33, i32* %10, align 4
  %34 = load i32, i32* %10, align 4
  ret i32 %34
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
  br i1 %16, label %17, label %20

17:                                               ; preds = %5
  %18 = load i32, i32* %7, align 4
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__._funk_set_node_dimension, i64 0, i64 0), i32 %18)
  call void @exit(i32 1) #6
  unreachable

20:                                               ; preds = %5
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 3
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  store i32 %24, i32* %11, align 4
  %25 = load i32, i32* %11, align 4
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %28

27:                                               ; preds = %20
  br label %51

28:                                               ; preds = %20
  %29 = load i32, i32* %11, align 4
  %30 = load i32, i32* %7, align 4
  %31 = add i32 %29, %30
  %32 = urem i32 %31, 250000
  store i32 %32, i32* %12, align 4
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 2
  %35 = load %struct.tpool*, %struct.tpool** %34, align 8
  %36 = getelementptr inbounds %struct.tpool, %struct.tpool* %35, i32 0, i32 0
  %37 = load i32, i32* %12, align 4
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %36, i64 0, i64 %38
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  store i32 1, i32* %40, align 8
  %41 = load i32, i32* %8, align 4
  %42 = load %struct.tnode*, %struct.tnode** %6, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  %44 = load %struct.tpool*, %struct.tpool** %43, align 8
  %45 = getelementptr inbounds %struct.tpool, %struct.tpool* %44, i32 0, i32 0
  %46 = load i32, i32* %12, align 4
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %45, i64 0, i64 %47
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 2
  %50 = bitcast %union.data_type* %49 to i32*
  store i32 %41, i32* %50, align 8
  br label %51

51:                                               ; preds = %28, %27
  ret void
}

; Function Attrs: noreturn
declare void @exit(i32) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tdata* @get_node(%struct.tnode*, i32, i8*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.tdata*, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store i8* %2, i8** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = icmp eq %struct.tnode* %13, null
  br i1 %14, label %15, label %17

15:                                               ; preds = %5
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

17:                                               ; preds = %5
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = call %struct.tnode* @validate_node(%struct.tnode* %18, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0))
  %20 = icmp eq %struct.tnode* %19, null
  br i1 %20, label %21, label %25

21:                                               ; preds = %17
  %22 = load i8*, i8** %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i64 0, i64 0), i8* %22, i32 %23)
  call void @exit(i32 1) #6
  unreachable

25:                                               ; preds = %17
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = load i32, i32* %7, align 4
  %30 = add i32 %28, %29
  store i32 %30, i32* %11, align 4
  %31 = load %struct.tnode*, %struct.tnode** %6, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 2
  %33 = load %struct.tpool*, %struct.tpool** %32, align 8
  %34 = getelementptr inbounds %struct.tpool, %struct.tpool* %33, i32 0, i32 0
  %35 = load i32, i32* %11, align 4
  %36 = urem i32 %35, 250000
  %37 = zext i32 %36 to i64
  %38 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %34, i64 0, i64 %37
  store %struct.tdata* %38, %struct.tdata** %12, align 8
  %39 = load i32, i32* %10, align 4
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %101

41:                                               ; preds = %25
  %42 = load %struct.tdata*, %struct.tdata** %12, align 8
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 1
  %44 = load i8, i8* %43, align 4
  %45 = zext i8 %44 to i32
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 2
  %48 = load %struct.tpool*, %struct.tpool** %47, align 8
  %49 = getelementptr inbounds %struct.tpool, %struct.tpool* %48, i32 0, i32 2
  %50 = load i8, i8* %49, align 4
  %51 = zext i8 %50 to i32
  %52 = icmp slt i32 %45, %51
  br i1 %52, label %53, label %101

53:                                               ; preds = %41
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 0
  %56 = load i32, i32* %55, align 8
  %57 = load %struct.tnode*, %struct.tnode** %6, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 2
  %59 = load %struct.tpool*, %struct.tpool** %58, align 8
  %60 = getelementptr inbounds %struct.tpool, %struct.tpool* %59, i32 0, i32 1
  %61 = load i32, i32* %60, align 8
  %62 = icmp ule i32 %56, %61
  br i1 %62, label %63, label %101

63:                                               ; preds = %53
  %64 = load i8*, i8** %8, align 8
  %65 = load i32, i32* %9, align 4
  %66 = load i32, i32* %11, align 4
  %67 = load %struct.tdata*, %struct.tdata** %12, align 8
  %68 = getelementptr inbounds %struct.tdata, %struct.tdata* %67, i32 0, i32 1
  %69 = load i8, i8* %68, align 4
  %70 = zext i8 %69 to i32
  %71 = load %struct.tnode*, %struct.tnode** %6, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 2
  %73 = load %struct.tpool*, %struct.tpool** %72, align 8
  %74 = icmp eq %struct.tpool* %73, @funk_global_memory_pool
  %75 = zext i1 %74 to i64
  %76 = select i1 %74, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %77 = load %struct.tnode*, %struct.tnode** %6, align 8
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 2
  %79 = load %struct.tpool*, %struct.tpool** %78, align 8
  %80 = getelementptr inbounds %struct.tpool, %struct.tpool* %79, i32 0, i32 2
  %81 = load i8, i8* %80, align 4
  %82 = zext i8 %81 to i32
  %83 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([79 x i8], [79 x i8]* @.str.8, i64 0, i64 0), i8* %64, i32 %65, i32 %66, i32 %70, i8* %76, i32 %82)
  %84 = load %struct.tnode*, %struct.tnode** %6, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 2
  %86 = load %struct.tpool*, %struct.tpool** %85, align 8
  %87 = icmp eq %struct.tpool* %86, @funk_global_memory_pool
  %88 = zext i1 %87 to i64
  %89 = select i1 %87, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %90 = load %struct.tnode*, %struct.tnode** %6, align 8
  %91 = getelementptr inbounds %struct.tnode, %struct.tnode* %90, i32 0, i32 0
  %92 = load i32, i32* %91, align 8
  %93 = load %struct.tnode*, %struct.tnode** %6, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 0
  %95 = load i32, i32* %94, align 8
  %96 = load %struct.tnode*, %struct.tnode** %6, align 8
  %97 = getelementptr inbounds %struct.tnode, %struct.tnode* %96, i32 0, i32 1
  %98 = load i32, i32* %97, align 4
  %99 = add i32 %95, %98
  %100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.11, i64 0, i64 0), i8* %89, i32 %92, i32 %99)
  call void @exit(i32 1) #6
  unreachable

101:                                              ; preds = %53, %41, %25
  %102 = load %struct.tdata*, %struct.tdata** %12, align 8
  ret %struct.tdata* %102
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define zeroext i8 @_get_wrap_creation(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = load i32, i32* %4, align 4
  %7 = call %struct.tdata* @get_node(%struct.tnode* %5, i32 %6, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__._get_wrap_creation, i64 0, i64 0), i32 184, i32 1)
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
  %7 = load i8, i8* %6, align 1
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = load i32, i32* %5, align 4
  %10 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 %9, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__._set_wrap_creation, i64 0, i64 0), i32 191, i32 0)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 1
  store i8 %7, i8* %11, align 4
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
define void @funk_increment_pool_tail(%struct.tpool*) #0 {
  %2 = alloca %struct.tpool*, align 8
  store %struct.tpool* %0, %struct.tpool** %2, align 8
  %3 = load %struct.tpool*, %struct.tpool** %2, align 8
  %4 = icmp eq %struct.tpool* %3, @funk_global_memory_pool
  br i1 %4, label %5, label %28

5:                                                ; preds = %1
  %6 = load %struct.tpool*, %struct.tpool** %2, align 8
  %7 = getelementptr inbounds %struct.tpool, %struct.tpool* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 8
  %9 = add i32 %8, 1
  %10 = icmp uge i32 %9, 250000
  br i1 %10, label %11, label %28

11:                                               ; preds = %5
  %12 = load %struct.tpool*, %struct.tpool** %2, align 8
  %13 = getelementptr inbounds %struct.tpool, %struct.tpool* %12, i32 0, i32 2
  %14 = load i8, i8* %13, align 4
  %15 = add i8 %14, 1
  store i8 %15, i8* %13, align 4
  %16 = load %struct.tpool*, %struct.tpool** %2, align 8
  %17 = icmp eq %struct.tpool* %16, @funk_global_memory_pool
  %18 = zext i1 %17 to i64
  %19 = select i1 %17, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %20 = load %struct.tpool*, %struct.tpool** %2, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 8
  %23 = load %struct.tpool*, %struct.tpool** %2, align 8
  %24 = getelementptr inbounds %struct.tpool, %struct.tpool* %23, i32 0, i32 2
  %25 = load i8, i8* %24, align 4
  %26 = zext i8 %25 to i32
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_increment_pool_tail, i64 0, i64 0), i8* %19, i32 %22, i32 250000, i32 %26)
  store i32 0, i32* @g_debug_continue, align 4
  br label %28

28:                                               ; preds = %11, %5, %1
  %29 = load %struct.tpool*, %struct.tpool** %2, align 8
  %30 = getelementptr inbounds %struct.tpool, %struct.tpool* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 8
  %32 = add i32 %31, 1
  %33 = urem i32 %32, 250000
  %34 = load %struct.tpool*, %struct.tpool** %2, align 8
  %35 = getelementptr inbounds %struct.tpool, %struct.tpool* %34, i32 0, i32 1
  store i32 %33, i32* %35, align 8
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
  %9 = icmp slt i32 %8, 8
  br i1 %9, label %10, label %16

10:                                               ; preds = %6
  %11 = load i8, i8* %2, align 1
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [7 x [100 x i8]], [7 x [100 x i8]]* @funk_types_str, i64 0, i64 %12
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %13, i64 0, i64 0
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.13, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.15, i64 0, i64 0))
  %4 = load %struct.tnode*, %struct.tnode** %2, align 8
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.16, i64 0, i64 0), %struct.tnode* %4)
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 3
  %8 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.17, i64 0, i64 0), i32 %9)
  %11 = load %struct.tnode*, %struct.tnode** %2, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  %13 = load %struct.tpool*, %struct.tpool** %12, align 8
  %14 = icmp eq %struct.tpool* %13, @funk_global_memory_pool
  %15 = zext i1 %14 to i64
  %16 = select i1 %14, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %17 = load %struct.tnode*, %struct.tnode** %2, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %23)
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.18, i64 0, i64 0), i8* %16, i32 %19, i32 %22, i32 %24)
  %26 = load %struct.tnode*, %struct.tnode** %2, align 8
  %27 = call %struct.tdata* @get_node(%struct.tnode* %26, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 261, i32 1)
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 2
  %29 = bitcast %union.data_type* %28 to i32*
  %30 = load i32, i32* %29, align 8
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.19, i64 0, i64 0), i32 %30)
  %32 = load %struct.tnode*, %struct.tnode** %2, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 262, i32 1)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 2
  %35 = bitcast %union.data_type* %34 to double*
  %36 = load double, double* %35, align 8
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.20, i64 0, i64 0), double %36)
  %38 = load %struct.tnode*, %struct.tnode** %2, align 8
  %39 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 263, i32 1)
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = trunc i32 %41 to i8
  call void @funk_print_type(i8 zeroext %42)
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.15, i64 0, i64 0))
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

12:                                               ; preds = %27, %3
  %13 = load i32, i32* %8, align 4
  %14 = load i32, i32* %5, align 4
  %15 = icmp ult i32 %13, %14
  br i1 %15, label %16, label %30

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
  call void @funk_increment_pool_tail(%struct.tpool* %26)
  br label %27

27:                                               ; preds = %16
  %28 = load i32, i32* %8, align 4
  %29 = add i32 %28, 1
  store i32 %29, i32* %8, align 4
  br label %12

30:                                               ; preds = %12
  %31 = load i32, i32* %7, align 4
  ret i32 %31
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
  %47 = load %struct.tnode*, %struct.tnode** %7, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 4
  %49 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %48, i32 0, i32 1
  store i32 0, i32* %49, align 4
  %50 = load %struct.tnode*, %struct.tnode** %7, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 4
  %52 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %51, i32 0, i32 0
  store i32 0, i32* %52, align 8
  %53 = load i8, i8* %11, align 1
  %54 = zext i8 %53 to i32
  %55 = icmp sge i32 %54, 2
  br i1 %55, label %56, label %65

56:                                               ; preds = %32
  %57 = load %struct.tnode*, %struct.tnode** %7, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 0
  %59 = load i32, i32* %58, align 8
  %60 = load i32, i32* %8, align 4
  %61 = add i32 %59, %60
  %62 = load %struct.tnode*, %struct.tnode** %7, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 3
  %64 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %63, i32 0, i32 1
  store i32 %61, i32* %64, align 4
  br label %69

65:                                               ; preds = %32
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 1
  store i32 0, i32* %68, align 4
  br label %69

69:                                               ; preds = %65, %56
  %70 = load %struct.tnode*, %struct.tnode** %7, align 8
  %71 = load i8, i8* %11, align 1
  %72 = zext i8 %71 to i32
  call void @_funk_set_node_dimension_count(%struct.tnode* %70, i32 %72)
  store i32 0, i32* %15, align 4
  br label %73

73:                                               ; preds = %131, %69
  %74 = load i32, i32* %15, align 4
  %75 = load i32, i32* %13, align 4
  %76 = icmp ult i32 %74, %75
  br i1 %76, label %77, label %134

77:                                               ; preds = %73
  %78 = load i32, i32* %10, align 4
  %79 = load %struct.tnode*, %struct.tnode** %7, align 8
  %80 = load i32, i32* %15, align 4
  %81 = call %struct.tdata* @get_node(%struct.tnode* %79, i32 %80, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 320, i32 0)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  store i32 %78, i32* %82, align 8
  %83 = load %struct.tnode*, %struct.tnode** %7, align 8
  %84 = load i32, i32* %15, align 4
  %85 = load %struct.tpool*, %struct.tpool** %14, align 8
  %86 = getelementptr inbounds %struct.tpool, %struct.tpool* %85, i32 0, i32 2
  %87 = load i8, i8* %86, align 4
  call void @_set_wrap_creation(%struct.tnode* %83, i32 %84, i8 zeroext %87)
  %88 = load %struct.tpool*, %struct.tpool** %14, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %88)
  %89 = load i8*, i8** %12, align 8
  %90 = icmp eq i8* %89, null
  br i1 %90, label %91, label %92

91:                                               ; preds = %77
  br label %131

92:                                               ; preds = %77
  %93 = load i32, i32* %10, align 4
  switch i32 %93, label %129 [
    i32 1, label %94
    i32 2, label %106
    i32 4, label %118
  ]

94:                                               ; preds = %92
  %95 = load i8*, i8** %12, align 8
  %96 = bitcast i8* %95 to i32*
  %97 = load i32, i32* %15, align 4
  %98 = zext i32 %97 to i64
  %99 = getelementptr inbounds i32, i32* %96, i64 %98
  %100 = load i32, i32* %99, align 4
  %101 = load %struct.tnode*, %struct.tnode** %7, align 8
  %102 = load i32, i32* %15, align 4
  %103 = call %struct.tdata* @get_node(%struct.tnode* %101, i32 %102, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 329, i32 1)
  %104 = getelementptr inbounds %struct.tdata, %struct.tdata* %103, i32 0, i32 2
  %105 = bitcast %union.data_type* %104 to i32*
  store i32 %100, i32* %105, align 8
  br label %130

106:                                              ; preds = %92
  %107 = load i8*, i8** %12, align 8
  %108 = bitcast i8* %107 to double*
  %109 = load i32, i32* %15, align 4
  %110 = zext i32 %109 to i64
  %111 = getelementptr inbounds double, double* %108, i64 %110
  %112 = load double, double* %111, align 8
  %113 = load %struct.tnode*, %struct.tnode** %7, align 8
  %114 = load i32, i32* %15, align 4
  %115 = call %struct.tdata* @get_node(%struct.tnode* %113, i32 %114, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 333, i32 1)
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 2
  %117 = bitcast %union.data_type* %116 to double*
  store double %112, double* %117, align 8
  br label %130

118:                                              ; preds = %92
  %119 = load %struct.tnode*, %struct.tnode** %7, align 8
  %120 = load i32, i32* %15, align 4
  %121 = call %struct.tdata* @get_node(%struct.tnode* %119, i32 %120, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 337, i32 1)
  %122 = getelementptr inbounds %struct.tdata, %struct.tdata* %121, i32 0, i32 2
  %123 = bitcast %union.data_type* %122 to i32*
  store i32 0, i32* %123, align 8
  %124 = load %struct.tnode*, %struct.tnode** %7, align 8
  %125 = load i32, i32* %15, align 4
  %126 = call %struct.tdata* @get_node(%struct.tnode* %124, i32 %125, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 338, i32 1)
  %127 = getelementptr inbounds %struct.tdata, %struct.tdata* %126, i32 0, i32 2
  %128 = bitcast %union.data_type* %127 to double*
  store double 0.000000e+00, double* %128, align 8
  br label %130

129:                                              ; preds = %92
  br label %130

130:                                              ; preds = %129, %118, %106, %94
  br label %131

131:                                              ; preds = %130, %91
  %132 = load i32, i32* %15, align 4
  %133 = add i32 %132, 1
  store i32 %133, i32* %15, align 4
  br label %73

134:                                              ; preds = %73
  %135 = load i8, i8* %11, align 1
  %136 = zext i8 %135 to i32
  %137 = icmp sge i32 %136, 2
  br i1 %137, label %138, label %157

138:                                              ; preds = %134
  store i32 0, i32* %16, align 4
  br label %139

139:                                              ; preds = %153, %138
  %140 = load i32, i32* %16, align 4
  %141 = load i8, i8* %11, align 1
  %142 = zext i8 %141 to i32
  %143 = icmp ult i32 %140, %142
  br i1 %143, label %144, label %156

144:                                              ; preds = %139
  %145 = load %struct.tnode*, %struct.tnode** %7, align 8
  %146 = load i32, i32* %13, align 4
  %147 = load i32, i32* %16, align 4
  %148 = add i32 %146, %147
  %149 = load %struct.tpool*, %struct.tpool** %14, align 8
  %150 = getelementptr inbounds %struct.tpool, %struct.tpool* %149, i32 0, i32 2
  %151 = load i8, i8* %150, align 4
  call void @_set_wrap_creation(%struct.tnode* %145, i32 %148, i8 zeroext %151)
  %152 = load %struct.tpool*, %struct.tpool** %14, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %152)
  br label %153

153:                                              ; preds = %144
  %154 = load i32, i32* %16, align 4
  %155 = add i32 %154, 1
  store i32 %155, i32* %16, align 4
  br label %139

156:                                              ; preds = %139
  br label %157

157:                                              ; preds = %156, %134
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_clone_node(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = load i32, i32* %6, align 4
  %12 = load %struct.tnode*, %struct.tnode** %5, align 8
  %13 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %12)
  %14 = trunc i32 %13 to i8
  call void @funk_create_node(%struct.tnode* %10, i32 %11, i32 1, i32 1, i8 zeroext %14, i8* null)
  store i32 0, i32* %7, align 4
  br label %15

15:                                               ; preds = %28, %3
  %16 = load i32, i32* %7, align 4
  %17 = load i32, i32* %6, align 4
  %18 = icmp ult i32 %16, %17
  br i1 %18, label %19, label %31

19:                                               ; preds = %15
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %7, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_clone_node, i64 0, i64 0), i32 362, i32 1)
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = load i32, i32* %7, align 4
  %25 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 %24, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_clone_node, i64 0, i64 0), i32 362, i32 1)
  %26 = bitcast %struct.tdata* %22 to i8*
  %27 = bitcast %struct.tdata* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %26, i8* align 8 %27, i64 16, i1 false)
  br label %28

28:                                               ; preds = %19
  %29 = load i32, i32* %7, align 4
  %30 = add i32 %29, 1
  store i32 %30, i32* %7, align 4
  br label %15

31:                                               ; preds = %15
  %32 = load i32, i32* %6, align 4
  %33 = icmp eq i32 %32, 1
  br i1 %33, label %34, label %41

34:                                               ; preds = %31
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 4
  %37 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %36, i32 0, i32 1
  store i32 0, i32* %37, align 4
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 3
  %40 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %39, i32 0, i32 1
  store i32 0, i32* %40, align 4
  br label %68

41:                                               ; preds = %31
  store i32 0, i32* %8, align 4
  br label %42

42:                                               ; preds = %53, %41
  %43 = load i32, i32* %8, align 4
  %44 = load %struct.tnode*, %struct.tnode** %5, align 8
  %45 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %44)
  %46 = icmp ult i32 %43, %45
  br i1 %46, label %47, label %56

47:                                               ; preds = %42
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = load i32, i32* %8, align 4
  %50 = load %struct.tnode*, %struct.tnode** %5, align 8
  %51 = load i32, i32* %8, align 4
  %52 = call i32 @_funk_get_node_dimension(%struct.tnode* %50, i32 %51, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_clone_node, i64 0, i64 0), i32 370)
  call void @_funk_set_node_dimension(%struct.tnode* %48, i32 %49, i32 %52, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_clone_node, i64 0, i64 0), i32 370)
  br label %53

53:                                               ; preds = %47
  %54 = load i32, i32* %8, align 4
  %55 = add i32 %54, 1
  store i32 %55, i32* %8, align 4
  br label %42

56:                                               ; preds = %42
  store i32 0, i32* %9, align 4
  br label %57

57:                                               ; preds = %65, %56
  %58 = load i32, i32* %9, align 4
  %59 = load %struct.tnode*, %struct.tnode** %5, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 4
  %61 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = icmp ult i32 %58, %62
  br i1 %63, label %64, label %68

64:                                               ; preds = %57
  br label %65

65:                                               ; preds = %64
  %66 = load i32, i32* %9, align 4
  %67 = add i32 %66, 1
  store i32 %67, i32* %9, align 4
  br label %57

68:                                               ; preds = %34, %57
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
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.21, i64 0, i64 0))
  call void @exit(i32 0) #6
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sum_list(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  store i32 0, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  store i32 %10, i32* %6, align 4
  %11 = load %struct.tnode*, %struct.tnode** %3, align 8
  %12 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %11)
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %20

14:                                               ; preds = %2
  %15 = load %struct.tnode*, %struct.tnode** %3, align 8
  %16 = call i32 @_funk_get_node_dimension(%struct.tnode* %15, i32 0, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.funk_sum_list, i64 0, i64 0), i32 414)
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = call i32 @_funk_get_node_dimension(%struct.tnode* %17, i32 1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.funk_sum_list, i64 0, i64 0), i32 414)
  %19 = mul i32 %16, %18
  store i32 %19, i32* %6, align 4
  br label %20

20:                                               ; preds = %14, %2
  store i32 0, i32* %7, align 4
  br label %21

21:                                               ; preds = %34, %20
  %22 = load i32, i32* %7, align 4
  %23 = load i32, i32* %6, align 4
  %24 = icmp ult i32 %22, %23
  br i1 %24, label %25, label %37

25:                                               ; preds = %21
  %26 = load %struct.tnode*, %struct.tnode** %3, align 8
  %27 = load i32, i32* %7, align 4
  %28 = call %struct.tdata* @get_node(%struct.tnode* %26, i32 %27, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.funk_sum_list, i64 0, i64 0), i32 419, i32 1)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 2
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = load i32, i32* %5, align 4
  %33 = add i32 %32, %31
  store i32 %33, i32* %5, align 4
  br label %34

34:                                               ; preds = %25
  %35 = load i32, i32* %7, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* %7, align 4
  br label %21

37:                                               ; preds = %21
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = bitcast i32* %5 to i8*
  call void @funk_create_node(%struct.tnode* %38, i32 1, i32 1, i32 1, i8 zeroext 1, i8* %39)
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
define i32 @is_list_consecutive_in_memory(%struct.tnode*, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  %9 = load i32, i32* %5, align 4
  %10 = icmp sle i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  store i32 1, i32* %3, align 4
  br label %38

12:                                               ; preds = %2
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i64 0
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %17

17:                                               ; preds = %34, %12
  %18 = load i32, i32* %7, align 4
  %19 = load i32, i32* %5, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %37

21:                                               ; preds = %17
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = load i32, i32* %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i64 %24
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %8, align 4
  %28 = load i32, i32* %6, align 4
  %29 = add nsw i32 %28, 1
  %30 = load i32, i32* %8, align 4
  %31 = icmp ne i32 %29, %30
  br i1 %31, label %32, label %33

32:                                               ; preds = %21
  store i32 0, i32* %3, align 4
  br label %38

33:                                               ; preds = %21
  br label %34

34:                                               ; preds = %33
  %35 = load i32, i32* %7, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %7, align 4
  br label %17

37:                                               ; preds = %17
  store i32 0, i32* %3, align 4
  br label %38

38:                                               ; preds = %37, %32, %11
  %39 = load i32, i32* %3, align 4
  ret i32 %39
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_element_in_matrix_2d_lit(%struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tdata*, align 8
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %12 = load %struct.tnode*, %struct.tnode** %5, align 8
  %13 = call i32 @_funk_get_node_dimension(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 476)
  store i32 %13, i32* %9, align 4
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call i32 @_funk_get_node_dimension(%struct.tnode* %14, i32 1, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 477)
  store i32 %15, i32* %10, align 4
  %16 = load i32, i32* %9, align 4
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %21, label %18

18:                                               ; preds = %4
  %19 = load i32, i32* %10, align 4
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %26

21:                                               ; preds = %18, %4
  %22 = load i32, i32* %9, align 4
  %23 = load i32, i32* %10, align 4
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 %22, i32 %23)
  %25 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node_info(%struct.tnode* %25)
  call void @exit(i32 1) #6
  unreachable

26:                                               ; preds = %18
  %27 = load i32, i32* %7, align 4
  %28 = icmp slt i32 %27, 0
  br i1 %28, label %29, label %33

29:                                               ; preds = %26
  %30 = load i32, i32* %9, align 4
  %31 = load i32, i32* %7, align 4
  %32 = add i32 %30, %31
  br label %35

33:                                               ; preds = %26
  %34 = load i32, i32* %7, align 4
  br label %35

35:                                               ; preds = %33, %29
  %36 = phi i32 [ %32, %29 ], [ %34, %33 ]
  store i32 %36, i32* %7, align 4
  %37 = load i32, i32* %8, align 4
  %38 = icmp slt i32 %37, 0
  br i1 %38, label %39, label %43

39:                                               ; preds = %35
  %40 = load i32, i32* %10, align 4
  %41 = load i32, i32* %8, align 4
  %42 = add i32 %40, %41
  br label %45

43:                                               ; preds = %35
  %44 = load i32, i32* %8, align 4
  br label %45

45:                                               ; preds = %43, %39
  %46 = phi i32 [ %42, %39 ], [ %44, %43 ]
  store i32 %46, i32* %8, align 4
  %47 = load i32, i32* %9, align 4
  %48 = load i32, i32* %7, align 4
  %49 = urem i32 %48, %47
  store i32 %49, i32* %7, align 4
  %50 = load i32, i32* %10, align 4
  %51 = load i32, i32* %8, align 4
  %52 = urem i32 %51, %50
  store i32 %52, i32* %8, align 4
  %53 = load %struct.tnode*, %struct.tnode** %5, align 8
  %54 = load i32, i32* %9, align 4
  %55 = load i32, i32* %7, align 4
  %56 = mul i32 %54, %55
  %57 = load i32, i32* %8, align 4
  %58 = add i32 %56, %57
  %59 = call %struct.tdata* @get_node(%struct.tnode* %53, i32 %58, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 493, i32 1)
  store %struct.tdata* %59, %struct.tdata** %11, align 8
  %60 = load %struct.tnode*, %struct.tnode** %6, align 8
  %61 = load %struct.tdata*, %struct.tdata** %11, align 8
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 0
  %63 = load i32, i32* %62, align 8
  %64 = load %struct.tdata*, %struct.tdata** %11, align 8
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 2
  %66 = bitcast %union.data_type* %65 to i8*
  call void @funk_create_node(%struct.tnode* %60, i32 1, i32 1, i32 %63, i8 zeroext 0, i8* %66)
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 504, i32 1)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 506, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %20)
  br label %22

22:                                               ; preds = %16, %4
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 509, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = icmp ne i32 %26, 1
  br i1 %27, label %28, label %34

28:                                               ; preds = %22
  %29 = load %struct.tnode*, %struct.tnode** %8, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 511, i32 1)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %32)
  br label %34

34:                                               ; preds = %28, %22
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 514, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 2
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %9, align 4
  %40 = load %struct.tnode*, %struct.tnode** %8, align 8
  %41 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 515, i32 1)
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
define void @funk_get_element_in_array_lit(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = call %struct.tnode* @validate_node(%struct.tnode* %7, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_lit, i64 0, i64 0))
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
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_copy_node(%struct.tnode* %26, %struct.tnode* %27)
  %28 = load %struct.tnode*, %struct.tnode** %5, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  store i32 1, i32* %29, align 4
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load i32, i32* %6, align 4
  %34 = add i32 %32, %33
  %35 = load %struct.tnode*, %struct.tnode** %5, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  store i32 %34, i32* %36, align 8
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 539, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %19

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 541, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 %17)
  br label %19

19:                                               ; preds = %13, %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 544, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 2
  %23 = bitcast %union.data_type* %22 to i32*
  %24 = load i32, i32* %23, align 8
  store i32 %24, i32* %7, align 4
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = load i32, i32* %7, align 4
  call void @funk_get_element_in_array_lit(%struct.tnode* %25, %struct.tnode* %26, i32 %27)
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
  %14 = call %struct.tnode* @validate_node(%struct.tnode* %13, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0))
  %15 = load %struct.tnode*, %struct.tnode** %7, align 8
  %16 = call %struct.tnode* @validate_node(%struct.tnode* %15, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0))
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 558, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %22 = load i32, i32* %9, align 4
  store i32 %22, i32* %11, align 4
  br label %23

23:                                               ; preds = %84, %4
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
  br i1 %34, label %35, label %87

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
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 4
  %57 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %56, i32 0, i32 0
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %12, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 4
  %61 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %60, i32 0, i32 0
  store i32 %58, i32* %61, align 8
  %62 = load %struct.tnode*, %struct.tnode** %6, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 3
  %64 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  %66 = load %struct.tnode*, %struct.tnode** %12, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 1
  store i32 %65, i32* %68, align 4
  %69 = load %struct.tnode*, %struct.tnode** %6, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 4
  %71 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %70, i32 0, i32 1
  %72 = load i32, i32* %71, align 4
  %73 = load %struct.tnode*, %struct.tnode** %12, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 4
  %75 = getelementptr inbounds %struct.tsiblings, %struct.tsiblings* %74, i32 0, i32 1
  store i32 %72, i32* %75, align 4
  %76 = load %struct.tnode*, %struct.tnode** %7, align 8
  %77 = call %struct.tdata* @get_node(%struct.tnode* %76, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 574, i32 1)
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %77, i32 0, i32 2
  %79 = bitcast %union.data_type* %78 to i32*
  %80 = load i32, i32* %79, align 8
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %79, align 8
  %82 = load i32, i32* %10, align 4
  %83 = add i32 %82, 1
  store i32 %83, i32* %10, align 4
  br label %84

84:                                               ; preds = %35
  %85 = load i32, i32* %11, align 4
  %86 = add i32 %85, 1
  store i32 %86, i32* %11, align 4
  br label %23

87:                                               ; preds = %33
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_regroup_list(i32, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca %struct.tdata*, align 8
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_regroup_list, i64 0, i64 0))
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load i32, i32* %5, align 4
  %16 = load %struct.tnode*, %struct.tnode** %7, align 8
  %17 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %16)
  call void @funk_create_node(%struct.tnode* %13, i32 %14, i32 %15, i32 %17, i8 zeroext 0, i8* null)
  %18 = load %struct.tnode*, %struct.tnode** %7, align 8
  %19 = load i32, i32* %8, align 4
  %20 = call i32 @is_list_consecutive_in_memory(%struct.tnode* %18, i32 %19)
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %29

22:                                               ; preds = %4
  %23 = load %struct.tnode*, %struct.tnode** %7, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i64 0
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 0
  store i32 %26, i32* %28, align 8
  br label %50

29:                                               ; preds = %4
  store i32 0, i32* %9, align 4
  br label %30

30:                                               ; preds = %46, %29
  %31 = load i32, i32* %9, align 4
  %32 = load i32, i32* %8, align 4
  %33 = icmp ult i32 %31, %32
  br i1 %33, label %34, label %49

34:                                               ; preds = %30
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = load i32, i32* %9, align 4
  %37 = zext i32 %36 to i64
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i64 %37
  %39 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_regroup_list, i64 0, i64 0), i32 595, i32 1)
  store %struct.tdata* %39, %struct.tdata** %10, align 8
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = load i32, i32* %9, align 4
  %42 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 %41, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_regroup_list, i64 0, i64 0), i32 596, i32 1)
  %43 = load %struct.tdata*, %struct.tdata** %10, align 8
  %44 = bitcast %struct.tdata* %42 to i8*
  %45 = bitcast %struct.tdata* %43 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %44, i8* align 8 %45, i64 16, i1 false)
  br label %46

46:                                               ; preds = %34
  %47 = load i32, i32* %9, align 4
  %48 = add i32 %47, 1
  store i32 %48, i32* %9, align 4
  br label %30

49:                                               ; preds = %30
  br label %50

50:                                               ; preds = %49, %22
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_regroup_list_r(i32, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %9 = load i32, i32* %5, align 4
  %10 = load %struct.tnode*, %struct.tnode** %6, align 8
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = load %struct.tnode*, %struct.tnode** %8, align 8
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_regroup_list_r, i64 0, i64 0), i32 607, i32 1)
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 2
  %15 = bitcast %union.data_type* %14 to i32*
  %16 = load i32, i32* %15, align 8
  call void @funk_regroup_list(i32 %9, %struct.tnode* %10, %struct.tnode* %11, i32 %16)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_2d_matrix(i32, %struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, i32* %6, align 4
  store %struct.tnode* %1, %struct.tnode** %7, align 8
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.24, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable
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
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_create_double_scalar, i64 0, i64 0))
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
  %11 = call %struct.tnode* @validate_node(%struct.tnode* %10, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_of_regs(i32, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load %struct.tnode*, %struct.tnode** %6, align 8
  %11 = load i32, i32* %8, align 4
  %12 = load i32, i32* %5, align 4
  call void @funk_create_node(%struct.tnode* %10, i32 %11, i32 %12, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %9, align 4
  br label %13

13:                                               ; preds = %28, %4
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %8, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %31

17:                                               ; preds = %13
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = load i32, i32* %9, align 4
  %20 = call %struct.tdata* @get_node(%struct.tnode* %18, i32 %19, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 648, i32 0)
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = load i32, i32* %9, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i64 %23
  %25 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 648, i32 1)
  %26 = bitcast %struct.tdata* %20 to i8*
  %27 = bitcast %struct.tdata* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %26, i8* align 8 %27, i64 16, i1 false)
  br label %28

28:                                               ; preds = %17
  %29 = load i32, i32* %9, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %9, align 4
  br label %13

31:                                               ; preds = %13
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
  call void @_funk_set_node_dimension(%struct.tnode* %18, i32 0, i32 %19, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0), i32 670)
  %20 = load %struct.tnode*, %struct.tnode** %7, align 8
  %21 = load i32, i32* %10, align 4
  call void @_funk_set_node_dimension(%struct.tnode* %20, i32 1, i32 %21, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0), i32 671)
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
  switch i32 %8, label %21 [
    i32 1, label %9
    i32 2, label %14
    i32 4, label %19
  ]

9:                                                ; preds = %2
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.25, i64 0, i64 0), i32 %12)
  br label %23

14:                                               ; preds = %2
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 2
  %16 = bitcast %union.data_type* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.26, i64 0, i64 0), double %17)
  br label %23

19:                                               ; preds = %2
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.27, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.28, i64 0, i64 0))
  br label %23

21:                                               ; preds = %2
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.27, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i64 0, i64 0))
  br label %23

23:                                               ; preds = %21, %19, %14, %9
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11, %3
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 701, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load i32, i32* %6, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %5, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 712, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  store i32 %19, i32* %23, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_increment_node_data_int(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tdata* @get_node(%struct.tnode* %3, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_increment_node_data_int, i64 0, i64 0), i32 717, i32 1)
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_copy_node_into_node_list, i64 0, i64 0), i32 724, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 737, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 1, i32* %22, align 8
  %23 = load i32, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 738, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 747, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 6, i32* %22, align 8
  %23 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 748, i32 1)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 757, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 2, i32* %22, align 8
  %23 = load double, double* %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 758, i32 1)
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
  br label %16

16:                                               ; preds = %10, %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = load i32, i32* %4, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 766, i32 1)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 2
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_pool(%struct.tpool*, i32, i32) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load %struct.tpool*, %struct.tpool** %4, align 8
  %9 = getelementptr inbounds %struct.tpool, %struct.tpool* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 8
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.31, i64 0, i64 0), i32 %10)
  %12 = load i32, i32* %5, align 4
  store i32 %12, i32* %7, align 4
  br label %13

13:                                               ; preds = %40, %3
  %14 = load i32, i32* %7, align 4
  %15 = load i32, i32* %5, align 4
  %16 = load i32, i32* %6, align 4
  %17 = add nsw i32 %15, %16
  %18 = icmp slt i32 %14, %17
  br i1 %18, label %19, label %43

19:                                               ; preds = %13
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 0
  %22 = load i32, i32* %7, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %21, i64 0, i64 %23
  %25 = bitcast %struct.tdata* %24 to { i64, i64 }*
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 0
  %27 = load i64, i64* %26, align 8
  %28 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  call void @funk_print_scalar_element(i64 %27, i64 %29)
  %30 = load i32, i32* %7, align 4
  %31 = icmp sgt i32 %30, 0
  br i1 %31, label %32, label %39

32:                                               ; preds = %19
  %33 = load i32, i32* %7, align 4
  %34 = add nsw i32 %33, 1
  %35 = srem i32 %34, 7
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %39

37:                                               ; preds = %32
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i64 0, i64 0))
  br label %39

39:                                               ; preds = %37, %32, %19
  br label %40

40:                                               ; preds = %39
  %41 = load i32, i32* %7, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %7, align 4
  br label %13

43:                                               ; preds = %13
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i64 0, i64 0))
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
define void @funk_memcp_arr(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  store i32 0, i32* %7, align 4
  br label %8

8:                                                ; preds = %21, %3
  %9 = load i32, i32* %7, align 4
  %10 = load i32, i32* %6, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %24

12:                                               ; preds = %8
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = load i32, i32* %7, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i64 %15
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = load i32, i32* %7, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i64 %19
  call void @funk_copy_node(%struct.tnode* %16, %struct.tnode* %20)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %7, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %7, align 4
  br label %8

24:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @debug_print_arith_operation(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = call %struct.tnode* @validate_node(%struct.tnode* %13, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0))
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = call %struct.tnode* @validate_node(%struct.tnode* %15, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0))
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = call %struct.tnode* @validate_node(%struct.tnode* %17, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0))
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 2
  %21 = load %struct.tpool*, %struct.tpool** %20, align 8
  %22 = icmp eq %struct.tpool* %21, @funk_global_memory_pool
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = load i32, i32* %10, align 4
  %29 = add i32 %27, %28
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.33, i64 0, i64 0), i8* %24, i32 %29)
  %31 = load %struct.tnode*, %struct.tnode** %9, align 8
  %32 = load i32, i32* %10, align 4
  %33 = call %struct.tdata* @get_node(%struct.tnode* %31, i32 %32, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 878, i32 1)
  %34 = bitcast %struct.tdata* %33 to { i64, i64 }*
  %35 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %34, i32 0, i32 0
  %36 = load i64, i64* %35, align 8
  %37 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %34, i32 0, i32 1
  %38 = load i64, i64* %37, align 8
  call void @funk_print_scalar_element(i64 %36, i64 %38)
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.34, i64 0, i64 0))
  %40 = load %struct.tnode*, %struct.tnode** %11, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 2
  %42 = load %struct.tpool*, %struct.tpool** %41, align 8
  %43 = icmp eq %struct.tpool* %42, @funk_global_memory_pool
  %44 = zext i1 %43 to i64
  %45 = select i1 %43, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %46 = load %struct.tnode*, %struct.tnode** %11, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = load i32, i32* %12, align 4
  %50 = add i32 %48, %49
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.33, i64 0, i64 0), i8* %45, i32 %50)
  %52 = load %struct.tnode*, %struct.tnode** %11, align 8
  %53 = load i32, i32* %12, align 4
  %54 = call %struct.tdata* @get_node(%struct.tnode* %52, i32 %53, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 881, i32 1)
  %55 = bitcast %struct.tdata* %54 to { i64, i64 }*
  %56 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %55, i32 0, i32 0
  %57 = load i64, i64* %56, align 8
  %58 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %55, i32 0, i32 1
  %59 = load i64, i64* %58, align 8
  call void @funk_print_scalar_element(i64 %57, i64 %59)
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 2
  %62 = load %struct.tpool*, %struct.tpool** %61, align 8
  %63 = icmp eq %struct.tpool* %62, @funk_global_memory_pool
  %64 = zext i1 %63 to i64
  %65 = select i1 %63, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 0
  %68 = load i32, i32* %67, align 8
  %69 = load i32, i32* %8, align 4
  %70 = add i32 %68, %69
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.35, i64 0, i64 0), i8* %65, i32 %70)
  %72 = load %struct.tnode*, %struct.tnode** %7, align 8
  %73 = load i32, i32* %8, align 4
  %74 = call %struct.tdata* @get_node(%struct.tnode* %72, i32 %73, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 884, i32 1)
  %75 = bitcast %struct.tdata* %74 to { i64, i64 }*
  %76 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %75, i32 0, i32 0
  %77 = load i64, i64* %76, align 8
  %78 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %75, i32 0, i32 1
  %79 = load i64, i64* %78, align 8
  call void @funk_print_scalar_element(i64 %77, i64 %79)
  %80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.36, i64 0, i64 0))
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_mul, i64 0, i64 0))
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_div, i64 0, i64 0))
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_add, i64 0, i64 0))
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sub, i64 0, i64 0))
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
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_slt, i64 0, i64 0))
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
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sgt, i64 0, i64 0))
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
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_sge, i64 0, i64 0))
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
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_eq, i64 0, i64 0))
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
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_ne, i64 0, i64 0))
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
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.funk_or, i64 0, i64 0))
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
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.funk_and, i64 0, i64 0))
  br label %48

48:                                               ; preds = %46, %40
  br label %49

49:                                               ; preds = %48, %21
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_funk_arith_op_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32, void (i8*, i8*, i8*, i32)*) #0 {
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.tnode*, align 8
  %13 = alloca i32, align 4
  %14 = alloca void (i8*, i8*, i8*, i32)*, align 8
  %15 = alloca %struct.tdata, align 8
  %16 = alloca %struct.tdata, align 8
  %17 = alloca %struct.tdata*, align 8
  %18 = alloca i8, align 1
  %19 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %8, align 8
  store i32 %1, i32* %9, align 4
  store %struct.tnode* %2, %struct.tnode** %10, align 8
  store i32 %3, i32* %11, align 4
  store %struct.tnode* %4, %struct.tnode** %12, align 8
  store i32 %5, i32* %13, align 4
  store void (i8*, i8*, i8*, i32)* %6, void (i8*, i8*, i8*, i32)** %14, align 8
  %20 = load %struct.tnode*, %struct.tnode** %10, align 8
  %21 = call %struct.tnode* @validate_node(%struct.tnode* %20, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %22 = load %struct.tnode*, %struct.tnode** %12, align 8
  %23 = call %struct.tnode* @validate_node(%struct.tnode* %22, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %24 = load %struct.tnode*, %struct.tnode** %8, align 8
  %25 = call %struct.tnode* @validate_node(%struct.tnode* %24, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %26 = load i32, i32* %11, align 4
  %27 = load %struct.tnode*, %struct.tnode** %10, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = icmp ugt i32 %26, %29
  br i1 %30, label %31, label %37

31:                                               ; preds = %7
  %32 = load i32, i32* %11, align 4
  %33 = load %struct.tnode*, %struct.tnode** %10, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.37, i64 0, i64 0), i32 %32, i32 %35)
  br label %37

37:                                               ; preds = %31, %7
  %38 = load i32, i32* %13, align 4
  %39 = load %struct.tnode*, %struct.tnode** %12, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = icmp ugt i32 %38, %41
  br i1 %42, label %43, label %49

43:                                               ; preds = %37
  %44 = load i32, i32* %13, align 4
  %45 = load %struct.tnode*, %struct.tnode** %12, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 1
  %47 = load i32, i32* %46, align 4
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.37, i64 0, i64 0), i32 %44, i32 %47)
  br label %49

49:                                               ; preds = %43, %37
  %50 = load i32, i32* %9, align 4
  %51 = load %struct.tnode*, %struct.tnode** %8, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = icmp ugt i32 %50, %53
  br i1 %54, label %55, label %61

55:                                               ; preds = %49
  %56 = load i32, i32* %9, align 4
  %57 = load %struct.tnode*, %struct.tnode** %8, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.37, i64 0, i64 0), i32 %56, i32 %59)
  br label %61

61:                                               ; preds = %55, %49
  %62 = load %struct.tnode*, %struct.tnode** %10, align 8
  %63 = load i32, i32* %11, align 4
  %64 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 %63, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1051, i32 1)
  %65 = bitcast %struct.tdata* %15 to i8*
  %66 = bitcast %struct.tdata* %64 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %65, i8* align 8 %66, i64 16, i1 false)
  %67 = load %struct.tnode*, %struct.tnode** %12, align 8
  %68 = load i32, i32* %13, align 4
  %69 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 %68, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1052, i32 1)
  %70 = bitcast %struct.tdata* %16 to i8*
  %71 = bitcast %struct.tdata* %69 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %70, i8* align 8 %71, i64 16, i1 false)
  %72 = load %struct.tnode*, %struct.tnode** %8, align 8
  %73 = load i32, i32* %9, align 4
  %74 = call %struct.tdata* @get_node(%struct.tnode* %72, i32 %73, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 1053, i32 1)
  store %struct.tdata* %74, %struct.tdata** %17, align 8
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %76 = load i32, i32* %75, align 8
  %77 = trunc i32 %76 to i8
  store i8 %77, i8* %18, align 1
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %79 = load i32, i32* %78, align 8
  %80 = trunc i32 %79 to i8
  store i8 %80, i8* %19, align 1
  %81 = load i8, i8* %19, align 1
  %82 = zext i8 %81 to i32
  %83 = icmp eq i32 %82, 4
  br i1 %83, label %84, label %85

84:                                               ; preds = %61
  store i8 1, i8* %19, align 1
  br label %85

85:                                               ; preds = %84, %61
  %86 = load i8, i8* %18, align 1
  %87 = zext i8 %86 to i32
  %88 = icmp eq i32 %87, 4
  br i1 %88, label %89, label %90

89:                                               ; preds = %85
  store i8 1, i8* %18, align 1
  br label %90

90:                                               ; preds = %89, %85
  %91 = load i8, i8* %18, align 1
  %92 = zext i8 %91 to i32
  %93 = icmp eq i32 %92, 1
  br i1 %93, label %94, label %112

94:                                               ; preds = %90
  %95 = load i8, i8* %19, align 1
  %96 = zext i8 %95 to i32
  %97 = icmp eq i32 %96, 1
  br i1 %97, label %98, label %112

98:                                               ; preds = %94
  %99 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %100 = load %struct.tdata*, %struct.tdata** %17, align 8
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 2
  %102 = bitcast %union.data_type* %101 to i32*
  %103 = bitcast i32* %102 to i8*
  %104 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 2
  %105 = bitcast %union.data_type* %104 to i32*
  %106 = bitcast i32* %105 to i8*
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %108 = bitcast %union.data_type* %107 to i32*
  %109 = bitcast i32* %108 to i8*
  call void %99(i8* %103, i8* %106, i8* %109, i32 1)
  %110 = load %struct.tdata*, %struct.tdata** %17, align 8
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 0
  store i32 1, i32* %111, align 8
  br label %254

112:                                              ; preds = %94, %90
  %113 = load i8, i8* %18, align 1
  %114 = zext i8 %113 to i32
  %115 = icmp eq i32 %114, 2
  br i1 %115, label %116, label %134

116:                                              ; preds = %112
  %117 = load i8, i8* %19, align 1
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %134

120:                                              ; preds = %116
  %121 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %122 = load %struct.tdata*, %struct.tdata** %17, align 8
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 2
  %124 = bitcast %union.data_type* %123 to double*
  %125 = bitcast double* %124 to i8*
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 2
  %127 = bitcast %union.data_type* %126 to double*
  %128 = bitcast double* %127 to i8*
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %130 = bitcast %union.data_type* %129 to double*
  %131 = bitcast double* %130 to i8*
  call void %121(i8* %125, i8* %128, i8* %131, i32 2)
  %132 = load %struct.tdata*, %struct.tdata** %17, align 8
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %132, i32 0, i32 0
  store i32 2, i32* %133, align 8
  br label %253

134:                                              ; preds = %116, %112
  %135 = load i8, i8* %18, align 1
  %136 = zext i8 %135 to i32
  %137 = icmp eq i32 %136, 2
  br i1 %137, label %138, label %156

138:                                              ; preds = %134
  %139 = load i8, i8* %19, align 1
  %140 = zext i8 %139 to i32
  %141 = icmp eq i32 %140, 1
  br i1 %141, label %142, label %156

142:                                              ; preds = %138
  %143 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %144 = load %struct.tdata*, %struct.tdata** %17, align 8
  %145 = getelementptr inbounds %struct.tdata, %struct.tdata* %144, i32 0, i32 2
  %146 = bitcast %union.data_type* %145 to double*
  %147 = bitcast double* %146 to i8*
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 2
  %149 = bitcast %union.data_type* %148 to double*
  %150 = bitcast double* %149 to i8*
  %151 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %152 = bitcast %union.data_type* %151 to i32*
  %153 = bitcast i32* %152 to i8*
  call void %143(i8* %147, i8* %150, i8* %153, i32 2)
  %154 = load %struct.tdata*, %struct.tdata** %17, align 8
  %155 = getelementptr inbounds %struct.tdata, %struct.tdata* %154, i32 0, i32 0
  store i32 2, i32* %155, align 8
  br label %252

156:                                              ; preds = %138, %134
  %157 = load i8, i8* %18, align 1
  %158 = zext i8 %157 to i32
  %159 = icmp eq i32 %158, 1
  br i1 %159, label %160, label %178

160:                                              ; preds = %156
  %161 = load i8, i8* %19, align 1
  %162 = zext i8 %161 to i32
  %163 = icmp eq i32 %162, 2
  br i1 %163, label %164, label %178

164:                                              ; preds = %160
  %165 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %166 = load %struct.tdata*, %struct.tdata** %17, align 8
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %166, i32 0, i32 2
  %168 = bitcast %union.data_type* %167 to double*
  %169 = bitcast double* %168 to i8*
  %170 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 2
  %171 = bitcast %union.data_type* %170 to i32*
  %172 = bitcast i32* %171 to i8*
  %173 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %174 = bitcast %union.data_type* %173 to double*
  %175 = bitcast double* %174 to i8*
  call void %165(i8* %169, i8* %172, i8* %175, i32 2)
  %176 = load %struct.tdata*, %struct.tdata** %17, align 8
  %177 = getelementptr inbounds %struct.tdata, %struct.tdata* %176, i32 0, i32 0
  store i32 2, i32* %177, align 8
  br label %251

178:                                              ; preds = %160, %156
  %179 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.38, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %180 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %181 = icmp eq void (i8*, i8*, i8*, i32)* %180, @funk_mul
  br i1 %181, label %182, label %184

182:                                              ; preds = %178
  %183 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.39, i64 0, i64 0))
  br label %244

184:                                              ; preds = %178
  %185 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %186 = icmp eq void (i8*, i8*, i8*, i32)* %185, @funk_div
  br i1 %186, label %187, label %189

187:                                              ; preds = %184
  %188 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.40, i64 0, i64 0))
  br label %243

189:                                              ; preds = %184
  %190 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %191 = icmp eq void (i8*, i8*, i8*, i32)* %190, @funk_add
  br i1 %191, label %192, label %194

192:                                              ; preds = %189
  %193 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.41, i64 0, i64 0))
  br label %242

194:                                              ; preds = %189
  %195 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %196 = icmp eq void (i8*, i8*, i8*, i32)* %195, @funk_sub
  br i1 %196, label %197, label %199

197:                                              ; preds = %194
  %198 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.42, i64 0, i64 0))
  br label %241

199:                                              ; preds = %194
  %200 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %201 = icmp eq void (i8*, i8*, i8*, i32)* %200, @funk_mod
  br i1 %201, label %202, label %204

202:                                              ; preds = %199
  %203 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.43, i64 0, i64 0))
  br label %240

204:                                              ; preds = %199
  %205 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %206 = icmp eq void (i8*, i8*, i8*, i32)* %205, @funk_slt
  br i1 %206, label %207, label %209

207:                                              ; preds = %204
  %208 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.44, i64 0, i64 0))
  br label %239

209:                                              ; preds = %204
  %210 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %211 = icmp eq void (i8*, i8*, i8*, i32)* %210, @funk_sgt
  br i1 %211, label %212, label %214

212:                                              ; preds = %209
  %213 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.45, i64 0, i64 0))
  br label %238

214:                                              ; preds = %209
  %215 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %216 = icmp eq void (i8*, i8*, i8*, i32)* %215, @funk_sge
  br i1 %216, label %217, label %219

217:                                              ; preds = %214
  %218 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.46, i64 0, i64 0))
  br label %237

219:                                              ; preds = %214
  %220 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %221 = icmp eq void (i8*, i8*, i8*, i32)* %220, @funk_eq
  br i1 %221, label %222, label %224

222:                                              ; preds = %219
  %223 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.47, i64 0, i64 0))
  br label %236

224:                                              ; preds = %219
  %225 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %226 = icmp eq void (i8*, i8*, i8*, i32)* %225, @funk_ne
  br i1 %226, label %227, label %229

227:                                              ; preds = %224
  %228 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.47, i64 0, i64 0))
  br label %235

229:                                              ; preds = %224
  %230 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %231 = icmp eq void (i8*, i8*, i8*, i32)* %230, @funk_or
  br i1 %231, label %232, label %234

232:                                              ; preds = %229
  %233 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.48, i64 0, i64 0))
  br label %234

234:                                              ; preds = %232, %229
  br label %235

235:                                              ; preds = %234, %227
  br label %236

236:                                              ; preds = %235, %222
  br label %237

237:                                              ; preds = %236, %217
  br label %238

238:                                              ; preds = %237, %212
  br label %239

239:                                              ; preds = %238, %207
  br label %240

240:                                              ; preds = %239, %202
  br label %241

241:                                              ; preds = %240, %197
  br label %242

242:                                              ; preds = %241, %192
  br label %243

243:                                              ; preds = %242, %187
  br label %244

244:                                              ; preds = %243, %182
  %245 = load i8, i8* %18, align 1
  call void @funk_print_type(i8 zeroext %245)
  %246 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.34, i64 0, i64 0))
  %247 = load i8, i8* %19, align 1
  call void @funk_print_type(i8 zeroext %247)
  %248 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i64 0, i64 0))
  %249 = load %struct.tdata*, %struct.tdata** %17, align 8
  %250 = getelementptr inbounds %struct.tdata, %struct.tdata* %249, i32 0, i32 0
  store i32 0, i32* %250, align 8
  br label %251

251:                                              ; preds = %244, %164
  br label %252

252:                                              ; preds = %251, %142
  br label %253

253:                                              ; preds = %252, %120
  br label %254

254:                                              ; preds = %253, %98
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_arith_op_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32, void (i8*, i8*, i8*, i32)*) #0 {
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.tnode*, align 8
  %13 = alloca i32, align 4
  %14 = alloca void (i8*, i8*, i8*, i32)*, align 8
  %15 = alloca %struct.tpool*, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %8, align 8
  store i32 %1, i32* %9, align 4
  store %struct.tnode* %2, %struct.tnode** %10, align 8
  store i32 %3, i32* %11, align 4
  store %struct.tnode* %4, %struct.tnode** %12, align 8
  store i32 %5, i32* %13, align 4
  store void (i8*, i8*, i8*, i32)* %6, void (i8*, i8*, i8*, i32)** %14, align 8
  %25 = call %struct.tpool* @get_pool_ptr(i32 1)
  store %struct.tpool* %25, %struct.tpool** %15, align 8
  %26 = load %struct.tnode*, %struct.tnode** %10, align 8
  %27 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %26)
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %7
  br label %33

30:                                               ; preds = %7
  %31 = load %struct.tnode*, %struct.tnode** %10, align 8
  %32 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %31)
  br label %33

33:                                               ; preds = %30, %29
  %34 = phi i32 [ 1, %29 ], [ %32, %30 ]
  store i32 %34, i32* %16, align 4
  %35 = load %struct.tnode*, %struct.tnode** %12, align 8
  %36 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %35)
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %39

38:                                               ; preds = %33
  br label %42

39:                                               ; preds = %33
  %40 = load %struct.tnode*, %struct.tnode** %12, align 8
  %41 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %40)
  br label %42

42:                                               ; preds = %39, %38
  %43 = phi i32 [ 1, %38 ], [ %41, %39 ]
  store i32 %43, i32* %17, align 4
  %44 = load i32, i32* %16, align 4
  %45 = load i32, i32* %17, align 4
  %46 = icmp ne i32 %44, %45
  br i1 %46, label %47, label %53

47:                                               ; preds = %42
  %48 = load i32, i32* %16, align 4
  %49 = load i32, i32* %17, align 4
  %50 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([101 x i8], [101 x i8]* @.str.49, i64 0, i64 0), i32 %48, i32 %49)
  %51 = load %struct.tnode*, %struct.tnode** %10, align 8
  call void @funk_print_node_info(%struct.tnode* %51)
  %52 = load %struct.tnode*, %struct.tnode** %12, align 8
  call void @funk_print_node_info(%struct.tnode* %52)
  call void @exit(i32 1) #6
  unreachable

53:                                               ; preds = %42
  %54 = load i32, i32* %16, align 4
  store i32 %54, i32* %18, align 4
  %55 = load i32, i32* %18, align 4
  %56 = icmp sgt i32 %55, 1
  br i1 %56, label %57, label %83

57:                                               ; preds = %53
  store i32 0, i32* %19, align 4
  br label %58

58:                                               ; preds = %79, %57
  %59 = load i32, i32* %19, align 4
  %60 = load i32, i32* %18, align 4
  %61 = icmp slt i32 %59, %60
  br i1 %61, label %62, label %82

62:                                               ; preds = %58
  %63 = load %struct.tnode*, %struct.tnode** %10, align 8
  %64 = load i32, i32* %19, align 4
  %65 = call i32 @_funk_get_node_dimension(%struct.tnode* %63, i32 %64, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1154)
  %66 = load %struct.tnode*, %struct.tnode** %12, align 8
  %67 = load i32, i32* %19, align 4
  %68 = call i32 @_funk_get_node_dimension(%struct.tnode* %66, i32 %67, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1154)
  %69 = icmp ne i32 %65, %68
  br i1 %69, label %70, label %78

70:                                               ; preds = %62
  %71 = load %struct.tnode*, %struct.tnode** %10, align 8
  %72 = load i32, i32* %19, align 4
  %73 = call i32 @_funk_get_node_dimension(%struct.tnode* %71, i32 %72, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1156)
  %74 = load %struct.tnode*, %struct.tnode** %12, align 8
  %75 = load i32, i32* %19, align 4
  %76 = call i32 @_funk_get_node_dimension(%struct.tnode* %74, i32 %75, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1156)
  %77 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.50, i64 0, i64 0), i32 %73, i32 %76)
  br label %78

78:                                               ; preds = %70, %62
  br label %79

79:                                               ; preds = %78
  %80 = load i32, i32* %19, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %19, align 4
  br label %58

82:                                               ; preds = %58
  br label %83

83:                                               ; preds = %82, %53
  %84 = load i32, i32* %18, align 4
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %109

86:                                               ; preds = %83
  %87 = load %struct.tnode*, %struct.tnode** %8, align 8
  %88 = load %struct.tnode*, %struct.tnode** %10, align 8
  %89 = getelementptr inbounds %struct.tnode, %struct.tnode* %88, i32 0, i32 1
  %90 = load i32, i32* %89, align 4
  call void @funk_create_node(%struct.tnode* %87, i32 %90, i32 1, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %20, align 4
  br label %91

91:                                               ; preds = %105, %86
  %92 = load i32, i32* %20, align 4
  %93 = load %struct.tnode*, %struct.tnode** %10, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 1
  %95 = load i32, i32* %94, align 4
  %96 = icmp ult i32 %92, %95
  br i1 %96, label %97, label %108

97:                                               ; preds = %91
  %98 = load %struct.tnode*, %struct.tnode** %8, align 8
  %99 = load i32, i32* %20, align 4
  %100 = load %struct.tnode*, %struct.tnode** %10, align 8
  %101 = load i32, i32* %20, align 4
  %102 = load %struct.tnode*, %struct.tnode** %12, align 8
  %103 = load i32, i32* %20, align 4
  %104 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %98, i32 %99, %struct.tnode* %100, i32 %101, %struct.tnode* %102, i32 %103, void (i8*, i8*, i8*, i32)* %104)
  br label %105

105:                                              ; preds = %97
  %106 = load i32, i32* %20, align 4
  %107 = add i32 %106, 1
  store i32 %107, i32* %20, align 4
  br label %91

108:                                              ; preds = %91
  br label %165

109:                                              ; preds = %83
  %110 = load i32, i32* %18, align 4
  %111 = icmp eq i32 %110, 2
  br i1 %111, label %112, label %161

112:                                              ; preds = %109
  %113 = load %struct.tnode*, %struct.tnode** %10, align 8
  %114 = call i32 @_funk_get_node_dimension(%struct.tnode* %113, i32 0, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1169)
  %115 = load %struct.tnode*, %struct.tnode** %10, align 8
  %116 = call i32 @_funk_get_node_dimension(%struct.tnode* %115, i32 1, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1169)
  %117 = mul i32 %114, %116
  store i32 %117, i32* %21, align 4
  %118 = load %struct.tnode*, %struct.tnode** %8, align 8
  %119 = load i32, i32* %21, align 4
  %120 = load i32, i32* %18, align 4
  %121 = trunc i32 %120 to i8
  call void @funk_create_node(%struct.tnode* %118, i32 %119, i32 1, i32 1, i8 zeroext %121, i8* null)
  %122 = load %struct.tnode*, %struct.tnode** %8, align 8
  %123 = load %struct.tnode*, %struct.tnode** %10, align 8
  %124 = call i32 @_funk_get_node_dimension(%struct.tnode* %123, i32 0, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1174)
  call void @_funk_set_node_dimension(%struct.tnode* %122, i32 0, i32 %124, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1174)
  %125 = load %struct.tnode*, %struct.tnode** %8, align 8
  %126 = load %struct.tnode*, %struct.tnode** %10, align 8
  %127 = call i32 @_funk_get_node_dimension(%struct.tnode* %126, i32 1, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1175)
  call void @_funk_set_node_dimension(%struct.tnode* %125, i32 1, i32 %127, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1175)
  store i32 0, i32* %22, align 4
  br label %128

128:                                              ; preds = %157, %112
  %129 = load i32, i32* %22, align 4
  %130 = load %struct.tnode*, %struct.tnode** %8, align 8
  %131 = call i32 @_funk_get_node_dimension(%struct.tnode* %130, i32 0, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1178)
  %132 = icmp ult i32 %129, %131
  br i1 %132, label %133, label %160

133:                                              ; preds = %128
  store i32 0, i32* %23, align 4
  br label %134

134:                                              ; preds = %153, %133
  %135 = load i32, i32* %23, align 4
  %136 = load %struct.tnode*, %struct.tnode** %8, align 8
  %137 = call i32 @_funk_get_node_dimension(%struct.tnode* %136, i32 1, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1179)
  %138 = icmp ult i32 %135, %137
  br i1 %138, label %139, label %156

139:                                              ; preds = %134
  %140 = load i32, i32* %22, align 4
  %141 = load %struct.tnode*, %struct.tnode** %8, align 8
  %142 = call i32 @_funk_get_node_dimension(%struct.tnode* %141, i32 1, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0), i32 1180)
  %143 = mul i32 %140, %142
  %144 = load i32, i32* %23, align 4
  %145 = add i32 %143, %144
  store i32 %145, i32* %24, align 4
  %146 = load %struct.tnode*, %struct.tnode** %8, align 8
  %147 = load i32, i32* %24, align 4
  %148 = load %struct.tnode*, %struct.tnode** %10, align 8
  %149 = load i32, i32* %24, align 4
  %150 = load %struct.tnode*, %struct.tnode** %12, align 8
  %151 = load i32, i32* %24, align 4
  %152 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %146, i32 %147, %struct.tnode* %148, i32 %149, %struct.tnode* %150, i32 %151, void (i8*, i8*, i8*, i32)* %152)
  br label %153

153:                                              ; preds = %139
  %154 = load i32, i32* %23, align 4
  %155 = add i32 %154, 1
  store i32 %155, i32* %23, align 4
  br label %134

156:                                              ; preds = %134
  br label %157

157:                                              ; preds = %156
  %158 = load i32, i32* %22, align 4
  %159 = add i32 %158, 1
  store i32 %159, i32* %22, align 4
  br label %128

160:                                              ; preds = %128
  br label %164

161:                                              ; preds = %109
  %162 = load i32, i32* %18, align 4
  %163 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.51, i64 0, i64 0), i32 %162)
  call void @exit(i32 1) #6
  unreachable

164:                                              ; preds = %160
  br label %165

165:                                              ; preds = %164, %108
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_div)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_mod)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_or_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_or)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_and_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_and)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_ne)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_eq)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_ne)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_mod)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_div)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_sgt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_flt_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_double_scalar(i32 1, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sgt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sge)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_sge)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_eq)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.52, i64 0, i64 0))
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
  %13 = call i32 @_funk_get_node_dimension(%struct.tnode* %11, i32 %12, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_dimension, i64 0, i64 0), i32 1489)
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.53, i64 0, i64 0), i32 %13)
  br label %15

15:                                               ; preds = %10
  %16 = load i32, i32* %3, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* %3, align 4
  br label %5

18:                                               ; preds = %5
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.54, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %6)
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %17

9:                                                ; preds = %1
  %10 = load %struct.tnode*, %struct.tnode** %2, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1501, i32 1)
  %12 = bitcast %struct.tdata* %11 to { i64, i64 }*
  %13 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 0
  %14 = load i64, i64* %13, align 8
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 1
  %16 = load i64, i64* %15, align 8
  call void @funk_print_scalar_element(i64 %14, i64 %16)
  br label %95

17:                                               ; preds = %1
  %18 = load %struct.tnode*, %struct.tnode** %2, align 8
  %19 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %18)
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %41

21:                                               ; preds = %17
  store i32 0, i32* %3, align 4
  br label %22

22:                                               ; preds = %37, %21
  %23 = load i32, i32* %3, align 4
  %24 = load %struct.tnode*, %struct.tnode** %2, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = icmp ult i32 %23, %26
  br i1 %27, label %28, label %40

28:                                               ; preds = %22
  %29 = load %struct.tnode*, %struct.tnode** %2, align 8
  %30 = load i32, i32* %3, align 4
  %31 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %30, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1507, i32 1)
  %32 = bitcast %struct.tdata* %31 to { i64, i64 }*
  %33 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %32, i32 0, i32 0
  %34 = load i64, i64* %33, align 8
  %35 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %32, i32 0, i32 1
  %36 = load i64, i64* %35, align 8
  call void @funk_print_scalar_element(i64 %34, i64 %36)
  br label %37

37:                                               ; preds = %28
  %38 = load i32, i32* %3, align 4
  %39 = add i32 %38, 1
  store i32 %39, i32* %3, align 4
  br label %22

40:                                               ; preds = %22
  br label %94

41:                                               ; preds = %17
  %42 = load %struct.tnode*, %struct.tnode** %2, align 8
  %43 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %42)
  %44 = icmp eq i32 %43, 2
  br i1 %44, label %45, label %86

45:                                               ; preds = %41
  %46 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %46)
  %47 = load %struct.tnode*, %struct.tnode** %2, align 8
  %48 = call i32 @_funk_get_node_dimension(%struct.tnode* %47, i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1514)
  %49 = load %struct.tnode*, %struct.tnode** %2, align 8
  %50 = call i32 @_funk_get_node_dimension(%struct.tnode* %49, i32 1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1514)
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.55, i64 0, i64 0), i32 %48, i32 %50)
  store i32 0, i32* %4, align 4
  br label %52

52:                                               ; preds = %82, %45
  %53 = load i32, i32* %4, align 4
  %54 = load %struct.tnode*, %struct.tnode** %2, align 8
  %55 = call i32 @_funk_get_node_dimension(%struct.tnode* %54, i32 1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1516)
  %56 = icmp ult i32 %53, %55
  br i1 %56, label %57, label %85

57:                                               ; preds = %52
  store i32 0, i32* %5, align 4
  br label %58

58:                                               ; preds = %77, %57
  %59 = load i32, i32* %5, align 4
  %60 = load %struct.tnode*, %struct.tnode** %2, align 8
  %61 = call i32 @_funk_get_node_dimension(%struct.tnode* %60, i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1517)
  %62 = icmp ult i32 %59, %61
  br i1 %62, label %63, label %80

63:                                               ; preds = %58
  %64 = load %struct.tnode*, %struct.tnode** %2, align 8
  %65 = load i32, i32* %4, align 4
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = call i32 @_funk_get_node_dimension(%struct.tnode* %66, i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1518)
  %68 = mul i32 %65, %67
  %69 = load i32, i32* %5, align 4
  %70 = add i32 %68, %69
  %71 = call %struct.tdata* @get_node(%struct.tnode* %64, i32 %70, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_node, i64 0, i64 0), i32 1518, i32 1)
  %72 = bitcast %struct.tdata* %71 to { i64, i64 }*
  %73 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %72, i32 0, i32 0
  %74 = load i64, i64* %73, align 8
  %75 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %72, i32 0, i32 1
  %76 = load i64, i64* %75, align 8
  call void @funk_print_scalar_element(i64 %74, i64 %76)
  br label %77

77:                                               ; preds = %63
  %78 = load i32, i32* %5, align 4
  %79 = add i32 %78, 1
  store i32 %79, i32* %5, align 4
  br label %58

80:                                               ; preds = %58
  %81 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i64 0, i64 0))
  br label %82

82:                                               ; preds = %80
  %83 = load i32, i32* %4, align 4
  %84 = add i32 %83, 1
  store i32 %84, i32* %4, align 4
  br label %52

85:                                               ; preds = %52
  br label %93

86:                                               ; preds = %41
  %87 = load %struct.tnode*, %struct.tnode** %2, align 8
  %88 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %87)
  %89 = load %struct.tnode*, %struct.tnode** %2, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 1
  %91 = load i32, i32* %90, align 4
  %92 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.56, i64 0, i64 0), i32 %88, i32 %91)
  br label %93

93:                                               ; preds = %86, %85
  br label %94

94:                                               ; preds = %93, %40
  br label %95

95:                                               ; preds = %94, %9
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_2d_array_element_reg_reg(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node_info(%struct.tnode* %9)
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %10)
  %12 = icmp ne i32 %11, 2
  br i1 %12, label %13, label %17

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %14)
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.57, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 %15)
  br label %17

17:                                               ; preds = %13, %3
  %18 = load %struct.tnode*, %struct.tnode** %5, align 8
  %19 = call %struct.tdata* @get_node(%struct.tnode* %18, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1534, i32 1)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 2
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  store i32 %22, i32* %7, align 4
  %23 = load %struct.tnode*, %struct.tnode** %6, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1535, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 2
  %26 = bitcast %union.data_type* %25 to i32*
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %8, align 4
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = call i32 @_funk_get_node_dimension(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1537)
  %31 = load i32, i32* %7, align 4
  %32 = mul i32 %30, %31
  %33 = load i32, i32* %8, align 4
  %34 = add i32 %32, %33
  %35 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 %34, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1537, i32 1)
  %36 = bitcast %struct.tdata* %35 to { i64, i64 }*
  %37 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %36, i32 0, i32 0
  %38 = load i64, i64* %37, align 8
  %39 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %36, i32 0, i32 1
  %40 = load i64, i64* %39, align 8
  call void @funk_print_scalar_element(i64 %38, i64 %40)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_2d_array_element_int_int(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = call i32 @_funk_get_node_dimension(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_int_int, i64 0, i64 0), i32 1542)
  %10 = load i32, i32* %5, align 4
  %11 = mul i32 %9, %10
  %12 = load i32, i32* %6, align 4
  %13 = add i32 %11, %12
  %14 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 %13, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_int_int, i64 0, i64 0), i32 1542, i32 1)
  %15 = bitcast %struct.tdata* %14 to { i64, i64 }*
  %16 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 0
  %17 = load i64, i64* %16, align 8
  %18 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 1
  %19 = load i64, i64* %18, align 8
  call void @funk_print_scalar_element(i64 %17, i64 %19)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1547, i32 1)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %16

9:                                                ; preds = %1
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1548, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = sitofp i32 %14 to float
  store float %15, float* %2, align 4
  br label %34

16:                                               ; preds = %1
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1549, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %29

22:                                               ; preds = %16
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1550, i32 1)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 2
  %26 = bitcast %union.data_type* %25 to double*
  %27 = load double, double* %26, align 8
  %28 = fptrunc double %27 to float
  store float %28, float* %2, align 4
  br label %34

29:                                               ; preds = %16
  %30 = load %struct.tnode*, %struct.tnode** %3, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1552, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i32 0, i32* %32, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.58, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
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
  %14 = call %struct.__sFILE* @"\01_fopen"(i8* %13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.59, i64 0, i64 0))
  store %struct.__sFILE* %14, %struct.__sFILE** %8, align 8
  %15 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %16 = icmp eq %struct.__sFILE* %15, null
  br i1 %16, label %17, label %20

17:                                               ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.60, i64 0, i64 0), i8* %18)
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
  %25 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %24, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.61, i64 0, i64 0), i32* %9)
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %45

27:                                               ; preds = %23
  %28 = load i32, i32* %9, align 4
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load %struct.tpool*, %struct.tpool** %7, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %32, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1581, i32 1)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 2
  %35 = bitcast %union.data_type* %34 to i32*
  store i32 %28, i32* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = load %struct.tpool*, %struct.tpool** %7, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 8
  %40 = call %struct.tdata* @get_node(%struct.tnode* %36, i32 %39, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1582, i32 1)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  store i32 1, i32* %41, align 8
  %42 = load %struct.tpool*, %struct.tpool** %7, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %42)
  %43 = load i32, i32* %10, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %10, align 4
  br label %23

45:                                               ; preds = %23
  %46 = load i32, i32* %10, align 4
  %47 = load %struct.tnode*, %struct.tnode** %5, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  store i32 %46, i32* %48, align 4
  %49 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %50 = call i32 @fclose(%struct.__sFILE* %49)
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
  %15 = alloca i32*, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store %struct.tnode* %1, %struct.tnode** %8, align 8
  store i32 %2, i32* %9, align 4
  store i32 %3, i32* %10, align 4
  store i32 %4, i32* %11, align 4
  store i32 %5, i32* %12, align 4
  %21 = load i32, i32* %9, align 4
  %22 = load i32, i32* %10, align 4
  %23 = icmp sgt i32 %21, %22
  br i1 %23, label %24, label %28

24:                                               ; preds = %6
  %25 = load i32, i32* %9, align 4
  %26 = load i32, i32* %10, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.62, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %25, i32 %26)
  call void @exit(i32 1) #6
  unreachable

28:                                               ; preds = %6
  %29 = load i32, i32* %11, align 4
  %30 = load i32, i32* %12, align 4
  %31 = icmp sgt i32 %29, %30
  br i1 %31, label %32, label %36

32:                                               ; preds = %28
  %33 = load i32, i32* %11, align 4
  %34 = load i32, i32* %12, align 4
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.63, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %33, i32 %34)
  call void @exit(i32 1) #6
  unreachable

36:                                               ; preds = %28
  %37 = load i32, i32* %10, align 4
  %38 = load i32, i32* %9, align 4
  %39 = sub nsw i32 %37, %38
  %40 = add nsw i32 %39, 1
  %41 = call i32 @abs(i32 %40) #7
  store i32 %41, i32* %13, align 4
  %42 = load i32, i32* %12, align 4
  %43 = load i32, i32* %11, align 4
  %44 = sub nsw i32 %42, %43
  %45 = add nsw i32 %44, 1
  %46 = call i32 @abs(i32 %45) #7
  store i32 %46, i32* %14, align 4
  %47 = load i32, i32* %13, align 4
  %48 = sext i32 %47 to i64
  %49 = mul i64 4, %48
  %50 = load i32, i32* %14, align 4
  %51 = sext i32 %50 to i64
  %52 = mul i64 %49, %51
  %53 = call i8* @malloc(i64 %52) #8
  %54 = bitcast i8* %53 to i32*
  store i32* %54, i32** %15, align 8
  store i32 0, i32* %16, align 4
  %55 = load i32, i32* %9, align 4
  store i32 %55, i32* %17, align 4
  br label %56

56:                                               ; preds = %118, %36
  %57 = load i32, i32* %17, align 4
  %58 = load i32, i32* %10, align 4
  %59 = icmp sle i32 %57, %58
  br i1 %59, label %60, label %121

60:                                               ; preds = %56
  %61 = load i32, i32* %11, align 4
  store i32 %61, i32* %18, align 4
  br label %62

62:                                               ; preds = %114, %60
  %63 = load i32, i32* %18, align 4
  %64 = load i32, i32* %12, align 4
  %65 = icmp sle i32 %63, %64
  br i1 %65, label %66, label %117

66:                                               ; preds = %62
  %67 = load i32, i32* %17, align 4
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %74

69:                                               ; preds = %66
  %70 = load i32, i32* %17, align 4
  %71 = load %struct.tnode*, %struct.tnode** %7, align 8
  %72 = call i32 @_funk_get_node_dimension(%struct.tnode* %71, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1628)
  %73 = add i32 %70, %72
  br label %76

74:                                               ; preds = %66
  %75 = load i32, i32* %17, align 4
  br label %76

76:                                               ; preds = %74, %69
  %77 = phi i32 [ %73, %69 ], [ %75, %74 ]
  store i32 %77, i32* %19, align 4
  %78 = load i32, i32* %18, align 4
  %79 = icmp slt i32 %78, 0
  br i1 %79, label %80, label %85

80:                                               ; preds = %76
  %81 = load i32, i32* %18, align 4
  %82 = load %struct.tnode*, %struct.tnode** %7, align 8
  %83 = call i32 @_funk_get_node_dimension(%struct.tnode* %82, i32 1, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1629)
  %84 = add i32 %81, %83
  br label %87

85:                                               ; preds = %76
  %86 = load i32, i32* %18, align 4
  br label %87

87:                                               ; preds = %85, %80
  %88 = phi i32 [ %84, %80 ], [ %86, %85 ]
  store i32 %88, i32* %20, align 4
  %89 = load %struct.tnode*, %struct.tnode** %7, align 8
  %90 = call i32 @_funk_get_node_dimension(%struct.tnode* %89, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1631)
  %91 = load i32, i32* %19, align 4
  %92 = urem i32 %91, %90
  store i32 %92, i32* %19, align 4
  %93 = load %struct.tnode*, %struct.tnode** %7, align 8
  %94 = call i32 @_funk_get_node_dimension(%struct.tnode* %93, i32 1, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1632)
  %95 = load i32, i32* %20, align 4
  %96 = urem i32 %95, %94
  store i32 %96, i32* %20, align 4
  %97 = load %struct.tnode*, %struct.tnode** %7, align 8
  %98 = load i32, i32* %19, align 4
  %99 = load %struct.tnode*, %struct.tnode** %7, align 8
  %100 = call i32 @_funk_get_node_dimension(%struct.tnode* %99, i32 0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1634)
  %101 = mul i32 %98, %100
  %102 = load i32, i32* %20, align 4
  %103 = add i32 %101, %102
  %104 = call %struct.tdata* @get_node(%struct.tnode* %97, i32 %103, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1634, i32 1)
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 2
  %106 = bitcast %union.data_type* %105 to i32*
  %107 = load i32, i32* %106, align 8
  %108 = load i32*, i32** %15, align 8
  %109 = load i32, i32* %16, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds i32, i32* %108, i64 %110
  store i32 %107, i32* %111, align 4
  %112 = load i32, i32* %16, align 4
  %113 = add nsw i32 %112, 1
  store i32 %113, i32* %16, align 4
  br label %114

114:                                              ; preds = %87
  %115 = load i32, i32* %18, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, i32* %18, align 4
  br label %62

117:                                              ; preds = %62
  br label %118

118:                                              ; preds = %117
  %119 = load i32, i32* %17, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, i32* %17, align 4
  br label %56

121:                                              ; preds = %56
  %122 = load %struct.tnode*, %struct.tnode** %8, align 8
  %123 = load i32*, i32** %15, align 8
  %124 = load i32, i32* %13, align 4
  %125 = load i32, i32* %14, align 4
  call void @funk_create_2d_matrix_int_literal(i32 0, %struct.tnode* %122, i32* %123, i32 %124, i32 %125)
  %126 = load i32*, i32** %15, align 8
  %127 = bitcast i32* %126 to i8*
  call void @free(i8* %127)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @abs(i32) #4

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #5

declare void @free(i8*) #1

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
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %17)
  %19 = icmp ne i32 %18, 2
  br i1 %19, label %20, label %24

20:                                               ; preds = %6
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %21)
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.64, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 %22)
  call void @exit(i32 1) #6
  unreachable

24:                                               ; preds = %6
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1659, i32 1)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 2
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  store i32 %29, i32* %13, align 4
  %30 = load %struct.tnode*, %struct.tnode** %10, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1660, i32 1)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 2
  %33 = bitcast %union.data_type* %32 to i32*
  %34 = load i32, i32* %33, align 8
  store i32 %34, i32* %14, align 4
  %35 = load %struct.tnode*, %struct.tnode** %11, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1661, i32 1)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 2
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %15, align 4
  %40 = load %struct.tnode*, %struct.tnode** %12, align 8
  %41 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1662, i32 1)
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 2
  %43 = bitcast %union.data_type* %42 to i32*
  %44 = load i32, i32* %43, align 8
  store i32 %44, i32* %16, align 4
  %45 = load %struct.tnode*, %struct.tnode** %7, align 8
  %46 = load %struct.tnode*, %struct.tnode** %8, align 8
  %47 = load i32, i32* %13, align 4
  %48 = load i32, i32* %14, align 4
  %49 = load i32, i32* %15, align 4
  %50 = load i32, i32* %16, align 4
  call void @funk_create_sub_matrix_lit_indexes(%struct.tnode* %45, %struct.tnode* %46, i32 %47, i32 %48, i32 %49, i32 %50)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_array_lit_indexes(%struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32*, align 8
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.63, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 %42, i32 %43)
  call void @exit(i32 1) #6
  unreachable

45:                                               ; preds = %36
  %46 = load i32, i32* %8, align 4
  %47 = load i32, i32* %7, align 4
  %48 = sub nsw i32 %46, %47
  %49 = add nsw i32 %48, 1
  %50 = call i32 @abs(i32 %49) #7
  store i32 %50, i32* %9, align 4
  %51 = load i32, i32* %9, align 4
  %52 = sext i32 %51 to i64
  %53 = mul i64 4, %52
  %54 = call i8* @malloc(i64 %53) #8
  %55 = bitcast i8* %54 to i32*
  store i32* %55, i32** %10, align 8
  store i32 0, i32* %11, align 4
  %56 = load i32, i32* %7, align 4
  store i32 %56, i32* %12, align 4
  br label %57

57:                                               ; preds = %79, %45
  %58 = load i32, i32* %12, align 4
  %59 = load i32, i32* %8, align 4
  %60 = icmp sle i32 %58, %59
  br i1 %60, label %61, label %82

61:                                               ; preds = %57
  %62 = load i32, i32* %12, align 4
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  %66 = urem i32 %62, %65
  store i32 %66, i32* %13, align 4
  %67 = load %struct.tnode*, %struct.tnode** %5, align 8
  %68 = load i32, i32* %13, align 4
  %69 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 %68, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 1687, i32 1)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %70 to i32*
  %72 = load i32, i32* %71, align 8
  %73 = load i32*, i32** %10, align 8
  %74 = load i32, i32* %11, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i32, i32* %73, i64 %75
  store i32 %72, i32* %76, align 4
  %77 = load i32, i32* %11, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %11, align 4
  br label %79

79:                                               ; preds = %61
  %80 = load i32, i32* %12, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %12, align 4
  br label %57

82:                                               ; preds = %57
  %83 = load %struct.tnode*, %struct.tnode** %6, align 8
  %84 = load i32*, i32** %10, align 8
  %85 = load i32, i32* %9, align 4
  call void @funk_create_list_i32_literal(i32 0, %struct.tnode* %83, i32* %84, i32 %85)
  %86 = load i32*, i32** %10, align 8
  %87 = bitcast i32* %86 to i8*
  call void @free(i8* %87)
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
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %11)
  %13 = icmp ne i32 %12, 1
  br i1 %13, label %14, label %18

14:                                               ; preds = %4
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %15)
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.65, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 %16)
  call void @exit(i32 1) #6
  unreachable

18:                                               ; preds = %4
  %19 = load %struct.tnode*, %struct.tnode** %7, align 8
  %20 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1706, i32 1)
  %21 = getelementptr inbounds %struct.tdata, %struct.tdata* %20, i32 0, i32 2
  %22 = bitcast %union.data_type* %21 to i32*
  %23 = load i32, i32* %22, align 8
  store i32 %23, i32* %9, align 4
  %24 = load %struct.tnode*, %struct.tnode** %8, align 8
  %25 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1707, i32 1)
  %26 = getelementptr inbounds %struct.tdata, %struct.tdata* %25, i32 0, i32 2
  %27 = bitcast %union.data_type* %26 to i32*
  %28 = load i32, i32* %27, align 8
  store i32 %28, i32* %10, align 4
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = load i32, i32* %9, align 4
  %32 = load i32, i32* %10, align 4
  call void @funk_create_sub_array_lit_indexes(%struct.tnode* %29, %struct.tnode* %30, i32 %31, i32 %32)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_dimensions(%struct.tnode*, i32*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  %9 = load i32*, i32** %5, align 8
  %10 = icmp eq i32* %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %3
  br label %63

12:                                               ; preds = %3
  %13 = load i32, i32* %6, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = call i32 @_funk_get_node_dimension_count(%struct.tnode* %14)
  %16 = icmp ne i32 %13, %15
  br i1 %16, label %17, label %29

17:                                               ; preds = %12
  store i32 0, i32* %7, align 4
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 2
  %20 = load %struct.tpool*, %struct.tpool** %19, align 8
  %21 = load i32, i32* %6, align 4
  %22 = call i32 @_funk_alloc_raw_tdata(%struct.tpool* %20, i32 %21, i32 1)
  store i32 %22, i32* %7, align 4
  %23 = load i32, i32* %7, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 3
  %26 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %25, i32 0, i32 1
  store i32 %23, i32* %26, align 4
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = load i32, i32* %6, align 4
  call void @_funk_set_node_dimension_count(%struct.tnode* %27, i32 %28)
  br label %29

29:                                               ; preds = %17, %12
  %30 = load i32, i32* %6, align 4
  %31 = icmp eq i32 %30, 2
  br i1 %31, label %32, label %47

32:                                               ; preds = %29
  %33 = load i32*, i32** %5, align 8
  %34 = getelementptr inbounds i32, i32* %33, i64 0
  %35 = load i32, i32* %34, align 4
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %47

37:                                               ; preds = %32
  %38 = load i32*, i32** %5, align 8
  %39 = getelementptr inbounds i32, i32* %38, i64 1
  %40 = load i32, i32* %39, align 4
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 1
  %43 = load i32, i32* %42, align 4
  %44 = icmp eq i32 %40, %43
  br i1 %44, label %45, label %47

45:                                               ; preds = %37
  %46 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @_funk_set_node_dimension_count(%struct.tnode* %46, i32 1)
  br label %47

47:                                               ; preds = %45, %37, %32, %29
  store i32 0, i32* %8, align 4
  br label %48

48:                                               ; preds = %60, %47
  %49 = load i32, i32* %8, align 4
  %50 = load i32, i32* %6, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %63

52:                                               ; preds = %48
  %53 = load %struct.tnode*, %struct.tnode** %4, align 8
  %54 = load i32, i32* %8, align 4
  %55 = load i32*, i32** %5, align 8
  %56 = load i32, i32* %8, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds i32, i32* %55, i64 %57
  %59 = load i32, i32* %58, align 4
  call void @_funk_set_node_dimension(%struct.tnode* %53, i32 %54, i32 %59, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_set_node_dimensions, i64 0, i64 0), i32 1737)
  br label %60

60:                                               ; preds = %52
  %61 = load i32, i32* %8, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %8, align 4
  br label %48

63:                                               ; preds = %11, %48
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_dimensions_2d(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [2 x i32], align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_set_node_dimensions_2d, i64 0, i64 0), i32 1744, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  store i32 %14, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %6, align 8
  %16 = call %struct.tdata* @get_node(%struct.tnode* %15, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_set_node_dimensions_2d, i64 0, i64 0), i32 1745, i32 1)
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 2
  %18 = bitcast %union.data_type* %17 to i32*
  %19 = load i32, i32* %18, align 8
  store i32 %19, i32* %8, align 4
  %20 = getelementptr inbounds [2 x i32], [2 x i32]* %9, i64 0, i64 0
  %21 = load i32, i32* %7, align 4
  store i32 %21, i32* %20, align 4
  %22 = getelementptr inbounds i32, i32* %20, i64 1
  %23 = load i32, i32* %8, align 4
  store i32 %23, i32* %22, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds [2 x i32], [2 x i32]* %9, i64 0, i64 0
  call void @funk_set_node_dimensions(%struct.tnode* %24, i32* %25, i32 2)
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
  %8 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.reshape, i64 0, i64 0), i32 1756, i32 1)
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
define void @funk_concatenate_lists(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tpool*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %11 = load %struct.tnode*, %struct.tnode** %5, align 8
  %12 = call %struct.tnode* @validate_node(%struct.tnode* %11, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0))
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = call %struct.tnode* @validate_node(%struct.tnode* %13, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0))
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = call %struct.tdata* @get_node(%struct.tnode* %15, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1800, i32 1)
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = icmp eq i32 %18, 4
  br i1 %19, label %20, label %29

20:                                               ; preds = %3
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = call %struct.tdata* @get_node(%struct.tnode* %21, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1800, i32 1)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = icmp eq i32 %24, 4
  br i1 %25, label %26, label %29

26:                                               ; preds = %20
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_node(%struct.tnode* %27, i32 1, i32 1, i32 4, i8 zeroext 0, i8* null)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.66, i64 0, i64 0))
  br label %138

29:                                               ; preds = %20, %3
  %30 = load %struct.tnode*, %struct.tnode** %4, align 8
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = call %struct.tdata* @get_node(%struct.tnode* %31, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1808, i32 1)
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i32, i32* %33, align 8
  %35 = icmp eq i32 %34, 4
  br i1 %35, label %36, label %37

36:                                               ; preds = %29
  br label %41

37:                                               ; preds = %29
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  br label %41

41:                                               ; preds = %37, %36
  %42 = phi i32 [ 0, %36 ], [ %40, %37 ]
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = call %struct.tdata* @get_node(%struct.tnode* %43, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1809, i32 1)
  %45 = getelementptr inbounds %struct.tdata, %struct.tdata* %44, i32 0, i32 0
  %46 = load i32, i32* %45, align 8
  %47 = icmp eq i32 %46, 4
  br i1 %47, label %48, label %49

48:                                               ; preds = %41
  br label %53

49:                                               ; preds = %41
  %50 = load %struct.tnode*, %struct.tnode** %6, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 1
  %52 = load i32, i32* %51, align 4
  br label %53

53:                                               ; preds = %49, %48
  %54 = phi i32 [ 0, %48 ], [ %52, %49 ]
  %55 = add i32 %42, %54
  call void @funk_create_node(%struct.tnode* %30, i32 %55, i32 1, i32 3, i8 zeroext 0, i8* null)
  %56 = load %struct.tnode*, %struct.tnode** %6, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  %58 = load %struct.tpool*, %struct.tpool** %57, align 8
  store %struct.tpool* %58, %struct.tpool** %7, align 8
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  br label %59

59:                                               ; preds = %95, %53
  %60 = load i32, i32* %9, align 4
  %61 = load %struct.tnode*, %struct.tnode** %5, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = load i32, i32* %62, align 4
  %64 = icmp ult i32 %60, %63
  br i1 %64, label %65, label %98

65:                                               ; preds = %59
  %66 = load %struct.tnode*, %struct.tnode** %5, align 8
  %67 = load i32, i32* %9, align 4
  %68 = call %struct.tdata* @get_node(%struct.tnode* %66, i32 %67, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1819, i32 1)
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  %70 = load i32, i32* %69, align 8
  %71 = icmp eq i32 %70, 4
  br i1 %71, label %72, label %73

72:                                               ; preds = %65
  br label %98

73:                                               ; preds = %65
  %74 = load %struct.tnode*, %struct.tnode** %5, align 8
  %75 = load i32, i32* %9, align 4
  %76 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 %75, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1822, i32 1)
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = load %struct.tnode*, %struct.tnode** %4, align 8
  %80 = load i32, i32* %8, align 4
  %81 = call %struct.tdata* @get_node(%struct.tnode* %79, i32 %80, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1822, i32 1)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  store i32 %78, i32* %82, align 8
  %83 = load %struct.tnode*, %struct.tnode** %4, align 8
  %84 = load i32, i32* %8, align 4
  %85 = call %struct.tdata* @get_node(%struct.tnode* %83, i32 %84, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1823, i32 1)
  %86 = getelementptr inbounds %struct.tdata, %struct.tdata* %85, i32 0, i32 2
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = load i32, i32* %9, align 4
  %89 = call %struct.tdata* @get_node(%struct.tnode* %87, i32 %88, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1823, i32 1)
  %90 = getelementptr inbounds %struct.tdata, %struct.tdata* %89, i32 0, i32 2
  %91 = bitcast %union.data_type* %86 to i8*
  %92 = bitcast %union.data_type* %90 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %91, i8* align 8 %92, i64 8, i1 false)
  %93 = load i32, i32* %8, align 4
  %94 = add i32 %93, 1
  store i32 %94, i32* %8, align 4
  br label %95

95:                                               ; preds = %73
  %96 = load i32, i32* %9, align 4
  %97 = add i32 %96, 1
  store i32 %97, i32* %9, align 4
  br label %59

98:                                               ; preds = %72, %59
  store i32 0, i32* %10, align 4
  br label %99

99:                                               ; preds = %135, %98
  %100 = load i32, i32* %10, align 4
  %101 = load %struct.tnode*, %struct.tnode** %6, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 1
  %103 = load i32, i32* %102, align 4
  %104 = icmp ult i32 %100, %103
  br i1 %104, label %105, label %138

105:                                              ; preds = %99
  %106 = load %struct.tnode*, %struct.tnode** %6, align 8
  %107 = load i32, i32* %10, align 4
  %108 = call %struct.tdata* @get_node(%struct.tnode* %106, i32 %107, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1829, i32 1)
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %108, i32 0, i32 0
  %110 = load i32, i32* %109, align 8
  %111 = icmp eq i32 %110, 4
  br i1 %111, label %112, label %113

112:                                              ; preds = %105
  br label %138

113:                                              ; preds = %105
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = load i32, i32* %10, align 4
  %116 = call %struct.tdata* @get_node(%struct.tnode* %114, i32 %115, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1832, i32 1)
  %117 = getelementptr inbounds %struct.tdata, %struct.tdata* %116, i32 0, i32 0
  %118 = load i32, i32* %117, align 8
  %119 = load %struct.tnode*, %struct.tnode** %4, align 8
  %120 = load i32, i32* %8, align 4
  %121 = call %struct.tdata* @get_node(%struct.tnode* %119, i32 %120, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1832, i32 1)
  %122 = getelementptr inbounds %struct.tdata, %struct.tdata* %121, i32 0, i32 0
  store i32 %118, i32* %122, align 8
  %123 = load %struct.tnode*, %struct.tnode** %4, align 8
  %124 = load i32, i32* %8, align 4
  %125 = call %struct.tdata* @get_node(%struct.tnode* %123, i32 %124, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1833, i32 1)
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %125, i32 0, i32 2
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = load i32, i32* %10, align 4
  %129 = call %struct.tdata* @get_node(%struct.tnode* %127, i32 %128, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1833, i32 1)
  %130 = getelementptr inbounds %struct.tdata, %struct.tdata* %129, i32 0, i32 2
  %131 = bitcast %union.data_type* %126 to i8*
  %132 = bitcast %union.data_type* %130 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %131, i8* align 8 %132, i64 8, i1 false)
  %133 = load i32, i32* %8, align 4
  %134 = add i32 %133, 1
  store i32 %134, i32* %8, align 4
  br label %135

135:                                              ; preds = %113
  %136 = load i32, i32* %10, align 4
  %137 = add i32 %136, 1
  store i32 %137, i32* %10, align 4
  br label %99

138:                                              ; preds = %26, %112, %99
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_start(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tnode* @validate_node(%struct.tnode* %3, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_get_node_start, i64 0, i64 0))
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
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0))
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
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.67, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

20:                                               ; preds = %17, %11
  %21 = load i32, i32* %2, align 4
  ret i32 %21
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_len(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_set_node_len, i64 0, i64 0))
  %7 = load i32, i32* %4, align 4
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  store i32 %7, i32* %9, align 4
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @_funk_set_node_dimension_count(%struct.tnode* %10, i32 1)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_pool(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  switch i32 %5, label %12 [
    i32 0, label %6
    i32 1, label %9
  ]

6:                                                ; preds = %2
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  store %struct.tpool* @funk_global_memory_pool, %struct.tpool** %8, align 8
  br label %14

9:                                                ; preds = %2
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  store %struct.tpool* @funk_functions_memory_pool, %struct.tpool** %11, align 8
  br label %14

12:                                               ; preds = %2
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.67, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_pool, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

14:                                               ; preds = %9, %6
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_start(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tnode*, %struct.tnode** %3, align 8
  %6 = call %struct.tnode* @validate_node(%struct.tnode* %5, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_set_node_start, i64 0, i64 0))
  %7 = load i32, i32* %4, align 4
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 0
  store i32 %7, i32* %9, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_alloc_tnode_array_from_range_regs(%struct.tnode*, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 1908, i32 1)
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 2
  %15 = bitcast %union.data_type* %14 to i32*
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %9, align 4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 1909, i32 1)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %10, align 4
  %22 = load i32, i32* %9, align 4
  %23 = load i32, i32* %10, align 4
  %24 = icmp uge i32 %22, %23
  br i1 %24, label %25, label %29

25:                                               ; preds = %4
  %26 = load i32, i32* %9, align 4
  %27 = load i32, i32* %10, align 4
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.68, i64 0, i64 0), i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 %26, i32 %27)
  call void @exit(i32 1) #6
  unreachable

29:                                               ; preds = %4
  %30 = load i32, i32* %10, align 4
  %31 = load i32, i32* %9, align 4
  %32 = sub i32 %30, %31
  store i32 %32, i32* %11, align 4
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = load i32, i32* %11, align 4
  %35 = load i32, i32* %8, align 4
  call void @funk_create_node(%struct.tnode* %33, i32 %34, i32 %35, i32 3, i8 zeroext 0, i8* null)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_alloc_tnode_array_from_range_len(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_len, i64 0, i64 0), i32 1928, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  store i32 %12, i32* %7, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load i32, i32* %6, align 4
  call void @funk_create_node(%struct.tnode* %13, i32 %14, i32 %15, i32 3, i8 zeroext 0, i8* null)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_tnode_array_element(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1937, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  store i32 %12, i32* %7, align 4
  %13 = load i32, i32* %7, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = icmp ugt i32 %13, %16
  br i1 %17, label %18, label %24

18:                                               ; preds = %3
  %19 = load i32, i32* %7, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.69, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 %19, i32 %22)
  br label %24

24:                                               ; preds = %18, %3
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = load i32, i32* %7, align 4
  %27 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 %26, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1943, i32 1)
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1943, i32 1)
  %30 = bitcast %struct.tdata* %27 to i8*
  %31 = bitcast %struct.tdata* %29 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %30, i8* align 8 %31, i64 16, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @funk_alloc_list_of_tnodes(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = load %struct.tnode*, %struct.tnode** %2, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_alloc_list_of_tnodes, i64 0, i64 0), i32 1949, i32 1)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 2
  %7 = bitcast %union.data_type* %6 to i32*
  %8 = load i32, i32* %7, align 8
  store i32 %8, i32* %3, align 4
  %9 = load i32, i32* %3, align 4
  %10 = zext i32 %9 to i64
  %11 = mul i64 %10, 32
  %12 = call i8* @malloc(i64 %11) #8
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
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 1970, i32 1)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp ne i32 %12, 6
  br i1 %13, label %14, label %16

14:                                               ; preds = %4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.70, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 1975, i32 1)
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
attributes #4 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn }
attributes #7 = { nounwind readnone }
attributes #8 = { allocsize(0) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
