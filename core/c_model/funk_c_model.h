
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

#define FUNK_MAX_DIMENSIONS 2 //may optimize when creating the runtime
struct tdimensions
{
  uint32_t count;  //stores 3,4,5...
  uint32_t d[FUNK_MAX_DIMENSIONS];
};

struct tnode
{
  uint32_t start, len;
  uint32_t dimension_idx;
  struct tpool * pool;
  struct tdimensions  dimension; //stride shall be an array of MAX_DIMENSIONS?


};


#define DATA(n,i) get_node(n,i,__FUNCTION__, __LINE__,1)
#define DATA_NO_CHECK(n,i) get_node(n,i,__FUNCTION__, __LINE__,0)
#define LEN(n) n->len
#define GET_DIM_POOL_IDX(n) n->dimension_idx
#define SET_DIM_POOL_IDX(n, i) n->dimension_idx = i;
#define DIM_COUNT(n) n->dimension.count
#define SET_DIM_COUNT(n,i) n->dimension.count = i
#define DIM(n,i) n->dimension.d[i]
#define SET_DIM(n,i,d) set_dimension(n,i,d)
#define WRAP_CREATION(n,i)  _get_wrap_creation(n,i)
#define SET_WRAP_CREATION(n,i,d)  _set_wrap_creation(n,i,d)
struct tdata * get_node(struct tnode * , uint32_t , const char * , int, int  );

void funk_create_int_scalar(enum pool_types  , struct tnode * , int32_t );
void funk_copy_node(struct tnode * , struct tnode * );

#endif
