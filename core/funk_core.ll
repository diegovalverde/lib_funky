; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [250000 x %struct.tdata], i32, i32 }
%struct.tdata = type { i32, %union.data_type }
%union.data_type = type { double }
%struct.tnode = type { i32, i32, i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, [2 x i32] }
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
@.str.5 = private unnamed_addr constant [38 x i8] c"INTERNAL ERROR: %s NULL node pointer\0A\00", align 1
@__FUNCTION__.get_node = private unnamed_addr constant [9 x i8] c"get_node\00", align 1
@.str.6 = private unnamed_addr constant [35 x i8] c"INTERNAL ERROR: called from %s:%d\0A\00", align 1
@.str.7 = private unnamed_addr constant [54 x i8] c"-E- attemping to access overwritten position in ring\0A\00", align 1
@funk_sleep.first = internal global i32 1, align 4
@.str.8 = private unnamed_addr constant [68 x i8] c"%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count %d\0A\00", align 1
@__FUNCTION__.funk_increment_pool_tail = private unnamed_addr constant [25 x i8] c"funk_increment_pool_tail\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@g_debug_continue = internal global i32 0, align 4
@.str.11 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@funk_types_str = internal global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@.str.12 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.14 = private unnamed_addr constant [4 x i8] c"%p\0A\00", align 1
@.str.15 = private unnamed_addr constant [17 x i8] c"%s[%d :%d] %d-d\0A\00", align 1
@.str.16 = private unnamed_addr constant [9 x i8] c"int: %d\0A\00", align 1
@__FUNCTION__.funk_print_node_info = private unnamed_addr constant [21 x i8] c"funk_print_node_info\00", align 1
@.str.17 = private unnamed_addr constant [12 x i8] c"double: %f\0A\00", align 1
@__FUNCTION__.funk_create_node = private unnamed_addr constant [17 x i8] c"funk_create_node\00", align 1
@.str.18 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@__FUNCTION__.funk_sum_list = private unnamed_addr constant [14 x i8] c"funk_sum_list\00", align 1
@.str.19 = private unnamed_addr constant [35 x i8] c"-E- %s Invalid dimensions %d x %d\0A\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_lit = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_lit\00", align 1
@__FUNCTION__.funk_get_element_in_matrix_2d_var = private unnamed_addr constant [34 x i8] c"funk_get_element_in_matrix_2d_var\00", align 1
@.str.20 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_get_element_in_array_var = private unnamed_addr constant [30 x i8] c"funk_get_element_in_array_var\00", align 1
@__FUNCTION__.add_node_to_nodelist = private unnamed_addr constant [21 x i8] c"add_node_to_nodelist\00", align 1
@__FUNCTION__.funk_regroup_list = private unnamed_addr constant [18 x i8] c"funk_regroup_list\00", align 1
@__FUNCTION__.funk_regroup_list_r = private unnamed_addr constant [20 x i8] c"funk_regroup_list_r\00", align 1
@__FUNCTION__.funk_create_scalar = private unnamed_addr constant [19 x i8] c"funk_create_scalar\00", align 1
@__FUNCTION__.funk_create_double_scalar = private unnamed_addr constant [26 x i8] c"funk_create_double_scalar\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@__FUNCTION__.funk_create_list_of_regs = private unnamed_addr constant [25 x i8] c"funk_create_list_of_regs\00", align 1
@__FUNCTION__.funk_create_list_i32_literal = private unnamed_addr constant [29 x i8] c"funk_create_list_i32_literal\00", align 1
@__FUNCTION__.funk_create_list_double_literal = private unnamed_addr constant [32 x i8] c"funk_create_list_double_literal\00", align 1
@.str.21 = private unnamed_addr constant [6 x i8] c" %3d \00", align 1
@.str.22 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.23 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.24 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.26 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_increment_node_data_int = private unnamed_addr constant [29 x i8] c"funk_increment_node_data_int\00", align 1
@__FUNCTION__.funk_copy_node_into_node_list = private unnamed_addr constant [30 x i8] c"funk_copy_node_into_node_list\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_set_node_value_fn_ptr = private unnamed_addr constant [27 x i8] c"funk_set_node_value_fn_ptr\00", align 1
@__FUNCTION__.funk_set_node_value_double = private unnamed_addr constant [27 x i8] c"funk_set_node_value_double\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.27 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.28 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@__FUNCTION__.debug_print_arith_operation = private unnamed_addr constant [28 x i8] c"debug_print_arith_operation\00", align 1
@.str.29 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.30 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.31 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.32 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
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
@.str.33 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.34 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@.str.35 = private unnamed_addr constant [14 x i8] c"-E- funk_mul\0A\00", align 1
@.str.36 = private unnamed_addr constant [14 x i8] c"-E- funk_div\0A\00", align 1
@.str.37 = private unnamed_addr constant [14 x i8] c"-E- funk_add\0A\00", align 1
@.str.38 = private unnamed_addr constant [14 x i8] c"-E- funk_sub\0A\00", align 1
@.str.39 = private unnamed_addr constant [14 x i8] c"-E- funk_mod\0A\00", align 1
@.str.40 = private unnamed_addr constant [14 x i8] c"-E- funk_slt\0A\00", align 1
@.str.41 = private unnamed_addr constant [14 x i8] c"-E- funk_sgt\0A\00", align 1
@.str.42 = private unnamed_addr constant [14 x i8] c"-E- funk_sge\0A\00", align 1
@.str.43 = private unnamed_addr constant [13 x i8] c"-E- funk_eq\0A\00", align 1
@.str.44 = private unnamed_addr constant [13 x i8] c"-E- funk_or\0A\00", align 1
@.str.45 = private unnamed_addr constant [101 x i8] c"\0A-E- cannot perform arithmetic operation in operand A of dimension %d and operand B of dimension %d\0A\00", align 1
@.str.46 = private unnamed_addr constant [30 x i8] c"-E- invalid dimensions %d %d\0A\00", align 1
@.str.47 = private unnamed_addr constant [59 x i8] c"-E- Arithmetic operation in %d is not currently supported\0A\00", align 1
@.str.48 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.49 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.50 = private unnamed_addr constant [2 x i8] c")\00", align 1
@__FUNCTION__.print_scalar = private unnamed_addr constant [13 x i8] c"print_scalar\00", align 1
@.str.51 = private unnamed_addr constant [10 x i8] c"%d x %d \0A\00", align 1
@.str.52 = private unnamed_addr constant [40 x i8] c" [...] %d-dimensional with %d elements\0A\00", align 1
@.str.53 = private unnamed_addr constant [65 x i8] c"%s Error cannot address as a matrix since node has %d dimensions\00", align 1
@__FUNCTION__.print_2d_array_element_reg_reg = private unnamed_addr constant [31 x i8] c"print_2d_array_element_reg_reg\00", align 1
@__FUNCTION__.print_2d_array_element_int_int = private unnamed_addr constant [31 x i8] c"print_2d_array_element_int_int\00", align 1
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.54 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@.str.55 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.56 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.57 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@__FUNCTION__.funk_read_list_from_file = private unnamed_addr constant [25 x i8] c"funk_read_list_from_file\00", align 1
@__FUNCTION__.reshape = private unnamed_addr constant [8 x i8] c"reshape\00", align 1
@.str.58 = private unnamed_addr constant [66 x i8] c"-E- reshape operation not possible for variable with %d elements\0A\00", align 1
@.str.59 = private unnamed_addr constant [28 x i8] c"%s Error r1 (%d) > r2 (%d)\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix_lit_indexes = private unnamed_addr constant [35 x i8] c"funk_create_sub_matrix_lit_indexes\00", align 1
@.str.60 = private unnamed_addr constant [28 x i8] c"%s Error c1 (%d) > c2 (%d)\0A\00", align 1
@.str.61 = private unnamed_addr constant [46 x i8] c"Error: %s shall have 2 dimensions and not %d\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix = private unnamed_addr constant [23 x i8] c"funk_create_sub_matrix\00", align 1
@__FUNCTION__.funk_create_sub_array_lit_indexes = private unnamed_addr constant [34 x i8] c"funk_create_sub_array_lit_indexes\00", align 1
@.str.62 = private unnamed_addr constant [46 x i8] c"Error: %s shall have 1 dimensions and not %d\0A\00", align 1
@__FUNCTION__.funk_create_sub_array = private unnamed_addr constant [22 x i8] c"funk_create_sub_array\00", align 1
@__FUNCTION__.funk_set_node_dimensions_2d = private unnamed_addr constant [28 x i8] c"funk_set_node_dimensions_2d\00", align 1
@__FUNCTION__.funk_concatenate_lists = private unnamed_addr constant [23 x i8] c"funk_concatenate_lists\00", align 1
@.str.63 = private unnamed_addr constant [38 x i8] c"funk_concatenate_lists [] , [] -> []\0A\00", align 1
@__FUNCTION__.funk_get_node_start = private unnamed_addr constant [20 x i8] c"funk_get_node_start\00", align 1
@__FUNCTION__.funk_get_node_pool = private unnamed_addr constant [19 x i8] c"funk_get_node_pool\00", align 1
@.str.64 = private unnamed_addr constant [21 x i8] c"-E- %s Invalid pool\0A\00", align 1
@__FUNCTION__.funk_set_node_len = private unnamed_addr constant [18 x i8] c"funk_set_node_len\00", align 1
@__FUNCTION__.funk_set_node_pool = private unnamed_addr constant [19 x i8] c"funk_set_node_pool\00", align 1
@__FUNCTION__.funk_set_node_start = private unnamed_addr constant [20 x i8] c"funk_set_node_start\00", align 1
@__FUNCTION__.funk_alloc_tnode_array_from_range_regs = private unnamed_addr constant [39 x i8] c"funk_alloc_tnode_array_from_range_regs\00", align 1
@.str.65 = private unnamed_addr constant [36 x i8] c"-E- %s Invalid range from %d to %d\0A\00", align 1
@__FUNCTION__.funk_alloc_tnode_array_from_range_len = private unnamed_addr constant [38 x i8] c"funk_alloc_tnode_array_from_range_len\00", align 1
@__FUNCTION__.funk_set_tnode_array_element = private unnamed_addr constant [29 x i8] c"funk_set_tnode_array_element\00", align 1
@.str.66 = private unnamed_addr constant [37 x i8] c"-E- %s Index %d out of range [0:%d]\0A\00", align 1
@__FUNCTION__.funk_alloc_list_of_tnodes = private unnamed_addr constant [26 x i8] c"funk_alloc_list_of_tnodes\00", align 1
@__FUNCTION__.funk_call_fn_pointer = private unnamed_addr constant [21 x i8] c"funk_call_fn_pointer\00", align 1
@.str.67 = private unnamed_addr constant [43 x i8] c"-E- calling node which is not a function!\0A\00", align 1

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
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 4
  %16 = load %struct.tpool*, %struct.tpool** %15, align 8
  %17 = icmp ne %struct.tpool* %16, @funk_global_memory_pool
  br i1 %17, label %18, label %42

18:                                               ; preds = %13
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 4
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
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 4
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
define void @set_dimension(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 5
  %10 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %9, i32 0, i32 1
  %11 = load i32, i32* %5, align 4
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds [2 x i32], [2 x i32]* %10, i64 0, i64 %12
  store i32 %7, i32* %13, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tdata* @get_node(%struct.tnode*, i32, i8*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store i32 %1, i32* %6, align 4
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = icmp eq %struct.tnode* %10, null
  br i1 %11, label %12, label %14

12:                                               ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

14:                                               ; preds = %4
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = call %struct.tnode* @validate_node(%struct.tnode* %15, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0))
  %17 = icmp eq %struct.tnode* %16, null
  br i1 %17, label %18, label %22

18:                                               ; preds = %14
  %19 = load i8*, i8** %7, align 8
  %20 = load i32, i32* %8, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.6, i64 0, i64 0), i8* %19, i32 %20)
  call void @exit(i32 1) #6
  unreachable

22:                                               ; preds = %14
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 2
  %25 = load i32, i32* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 4
  %28 = load %struct.tpool*, %struct.tpool** %27, align 8
  %29 = getelementptr inbounds %struct.tpool, %struct.tpool* %28, i32 0, i32 2
  %30 = load i32, i32* %29, align 4
  %31 = icmp ult i32 %25, %30
  br i1 %31, label %32, label %44

32:                                               ; preds = %22
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 4
  %38 = load %struct.tpool*, %struct.tpool** %37, align 8
  %39 = getelementptr inbounds %struct.tpool, %struct.tpool* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 8
  %41 = icmp ule i32 %35, %40
  br i1 %41, label %42, label %44

42:                                               ; preds = %32
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.7, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

