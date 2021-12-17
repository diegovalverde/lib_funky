
#ifndef FUNK_C_MODEL_H_INCLUDED
#define FUNK_C_MODEL_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>


enum pool_types{
  global_pool=0,
  function_pool=1
};

enum funk_types{
type_invalid,
type_i32,
type_d64,
type_array ,
type_empty_array ,
type_scalar ,
type_function ,
type_pointer_to_pool_entry,
type_pool_node_entry,
max_types
};



enum FUNK_CONFIG_PARAMS{
  FUNK_PARAM_DEBUG_VERBOSITY,
  FUNK_PARAM_PRINT_ARRAY_MAX_ELEMENTS

};




#define FUNK_MAX_POOL_SIZE (50*50*100)
struct tnode;



struct tdata
{
  //one option is having the types (initially set to unknown) here
  //for later optimization. Since variables are
  //immutable, then the types will not change,
  //so you need to determine only once
  enum funk_types type;
  uint8_t wrap_creation;
  union data_type{
    double d64;
    int32_t i32;
    struct tnode  (*fn)(int, struct tnode *);
  } data;

};

struct tpool
{
  struct tdata data[FUNK_MAX_POOL_SIZE];
  uint32_t tail;
  uint8_t wrap_count;
} ;

struct tdimensions
{
  uint32_t count;
  uint32_t ptr_idx;
};

#define POOL_ENTRY_LEN 4
#define MAX_DEFERENCE_DEPTH 10


struct tnode
{
  uint32_t start, len;
  struct tpool * pool;
  struct tdimensions  dimension;

};



#define FATAL_ERROR_IF(EXP, MSG) \
  if (EXP) { \
      printf("\nINTERNAL ERROR:  %s +%d '" #EXP "':\n" #MSG "\n", __FUNCTION__, __LINE__); exit(1);}

#define DATA(n,i) get_node(n,i,__FUNCTION__, __LINE__,1)
#define IS_PTR(n,idx)  (DATA(n,idx)->type ==  type_pointer_to_pool_entry || DATA(n,idx)->type == type_array)
#define IS_NODE_IN_POOL(n,idx)  (DATA(n,idx)->type ==  type_pool_node_entry)
#define PTR(n,idx) (DATA(n,idx)->data.i)
#define DATA_NO_CHECK(n,i) get_node(n,i,__FUNCTION__, __LINE__,0)
#define LEN(n) n->len
#define GET_DIM_POOL_IDX(n) n->dimension.ptr_idx
#define SET_DIM_POOL_IDX(n, i) n->dimension.ptr_idx = i

#define DIM_COUNT(n) _funk_get_node_dimension_count(n)
#define SET_DIM_COUNT(n,i) _funk_set_node_dimension_count(n,i)
#define INC_TAIL(pool) funk_increment_pool_tail(pool, __FUNCTION__, __LINE__)
#define DIM(n,i) _funk_get_node_dimension(n,i)
#define SET_DIM(n,i,d) _funk_set_node_dimension(n,i,d,__FUNCTION__,__LINE__)
#define WRAP_CREATION(n,i)  _get_wrap_creation(n,i)
#define SET_WRAP_CREATION(n,i,d)  _set_wrap_creation(n,i,d)
#define DEREF(dst,src,idx) _dereference(dst, src->pool, src->start, idx, MAX_DEFERENCE_DEPTH, (char*)__FUNCTION__,__LINE__);
struct tdata * get_node(struct tnode * , uint32_t , const char * , int, int  );

void funk_create_int_scalar(enum pool_types  , struct tnode * , int32_t );
void funk_copy_node(struct tnode * , struct tnode * );

void funk_ne_rr(struct tnode *r, struct tnode *a, struct tnode *b);
void funk_add_rr(struct tnode *r, struct tnode *a, struct tnode *b);
void funk_mul_ri(struct tnode *node_r, struct tnode *node_a, int value);
//Public functions

 void funk_init();
 void funk_create_i32_scalar(enum pool_types pool, struct tnode *dst, int32_t val);
 void funk_create_list_of_regs(struct tnode *dst, struct tnode *list, int32_t size);
 void funk_create_empty_list_element(enum pool_types pool_type, struct tnode *dst);
 void funk_print_node(struct tnode *);
 void funk_get_element_in_array(struct tnode *src, struct tnode *dst, int idx);
 void funk_exit();
 void funk_get_len(struct tnode *dst, struct tnode *src);
 void funk_create_d64_scalar(enum pool_types pool, struct tnode *dst,
                                double val);

void funk_flt_rf(struct tnode *node_r, struct tnode *node_a, double value);
void funk_slt_rr(struct tnode *r, struct tnode *a, struct tnode *b);
void funk_mul_rr(struct tnode *r, struct tnode *a, struct tnode *b);
void funk_sub_rr(struct tnode *r, struct tnode *a, struct tnode *b);
enum pool_types get_pool_enum(struct tpool *pool) ;
void funk_add_ri(struct tnode *node_r, struct tnode *node_a, int value);
void funk_div_ri(struct tnode *node_r, struct tnode *node_a, int value) ;
void funk_sub_ri(struct tnode *node_r, struct tnode *node_a, int value);
void funk_slt_ri(struct tnode *node_r, struct tnode *node_a, int value) ;
void funk_eq_ri(struct tnode *node_r, struct tnode *node_a, int value);
void funk_sgt_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funk_slt_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;

typedef struct tnode (*FunkyFunctionPointer)(int, struct tnode *);

void funk_create_node(struct tnode *dst, uint32_t data_len,
                      enum pool_types pool_type, enum funk_types type,
                      uint8_t dim_count, void *val);

uint32_t _copy_node_to_pool(struct tnode *src);
int _funk_sum_list(struct tnode *src);
void funk_prepend_element_to_list(struct tnode *dst, struct tnode *L,
                                  struct tnode *R);
void funk_create_sub_array_lit_indexes(struct tnode *src, struct tnode *dst,
                                       int32_t c1, int32_t c2);

void funk_create_sub_array(struct tnode *src, struct tnode *dst,
                           struct tnode *i, struct tnode *j);

struct tnode funky_get_element_range(unsigned int level, struct tnode * node, int * start, int * end, int * is_range);

struct tnode funky_pop_first(struct tnode *dst, struct tnode *src);
void funk_copy_first_element_from_list(struct tnode *dst, struct tnode *src);

struct tnode funk_concatenate_lists(struct tnode *L,
                            struct tnode *R);

int  funky_cmp_element_in_array_int(struct tnode *src, int idx, int value) ;

struct tnode funk_roll( struct tnode *src, struct tnode *deltas,
               uint32_t delta_count);

struct tnode funk_not(struct tnode *src);

struct tnode funk_append_element_to_list(struct tnode *L,
                                 struct tnode *R);

void funk_flatten(struct tnode *dst, struct tnode *src);
void funk_add_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funk_sgt_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funk_sge_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funk_and_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funk_eq_ri(struct tnode *node_r, struct tnode *node_a, int value) ;
void funk_eq_rr(struct tnode *r, struct tnode *a, struct tnode *b) ;
void funky_print_type(struct tnode n);

int __get_len(struct tnode *src);

#endif
