
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
type_int,
type_double,
type_array ,
type_empty_array ,
type_scalar ,
type_function ,
type_next_node ,
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
    double f;
    int32_t i;
    void (*fn)(struct tnode *, int, struct tnode *);
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

#define SIBLING_POOL_ENTRY_LEN 4
struct tsiblings
{
  uint32_t count;
  uint32_t ptr_idx;
};


struct tnode
{
  uint32_t start, len;


  struct tpool * pool;
  struct tdimensions  dimension;
  struct tsiblings siblings;
};


#define DATA(n,i) get_node(n,i,__FUNCTION__, __LINE__,1)
#define DATA_NO_CHECK(n,i) get_node(n,i,__FUNCTION__, __LINE__,0)
#define LEN(n) n->len
#define GET_DIM_POOL_IDX(n) n->dimension.ptr_idx
#define SET_DIM_POOL_IDX(n, i) n->dimension.ptr_idx = i
#define GET_SIBLING_IDX(n) n->siblings.ptr_idx
#define SET_SIBLING_IDX(n, i) n->siblings.ptr_idx = i
#define SIBLING_COUNT(n) n->siblings.count
#define SET_SIBLING_COUNT(n,i) n->siblings.count = i

#define DIM_COUNT(n) _funk_get_node_dimension_count(n)
#define SET_DIM_COUNT(n,i) _funk_set_node_dimension_count(n,i)
#define DIM(n,i) _funk_get_node_dimension(n,i,(char*)__FUNCTION__, __LINE__)
#define SIBLING(n,i) _get_sibling(n,i,__FUNCTION__,__LINE__)
#define SET_DIM(n,i,d) _funk_set_node_dimension(n,i,d,__FUNCTION__,__LINE__)
#define SET_SIBLING(n,i,d) _set_sibling(n,i,d,__FUNCTION__,__LINE__)
#define WRAP_CREATION(n,i)  _get_wrap_creation(n,i)
#define SET_WRAP_CREATION(n,i,d)  _set_wrap_creation(n,i,d)
struct tdata * get_node(struct tnode * , uint32_t , const char * , int, int  );

void funk_create_int_scalar(enum pool_types  , struct tnode * , int32_t );
void funk_copy_node(struct tnode * , struct tnode * );

#endif