44:                                               ; preds = %32, %22
  %45 = load %struct.tnode*, %struct.tnode** %5, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 0
  %47 = load i32, i32* %46, align 8
  %48 = load i32, i32* %6, align 4
  %49 = add i32 %47, %48
  store i32 %49, i32* %9, align 4
  %50 = load %struct.tnode*, %struct.tnode** %5, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 4
  %52 = load %struct.tpool*, %struct.tpool** %51, align 8
  %53 = getelementptr inbounds %struct.tpool, %struct.tpool* %52, i32 0, i32 0
  %54 = load i32, i32* %9, align 4
  %55 = urem i32 %54, 250000
  %56 = zext i32 %55 to i64
  %57 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %53, i64 0, i64 %56
  ret %struct.tdata* %57
}

; Function Attrs: noreturn
declare void @exit(i32) #2

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
define void @funk_increment_pool_tail(%struct.tpool*, i32) #0 {
  %3 = alloca %struct.tpool*, align 8
  %4 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tpool*, %struct.tpool** %3, align 8
  %6 = icmp eq %struct.tpool* %5, @funk_global_memory_pool
  br i1 %6, label %7, label %30

7:                                                ; preds = %2
  %8 = load %struct.tpool*, %struct.tpool** %3, align 8
  %9 = getelementptr inbounds %struct.tpool, %struct.tpool* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 8
  %11 = load i32, i32* %4, align 4
  %12 = add i32 %10, %11
  %13 = icmp uge i32 %12, 250000
  br i1 %13, label %14, label %30

14:                                               ; preds = %7
  %15 = load %struct.tpool*, %struct.tpool** %3, align 8
  %16 = getelementptr inbounds %struct.tpool, %struct.tpool* %15, i32 0, i32 2
  %17 = load i32, i32* %16, align 4
  %18 = add i32 %17, 1
  store i32 %18, i32* %16, align 4
  %19 = load %struct.tpool*, %struct.tpool** %3, align 8
  %20 = icmp eq %struct.tpool* %19, @funk_global_memory_pool
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %23 = load %struct.tpool*, %struct.tpool** %3, align 8
  %24 = getelementptr inbounds %struct.tpool, %struct.tpool* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 8
  %26 = load %struct.tpool*, %struct.tpool** %3, align 8
  %27 = getelementptr inbounds %struct.tpool, %struct.tpool* %26, i32 0, i32 2
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_increment_pool_tail, i64 0, i64 0), i8* %22, i32 %25, i32 250000, i32 %28)
  store i32 0, i32* @g_debug_continue, align 4
  br label %30

30:                                               ; preds = %14, %7, %2
  %31 = load %struct.tpool*, %struct.tpool** %3, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 1
  %33 = load i32, i32* %32, align 8
  %34 = load i32, i32* %4, align 4
  %35 = add i32 %33, %34
  %36 = urem i32 %35, 250000
  %37 = load %struct.tpool*, %struct.tpool** %3, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  store i32 %36, i32* %38, align 8
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.11, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.13, i64 0, i64 0))
  %4 = load %struct.tnode*, %struct.tnode** %2, align 8
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i64 0, i64 0), %struct.tnode* %4)
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 4
  %8 = load %struct.tpool*, %struct.tpool** %7, align 8
  %9 = icmp eq %struct.tpool* %8, @funk_global_memory_pool
  %10 = zext i1 %9 to i64
  %11 = select i1 %9, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = load %struct.tnode*, %struct.tnode** %2, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = load %struct.tnode*, %struct.tnode** %2, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 5
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.15, i64 0, i64 0), i8* %11, i32 %14, i32 %17, i32 %21)
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 189)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  %27 = load i32, i32* %26, align 8
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.16, i64 0, i64 0), i32 %27)
  %29 = load %struct.tnode*, %struct.tnode** %2, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 190)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 1
  %32 = bitcast %union.data_type* %31 to double*
  %33 = load double, double* %32, align 8
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.17, i64 0, i64 0), double %33)
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0), i32 191)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = trunc i32 %38 to i8
  call void @funk_print_type(i8 zeroext %39)
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.13, i64 0, i64 0))
  ret void
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
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store i32 %2, i32* %9, align 4
  store i32 %3, i32* %10, align 4
  store i8 %4, i8* %11, align 1
  store i8* %5, i8** %12, align 8
  %16 = load i8, i8* %11, align 1
  %17 = zext i8 %16 to i32
  %18 = icmp slt i32 %17, 2
  br i1 %18, label %19, label %20

19:                                               ; preds = %6
  br label %23

20:                                               ; preds = %6
  %21 = load i8, i8* %11, align 1
  %22 = zext i8 %21 to i32
  br label %23

23:                                               ; preds = %20, %19
  %24 = phi i32 [ 1, %19 ], [ %22, %20 ]
  %25 = trunc i32 %24 to i8
  store i8 %25, i8* %11, align 1
  %26 = load i32, i32* %8, align 4
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %23
  br label %31

29:                                               ; preds = %23
  %30 = load i32, i32* %8, align 4
  br label %31

31:                                               ; preds = %29, %28
  %32 = phi i32 [ 1, %28 ], [ %30, %29 ]
  store i32 %32, i32* %13, align 4
  %33 = load i32, i32* %9, align 4
  %34 = call %struct.tpool* @get_pool_ptr(i32 %33)
  store %struct.tpool* %34, %struct.tpool** %14, align 8
  %35 = load %struct.tpool*, %struct.tpool** %14, align 8
  %36 = getelementptr inbounds %struct.tpool, %struct.tpool* %35, i32 0, i32 1
  %37 = load i32, i32* %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %7, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 0
  store i32 %37, i32* %39, align 8
  %40 = load %struct.tpool*, %struct.tpool** %14, align 8
  %41 = load %struct.tnode*, %struct.tnode** %7, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 4
  store %struct.tpool* %40, %struct.tpool** %42, align 8
  %43 = load i32, i32* %13, align 4
  %44 = load %struct.tnode*, %struct.tnode** %7, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  store i32 %43, i32* %45, align 4
  %46 = load i8, i8* %11, align 1
  %47 = zext i8 %46 to i32
  %48 = load %struct.tnode*, %struct.tnode** %7, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 5
  %50 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %49, i32 0, i32 0
  store i32 %47, i32* %50, align 8
  %51 = load i8, i8* %11, align 1
  %52 = zext i8 %51 to i32
  %53 = icmp sge i32 %52, 2
  br i1 %53, label %54, label %67

54:                                               ; preds = %31
  %55 = load %struct.tnode*, %struct.tnode** %7, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = load i32, i32* %8, align 4
  %59 = add i32 %57, %58
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 3
  store i32 %59, i32* %61, align 4
  %62 = load %struct.tpool*, %struct.tpool** %14, align 8
  %63 = load i32, i32* %8, align 4
  %64 = load i8, i8* %11, align 1
  %65 = zext i8 %64 to i32
  %66 = add i32 %63, %65
  call void @funk_increment_pool_tail(%struct.tpool* %62, i32 %66)
  br label %72

67:                                               ; preds = %31
  %68 = load %struct.tnode*, %struct.tnode** %7, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 3
  store i32 0, i32* %69, align 4
  %70 = load %struct.tpool*, %struct.tpool** %14, align 8
  %71 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %70, i32 %71)
  br label %72

72:                                               ; preds = %67, %54
  store i32 0, i32* %15, align 4
  br label %73

73:                                               ; preds = %130, %72
  %74 = load i32, i32* %15, align 4
  %75 = load i32, i32* %13, align 4
  %76 = icmp ult i32 %74, %75
  br i1 %76, label %77, label %133

77:                                               ; preds = %73
  %78 = load i32, i32* %10, align 4
  %79 = load %struct.tnode*, %struct.tnode** %7, align 8
  %80 = load i32, i32* %15, align 4
  %81 = call %struct.tdata* @get_node(%struct.tnode* %79, i32 %80, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 228)
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  store i32 %78, i32* %82, align 8
  %83 = load %struct.tpool*, %struct.tpool** %14, align 8
  %84 = getelementptr inbounds %struct.tpool, %struct.tpool* %83, i32 0, i32 2
  %85 = load i32, i32* %84, align 4
  %86 = load %struct.tnode*, %struct.tnode** %7, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 2
  store i32 %85, i32* %87, align 8
  %88 = load i8*, i8** %12, align 8
  %89 = icmp eq i8* %88, null
  br i1 %89, label %90, label %91

90:                                               ; preds = %77
  br label %130

91:                                               ; preds = %77
  %92 = load i32, i32* %10, align 4
  switch i32 %92, label %128 [
    i32 1, label %93
    i32 2, label %105
    i32 4, label %117
  ]

93:                                               ; preds = %91
  %94 = load i8*, i8** %12, align 8
  %95 = bitcast i8* %94 to i32*
  %96 = load i32, i32* %15, align 4
  %97 = zext i32 %96 to i64
  %98 = getelementptr inbounds i32, i32* %95, i64 %97
  %99 = load i32, i32* %98, align 4
  %100 = load %struct.tnode*, %struct.tnode** %7, align 8
  %101 = load i32, i32* %15, align 4
  %102 = call %struct.tdata* @get_node(%struct.tnode* %100, i32 %101, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 236)
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 1
  %104 = bitcast %union.data_type* %103 to i32*
  store i32 %99, i32* %104, align 8
  br label %129

105:                                              ; preds = %91
  %106 = load i8*, i8** %12, align 8
  %107 = bitcast i8* %106 to double*
  %108 = load i32, i32* %15, align 4
  %109 = zext i32 %108 to i64
  %110 = getelementptr inbounds double, double* %107, i64 %109
  %111 = load double, double* %110, align 8
  %112 = load %struct.tnode*, %struct.tnode** %7, align 8
  %113 = load i32, i32* %15, align 4
  %114 = call %struct.tdata* @get_node(%struct.tnode* %112, i32 %113, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 240)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 1
  %116 = bitcast %union.data_type* %115 to double*
  store double %111, double* %116, align 8
  br label %129

117:                                              ; preds = %91
  %118 = load %struct.tnode*, %struct.tnode** %7, align 8
  %119 = load i32, i32* %15, align 4
  %120 = call %struct.tdata* @get_node(%struct.tnode* %118, i32 %119, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 244)
  %121 = getelementptr inbounds %struct.tdata, %struct.tdata* %120, i32 0, i32 1
  %122 = bitcast %union.data_type* %121 to i32*
  store i32 0, i32* %122, align 8
  %123 = load %struct.tnode*, %struct.tnode** %7, align 8
  %124 = load i32, i32* %15, align 4
  %125 = call %struct.tdata* @get_node(%struct.tnode* %123, i32 %124, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_node, i64 0, i64 0), i32 245)
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %125, i32 0, i32 1
  %127 = bitcast %union.data_type* %126 to double*
  store double 0.000000e+00, double* %127, align 8
  br label %129

128:                                              ; preds = %91
  br label %129

129:                                              ; preds = %128, %117, %105, %93
  br label %130

130:                                              ; preds = %129, %90
  %131 = load i32, i32* %15, align 4
  %132 = add i32 %131, 1
  store i32 %132, i32* %15, align 4
  br label %73

133:                                              ; preds = %73
  ret void
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
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 5
  %18 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = load %struct.tnode*, %struct.tnode** %3, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 5
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  store i32 %19, i32* %22, align 8
  store i32 0, i32* %5, align 4
  br label %23

23:                                               ; preds = %40, %2
  %24 = load i32, i32* %5, align 4
  %25 = icmp slt i32 %24, 2
  br i1 %25, label %26, label %43

26:                                               ; preds = %23
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 5
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 1
  %30 = load i32, i32* %5, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [2 x i32], [2 x i32]* %29, i64 0, i64 %31
  %33 = load i32, i32* %32, align 4
  %34 = load %struct.tnode*, %struct.tnode** %3, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 5
  %36 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %35, i32 0, i32 1
  %37 = load i32, i32* %5, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2 x i32], [2 x i32]* %36, i64 0, i64 %38
  store i32 %33, i32* %39, align 4
  br label %40

40:                                               ; preds = %26
  %41 = load i32, i32* %5, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %5, align 4
  br label %23

43:                                               ; preds = %23
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 4
  %46 = load %struct.tpool*, %struct.tpool** %45, align 8
  %47 = load %struct.tnode*, %struct.tnode** %3, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 4
  store %struct.tpool* %46, %struct.tpool** %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 4
  %51 = load %struct.tpool*, %struct.tpool** %50, align 8
  %52 = getelementptr inbounds %struct.tpool, %struct.tpool* %51, i32 0, i32 2
  %53 = load i32, i32* %52, align 4
  %54 = load %struct.tnode*, %struct.tnode** %3, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 2
  store i32 %53, i32* %55, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_exit() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.18, i64 0, i64 0))
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
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 5
  %13 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp eq i32 %14, 2
  br i1 %15, label %16, label %28

16:                                               ; preds = %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 1
  %20 = getelementptr inbounds [2 x i32], [2 x i32]* %19, i64 0, i64 0
  %21 = load i32, i32* %20, align 4
  %22 = load %struct.tnode*, %struct.tnode** %3, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 5
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 1
  %25 = getelementptr inbounds [2 x i32], [2 x i32]* %24, i64 0, i64 1
  %26 = load i32, i32* %25, align 4
  %27 = mul i32 %21, %26
  store i32 %27, i32* %6, align 4
  br label %28

28:                                               ; preds = %16, %2
  store i32 0, i32* %7, align 4
  br label %29

29:                                               ; preds = %42, %28
  %30 = load i32, i32* %7, align 4
  %31 = load i32, i32* %6, align 4
  %32 = icmp ult i32 %30, %31
  br i1 %32, label %33, label %45

33:                                               ; preds = %29
  %34 = load %struct.tnode*, %struct.tnode** %3, align 8
  %35 = load i32, i32* %7, align 4
  %36 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 %35, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.funk_sum_list, i64 0, i64 0), i32 295)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 1
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  %40 = load i32, i32* %5, align 4
  %41 = add i32 %40, %39
  store i32 %41, i32* %5, align 4
  br label %42

42:                                               ; preds = %33
  %43 = load i32, i32* %7, align 4
  %44 = add i32 %43, 1
  store i32 %44, i32* %7, align 4
  br label %29

45:                                               ; preds = %29
  %46 = load %struct.tnode*, %struct.tnode** %4, align 8
  %47 = bitcast i32* %5 to i8*
  call void @funk_create_node(%struct.tnode* %46, i32 1, i32 1, i32 1, i8 zeroext 1, i8* %47)
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
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 2), align 4
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 2), align 4
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

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
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 5
  %14 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %13, i32 0, i32 1
  %15 = getelementptr inbounds [2 x i32], [2 x i32]* %14, i64 0, i64 0
  %16 = load i32, i32* %15, align 4
  store i32 %16, i32* %9, align 4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 1
  %20 = getelementptr inbounds [2 x i32], [2 x i32]* %19, i64 0, i64 1
  %21 = load i32, i32* %20, align 4
  store i32 %21, i32* %10, align 4
  %22 = load i32, i32* %9, align 4
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %27, label %24

24:                                               ; preds = %4
  %25 = load i32, i32* %10, align 4
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %32

27:                                               ; preds = %24, %4
  %28 = load i32, i32* %9, align 4
  %29 = load i32, i32* %10, align 4
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 %28, i32 %29)
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_print_node_info(%struct.tnode* %31)
  call void @exit(i32 1) #6
  unreachable

32:                                               ; preds = %24
  %33 = load i32, i32* %7, align 4
  %34 = icmp slt i32 %33, 0
  br i1 %34, label %35, label %39

35:                                               ; preds = %32
  %36 = load i32, i32* %9, align 4
  %37 = load i32, i32* %7, align 4
  %38 = add i32 %36, %37
  br label %41

39:                                               ; preds = %32
  %40 = load i32, i32* %7, align 4
  br label %41

41:                                               ; preds = %39, %35
  %42 = phi i32 [ %38, %35 ], [ %40, %39 ]
  store i32 %42, i32* %7, align 4
  %43 = load i32, i32* %8, align 4
  %44 = icmp slt i32 %43, 0
  br i1 %44, label %45, label %49

45:                                               ; preds = %41
  %46 = load i32, i32* %10, align 4
  %47 = load i32, i32* %8, align 4
  %48 = add i32 %46, %47
  br label %51

49:                                               ; preds = %41
  %50 = load i32, i32* %8, align 4
  br label %51

51:                                               ; preds = %49, %45
  %52 = phi i32 [ %48, %45 ], [ %50, %49 ]
  store i32 %52, i32* %8, align 4
  %53 = load i32, i32* %9, align 4
  %54 = load i32, i32* %7, align 4
  %55 = urem i32 %54, %53
  store i32 %55, i32* %7, align 4
  %56 = load i32, i32* %10, align 4
  %57 = load i32, i32* %8, align 4
  %58 = urem i32 %57, %56
  store i32 %58, i32* %8, align 4
  %59 = load %struct.tnode*, %struct.tnode** %5, align 8
  %60 = load i32, i32* %9, align 4
  %61 = load i32, i32* %7, align 4
  %62 = mul i32 %60, %61
  %63 = load i32, i32* %8, align 4
  %64 = add i32 %62, %63
  %65 = call %struct.tdata* @get_node(%struct.tnode* %59, i32 %64, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_lit, i64 0, i64 0), i32 365)
  store %struct.tdata* %65, %struct.tdata** %11, align 8
  %66 = load %struct.tnode*, %struct.tnode** %6, align 8
  %67 = load %struct.tdata*, %struct.tdata** %11, align 8
  %68 = getelementptr inbounds %struct.tdata, %struct.tdata* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = load %struct.tdata*, %struct.tdata** %11, align 8
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 1
  %72 = bitcast %union.data_type* %71 to i8*
  call void @funk_create_node(%struct.tnode* %66, i32 1, i32 1, i32 %69, i8 zeroext 0, i8* %72)
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 378)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 380)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %20)
  br label %22

22:                                               ; preds = %16, %4
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 383)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = icmp ne i32 %26, 1
  br i1 %27, label %28, label %34

28:                                               ; preds = %22
  %29 = load %struct.tnode*, %struct.tnode** %8, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 385)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 %32)
  br label %34

34:                                               ; preds = %28, %22
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = call %struct.tdata* @get_node(%struct.tnode* %35, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 388)
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 1
  %38 = bitcast %union.data_type* %37 to i32*
  %39 = load i32, i32* %38, align 8
  store i32 %39, i32* %9, align 4
  %40 = load %struct.tnode*, %struct.tnode** %8, align 8
  %41 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_get_element_in_matrix_2d_var, i64 0, i64 0), i32 389)
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 1
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
  %7 = load i32, i32* %6, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %9, label %15

9:                                                ; preds = %3
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* %6, align 4
  %14 = add i32 %12, %13
  br label %17

15:                                               ; preds = %3
  %16 = load i32, i32* %6, align 4
  br label %17

17:                                               ; preds = %15, %9
  %18 = phi i32 [ %14, %9 ], [ %16, %15 ]
  store i32 %18, i32* %6, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = load i32, i32* %6, align 4
  %23 = urem i32 %22, %21
  store i32 %23, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 4
  %26 = load %struct.tpool*, %struct.tpool** %25, align 8
  %27 = load %struct.tnode*, %struct.tnode** %5, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 4
  store %struct.tpool* %26, %struct.tpool** %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 4
  %31 = load %struct.tpool*, %struct.tpool** %30, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 2
  %33 = load i32, i32* %32, align 4
  %34 = load %struct.tnode*, %struct.tnode** %5, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 2
  store i32 %33, i32* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 5
  %38 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %37, i32 0, i32 0
  store i32 0, i32* %38, align 8
  %39 = load %struct.tnode*, %struct.tnode** %5, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  store i32 1, i32* %40, align 4
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 0
  %43 = load i32, i32* %42, align 8
  %44 = load i32, i32* %6, align 4
  %45 = add i32 %43, %44
  %46 = urem i32 %45, 250000
  %47 = load %struct.tnode*, %struct.tnode** %5, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  store i32 %46, i32* %48, align 8
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 412)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %19

13:                                               ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 414)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 %17)
  br label %19

19:                                               ; preds = %13, %3
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_get_element_in_array_var, i64 0, i64 0), i32 417)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 1
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
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = call %struct.tnode* @validate_node(%struct.tnode* %12, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0))
  %14 = load %struct.tnode*, %struct.tnode** %7, align 8
  %15 = call %struct.tnode* @validate_node(%struct.tnode* %14, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0))
  %16 = load %struct.tnode*, %struct.tnode** %7, align 8
  %17 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 431)
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 1
  %19 = bitcast %union.data_type* %18 to i32*
  %20 = load i32, i32* %19, align 8
  store i32 %20, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %21 = load i32, i32* %9, align 4
  store i32 %21, i32* %11, align 4
  br label %22

22:                                               ; preds = %82, %4
  %23 = load i32, i32* %10, align 4
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = icmp ult i32 %23, %26
  br i1 %27, label %28, label %32

28:                                               ; preds = %22
  %29 = load i32, i32* %11, align 4
  %30 = load i32, i32* %8, align 4
  %31 = icmp ult i32 %29, %30
  br label %32

32:                                               ; preds = %28, %22
  %33 = phi i1 [ false, %22 ], [ %31, %28 ]
  br i1 %33, label %34, label %85

34:                                               ; preds = %32
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 4
  %37 = load %struct.tpool*, %struct.tpool** %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = load i32, i32* %11, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i64 %40
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 4
  store %struct.tpool* %37, %struct.tpool** %42, align 8
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 4
  %45 = load %struct.tpool*, %struct.tpool** %44, align 8
  %46 = getelementptr inbounds %struct.tpool, %struct.tpool* %45, i32 0, i32 2
  %47 = load i32, i32* %46, align 4
  %48 = load %struct.tnode*, %struct.tnode** %5, align 8
  %49 = load i32, i32* %11, align 4
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i64 %50
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 2
  store i32 %47, i32* %52, align 8
  %53 = load %struct.tnode*, %struct.tnode** %6, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 0
  %55 = load i32, i32* %54, align 8
  %56 = load i32, i32* %10, align 4
  %57 = add i32 %55, %56
  %58 = load %struct.tnode*, %struct.tnode** %5, align 8
  %59 = load i32, i32* %11, align 4
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i64 %60
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 0
  store i32 %57, i32* %62, align 8
  %63 = load %struct.tnode*, %struct.tnode** %5, align 8
  %64 = load i32, i32* %11, align 4
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i64 %65
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 1
  store i32 1, i32* %67, align 4
  %68 = load %struct.tnode*, %struct.tnode** %5, align 8
  %69 = load i32, i32* %11, align 4
  %70 = zext i32 %69 to i64
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i64 %70
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 5
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 0
  store i32 1, i32* %73, align 8
  %74 = load %struct.tnode*, %struct.tnode** %7, align 8
  %75 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.add_node_to_nodelist, i64 0, i64 0), i32 449)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 1
  %77 = bitcast %union.data_type* %76 to i32*
  %78 = load i32, i32* %77, align 8
  %79 = add nsw i32 %78, 1
  store i32 %79, i32* %77, align 8
  %80 = load i32, i32* %10, align 4
  %81 = add i32 %80, 1
  store i32 %81, i32* %10, align 4
  br label %82

82:                                               ; preds = %34
  %83 = load i32, i32* %11, align 4
  %84 = add i32 %83, 1
  store i32 %84, i32* %11, align 4
  br label %22

85:                                               ; preds = %32
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_regroup_list(i32, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tpool*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tdata*, align 8
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %12 = load i32, i32* %5, align 4
  %13 = call %struct.tpool* @get_pool_ptr(i32 %12)
  store %struct.tpool* %13, %struct.tpool** %9, align 8
  %14 = load %struct.tpool*, %struct.tpool** %9, align 8
  %15 = load %struct.tnode*, %struct.tnode** %6, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 4
  store %struct.tpool* %14, %struct.tpool** %16, align 8
  %17 = load %struct.tpool*, %struct.tpool** %9, align 8
  %18 = getelementptr inbounds %struct.tpool, %struct.tpool* %17, i32 0, i32 2
  %19 = load i32, i32* %18, align 4
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 2
  store i32 %19, i32* %21, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 5
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 0
  store i32 1, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %7, align 8
  %26 = load i32, i32* %8, align 4
  %27 = call i32 @is_list_consecutive_in_memory(%struct.tnode* %25, i32 %26)
  %28 = icmp eq i32 %27, 1
  br i1 %28, label %29, label %39

29:                                               ; preds = %4
  %30 = load %struct.tnode*, %struct.tnode** %7, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i64 0
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 0
  store i32 %33, i32* %35, align 8
  %36 = load i32, i32* %8, align 4
  %37 = load %struct.tnode*, %struct.tnode** %6, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  store i32 %36, i32* %38, align 4
  br label %70

39:                                               ; preds = %4
  %40 = load %struct.tpool*, %struct.tpool** %9, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 1
  %42 = load i32, i32* %41, align 8
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 0
  store i32 %42, i32* %44, align 8
  %45 = load i32, i32* %8, align 4
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  store i32 %45, i32* %47, align 4
  %48 = load %struct.tpool*, %struct.tpool** %9, align 8
  %49 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %48, i32 %49)
  store i32 0, i32* %10, align 4
  br label %50

50:                                               ; preds = %66, %39
  %51 = load i32, i32* %10, align 4
  %52 = load i32, i32* %8, align 4
  %53 = icmp ult i32 %51, %52
  br i1 %53, label %54, label %69

54:                                               ; preds = %50
  %55 = load %struct.tnode*, %struct.tnode** %7, align 8
  %56 = load i32, i32* %10, align 4
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i64 %57
  %59 = call %struct.tdata* @get_node(%struct.tnode* %58, i32 0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_regroup_list, i64 0, i64 0), i32 481)
  store %struct.tdata* %59, %struct.tdata** %11, align 8
  %60 = load %struct.tnode*, %struct.tnode** %6, align 8
  %61 = load i32, i32* %10, align 4
  %62 = call %struct.tdata* @get_node(%struct.tnode* %60, i32 %61, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__.funk_regroup_list, i64 0, i64 0), i32 482)
  %63 = load %struct.tdata*, %struct.tdata** %11, align 8
  %64 = bitcast %struct.tdata* %62 to i8*
  %65 = bitcast %struct.tdata* %63 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %64, i8* align 8 %65, i64 16, i1 false)
  br label %66

66:                                               ; preds = %54
  %67 = load i32, i32* %10, align 4
  %68 = add i32 %67, 1
  store i32 %68, i32* %10, align 4
  br label %50

69:                                               ; preds = %50
  br label %70

70:                                               ; preds = %69, %29
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #3

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
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__FUNCTION__.funk_regroup_list_r, i64 0, i64 0), i32 493)
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
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
  %11 = load i32, i32* %6, align 4
  %12 = load %struct.tnode*, %struct.tnode** %7, align 8
  %13 = load %struct.tnode*, %struct.tnode** %8, align 8
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %10, align 4
  %16 = mul nsw i32 %14, %15
  call void @funk_regroup_list(i32 %11, %struct.tnode* %12, %struct.tnode* %13, i32 %16)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 2, i32* %19, align 8
  %20 = load i32, i32* %9, align 4
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 5
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 1
  %24 = getelementptr inbounds [2 x i32], [2 x i32]* %23, i64 0, i64 0
  store i32 %20, i32* %24, align 4
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 5
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 1
  store i32 %25, i32* %29, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_scalar(%struct.tpool*, %struct.tnode*, i8*, i32) #0 {
  %5 = alloca %struct.tpool*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load %struct.tpool*, %struct.tpool** %5, align 8
  %10 = getelementptr inbounds %struct.tpool, %struct.tpool* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 8
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 0
  store i32 %11, i32* %13, align 8
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  store i32 1, i32* %15, align 4
  %16 = load %struct.tpool*, %struct.tpool** %5, align 8
  %17 = load %struct.tnode*, %struct.tnode** %6, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 4
  store %struct.tpool* %16, %struct.tpool** %18, align 8
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 5
  %21 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %20, i32 0, i32 0
  store i32 1, i32* %21, align 8
  %22 = load %struct.tpool*, %struct.tpool** %5, align 8
  %23 = getelementptr inbounds %struct.tpool, %struct.tpool* %22, i32 0, i32 2
  %24 = load i32, i32* %23, align 4
  %25 = load %struct.tnode*, %struct.tnode** %6, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  store i32 %24, i32* %26, align 8
  %27 = load %struct.tpool*, %struct.tpool** %5, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %27, i32 1)
  %28 = load i32, i32* %8, align 4
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0), i32 516)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  store i32 %28, i32* %31, align 8
  %32 = load i32, i32* %8, align 4
  switch i32 %32, label %58 [
    i32 1, label %33
    i32 2, label %41
    i32 4, label %49
  ]

33:                                               ; preds = %4
  %34 = load i8*, i8** %7, align 8
  %35 = bitcast i8* %34 to i32*
  %36 = load i32, i32* %35, align 4
  %37 = load %struct.tnode*, %struct.tnode** %6, align 8
  %38 = call %struct.tdata* @get_node(%struct.tnode* %37, i32 0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0), i32 520)
  %39 = getelementptr inbounds %struct.tdata, %struct.tdata* %38, i32 0, i32 1
  %40 = bitcast %union.data_type* %39 to i32*
  store i32 %36, i32* %40, align 8
  br label %60

41:                                               ; preds = %4
  %42 = load i8*, i8** %7, align 8
  %43 = bitcast i8* %42 to double*
  %44 = load double, double* %43, align 8
  %45 = load %struct.tnode*, %struct.tnode** %6, align 8
  %46 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0), i32 524)
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 1
  %48 = bitcast %union.data_type* %47 to double*
  store double %44, double* %48, align 8
  br label %60

49:                                               ; preds = %4
  %50 = load %struct.tnode*, %struct.tnode** %6, align 8
  %51 = call %struct.tdata* @get_node(%struct.tnode* %50, i32 0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0), i32 528)
  %52 = getelementptr inbounds %struct.tdata, %struct.tdata* %51, i32 0, i32 1
  %53 = bitcast %union.data_type* %52 to i32*
  store i32 0, i32* %53, align 8
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  %55 = call %struct.tdata* @get_node(%struct.tnode* %54, i32 0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0), i32 529)
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to double*
  store double 0.000000e+00, double* %57, align 8
  br label %60

58:                                               ; preds = %4
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_create_scalar, i64 0, i64 0))
  br label %60

60:                                               ; preds = %58, %49, %41, %33
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
  %9 = alloca %struct.tpool*, align 8
  %10 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = call %struct.tpool* @get_pool_ptr(i32 %11)
  store %struct.tpool* %12, %struct.tpool** %9, align 8
  %13 = load %struct.tpool*, %struct.tpool** %9, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 8
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  store i32 %15, i32* %17, align 8
  %18 = load i32, i32* %8, align 4
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  store i32 %18, i32* %20, align 4
  %21 = load %struct.tpool*, %struct.tpool** %9, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 4
  store %struct.tpool* %21, %struct.tpool** %23, align 8
  %24 = load %struct.tpool*, %struct.tpool** %9, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 2
  %26 = load i32, i32* %25, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  store i32 %26, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 5
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 0
  store i32 1, i32* %31, align 8
  %32 = load %struct.tpool*, %struct.tpool** %9, align 8
  %33 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %32, i32 %33)
  store i32 0, i32* %10, align 4
  br label %34

34:                                               ; preds = %49, %4
  %35 = load i32, i32* %10, align 4
  %36 = load i32, i32* %8, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %52

38:                                               ; preds = %34
  %39 = load %struct.tnode*, %struct.tnode** %6, align 8
  %40 = load i32, i32* %10, align 4
  %41 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 %40, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 572)
  %42 = load %struct.tnode*, %struct.tnode** %7, align 8
  %43 = load i32, i32* %10, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i64 %44
  %46 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 0, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_list_of_regs, i64 0, i64 0), i32 572)
  %47 = bitcast %struct.tdata* %41 to i8*
  %48 = bitcast %struct.tdata* %46 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %47, i8* align 8 %48, i64 16, i1 false)
  br label %49

49:                                               ; preds = %38
  %50 = load i32, i32* %10, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %10, align 4
  br label %34

52:                                               ; preds = %34
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_i32_literal(i32, %struct.tnode*, i32*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tpool*, align 8
  %10 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32* %2, i32** %7, align 8
  store i32 %3, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = call %struct.tpool* @get_pool_ptr(i32 %11)
  store %struct.tpool* %12, %struct.tpool** %9, align 8
  %13 = load %struct.tpool*, %struct.tpool** %9, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 8
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  store i32 %15, i32* %17, align 8
  %18 = load i32, i32* %8, align 4
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  store i32 %18, i32* %20, align 4
  %21 = load %struct.tpool*, %struct.tpool** %9, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 4
  store %struct.tpool* %21, %struct.tpool** %23, align 8
  %24 = load %struct.tpool*, %struct.tpool** %9, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 2
  %26 = load i32, i32* %25, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  store i32 %26, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 5
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 0
  store i32 1, i32* %31, align 8
  %32 = load %struct.tpool*, %struct.tpool** %9, align 8
  %33 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %32, i32 %33)
  store i32 0, i32* %10, align 4
  br label %34

34:                                               ; preds = %53, %4
  %35 = load i32, i32* %10, align 4
  %36 = load i32, i32* %8, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %56

38:                                               ; preds = %34
  %39 = load %struct.tnode*, %struct.tnode** %6, align 8
  %40 = load i32, i32* %10, align 4
  %41 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 %40, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_i32_literal, i64 0, i64 0), i32 592)
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  store i32 1, i32* %42, align 8
  %43 = load i32*, i32** %7, align 8
  %44 = load i32, i32* %10, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds i32, i32* %43, i64 %45
  %47 = load i32, i32* %46, align 4
  %48 = load %struct.tnode*, %struct.tnode** %6, align 8
  %49 = load i32, i32* %10, align 4
  %50 = call %struct.tdata* @get_node(%struct.tnode* %48, i32 %49, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_i32_literal, i64 0, i64 0), i32 593)
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 1
  %52 = bitcast %union.data_type* %51 to i32*
  store i32 %47, i32* %52, align 8
  br label %53

53:                                               ; preds = %38
  %54 = load i32, i32* %10, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* %10, align 4
  br label %34

56:                                               ; preds = %34
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_double_literal(i32, %struct.tnode*, double*, i32) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca double*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tpool*, align 8
  %10 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store double* %2, double** %7, align 8
  store i32 %3, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = call %struct.tpool* @get_pool_ptr(i32 %11)
  store %struct.tpool* %12, %struct.tpool** %9, align 8
  %13 = load %struct.tpool*, %struct.tpool** %9, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 8
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  store i32 %15, i32* %17, align 8
  %18 = load i32, i32* %8, align 4
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  store i32 %18, i32* %20, align 4
  %21 = load %struct.tpool*, %struct.tpool** %9, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 4
  store %struct.tpool* %21, %struct.tpool** %23, align 8
  %24 = load %struct.tpool*, %struct.tpool** %9, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 2
  %26 = load i32, i32* %25, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  store i32 %26, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 5
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 0
  store i32 1, i32* %31, align 8
  %32 = load %struct.tpool*, %struct.tpool** %9, align 8
  %33 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %32, i32 %33)
  store i32 0, i32* %10, align 4
  br label %34

34:                                               ; preds = %53, %4
  %35 = load i32, i32* %10, align 4
  %36 = load i32, i32* %8, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %56

38:                                               ; preds = %34
  %39 = load %struct.tnode*, %struct.tnode** %6, align 8
  %40 = load i32, i32* %10, align 4
  %41 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 %40, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @__FUNCTION__.funk_create_list_double_literal, i64 0, i64 0), i32 613)
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  store i32 2, i32* %42, align 8
  %43 = load double*, double** %7, align 8
  %44 = load i32, i32* %10, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds double, double* %43, i64 %45
  %47 = load double, double* %46, align 8
  %48 = load %struct.tnode*, %struct.tnode** %6, align 8
  %49 = load i32, i32* %10, align 4
  %50 = call %struct.tdata* @get_node(%struct.tnode* %48, i32 %49, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @__FUNCTION__.funk_create_list_double_literal, i64 0, i64 0), i32 614)
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 1
  %52 = bitcast %union.data_type* %51 to double*
  store double %47, double* %52, align 8
  br label %53

53:                                               ; preds = %38
  %54 = load i32, i32* %10, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* %10, align 4
  br label %34

56:                                               ; preds = %34
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
  %11 = load i32, i32* %6, align 4
  %12 = load %struct.tnode*, %struct.tnode** %7, align 8
  %13 = load i32*, i32** %8, align 8
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %10, align 4
  %16 = mul nsw i32 %14, %15
  call void @funk_create_list_i32_literal(i32 %11, %struct.tnode* %12, i32* %13, i32 %16)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 2, i32* %19, align 8
  %20 = load i32, i32* %9, align 4
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 5
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 1
  %24 = getelementptr inbounds [2 x i32], [2 x i32]* %23, i64 0, i64 0
  store i32 %20, i32* %24, align 4
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 5
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 1
  store i32 %25, i32* %29, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_scalar_element(i32, i64) #0 {
  %3 = alloca %struct.tdata, align 8
  %4 = bitcast %struct.tdata* %3 to { i32, i64 }*
  %5 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %4, i32 0, i32 0
  store i32 %0, i32* %5, align 8
  %6 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %4, i32 0, i32 1
  store i64 %1, i64* %6, align 8
  %7 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  switch i32 %8, label %21 [
    i32 1, label %9
    i32 2, label %14
    i32 4, label %19
  ]

9:                                                ; preds = %2
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.21, i64 0, i64 0), i32 %12)
  br label %23

14:                                               ; preds = %2
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %16 = bitcast %union.data_type* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.22, i64 0, i64 0), double %17)
  br label %23

19:                                               ; preds = %2
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.24, i64 0, i64 0))
  br label %23

21:                                               ; preds = %2
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11, %3
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 657)
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load i32, i32* %6, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %5, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 668)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  store i32 %19, i32* %23, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_increment_node_data_int(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = call %struct.tdata* @get_node(%struct.tnode* %3, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_increment_node_data_int, i64 0, i64 0), i32 673)
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 1
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_copy_node_into_node_list, i64 0, i64 0), i32 679)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 1
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 690)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 1, i32* %22, align 8
  %23 = load i32, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 691)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 700)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 6, i32* %22, align 8
  %23 = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_fn_ptr, i64 0, i64 0), i32 701)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
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
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 710)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i32 2, i32* %22, align 8
  %23 = load double, double* %6, align 8
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_set_node_value_double, i64 0, i64 0), i32 711)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
  br label %16

16:                                               ; preds = %10, %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = load i32, i32* %4, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 719)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 1
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
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.27, i64 0, i64 0), i32 %10)
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
  %25 = bitcast %struct.tdata* %24 to { i32, i64 }*
  %26 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %25, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  call void @funk_print_scalar_element(i32 %27, i64 %29)
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
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i64 0, i64 0))
  br label %39

39:                                               ; preds = %37, %32, %19
  br label %40

40:                                               ; preds = %39
  %41 = load i32, i32* %7, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %7, align 4
  br label %13

43:                                               ; preds = %13
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i64 0, i64 0))
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
define void @funk_debug_function_entry_hook(i8*, i32) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
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
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 4
  %21 = load %struct.tpool*, %struct.tpool** %20, align 8
  %22 = icmp eq %struct.tpool* %21, @funk_global_memory_pool
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = load i32, i32* %10, align 4
  %29 = add i32 %27, %28
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.29, i64 0, i64 0), i8* %24, i32 %29)
  %31 = load %struct.tnode*, %struct.tnode** %9, align 8
  %32 = load i32, i32* %10, align 4
  %33 = call %struct.tdata* @get_node(%struct.tnode* %31, i32 %32, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 822)
  %34 = bitcast %struct.tdata* %33 to { i32, i64 }*
  %35 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  %37 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %34, i32 0, i32 1
  %38 = load i64, i64* %37, align 8
  call void @funk_print_scalar_element(i32 %36, i64 %38)
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.30, i64 0, i64 0))
  %40 = load %struct.tnode*, %struct.tnode** %11, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 4
  %42 = load %struct.tpool*, %struct.tpool** %41, align 8
  %43 = icmp eq %struct.tpool* %42, @funk_global_memory_pool
  %44 = zext i1 %43 to i64
  %45 = select i1 %43, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %46 = load %struct.tnode*, %struct.tnode** %11, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = load i32, i32* %12, align 4
  %50 = add i32 %48, %49
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.29, i64 0, i64 0), i8* %45, i32 %50)
  %52 = load %struct.tnode*, %struct.tnode** %11, align 8
  %53 = load i32, i32* %12, align 4
  %54 = call %struct.tdata* @get_node(%struct.tnode* %52, i32 %53, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 825)
  %55 = bitcast %struct.tdata* %54 to { i32, i64 }*
  %56 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %55, i32 0, i32 1
  %59 = load i64, i64* %58, align 8
  call void @funk_print_scalar_element(i32 %57, i64 %59)
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 4
  %62 = load %struct.tpool*, %struct.tpool** %61, align 8
  %63 = icmp eq %struct.tpool* %62, @funk_global_memory_pool
  %64 = zext i1 %63 to i64
  %65 = select i1 %63, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0)
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 0
  %68 = load i32, i32* %67, align 8
  %69 = load i32, i32* %8, align 4
  %70 = add i32 %68, %69
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.31, i64 0, i64 0), i8* %65, i32 %70)
  %72 = load %struct.tnode*, %struct.tnode** %7, align 8
  %73 = load i32, i32* %8, align 4
  %74 = call %struct.tdata* @get_node(%struct.tnode* %72, i32 %73, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.debug_print_arith_operation, i64 0, i64 0), i32 828)
  %75 = bitcast %struct.tdata* %74 to { i32, i64 }*
  %76 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %75, i32 0, i32 0
  %77 = load i32, i32* %76, align 8
  %78 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %75, i32 0, i32 1
  %79 = load i64, i64* %78, align 8
  call void @funk_print_scalar_element(i32 %77, i64 %79)
  %80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.32, i64 0, i64 0))
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
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.33, i64 0, i64 0), i32 %32, i32 %35)
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
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.33, i64 0, i64 0), i32 %44, i32 %47)
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
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.33, i64 0, i64 0), i32 %56, i32 %59)
  br label %61

61:                                               ; preds = %55, %49
  %62 = load %struct.tnode*, %struct.tnode** %10, align 8
  %63 = load i32, i32* %11, align 4
  %64 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 %63, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 995)
  %65 = bitcast %struct.tdata* %15 to i8*
  %66 = bitcast %struct.tdata* %64 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %65, i8* align 8 %66, i64 16, i1 false)
  %67 = load %struct.tnode*, %struct.tnode** %12, align 8
  %68 = load i32, i32* %13, align 4
  %69 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 %68, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 996)
  %70 = bitcast %struct.tdata* %16 to i8*
  %71 = bitcast %struct.tdata* %69 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %70, i8* align 8 %71, i64 16, i1 false)
  %72 = load %struct.tnode*, %struct.tnode** %8, align 8
  %73 = load i32, i32* %9, align 4
  %74 = call %struct.tdata* @get_node(%struct.tnode* %72, i32 %73, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0), i32 997)
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
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 1
  %102 = bitcast %union.data_type* %101 to i32*
  %103 = bitcast i32* %102 to i8*
  %104 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %105 = bitcast %union.data_type* %104 to i32*
  %106 = bitcast i32* %105 to i8*
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
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
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to double*
  %125 = bitcast double* %124 to i8*
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %127 = bitcast %union.data_type* %126 to double*
  %128 = bitcast double* %127 to i8*
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
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
  %145 = getelementptr inbounds %struct.tdata, %struct.tdata* %144, i32 0, i32 1
  %146 = bitcast %union.data_type* %145 to double*
  %147 = bitcast double* %146 to i8*
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %149 = bitcast %union.data_type* %148 to double*
  %150 = bitcast double* %149 to i8*
  %151 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
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
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %166, i32 0, i32 1
  %168 = bitcast %union.data_type* %167 to double*
  %169 = bitcast double* %168 to i8*
  %170 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %171 = bitcast %union.data_type* %170 to i32*
  %172 = bitcast i32* %171 to i8*
  %173 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %174 = bitcast %union.data_type* %173 to double*
  %175 = bitcast double* %174 to i8*
  call void %165(i8* %169, i8* %172, i8* %175, i32 2)
  %176 = load %struct.tdata*, %struct.tdata** %17, align 8
  %177 = getelementptr inbounds %struct.tdata, %struct.tdata* %176, i32 0, i32 0
  store i32 2, i32* %177, align 8
  br label %251

178:                                              ; preds = %160, %156
  %179 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.34, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__FUNCTION__._funk_arith_op_rr, i64 0, i64 0))
  %180 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %181 = icmp eq void (i8*, i8*, i8*, i32)* %180, @funk_mul
  br i1 %181, label %182, label %184

182:                                              ; preds = %178
  %183 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.35, i64 0, i64 0))
  br label %244

184:                                              ; preds = %178
  %185 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %186 = icmp eq void (i8*, i8*, i8*, i32)* %185, @funk_div
  br i1 %186, label %187, label %189

187:                                              ; preds = %184
  %188 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.36, i64 0, i64 0))
  br label %243

189:                                              ; preds = %184
  %190 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %191 = icmp eq void (i8*, i8*, i8*, i32)* %190, @funk_add
  br i1 %191, label %192, label %194

192:                                              ; preds = %189
  %193 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.37, i64 0, i64 0))
  br label %242

194:                                              ; preds = %189
  %195 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %196 = icmp eq void (i8*, i8*, i8*, i32)* %195, @funk_sub
  br i1 %196, label %197, label %199

197:                                              ; preds = %194
  %198 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.38, i64 0, i64 0))
  br label %241

199:                                              ; preds = %194
  %200 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %201 = icmp eq void (i8*, i8*, i8*, i32)* %200, @funk_mod
  br i1 %201, label %202, label %204

202:                                              ; preds = %199
  %203 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.39, i64 0, i64 0))
  br label %240

204:                                              ; preds = %199
  %205 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %206 = icmp eq void (i8*, i8*, i8*, i32)* %205, @funk_slt
  br i1 %206, label %207, label %209

207:                                              ; preds = %204
  %208 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.40, i64 0, i64 0))
  br label %239

209:                                              ; preds = %204
  %210 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %211 = icmp eq void (i8*, i8*, i8*, i32)* %210, @funk_sgt
  br i1 %211, label %212, label %214

212:                                              ; preds = %209
  %213 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.41, i64 0, i64 0))
  br label %238

214:                                              ; preds = %209
  %215 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %216 = icmp eq void (i8*, i8*, i8*, i32)* %215, @funk_sge
  br i1 %216, label %217, label %219

217:                                              ; preds = %214
  %218 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.42, i64 0, i64 0))
  br label %237

219:                                              ; preds = %214
  %220 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %221 = icmp eq void (i8*, i8*, i8*, i32)* %220, @funk_eq
  br i1 %221, label %222, label %224

222:                                              ; preds = %219
  %223 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.43, i64 0, i64 0))
  br label %236

224:                                              ; preds = %219
  %225 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %226 = icmp eq void (i8*, i8*, i8*, i32)* %225, @funk_ne
  br i1 %226, label %227, label %229

227:                                              ; preds = %224
  %228 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.43, i64 0, i64 0))
  br label %235

229:                                              ; preds = %224
  %230 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %231 = icmp eq void (i8*, i8*, i8*, i32)* %230, @funk_or
  br i1 %231, label %232, label %234

232:                                              ; preds = %229
  %233 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.44, i64 0, i64 0))
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
  %246 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.30, i64 0, i64 0))
  %247 = load i8, i8* %19, align 1
  call void @funk_print_type(i8 zeroext %247)
  %248 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i64 0, i64 0))
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
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 5
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %32

31:                                               ; preds = %7
  br label %37

32:                                               ; preds = %7
  %33 = load %struct.tnode*, %struct.tnode** %10, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 5
  %35 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  br label %37

37:                                               ; preds = %32, %31
  %38 = phi i32 [ 1, %31 ], [ %36, %32 ]
  store i32 %38, i32* %16, align 4
  %39 = load %struct.tnode*, %struct.tnode** %12, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 5
  %41 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %45

44:                                               ; preds = %37
  br label %50

45:                                               ; preds = %37
  %46 = load %struct.tnode*, %struct.tnode** %12, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 5
  %48 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  br label %50

50:                                               ; preds = %45, %44
  %51 = phi i32 [ 1, %44 ], [ %49, %45 ]
  store i32 %51, i32* %17, align 4
  %52 = load i32, i32* %16, align 4
  %53 = load i32, i32* %17, align 4
  %54 = icmp ne i32 %52, %53
  br i1 %54, label %55, label %61

55:                                               ; preds = %50
  %56 = load i32, i32* %16, align 4
  %57 = load i32, i32* %17, align 4
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([101 x i8], [101 x i8]* @.str.45, i64 0, i64 0), i32 %56, i32 %57)
  %59 = load %struct.tnode*, %struct.tnode** %10, align 8
  call void @funk_print_node_info(%struct.tnode* %59)
  %60 = load %struct.tnode*, %struct.tnode** %12, align 8
  call void @funk_print_node_info(%struct.tnode* %60)
  call void @exit(i32 1) #6
  unreachable

61:                                               ; preds = %50
  %62 = load i32, i32* %16, align 4
  store i32 %62, i32* %18, align 4
  %63 = load i32, i32* %18, align 4
  %64 = icmp sgt i32 %63, 1
  br i1 %64, label %65, label %107

65:                                               ; preds = %61
  store i32 0, i32* %19, align 4
  br label %66

66:                                               ; preds = %103, %65
  %67 = load i32, i32* %19, align 4
  %68 = load i32, i32* %18, align 4
  %69 = icmp slt i32 %67, %68
  br i1 %69, label %70, label %106

70:                                               ; preds = %66
  %71 = load %struct.tnode*, %struct.tnode** %10, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 5
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 1
  %74 = load i32, i32* %19, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds [2 x i32], [2 x i32]* %73, i64 0, i64 %75
  %77 = load i32, i32* %76, align 4
  %78 = load %struct.tnode*, %struct.tnode** %12, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 5
  %80 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %79, i32 0, i32 1
  %81 = load i32, i32* %19, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [2 x i32], [2 x i32]* %80, i64 0, i64 %82
  %84 = load i32, i32* %83, align 4
  %85 = icmp ne i32 %77, %84
  br i1 %85, label %86, label %102

86:                                               ; preds = %70
  %87 = load %struct.tnode*, %struct.tnode** %10, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 5
  %89 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %88, i32 0, i32 1
  %90 = load i32, i32* %19, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds [2 x i32], [2 x i32]* %89, i64 0, i64 %91
  %93 = load i32, i32* %92, align 4
  %94 = load %struct.tnode*, %struct.tnode** %12, align 8
  %95 = getelementptr inbounds %struct.tnode, %struct.tnode* %94, i32 0, i32 5
  %96 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %95, i32 0, i32 1
  %97 = load i32, i32* %19, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [2 x i32], [2 x i32]* %96, i64 0, i64 %98
  %100 = load i32, i32* %99, align 4
  %101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.46, i64 0, i64 0), i32 %93, i32 %100)
  br label %102

102:                                              ; preds = %86, %70
  br label %103

103:                                              ; preds = %102
  %104 = load i32, i32* %19, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, i32* %19, align 4
  br label %66

106:                                              ; preds = %66
  br label %107

107:                                              ; preds = %106, %61
  %108 = load i32, i32* %18, align 4
  %109 = icmp eq i32 %108, 1
  br i1 %109, label %110, label %133

110:                                              ; preds = %107
  %111 = load %struct.tnode*, %struct.tnode** %8, align 8
  %112 = load %struct.tnode*, %struct.tnode** %10, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 1
  %114 = load i32, i32* %113, align 4
  call void @funk_create_node(%struct.tnode* %111, i32 %114, i32 1, i32 1, i8 zeroext 0, i8* null)
  store i32 0, i32* %20, align 4
  br label %115

115:                                              ; preds = %129, %110
  %116 = load i32, i32* %20, align 4
  %117 = load %struct.tnode*, %struct.tnode** %10, align 8
  %118 = getelementptr inbounds %struct.tnode, %struct.tnode* %117, i32 0, i32 1
  %119 = load i32, i32* %118, align 4
  %120 = icmp ult i32 %116, %119
  br i1 %120, label %121, label %132

121:                                              ; preds = %115
  %122 = load %struct.tnode*, %struct.tnode** %8, align 8
  %123 = load i32, i32* %20, align 4
  %124 = load %struct.tnode*, %struct.tnode** %10, align 8
  %125 = load i32, i32* %20, align 4
  %126 = load %struct.tnode*, %struct.tnode** %12, align 8
  %127 = load i32, i32* %20, align 4
  %128 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %122, i32 %123, %struct.tnode* %124, i32 %125, %struct.tnode* %126, i32 %127, void (i8*, i8*, i8*, i32)* %128)
  br label %129

129:                                              ; preds = %121
  %130 = load i32, i32* %20, align 4
  %131 = add i32 %130, 1
  store i32 %131, i32* %20, align 4
  br label %115

132:                                              ; preds = %115
  br label %210

133:                                              ; preds = %107
  %134 = load i32, i32* %18, align 4
  %135 = icmp eq i32 %134, 2
  br i1 %135, label %136, label %206

136:                                              ; preds = %133
  %137 = load %struct.tnode*, %struct.tnode** %10, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 5
  %139 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %138, i32 0, i32 1
  %140 = getelementptr inbounds [2 x i32], [2 x i32]* %139, i64 0, i64 0
  %141 = load i32, i32* %140, align 4
  %142 = load %struct.tnode*, %struct.tnode** %10, align 8
  %143 = getelementptr inbounds %struct.tnode, %struct.tnode* %142, i32 0, i32 5
  %144 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %143, i32 0, i32 1
  %145 = getelementptr inbounds [2 x i32], [2 x i32]* %144, i64 0, i64 1
  %146 = load i32, i32* %145, align 4
  %147 = mul i32 %141, %146
  store i32 %147, i32* %21, align 4
  %148 = load %struct.tnode*, %struct.tnode** %8, align 8
  %149 = load i32, i32* %21, align 4
  %150 = load i32, i32* %18, align 4
  %151 = trunc i32 %150 to i8
  call void @funk_create_node(%struct.tnode* %148, i32 %149, i32 1, i32 1, i8 zeroext %151, i8* null)
  %152 = load %struct.tnode*, %struct.tnode** %8, align 8
  %153 = load %struct.tnode*, %struct.tnode** %10, align 8
  %154 = getelementptr inbounds %struct.tnode, %struct.tnode* %153, i32 0, i32 5
  %155 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %154, i32 0, i32 1
  %156 = getelementptr inbounds [2 x i32], [2 x i32]* %155, i64 0, i64 0
  %157 = load i32, i32* %156, align 4
  call void @set_dimension(%struct.tnode* %152, i32 0, i32 %157)
  %158 = load %struct.tnode*, %struct.tnode** %8, align 8
  %159 = load %struct.tnode*, %struct.tnode** %10, align 8
  %160 = getelementptr inbounds %struct.tnode, %struct.tnode* %159, i32 0, i32 5
  %161 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %160, i32 0, i32 1
  %162 = getelementptr inbounds [2 x i32], [2 x i32]* %161, i64 0, i64 1
  %163 = load i32, i32* %162, align 4
  call void @set_dimension(%struct.tnode* %158, i32 1, i32 %163)
  store i32 0, i32* %22, align 4
  br label %164

164:                                              ; preds = %202, %136
  %165 = load i32, i32* %22, align 4
  %166 = load %struct.tnode*, %struct.tnode** %8, align 8
  %167 = getelementptr inbounds %struct.tnode, %struct.tnode* %166, i32 0, i32 5
  %168 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %167, i32 0, i32 1
  %169 = getelementptr inbounds [2 x i32], [2 x i32]* %168, i64 0, i64 0
  %170 = load i32, i32* %169, align 4
  %171 = icmp ult i32 %165, %170
  br i1 %171, label %172, label %205

172:                                              ; preds = %164
  store i32 0, i32* %23, align 4
  br label %173

173:                                              ; preds = %198, %172
  %174 = load i32, i32* %23, align 4
  %175 = load %struct.tnode*, %struct.tnode** %8, align 8
  %176 = getelementptr inbounds %struct.tnode, %struct.tnode* %175, i32 0, i32 5
  %177 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %176, i32 0, i32 1
  %178 = getelementptr inbounds [2 x i32], [2 x i32]* %177, i64 0, i64 1
  %179 = load i32, i32* %178, align 4
  %180 = icmp ult i32 %174, %179
  br i1 %180, label %181, label %201

181:                                              ; preds = %173
  %182 = load i32, i32* %22, align 4
  %183 = load %struct.tnode*, %struct.tnode** %8, align 8
  %184 = getelementptr inbounds %struct.tnode, %struct.tnode* %183, i32 0, i32 5
  %185 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %184, i32 0, i32 1
  %186 = getelementptr inbounds [2 x i32], [2 x i32]* %185, i64 0, i64 1
  %187 = load i32, i32* %186, align 4
  %188 = mul i32 %182, %187
  %189 = load i32, i32* %23, align 4
  %190 = add i32 %188, %189
  store i32 %190, i32* %24, align 4
  %191 = load %struct.tnode*, %struct.tnode** %8, align 8
  %192 = load i32, i32* %24, align 4
  %193 = load %struct.tnode*, %struct.tnode** %10, align 8
  %194 = load i32, i32* %24, align 4
  %195 = load %struct.tnode*, %struct.tnode** %12, align 8
  %196 = load i32, i32* %24, align 4
  %197 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  call void @_funk_arith_op_rr(%struct.tnode* %191, i32 %192, %struct.tnode* %193, i32 %194, %struct.tnode* %195, i32 %196, void (i8*, i8*, i8*, i32)* %197)
  br label %198

198:                                              ; preds = %181
  %199 = load i32, i32* %23, align 4
  %200 = add i32 %199, 1
  store i32 %200, i32* %23, align 4
  br label %173

201:                                              ; preds = %173
  br label %202

202:                                              ; preds = %201
  %203 = load i32, i32* %22, align 4
  %204 = add i32 %203, 1
  store i32 %204, i32* %22, align 4
  br label %164

205:                                              ; preds = %164
  br label %209

206:                                              ; preds = %133
  %207 = load i32, i32* %18, align 4
  %208 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.47, i64 0, i64 0), i32 %207)
  call void @exit(i32 1) #6
  unreachable

209:                                              ; preds = %205
  br label %210

210:                                              ; preds = %209, %132
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
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.48, i64 0, i64 0))
  store i32 0, i32* %3, align 4
  br label %5

5:                                                ; preds = %21, %1
  %6 = load i32, i32* %3, align 4
  %7 = load %struct.tnode*, %struct.tnode** %2, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 5
  %9 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = icmp ult i32 %6, %10
  br i1 %11, label %12, label %24

12:                                               ; preds = %5
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 5
  %15 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %14, i32 0, i32 1
  %16 = load i32, i32* %3, align 4
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds [2 x i32], [2 x i32]* %15, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.49, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

24:                                               ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.50, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 5
  %8 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %19

11:                                               ; preds = %1
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.print_scalar, i64 0, i64 0), i32 1445)
  %14 = bitcast %struct.tdata* %13 to { i32, i64 }*
  %15 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %14, i32 0, i32 1
  %18 = load i64, i64* %17, align 8
  call void @funk_print_scalar_element(i32 %16, i64 %18)
  br label %118

19:                                               ; preds = %1
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 5
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %45

25:                                               ; preds = %19
  store i32 0, i32* %3, align 4
  br label %26

26:                                               ; preds = %41, %25
  %27 = load i32, i32* %3, align 4
  %28 = load %struct.tnode*, %struct.tnode** %2, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp ult i32 %27, %30
  br i1 %31, label %32, label %44

32:                                               ; preds = %26
  %33 = load %struct.tnode*, %struct.tnode** %2, align 8
  %34 = load i32, i32* %3, align 4
  %35 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 %34, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.print_scalar, i64 0, i64 0), i32 1451)
  %36 = bitcast %struct.tdata* %35 to { i32, i64 }*
  %37 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %36, i32 0, i32 1
  %40 = load i64, i64* %39, align 8
  call void @funk_print_scalar_element(i32 %38, i64 %40)
  br label %41

41:                                               ; preds = %32
  %42 = load i32, i32* %3, align 4
  %43 = add i32 %42, 1
  store i32 %43, i32* %3, align 4
  br label %26

44:                                               ; preds = %26
  br label %117

45:                                               ; preds = %19
  %46 = load %struct.tnode*, %struct.tnode** %2, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 5
  %48 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %107

51:                                               ; preds = %45
  %52 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %52)
  %53 = load %struct.tnode*, %struct.tnode** %2, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 5
  %55 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %54, i32 0, i32 1
  %56 = getelementptr inbounds [2 x i32], [2 x i32]* %55, i64 0, i64 0
  %57 = load i32, i32* %56, align 4
  %58 = load %struct.tnode*, %struct.tnode** %2, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 5
  %60 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %59, i32 0, i32 1
  %61 = getelementptr inbounds [2 x i32], [2 x i32]* %60, i64 0, i64 1
  %62 = load i32, i32* %61, align 4
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.51, i64 0, i64 0), i32 %57, i32 %62)
  store i32 0, i32* %4, align 4
  br label %64

64:                                               ; preds = %103, %51
  %65 = load i32, i32* %4, align 4
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 5
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 1
  %69 = getelementptr inbounds [2 x i32], [2 x i32]* %68, i64 0, i64 1
  %70 = load i32, i32* %69, align 4
  %71 = icmp ult i32 %65, %70
  br i1 %71, label %72, label %106

72:                                               ; preds = %64
  store i32 0, i32* %5, align 4
  br label %73

73:                                               ; preds = %98, %72
  %74 = load i32, i32* %5, align 4
  %75 = load %struct.tnode*, %struct.tnode** %2, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 5
  %77 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %76, i32 0, i32 1
  %78 = getelementptr inbounds [2 x i32], [2 x i32]* %77, i64 0, i64 0
  %79 = load i32, i32* %78, align 4
  %80 = icmp ult i32 %74, %79
  br i1 %80, label %81, label %101

81:                                               ; preds = %73
  %82 = load %struct.tnode*, %struct.tnode** %2, align 8
  %83 = load i32, i32* %4, align 4
  %84 = load %struct.tnode*, %struct.tnode** %2, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 5
  %86 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %85, i32 0, i32 1
  %87 = getelementptr inbounds [2 x i32], [2 x i32]* %86, i64 0, i64 0
  %88 = load i32, i32* %87, align 4
  %89 = mul i32 %83, %88
  %90 = load i32, i32* %5, align 4
  %91 = add i32 %89, %90
  %92 = call %struct.tdata* @get_node(%struct.tnode* %82, i32 %91, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.print_scalar, i64 0, i64 0), i32 1462)
  %93 = bitcast %struct.tdata* %92 to { i32, i64 }*
  %94 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %93, i32 0, i32 0
  %95 = load i32, i32* %94, align 8
  %96 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %93, i32 0, i32 1
  %97 = load i64, i64* %96, align 8
  call void @funk_print_scalar_element(i32 %95, i64 %97)
  br label %98

98:                                               ; preds = %81
  %99 = load i32, i32* %5, align 4
  %100 = add i32 %99, 1
  store i32 %100, i32* %5, align 4
  br label %73

101:                                              ; preds = %73
  %102 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i64 0, i64 0))
  br label %103

103:                                              ; preds = %101
  %104 = load i32, i32* %4, align 4
  %105 = add i32 %104, 1
  store i32 %105, i32* %4, align 4
  br label %64

106:                                              ; preds = %64
  br label %116

107:                                              ; preds = %45
  %108 = load %struct.tnode*, %struct.tnode** %2, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 5
  %110 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %109, i32 0, i32 0
  %111 = load i32, i32* %110, align 8
  %112 = load %struct.tnode*, %struct.tnode** %2, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 1
  %114 = load i32, i32* %113, align 4
  %115 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.52, i64 0, i64 0), i32 %111, i32 %114)
  br label %116

116:                                              ; preds = %107, %106
  br label %117

117:                                              ; preds = %116, %44
  br label %118

118:                                              ; preds = %117, %11
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
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 5
  %12 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = icmp ne i32 %13, 2
  br i1 %14, label %15, label %21

15:                                               ; preds = %3
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 5
  %18 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.53, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %15, %3
  %22 = load %struct.tnode*, %struct.tnode** %5, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1478)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %7, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = call %struct.tdata* @get_node(%struct.tnode* %27, i32 0, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1479)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  store i32 %31, i32* %8, align 4
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = load %struct.tnode*, %struct.tnode** %4, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 5
  %35 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %34, i32 0, i32 1
  %36 = getelementptr inbounds [2 x i32], [2 x i32]* %35, i64 0, i64 0
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* %7, align 4
  %39 = mul i32 %37, %38
  %40 = load i32, i32* %8, align 4
  %41 = add i32 %39, %40
  %42 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 %41, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 1481)
  %43 = bitcast %struct.tdata* %42 to { i32, i64 }*
  %44 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %43, i32 0, i32 1
  %47 = load i64, i64* %46, align 8
  call void @funk_print_scalar_element(i32 %45, i64 %47)
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
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 5
  %10 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %9, i32 0, i32 1
  %11 = getelementptr inbounds [2 x i32], [2 x i32]* %10, i64 0, i64 0
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* %5, align 4
  %14 = mul i32 %12, %13
  %15 = load i32, i32* %6, align 4
  %16 = add i32 %14, %15
  %17 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 %16, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_int_int, i64 0, i64 0), i32 1486)
  %18 = bitcast %struct.tdata* %17 to { i32, i64 }*
  %19 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = getelementptr inbounds { i32, i64 }, { i32, i64 }* %18, i32 0, i32 1
  %22 = load i64, i64* %21, align 8
  call void @funk_print_scalar_element(i32 %20, i64 %22)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1491)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %16

9:                                                ; preds = %1
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1492)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = sitofp i32 %14 to float
  store float %15, float* %2, align 4
  br label %34

16:                                               ; preds = %1
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1493)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %29

22:                                               ; preds = %16
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1494)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to double*
  %27 = load double, double* %26, align 8
  %28 = fptrunc double %27 to float
  store float %28, float* %2, align 4
  br label %34

29:                                               ; preds = %16
  %30 = load %struct.tnode*, %struct.tnode** %3, align 8
  %31 = call %struct.tdata* @get_node(%struct.tnode* %30, i32 0, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0), i32 1496)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i32 0, i32* %32, align 8
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.54, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
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
  %14 = call %struct.__sFILE* @"\01_fopen"(i8* %13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.55, i64 0, i64 0))
  store %struct.__sFILE* %14, %struct.__sFILE** %8, align 8
  %15 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8
  %16 = icmp eq %struct.__sFILE* %15, null
  br i1 %16, label %17, label %20

17:                                               ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.56, i64 0, i64 0), i8* %18)
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
  %25 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %24, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.57, i64 0, i64 0), i32* %9)
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %45

27:                                               ; preds = %23
  %28 = load i32, i32* %9, align 4
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load %struct.tpool*, %struct.tpool** %7, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %32, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1525)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to i32*
  store i32 %28, i32* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = load %struct.tpool*, %struct.tpool** %7, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 8
  %40 = call %struct.tdata* @get_node(%struct.tnode* %36, i32 %39, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_read_list_from_file, i64 0, i64 0), i32 1526)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  store i32 1, i32* %41, align 8
  %42 = load %struct.tpool*, %struct.tpool** %7, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %42, i32 1)
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
define void @reshape(%struct.tnode*, i32*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @__FUNCTION__.reshape, i64 0, i64 0), i32 1540)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp eq i32 %12, 4
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %69

15:                                               ; preds = %3
  %16 = load i32, i32* %6, align 4
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 %16, i32* %19, align 8
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %20

20:                                               ; preds = %50, %15
  %21 = load i32, i32* %8, align 4
  %22 = load i32, i32* %6, align 4
  %23 = icmp ult i32 %21, %22
  br i1 %23, label %24, label %27

24:                                               ; preds = %20
  %25 = load i32, i32* %8, align 4
  %26 = icmp ult i32 %25, 2
  br label %27

27:                                               ; preds = %24, %20
  %28 = phi i1 [ false, %20 ], [ %26, %24 ]
  br i1 %28, label %29, label %53

29:                                               ; preds = %27
  %30 = load i32*, i32** %5, align 8
  %31 = load i32, i32* %8, align 4
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds i32, i32* %30, i64 %32
  %34 = load i32, i32* %33, align 4
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 5
  %37 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %36, i32 0, i32 1
  %38 = load i32, i32* %8, align 4
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [2 x i32], [2 x i32]* %37, i64 0, i64 %39
  store i32 %34, i32* %40, align 4
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 5
  %43 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %42, i32 0, i32 1
  %44 = load i32, i32* %8, align 4
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [2 x i32], [2 x i32]* %43, i64 0, i64 %45
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* %7, align 4
  %49 = mul i32 %48, %47
  store i32 %49, i32* %7, align 4
  br label %50

50:                                               ; preds = %29
  %51 = load i32, i32* %8, align 4
  %52 = add i32 %51, 1
  store i32 %52, i32* %8, align 4
  br label %20

53:                                               ; preds = %27
  %54 = load %struct.tnode*, %struct.tnode** %4, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = load i32, i32* %55, align 4
  %57 = icmp ugt i32 %56, 0
  br i1 %57, label %58, label %69

58:                                               ; preds = %53
  %59 = load i32, i32* %7, align 4
  %60 = load %struct.tnode*, %struct.tnode** %4, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 1
  %62 = load i32, i32* %61, align 4
  %63 = icmp ugt i32 %59, %62
  br i1 %63, label %64, label %69

64:                                               ; preds = %58
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = load i32, i32* %66, align 4
  %68 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.58, i64 0, i64 0), i32 %67)
  call void @exit(i32 1) #6
  unreachable

69:                                               ; preds = %14, %58, %53
  ret void
}

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
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.59, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %25, i32 %26)
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.60, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 %33, i32 %34)
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

56:                                               ; preds = %133, %36
  %57 = load i32, i32* %17, align 4
  %58 = load i32, i32* %10, align 4
  %59 = icmp sle i32 %57, %58
  br i1 %59, label %60, label %136

60:                                               ; preds = %56
  %61 = load i32, i32* %11, align 4
  store i32 %61, i32* %18, align 4
  br label %62

62:                                               ; preds = %129, %60
  %63 = load i32, i32* %18, align 4
  %64 = load i32, i32* %12, align 4
  %65 = icmp sle i32 %63, %64
  br i1 %65, label %66, label %132

66:                                               ; preds = %62
  %67 = load i32, i32* %17, align 4
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %77

69:                                               ; preds = %66
  %70 = load i32, i32* %17, align 4
  %71 = load %struct.tnode*, %struct.tnode** %7, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 5
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 1
  %74 = getelementptr inbounds [2 x i32], [2 x i32]* %73, i64 0, i64 0
  %75 = load i32, i32* %74, align 4
  %76 = add i32 %70, %75
  br label %79

77:                                               ; preds = %66
  %78 = load i32, i32* %17, align 4
  br label %79

79:                                               ; preds = %77, %69
  %80 = phi i32 [ %76, %69 ], [ %78, %77 ]
  store i32 %80, i32* %19, align 4
  %81 = load i32, i32* %18, align 4
  %82 = icmp slt i32 %81, 0
  br i1 %82, label %83, label %91

83:                                               ; preds = %79
  %84 = load i32, i32* %18, align 4
  %85 = load %struct.tnode*, %struct.tnode** %7, align 8
  %86 = getelementptr inbounds %struct.tnode, %struct.tnode* %85, i32 0, i32 5
  %87 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %86, i32 0, i32 1
  %88 = getelementptr inbounds [2 x i32], [2 x i32]* %87, i64 0, i64 1
  %89 = load i32, i32* %88, align 4
  %90 = add i32 %84, %89
  br label %93

91:                                               ; preds = %79
  %92 = load i32, i32* %18, align 4
  br label %93

93:                                               ; preds = %91, %83
  %94 = phi i32 [ %90, %83 ], [ %92, %91 ]
  store i32 %94, i32* %20, align 4
  %95 = load %struct.tnode*, %struct.tnode** %7, align 8
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 5
  %97 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %96, i32 0, i32 1
  %98 = getelementptr inbounds [2 x i32], [2 x i32]* %97, i64 0, i64 0
  %99 = load i32, i32* %98, align 4
  %100 = load i32, i32* %19, align 4
  %101 = urem i32 %100, %99
  store i32 %101, i32* %19, align 4
  %102 = load %struct.tnode*, %struct.tnode** %7, align 8
  %103 = getelementptr inbounds %struct.tnode, %struct.tnode* %102, i32 0, i32 5
  %104 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %103, i32 0, i32 1
  %105 = getelementptr inbounds [2 x i32], [2 x i32]* %104, i64 0, i64 1
  %106 = load i32, i32* %105, align 4
  %107 = load i32, i32* %20, align 4
  %108 = urem i32 %107, %106
  store i32 %108, i32* %20, align 4
  %109 = load %struct.tnode*, %struct.tnode** %7, align 8
  %110 = load i32, i32* %19, align 4
  %111 = load %struct.tnode*, %struct.tnode** %7, align 8
  %112 = getelementptr inbounds %struct.tnode, %struct.tnode* %111, i32 0, i32 5
  %113 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %112, i32 0, i32 1
  %114 = getelementptr inbounds [2 x i32], [2 x i32]* %113, i64 0, i64 0
  %115 = load i32, i32* %114, align 4
  %116 = mul i32 %110, %115
  %117 = load i32, i32* %20, align 4
  %118 = add i32 %116, %117
  %119 = call %struct.tdata* @get_node(%struct.tnode* %109, i32 %118, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__FUNCTION__.funk_create_sub_matrix_lit_indexes, i64 0, i64 0), i32 1596)
  %120 = getelementptr inbounds %struct.tdata, %struct.tdata* %119, i32 0, i32 1
  %121 = bitcast %union.data_type* %120 to i32*
  %122 = load i32, i32* %121, align 8
  %123 = load i32*, i32** %15, align 8
  %124 = load i32, i32* %16, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds i32, i32* %123, i64 %125
  store i32 %122, i32* %126, align 4
  %127 = load i32, i32* %16, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, i32* %16, align 4
  br label %129

129:                                              ; preds = %93
  %130 = load i32, i32* %18, align 4
  %131 = add nsw i32 %130, 1
  store i32 %131, i32* %18, align 4
  br label %62

132:                                              ; preds = %62
  br label %133

133:                                              ; preds = %132
  %134 = load i32, i32* %17, align 4
  %135 = add nsw i32 %134, 1
  store i32 %135, i32* %17, align 4
  br label %56

136:                                              ; preds = %56
  %137 = load %struct.tnode*, %struct.tnode** %8, align 8
  %138 = load i32*, i32** %15, align 8
  %139 = load i32, i32* %13, align 4
  %140 = load i32, i32* %14, align 4
  call void @funk_create_2d_matrix_int_literal(i32 0, %struct.tnode* %137, i32* %138, i32 %139, i32 %140)
  %141 = load i32*, i32** %15, align 8
  %142 = bitcast i32* %141 to i8*
  call void @free(i8* %142)
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
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp ne i32 %20, 2
  br i1 %21, label %22, label %28

22:                                               ; preds = %6
  %23 = load %struct.tnode*, %struct.tnode** %7, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 5
  %25 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.61, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 %26)
  call void @exit(i32 1) #6
  unreachable

28:                                               ; preds = %6
  %29 = load %struct.tnode*, %struct.tnode** %9, align 8
  %30 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1621)
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 1
  %32 = bitcast %union.data_type* %31 to i32*
  %33 = load i32, i32* %32, align 8
  store i32 %33, i32* %13, align 4
  %34 = load %struct.tnode*, %struct.tnode** %10, align 8
  %35 = call %struct.tdata* @get_node(%struct.tnode* %34, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1622)
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 1
  %37 = bitcast %union.data_type* %36 to i32*
  %38 = load i32, i32* %37, align 8
  store i32 %38, i32* %14, align 4
  %39 = load %struct.tnode*, %struct.tnode** %11, align 8
  %40 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1623)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 1
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
  store i32 %43, i32* %15, align 4
  %44 = load %struct.tnode*, %struct.tnode** %12, align 8
  %45 = call %struct.tdata* @get_node(%struct.tnode* %44, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 1624)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to i32*
  %48 = load i32, i32* %47, align 8
  store i32 %48, i32* %16, align 4
  %49 = load %struct.tnode*, %struct.tnode** %7, align 8
  %50 = load %struct.tnode*, %struct.tnode** %8, align 8
  %51 = load i32, i32* %13, align 4
  %52 = load i32, i32* %14, align 4
  %53 = load i32, i32* %15, align 4
  %54 = load i32, i32* %16, align 4
  call void @funk_create_sub_matrix_lit_indexes(%struct.tnode* %49, %struct.tnode* %50, i32 %51, i32 %52, i32 %53, i32 %54)
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.60, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 %42, i32 %43)
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
  %69 = call %struct.tdata* @get_node(%struct.tnode* %67, i32 %68, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_sub_array_lit_indexes, i64 0, i64 0), i32 1649)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 1
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
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 5
  %13 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %22

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 5
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.62, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 %20)
  call void @exit(i32 1) #6
  unreachable

22:                                               ; preds = %4
  %23 = load %struct.tnode*, %struct.tnode** %7, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1668)
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %9, align 4
  %28 = load %struct.tnode*, %struct.tnode** %8, align 8
  %29 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_sub_array, i64 0, i64 0), i32 1669)
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 1
  %31 = bitcast %union.data_type* %30 to i32*
  %32 = load i32, i32* %31, align 8
  store i32 %32, i32* %10, align 4
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = load i32, i32* %9, align 4
  %36 = load i32, i32* %10, align 4
  call void @funk_create_sub_array_lit_indexes(%struct.tnode* %33, %struct.tnode* %34, i32 %35, i32 %36)
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
  %8 = load i32, i32* %6, align 4
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 5
  %11 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %10, i32 0, i32 0
  store i32 %8, i32* %11, align 8
  %12 = load i32*, i32** %5, align 8
  %13 = icmp eq i32* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %40

15:                                               ; preds = %3
  store i32 0, i32* %7, align 4
  br label %16

16:                                               ; preds = %37, %15
  %17 = load i32, i32* %7, align 4
  %18 = load i32, i32* %6, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %23

20:                                               ; preds = %16
  %21 = load i32, i32* %7, align 4
  %22 = icmp slt i32 %21, 2
  br label %23

23:                                               ; preds = %20, %16
  %24 = phi i1 [ false, %16 ], [ %22, %20 ]
  br i1 %24, label %25, label %40

25:                                               ; preds = %23
  %26 = load i32*, i32** %5, align 8
  %27 = load i32, i32* %7, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, i32* %26, i64 %28
  %30 = load i32, i32* %29, align 4
  %31 = load %struct.tnode*, %struct.tnode** %4, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 5
  %33 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %32, i32 0, i32 1
  %34 = load i32, i32* %7, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [2 x i32], [2 x i32]* %33, i64 0, i64 %35
  store i32 %30, i32* %36, align 4
  br label %37

37:                                               ; preds = %25
  %38 = load i32, i32* %7, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, i32* %7, align 4
  br label %16

40:                                               ; preds = %14, %23
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
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_set_node_dimensions_2d, i64 0, i64 0), i32 1690)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  store i32 %14, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %6, align 8
  %16 = call %struct.tdata* @get_node(%struct.tnode* %15, i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_set_node_dimensions_2d, i64 0, i64 0), i32 1691)
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
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
  %16 = call %struct.tdata* @get_node(%struct.tnode* %15, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1716)
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = icmp eq i32 %18, 4
  br i1 %19, label %20, label %29

20:                                               ; preds = %3
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = call %struct.tdata* @get_node(%struct.tnode* %21, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1716)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = icmp eq i32 %24, 4
  br i1 %25, label %26, label %29

26:                                               ; preds = %20
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_create_empty_list_element(i32 1, %struct.tnode* %27)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.63, i64 0, i64 0))
  br label %134

29:                                               ; preds = %20, %3
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 4
  %32 = load %struct.tpool*, %struct.tpool** %31, align 8
  store %struct.tpool* %32, %struct.tpool** %7, align 8
  %33 = load %struct.tpool*, %struct.tpool** %7, align 8
  %34 = getelementptr inbounds %struct.tpool, %struct.tpool* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 8
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  store i32 %35, i32* %37, align 8
  %38 = load %struct.tpool*, %struct.tpool** %7, align 8
  %39 = load %struct.tnode*, %struct.tnode** %4, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 4
  store %struct.tpool* %38, %struct.tpool** %40, align 8
  %41 = load %struct.tpool*, %struct.tpool** %7, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 2
  %43 = load i32, i32* %42, align 4
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 2
  store i32 %43, i32* %45, align 8
  %46 = load %struct.tnode*, %struct.tnode** %4, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 5
  %48 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %47, i32 0, i32 0
  store i32 1, i32* %48, align 8
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  br label %49

49:                                               ; preds = %85, %29
  %50 = load i32, i32* %9, align 4
  %51 = load %struct.tnode*, %struct.tnode** %5, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = icmp ult i32 %50, %53
  br i1 %54, label %55, label %88

55:                                               ; preds = %49
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = load i32, i32* %9, align 4
  %58 = call %struct.tdata* @get_node(%struct.tnode* %56, i32 %57, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1734)
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 0
  %60 = load i32, i32* %59, align 8
  %61 = icmp eq i32 %60, 4
  br i1 %61, label %62, label %63

62:                                               ; preds = %55
  br label %88

63:                                               ; preds = %55
  %64 = load %struct.tnode*, %struct.tnode** %5, align 8
  %65 = load i32, i32* %9, align 4
  %66 = call %struct.tdata* @get_node(%struct.tnode* %64, i32 %65, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1737)
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 0
  %68 = load i32, i32* %67, align 8
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = load i32, i32* %8, align 4
  %71 = call %struct.tdata* @get_node(%struct.tnode* %69, i32 %70, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1737)
  %72 = getelementptr inbounds %struct.tdata, %struct.tdata* %71, i32 0, i32 0
  store i32 %68, i32* %72, align 8
  %73 = load %struct.tnode*, %struct.tnode** %4, align 8
  %74 = load i32, i32* %8, align 4
  %75 = call %struct.tdata* @get_node(%struct.tnode* %73, i32 %74, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1738)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 1
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = load i32, i32* %9, align 4
  %79 = call %struct.tdata* @get_node(%struct.tnode* %77, i32 %78, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1738)
  %80 = getelementptr inbounds %struct.tdata, %struct.tdata* %79, i32 0, i32 1
  %81 = bitcast %union.data_type* %76 to i8*
  %82 = bitcast %union.data_type* %80 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %81, i8* align 8 %82, i64 8, i1 false)
  %83 = load i32, i32* %8, align 4
  %84 = add i32 %83, 1
  store i32 %84, i32* %8, align 4
  br label %85

85:                                               ; preds = %63
  %86 = load i32, i32* %9, align 4
  %87 = add i32 %86, 1
  store i32 %87, i32* %9, align 4
  br label %49

88:                                               ; preds = %62, %49
  store i32 0, i32* %10, align 4
  br label %89

89:                                               ; preds = %125, %88
  %90 = load i32, i32* %10, align 4
  %91 = load %struct.tnode*, %struct.tnode** %6, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 1
  %93 = load i32, i32* %92, align 4
  %94 = icmp ult i32 %90, %93
  br i1 %94, label %95, label %128

95:                                               ; preds = %89
  %96 = load %struct.tnode*, %struct.tnode** %6, align 8
  %97 = load i32, i32* %10, align 4
  %98 = call %struct.tdata* @get_node(%struct.tnode* %96, i32 %97, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1744)
  %99 = getelementptr inbounds %struct.tdata, %struct.tdata* %98, i32 0, i32 0
  %100 = load i32, i32* %99, align 8
  %101 = icmp eq i32 %100, 4
  br i1 %101, label %102, label %103

102:                                              ; preds = %95
  br label %128

103:                                              ; preds = %95
  %104 = load %struct.tnode*, %struct.tnode** %6, align 8
  %105 = load i32, i32* %10, align 4
  %106 = call %struct.tdata* @get_node(%struct.tnode* %104, i32 %105, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1747)
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %106, i32 0, i32 0
  %108 = load i32, i32* %107, align 8
  %109 = load %struct.tnode*, %struct.tnode** %4, align 8
  %110 = load i32, i32* %8, align 4
  %111 = call %struct.tdata* @get_node(%struct.tnode* %109, i32 %110, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1747)
  %112 = getelementptr inbounds %struct.tdata, %struct.tdata* %111, i32 0, i32 0
  store i32 %108, i32* %112, align 8
  %113 = load %struct.tnode*, %struct.tnode** %4, align 8
  %114 = load i32, i32* %8, align 4
  %115 = call %struct.tdata* @get_node(%struct.tnode* %113, i32 %114, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1748)
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 1
  %117 = load %struct.tnode*, %struct.tnode** %6, align 8
  %118 = load i32, i32* %10, align 4
  %119 = call %struct.tdata* @get_node(%struct.tnode* %117, i32 %118, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_concatenate_lists, i64 0, i64 0), i32 1748)
  %120 = getelementptr inbounds %struct.tdata, %struct.tdata* %119, i32 0, i32 1
  %121 = bitcast %union.data_type* %116 to i8*
  %122 = bitcast %union.data_type* %120 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %121, i8* align 8 %122, i64 8, i1 false)
  %123 = load i32, i32* %8, align 4
  %124 = add i32 %123, 1
  store i32 %124, i32* %8, align 4
  br label %125

125:                                              ; preds = %103
  %126 = load i32, i32* %10, align 4
  %127 = add i32 %126, 1
  store i32 %127, i32* %10, align 4
  br label %89

128:                                              ; preds = %102, %89
  %129 = load i32, i32* %8, align 4
  %130 = load %struct.tnode*, %struct.tnode** %4, align 8
  %131 = getelementptr inbounds %struct.tnode, %struct.tnode* %130, i32 0, i32 1
  store i32 %129, i32* %131, align 4
  %132 = load %struct.tpool*, %struct.tpool** %7, align 8
  %133 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %132, i32 %133)
  br label %134

134:                                              ; preds = %128, %26
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
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 4
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = icmp eq %struct.tpool* %9, @funk_global_memory_pool
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %20

12:                                               ; preds = %1
  %13 = load %struct.tnode*, %struct.tnode** %3, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 4
  %15 = load %struct.tpool*, %struct.tpool** %14, align 8
  %16 = icmp eq %struct.tpool* %15, @funk_functions_memory_pool
  br i1 %16, label %17, label %18

17:                                               ; preds = %12
  store i32 1, i32* %2, align 4
  br label %20

18:                                               ; preds = %12
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.64, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_pool, i64 0, i64 0))
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
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 5
  %12 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %11, i32 0, i32 0
  store i32 1, i32* %12, align 8
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
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 4
  store %struct.tpool* @funk_global_memory_pool, %struct.tpool** %8, align 8
  br label %14

9:                                                ; preds = %2
  %10 = load %struct.tnode*, %struct.tnode** %3, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 4
  store %struct.tpool* @funk_functions_memory_pool, %struct.tpool** %11, align 8
  br label %14

12:                                               ; preds = %2
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.64, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_pool, i64 0, i64 0))
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
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 1818)
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %15 = bitcast %union.data_type* %14 to i32*
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %9, align 4
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 1819)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 1
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
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.65, i64 0, i64 0), i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_regs, i64 0, i64 0), i32 %26, i32 %27)
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @__FUNCTION__.funk_alloc_tnode_array_from_range_len, i64 0, i64 0), i32 1838)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 1
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1847)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 1
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
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.66, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 %19, i32 %22)
  br label %24

24:                                               ; preds = %18, %3
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = load i32, i32* %7, align 4
  %27 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 %26, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1853)
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 0, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_set_tnode_array_element, i64 0, i64 0), i32 1853)
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
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.funk_alloc_list_of_tnodes, i64 0, i64 0), i32 1859)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 1
  %7 = bitcast %union.data_type* %6 to i32*
  %8 = load i32, i32* %7, align 8
  store i32 %8, i32* %3, align 4
  %9 = load i32, i32* %3, align 4
  %10 = zext i32 %9 to i64
  %11 = mul i64 %10, 40
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
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 1880)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp ne i32 %12, 6
  br i1 %13, label %14, label %16

14:                                               ; preds = %4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.67, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

16:                                               ; preds = %4
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_call_fn_pointer, i64 0, i64 0), i32 1885)
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 1
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
