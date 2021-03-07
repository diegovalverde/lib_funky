
#include "funk_c_model.h"

//#define FUNK_DEBUG_BUILD 0


#ifdef FUNK_DEBUG_BUILD
  #warning Compiling for DEBUG
#endif
struct tpool funk_global_memory_pool, funk_functions_memory_pool;
static uint32_t g_debug_continue = 0;

static char funk_types_str[][100]=
{
  "type_invalid",
  "type_int",
  "type_double",
  "type_array",
  "type_empty_array",
  "type_scalar",
  "type_function"
};
#define POOL_STR(pool) ((pool == &funk_global_memory_pool)?"gpool":"fpool")

void funk_print_node_info(struct tnode * );
void funk_print_node(struct tnode *);
void funk_print_pool(struct tpool * , int , int );
void funk_get_element_in_list_of_regs(struct tnode * ,struct tnode *, uint32_t);
void _dereference(struct tnode * dst, struct tpool * pool,uint32_t start,  int idx, int current_depth);
/*
  Exporting globals does not work very well with web-assembly
  this is why we use these enums instead
*/
struct tpool * get_pool_ptr(enum pool_types pool){
  switch(pool){
    case global_pool: return &funk_global_memory_pool;
    case function_pool: return &funk_functions_memory_pool;
    default:
    {
     printf("-E- %s\n",__FUNCTION__);
     return NULL;
    }
  }
}
// when compiling an application using debug mode
// the compiler updates the  g_funk_debug_current_executed_line for
// every instruction executed, you can then use this set breakpoints
// using the interactive debugger
#ifdef FUNK_DEBUG_BUILD
uint32_t g_funk_debug_current_executed_line = 0;
uint32_t g_funk_internal_function_tracing_enabled = 0;
#endif


#ifdef FUNK_DEBUG_BUILD
  #define TRACE(msg) if (g_funk_internal_function_tracing_enabled) printf("%s %s \n", msg, __FUNCTION__);
#else
  #define TRACE(msg)
#endif
#ifdef FUNK_DEBUG_BUILD
#define MEM_USAGE(fn)  { \
  struct rusage r_usage; \
  getrusage(RUSAGE_SELF,&r_usage); \
  printf("'%s' : Memory usage: %ld kilobytes\n", \
  fn, \
  r_usage.ru_maxrss);}
#else
  #define MEM_USAGE(fn) //optimized out
#endif

#define VALIDATE_NODE(n) validate_node(n, __FUNCTION__)
uint8_t _get_wrap_creation(struct tnode * n, uint32_t i);

struct tnode * validate_node(struct tnode * n, const char * function){
  TRACE("start");
  if (n == NULL){
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' NULL node\n",function);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }
  if (n->pool != &funk_global_memory_pool && n->pool != &funk_functions_memory_pool){
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' n[%d:%d]{%p} pointer %p to memory pool is not valid\n",function,
    n->start, n->start + LEN(n), n,
    n->pool);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }

  return n;
}

void _funk_set_node_dimension_count(struct tnode * n, uint32_t i){
  n->dimension.count = i;
}

uint32_t _funk_get_node_dimension_count(struct tnode * n){
  return n->dimension.count;
}

uint32_t _funk_get_node_dimension(struct tnode * n,
  uint32_t idx, char * caller, int line){

  uint32_t dim_idx = GET_DIM_POOL_IDX(n);
  uint32_t dimension = (dim_idx == 0) ? 1: n->pool->data[(dim_idx + idx) % FUNK_MAX_POOL_SIZE].data.i;

  return dimension;
}

void _funk_set_node_dimension(struct tnode * n, uint32_t idx,
   uint32_t val, char * caller, int line){

  if (idx > DIM_COUNT(n)){
    printf("-E- %s Invalid dimension %d \n",__FUNCTION__,idx);
    exit(1);
  }


  uint32_t dim_idx = GET_DIM_POOL_IDX(n);

  if (dim_idx == 0) return;

  uint32_t k = (dim_idx + idx) % FUNK_MAX_POOL_SIZE;

   n->pool->data[k].type = type_int;
   n->pool->data[k].data.i = val;


}

struct tdata * get_node(struct tnode * n, uint32_t i, const char * caller, int line, int check ){
  TRACE("start");

  if (n == NULL){
    printf("INTERNAL ERROR: %s NULL node pointer\n",__FUNCTION__);
    exit(1);
  }
  if (VALIDATE_NODE(n) == NULL){
    printf("INTERNAL ERROR: called from %s:%d\n", caller, line);
    exit(1);
  }


  uint32_t idx = (n->start + i);

  #ifdef FUNK_DEBUG_BUILD
  if (idx !=0 && (idx % FUNK_MAX_POOL_SIZE == 0)){
    printf("%s wrapping around %d + %d = %d:%d\n", __FUNCTION__, n->start, i, idx, LEN(n));
  }

  if (n->pool != &funk_global_memory_pool && n->pool != &funk_functions_memory_pool){
    printf("%s pointer %p to memory pool is not valid\n",__FUNCTION__,n->pool);
  }
  #endif

  struct tdata * data =  &(n->pool->data[idx % FUNK_MAX_POOL_SIZE]);

  if (check && data->wrap_creation < n->pool->wrap_count && n->start <= n->pool->tail){
    printf("-E- %s:%d get_node: attemping to access overwritten position %d:%d in '%s':%d\n",
    caller, line, idx,
    data->wrap_creation, POOL_STR(n->pool),n->pool->wrap_count);
    printf("%s[%d:%d]\n", POOL_STR(n->pool), n->start, n->start+n->len);
    exit(1);
  }


  return data;
}


uint8_t _get_wrap_creation(struct tnode * n, uint32_t i){

  return DATA(n,i)->wrap_creation;
  //return n->wrap_creation;
}

void _set_wrap_creation(struct tnode * n, uint32_t i, uint8_t d){

  //dont do checks since we are overwritting
  DATA_NO_CHECK(n,i)->wrap_creation = d;
  //n->wrap_creation = d;
}


#ifdef FUNK_DEBUG_BUILD


 #define SZ_DBG_NODES 1024
 struct tnode g_debug_nodes[SZ_DBG_NODES];
 int32_t g_debug_node_tail = 0;



 void funk_print_nodes(struct tpool * pool){
   for (int i =0; i < g_debug_node_tail; i++){
     if (pool == g_debug_nodes[i].pool){
        printf("%d: ",i); funk_print_node_info(&g_debug_nodes[i]); printf("\n");}
   }
 }



#endif


void funk_sleep(int aSeconds){
  TRACE("start");

  static int first = 1;
  if (first){
    first = 0;
    return;
  }
  sleep(aSeconds);
}

void funk_increment_pool_tail(struct tpool * pool){
  TRACE("start");

  if (pool == &funk_global_memory_pool && (pool->tail + 1 >= FUNK_MAX_POOL_SIZE) ){
    pool->wrap_count++;
    printf("%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count %d\n", __FUNCTION__,
    ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
     pool->tail, FUNK_MAX_POOL_SIZE, pool->wrap_count);
    g_debug_continue = 0;

  }
  pool->tail = (pool->tail + 1) % FUNK_MAX_POOL_SIZE;
}


void funk_print_type(unsigned char type){
  TRACE("start");

  if (type >= 0 && type < max_types){
      printf("%s", funk_types_str[type]);
  } else {
      printf("-E- %s Invalid type %d\n", __FUNCTION__, type);
  }

}

void funk_print_node_info(struct tnode * n){
  TRACE("start");

  printf("\n\n");
  printf("%p\n", n);
  printf("pool DIM idx: %d\n", GET_DIM_POOL_IDX(n));
  printf("%s[%d :%d] %d-d\n", POOL_STR(n->pool), n->start, LEN(n), DIM_COUNT(n) );
  printf("int: %d\n", DATA(n,0)->data.i);
  printf("double: %f\n", DATA(n,0)->data.f);
  funk_print_type(DATA(n,0)->type);
  printf("\n\n");

  TRACE("end");
}

uint32_t _funk_alloc_raw_tdata(struct tpool * pool, uint32_t len, enum funk_types type)
{
  TRACE("start");

  uint32_t start = pool->tail;


  for (uint32_t i = 0; i < len; i++){

    pool->data[pool->tail].type=type;
    funk_increment_pool_tail(pool);
  }

  TRACE("end");
  return start;
}

void funk_create_node(struct tnode * dst,
  uint32_t data_len, enum pool_types pool_type,
  enum funk_types type, uint8_t dim_count, void * val)
{
  TRACE("start");


  dim_count  = (dim_count < 2) ? 1 : dim_count;
  uint32_t len  = (data_len == 0) ? 1 : data_len;

  struct tpool * pool = get_pool_ptr(pool_type);

  dst->start  = pool->tail;
  dst->pool = pool;

  LEN(dst) = len;

  if (dim_count >= 2){

      SET_DIM_POOL_IDX(dst, dst->start  + data_len);


  } else {

      SET_DIM_POOL_IDX(dst, 0);

  }

  SET_DIM_COUNT(dst,dim_count);


  for (uint32_t i = 0; i < len; i++){
    DATA_NO_CHECK(dst,i)->type=type;
    SET_WRAP_CREATION(dst,i, pool->wrap_count);
    funk_increment_pool_tail(pool);

      if (val == NULL)
        continue;

    switch (type) {
      case type_int:
        DATA(dst,i)->data.i = ((int*)val)[i];
        break;

      case type_double:
        DATA(dst,i)->data.f = ((double*)val)[i];
        break;

      case type_empty_array:
        DATA(dst,i)->data.i = 0;
        DATA(dst,i)->data.f = 0;
        break;

      default:
        break;
    }
  }

  if (dim_count >= 2){
    for (uint32_t i = 0; i < dim_count; i++){
        SET_WRAP_CREATION(dst,len+i, pool->wrap_count);
        funk_increment_pool_tail(pool);
    }
  }

}

void funk_clone_node(struct tnode * dst, struct tnode * src){
  TRACE("start");
  //printf("funk_clone_node\n");
  struct tnode * psrc = src;


  if (IS_PTR(src,0)){
    struct tnode tmp;
    DEREF(&tmp,src,0);
    // printf(">>>>>>>>>>\n");
    // funk_print_node(&tmp);

    psrc = &tmp;
    //printf(">>>>>>>>>> %d\n", LEN(psrc));

  }
  int len = (IS_PTR(src,0)) ? LEN(psrc) : 1;

  funk_create_node(dst, len, function_pool, type_int,
    DIM_COUNT(src) , NULL);

  for (uint32_t i = 0; i < len; i++){
    *DATA(dst,i) = *DATA(psrc,i);
  }


  if (len == 1){
    SET_DIM_COUNT(dst,0);
    SET_DIM_POOL_IDX(dst,0);
    return;
  }
  for (uint32_t i = 0; i < DIM_COUNT(psrc); i++){
    SET_DIM(dst,i, DIM(psrc,i));
  }

  //funk_print_node(dst);

}

void funk_copy_node(struct tnode * dst, struct tnode * src){
  TRACE("start");


  dst->start = src->start;

  LEN(dst) = LEN(src);
  SET_DIM_COUNT(dst, DIM_COUNT(src));


  dst->pool = src->pool;
  uint32_t idx = GET_DIM_POOL_IDX(src);

  SET_DIM_POOL_IDX(dst,idx);


  TRACE("end");
}

void funk_exit(){
  TRACE("start");

  printf("-I- Exiting\n");
  exit(0);
}

void funk_roll(struct tnode * dst, struct tnode * src, struct tnode * deltas, int delta_count ){
  if (delta_count != DIM_COUNT(src)){
    printf("-E- %s Invalid Dimension count: %d\n", __FUNCTION__, delta_count);
    exit(1);
  }

  funk_print_node(deltas);
  funk_print_node((deltas+1));
  int di_ = DATA(deltas,0)->data.i;
  int dj_ = DATA((deltas+1),0)->data.i;
  // printf("\n\n>>>>> %d\n", di_);
  // printf(">>>>> %d\n", dj_);


  if (delta_count == 2){
    int r = DIM(src,0);
    int c = DIM(src,1);
    int *arr = (int *)malloc(r * c * sizeof(int));

    for (int i = 0; i <  r; i++) {
      for (int j = 0; j < c; j++) {
        int di = (i + di_) % DIM(src,0);
        int dj = (j + dj_) % DIM(src,1);
        di = (di < 0) ? DIM(src,0) + di : di;
        dj = (dj < 0) ? DIM(src,1) + dj : dj;

        // printf("[%d, %d] + [%d, %d] <- [%d,%d]\n", i,j, di_, dj_, di, dj);
        //
        // printf("src[%d,%d] = %d \n", di,dj, DATA(src, i*c + j)->data.i);
         *(arr + di*c + dj) = DATA(src, i*c + j)->data.i;
       }
     }
      funk_create_node(dst, LEN(src), (src->pool == &funk_global_memory_pool) ? function_pool : global_pool,
      DATA(src,0)->type, DIM_COUNT(src), arr);
      free(arr);

  } else {
    printf("-E- %s Unsupported\n", __FUNCTION__);
    exit(1);
  }
  for (int i = 0; i < delta_count; i++){
    SET_DIM(dst,i, DIM(src,i) );
  }
}

void funk_not(struct tnode * dst, struct tnode * src){
  TRACE("start");
  funk_create_node(dst, LEN(src), (src->pool == &funk_global_memory_pool) ? function_pool : global_pool,
   DATA(src,0)->type, DIM_COUNT(src), NULL);

   for (int i = 0; i < DIM_COUNT(src); i++){
      SET_DIM(dst,i, DIM(src,i) );
   }

  for (int i = 0; i < LEN(src); i++){
    if (DATA(src,i)->data.i == 0){
      DATA(dst,i)->data.i = 1;
    } else {
      DATA(dst,i)->data.i = 0;
    }
  }
}
void funk_sum_list(struct tnode * dst, struct tnode * src){
  TRACE("start");


  uint32_t total = 0;
  uint32_t m = LEN(src);


  if (DIM_COUNT(src) == 2) {
    m = DIM(src,0)*DIM(src,1);
  }
  for (uint32_t i = 0; i < m; i++)
  {
    total += DATA(src,i)->data.i;
  }

  funk_create_node(dst, 1, function_pool, type_int, 1, (void*)&total);


}

void funk_init(void){
  TRACE("start");

  unsigned int seed = (unsigned int)time(NULL);
  srand(seed);
  funk_global_memory_pool.tail = 0;
  funk_global_memory_pool.wrap_count = 0;
  funk_functions_memory_pool.tail = 0;
  funk_functions_memory_pool.wrap_count = 0;

  // clear out the memory
  memset(&funk_global_memory_pool.data,0,FUNK_MAX_POOL_SIZE*sizeof(struct tdata));


#ifdef FUNK_DEBUG_BUILD
    for (int i = 0; i < FUNK_MAX_POOL_SIZE; i++){
      funk_global_memory_pool.data[i].data.i = 0;
    }
printf(" _____            _       \n");
printf("|  ___|   _ _ __ | | ___   _ \n");
printf("| |_ | | | | '_ \\| |/ / | | |\n");
printf("|  _|| |_| | | | |   <| |_| |\n");
printf("|_|   \\__,_|_| |_|_|\\_\\__   |\n");
printf("                        |___/ \n");
    printf("===== FUNK better-than-nothing debugger =====\n");
    printf("-I- Global pool size %d\n", FUNK_MAX_POOL_SIZE);
    printf("-I- init_random_seed: %d\n", seed);
    printf("Press any key to start\n");
    getchar();
#endif



}

int is_list_consecutive_in_memory(struct tnode * list, int32_t size){
  TRACE("start");

  if (size <= 1)
    return 1;

  int prev = list[0].start;

  for (int i = 1; i < size; i++){
    int current = list[i].start;

    if (prev + 1 != current)
      return 0;
  }
  return 0;
}

void funk_get_element_in_matrix_2d_lit(struct tnode * src, struct tnode * dst , int32_t idx_0, int32_t idx_1){
    TRACE("start");
    // negative indexes allow getting last elemets like in python
    uint32_t d0 = DIM(src,0);
    uint32_t d1 = DIM(src,1);

    if (d0 == 0 || d1 == 0){
      printf("-E- %s Invalid dimensions %d x %d\n", __FUNCTION__, d0, d1);
      funk_print_node_info(src);
      exit(1);
    }


    idx_0 = (idx_0 < 0) ? d0 + idx_0 : idx_0;
    idx_1 = (idx_1 < 0) ? d1 + idx_1 : idx_1;

    idx_0 %= d0;
    idx_1 %= d1;


        struct tdata * data = DATA(src, d0* idx_0 + idx_1);

        funk_create_node(dst,
          1, function_pool,
          data->type, 0, (void *) &data->data);

}

void funk_get_element_in_matrix_2d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i, struct tnode * node_j){
  TRACE("start");

  if (DATA(node_i, 0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, DATA(node_i,0)->type );
  }

  if (DATA(node_j,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, DATA(node_j,0)->type );
  }

  int32_t idx_0 = DATA(node_i,0)->data.i;
  int32_t idx_1 = DATA(node_j,0)->data.i;

 funk_get_element_in_matrix_2d_lit(src, dst, idx_0, idx_1);

}
void _dereference(struct tnode * dst, struct tpool * pool,uint32_t start,  int idx, int current_depth){
  TRACE("start");

  int type = pool->data[(start + idx) % FUNK_MAX_POOL_SIZE].type;

  if (current_depth == 0){
    printf("-E- %s max depth\n", __FUNCTION__);
    exit(1);
  }

  if (type ==  type_pointer_to_pool_entry){
    //printf("\n$");
    //printf("%s PTR -> %d, len %d\n",__FUNCTION__, DATA(&src,idx)->data.i,DATA(&src,idx+1)->data.i );

    _dereference(dst, pool, pool->data[(start + idx)% FUNK_MAX_POOL_SIZE].data.i, 0, current_depth-1);
  } else if (type == type_pool_node_entry){
    //printf("\n#");

    dst->pool = pool;
    dst->start             = pool->data[(start + idx + 0) % FUNK_MAX_POOL_SIZE].data.i;
    dst->len               = pool->data[(start + idx + 1) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.count   = pool->data[(start + idx + 2) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.ptr_idx = pool->data[(start + idx + 3) % FUNK_MAX_POOL_SIZE].data.i;
    //printf("%s NODE IN POOL %d len %d\n",__FUNCTION__, start, dst->len);
  } else {
    printf("-E- %s unknown type %d\n", __FUNCTION__, type);
    exit(1);
  }

}
void funk_get_element_in_array(struct tnode * src, struct tnode * dst, int idx){
  TRACE("start");
  VALIDATE_NODE(src);
  //printf("IDX %d\n", idx);
  //printf("\n%s src[%d] start %d %d\n",__FUNCTION__, idx, src->start + idx, DATA(src,idx)->data.i);

  // negative indexes allow getting last elemets like in python
  idx = (idx < 0) ? LEN(src) + idx : idx;
  idx %= LEN(src);

  if (IS_PTR(src,idx) || IS_NODE_IN_POOL(src,idx)) {
    //printf("type %d\n", DATA(src,idx)->type);
    // copy source
    DEREF(dst,src,idx)

/*
    dst->pool = src->pool;
    dst->start             = src->pool->data[(PTR(src,idx) + 0) % FUNK_MAX_POOL_SIZE].data.i;
    dst->len               = src->pool->data[(PTR(src,idx) + 1) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.count   = src->pool->data[(PTR(src,idx) + 2) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.ptr_idx = src->pool->data[(PTR(src,idx) + 3) % FUNK_MAX_POOL_SIZE].data.i;
    */
  } else {

    funk_copy_node(dst, src);
    if (DIM_COUNT(src) == 2){
      //printf("\n%d x %d, idx %i\n",DIM(src,1), DIM(src,0), idx);

      //printf("%d xxxxxx %d\n", idx, idx%DIM(src,0) + DIM(src,0)*(idx / DIM(src,0)) );
      //dst->start = src->start + idx; //+ DIM(src,0)*idx;
      dst->start = src->start + DIM(src,0)*idx;//(idx%DIM(src,0)) + DIM(src,0)*(idx / DIM(src,0));
      LEN(dst) = DIM(src,0);
    } else {
      dst->start = src->start + idx;
      LEN(dst) = 1;
    }

    //printf(">>>idx: %d, len(src) %d dim_count(src): %d,  %d x %d\n", idx, LEN(src), DIM_COUNT(src), DIM(src,0), DIM(src,1) );
    dst->dimension.ptr_idx = 0;
    dst->dimension.count = 0;
    //funk_print_node(dst);
  }

}

void funk_get_element_in_array_var(struct tnode * src, struct tnode * dst , struct tnode * node_i){
  TRACE("start");
  if (DATA(node_i,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, DATA(node_i,0)->type );
  }

  int32_t idx_0 = DATA(node_i, 0)->data.i;

  funk_get_element_in_array(src, dst, idx_0);

}

void add_node_to_nodelist(struct tnode * list, struct tnode * node,
  struct tnode * idx_node, uint32_t list_len){
  TRACE("start");


  VALIDATE_NODE(node);
  VALIDATE_NODE(idx_node);

  int32_t idx = DATA(idx_node,0)->data.i;

  uint32_t k = 0;
  for (uint32_t i = idx; (k < LEN(node)) && (i < list_len); i++){
    //printf("i: %d k: %d nl: %d ll:%d \n", i, k, LEN(node), list_len);
    struct tnode * l = (list + i);
    l->pool  = node->pool;

    l->start = node->start + k;
    LEN(l) = 1;
    SET_DIM_COUNT(l ,1);


    SET_DIM_POOL_IDX(l, GET_DIM_POOL_IDX(node) );


    DATA(idx_node,0)->data.i += 1;
    k++;
  }

}

void funk_regroup_list(enum pool_types pool_type, struct tnode * dst, struct tnode * list , uint32_t size ){
  TRACE("start");

  VALIDATE_NODE(list); //validate node[0]
  funk_create_node(dst, size, pool_type, DIM_COUNT(list), 0, NULL);


  if (is_list_consecutive_in_memory(list, size) == 1){
    dst->start = list[0].start;


  } else {

    for (uint32_t i = 0; i < size; i++){

      struct tdata * p = DATA(&list[i],0);
      *DATA(dst,i) = *p;

    }

  }


}

void funk_regroup_list_r(enum pool_types pool_type, struct tnode * n, struct tnode * list , struct tnode *  size ){
  TRACE("start");
  funk_regroup_list(pool_type, n, list, DATA(size,0)->data.i);
}

void funk_create_2d_matrix(enum pool_types pool, struct tnode * dst, struct tnode * list, int32_t n, int32_t m ){
  TRACE("start");

  printf("YYYY\n");
  exit(1);

  funk_create_node(dst, n*m, pool, type_int, 2, NULL);
  SET_DIM(dst,0,n);
  SET_DIM(dst,1,m);
  funk_regroup_list(pool, dst, list, n*m );



}

void funk_create_double_scalar(enum pool_types pool, struct tnode * dst, double val){
  TRACE("start");
  funk_create_node(dst, 1, pool, type_double, 0, (void*)&val);
  VALIDATE_NODE(dst);

}

void funk_create_int_scalar(enum pool_types pool, struct tnode * dst, int32_t val){
  TRACE("start");

  funk_create_node(dst, 1, pool, type_int, 0, (void*)&val);
  VALIDATE_NODE(dst);

}

void funk_get_element_in_list_of_regs(struct tnode *dst, struct tnode * src, uint32_t i){
  TRACE("start");
  funk_get_element_in_array(src,dst,i);


  TRACE("end");
}

uint32_t _copy_node_to_pool(struct tnode * src){
    uint32_t idx = _funk_alloc_raw_tdata(src->pool, POOL_ENTRY_LEN, type_pool_node_entry);

    src->pool->data[idx%FUNK_MAX_POOL_SIZE].data.i = src->start;
    src->pool->data[(idx + 1 )%FUNK_MAX_POOL_SIZE].data.i = src->len;
    src->pool->data[(idx + 2 )%FUNK_MAX_POOL_SIZE].data.i = src->dimension.count;
    src->pool->data[(idx + 3 )%FUNK_MAX_POOL_SIZE].data.i = src->dimension.ptr_idx;

    return idx;
}

void funk_create_list_of_regs(enum pool_types pool_type, struct tnode * dst, struct tnode * list , int32_t size ){
  TRACE("start");

  funk_create_node(dst, size, pool_type, type_int, 0, NULL);

  for (int32_t i = 0; i < size; i++){
    if (list[i].len > 1){
      // if this node contains other nodes then save the node
      // in the pool and create a pointer to the position in
      // the pool to where this node node lives



      DATA_NO_CHECK(dst,i)->type = type_pointer_to_pool_entry;
      DATA_NO_CHECK(dst,i)->data.i = _copy_node_to_pool(&list[i]);

      //printf("funk_create_list_of_regs ptr %d \n", DATA_NO_CHECK(dst,i)->data.i);

    } else {

        struct tnode * x = list + i;
        *DATA_NO_CHECK(dst,i) = *DATA(&list[i],0);
        //printf("funk_create_list_of_regs VAL %d \n", DATA_NO_CHECK(dst,i)->data.i);
  }
  }

}

void funk_create_list_i32_literal(enum pool_types pool_type, struct tnode * dst, int32_t * list , int32_t size ){
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_int, 0, (void*)list);

}

void funk_create_list_double_literal(enum pool_types pool_type, struct tnode * dst, double * list , int32_t size ){
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_double, 0, (void*)list);

}

void funk_create_2d_matrix_int_literal(enum pool_types  pool_type, struct tnode * dst, int32_t * list , int32_t n, int32_t m ){
  TRACE("start");

  funk_create_node(dst, n*m, pool_type, type_int, 2, (void*)list);
  SET_DIM(dst,0,n);
  SET_DIM(dst,1,m);


}

void funk_print_scalar_element(struct tdata n){
  TRACE("start");

    switch( n.type ){
      case type_int:
        printf("%3d ", n.data.i);
        break;
      case type_double:
        printf("%5.5f", n.data.f);
        break;
      case type_empty_array:
        printf("%5s", "[]");
        break;
      case type_function:
        printf("<function> %p",n.data.fn);
        break;
      case type_pointer_to_pool_entry:
        printf("*-> %d",n.data.i);
        break;
      case type_pool_node_entry:
        printf("* %d",n.data.i);
        break;
      default:
        printf("%5s","?");
    }
  TRACE("\nend");
}

void funk_get_node_type(struct tnode  * node, uint32_t offset, unsigned char * type){
  TRACE("start");

  if (LEN(node) > 0 && offset >= LEN(node)){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
  }
  *type = DATA(node, offset)->type;

  TRACE("end");
}

void funk_set_node_type(struct tnode  * node, uint32_t offset, enum funk_types type){
  TRACE("start");

  if (offset >= LEN(node)){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
  }
  DATA(node, offset)->type =  type;
}

void funk_increment_node_data_int(struct tnode  * node){
  TRACE("start");
  DATA(node,0)->data.i++;

}

void funk_copy_node_into_node_list(struct tnode  * dst_list, struct tnode * src, struct tnode * idx_node ){
  TRACE("start");
  //VALIDATE_NODE(src);
  int32_t idx = DATA(idx_node,0)->data.i;


  funk_copy_node(&dst_list[idx], src);

}

void funk_set_node_value_int(struct tnode  * node, uint32_t offset, uint32_t value){
  TRACE("start");

  if (offset >= LEN(node)){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
  }
  DATA(node, offset )->type = type_int;
  DATA(node, offset )->data.i = value;

  TRACE("\nend");
}

void funk_set_node_value_fn_ptr(struct tnode  * node, uint32_t offset, void (*fn)(struct tnode *, int, struct tnode *)){
  TRACE("start");

  if (offset >= LEN(node)){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
  }
  DATA(node, offset )->type = type_function;
  DATA(node, offset )->data.fn = fn;
}

void funk_set_node_value_double(struct tnode  * node, uint32_t offset, double value){
  TRACE("start");

  if (offset >= LEN(node)){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
  }
  DATA(node, offset )->type = type_double;
  DATA(node, offset )->data.f = value;
}

int32_t funk_get_node_value_int(struct tnode * node, uint32_t offset){
  TRACE("start");
    if (offset > LEN(node)){
      printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, LEN(node));
    }
    return DATA(node, offset )->data.i;
}

void funk_print_pool(struct tpool * pool, int begin, int len){
  TRACE("start");
  printf("tail @: %d\n", pool->tail);
   for (int i = begin; i < begin + len; i++){

     printf("%d:", i); funk_print_scalar_element(pool->data[i]); printf("  ");
     if (i >0 && (i + 1) % 7 == 0)
       printf("\n" );
   }
   printf("\n" );
 }

void funk_get_next_node(struct tnode *dst, struct tnode * n){
  TRACE("start");
  VALIDATE_NODE(n);


   funk_copy_node(dst, n);

   LEN(dst) = LEN(n) - 1;


   if (LEN(dst) == 0){
     funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
   } else {
     dst->start = n->start + 1;
   }
   //CHECK_TYPES(dst);
 }

void funk_debug_function_entry_hook(const char * function_name, struct tnode * inputs, int arity){
  TRACE("start");
  MEM_USAGE(function_name);

  #ifdef FUNK_DEBUG_BUILD

  char str[8];


  if (funk_global_memory_pool.tail + 1 == FUNK_MAX_POOL_SIZE){
    printf("\n\n\n=== funk_global_memory_pool.tail = %d about to reach max of %d\n", funk_global_memory_pool.tail, FUNK_MAX_POOL_SIZE);
  } else if (g_debug_continue == 1){
    return;
  }

  printf("\n\n\n=== %s arity %d  ========= \n", function_name, arity);
  for (int i = 0; i < arity; i++){
    printf("input %d:\n",i);
    funk_print_node(&inputs[i]);
    printf("\n");
  }
  do {
      printf("\n>");
      fgets(str,8,stdin);

      if (!strncmp(str,"gpool",5)){
        int begin, len;
        printf("begin len:");
        scanf("%d %d", &begin, &len);

        funk_print_pool(&funk_global_memory_pool, begin, len);
      } else if (!strncmp(str,"fpool",5)){
        funk_print_pool(&funk_functions_memory_pool,0,256);
      } else if (!strncmp(str,"r",1)){
        g_debug_continue = 1;
      } else if (!strncmp(str,"q",1)){
        exit(0);
      } else if (!strncmp(str,"fnod",4)){
        funk_print_nodes(&funk_functions_memory_pool);
      } else if (!strncmp(str,"gnod",4)){
        funk_print_nodes(&funk_global_memory_pool);
      } else if (!strncmp(str,"rs",2)){

        printf("\n");


      } else if (!strncmp(str,"ftrace",6)){
        g_funk_internal_function_tracing_enabled = !g_funk_internal_function_tracing_enabled;
    } else {
       return;
    }

  } while (strncmp(str,"c",1) && strncmp(str,"r",1));

  #endif
}

void funk_debug_function_exit_hook(const char * function_name, struct tnode * retval){
  TRACE("start");


  #ifdef FUNK_DEBUG_BUILD
    printf("'%s' returned:", function_name);
    funk_print_node(retval);
    getchar();
    printf("\n==========================\n\n");
  #endif

}

void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n){
  TRACE("start");

  for (int i = 0; i < n; ++i){


     funk_copy_node(&dst[i], &src[i]);


  }

  TRACE("end");

}

void debug_print_arith_operation( struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset){
                   VALIDATE_NODE(node_r);
                   VALIDATE_NODE(node_a);
                   VALIDATE_NODE(node_b);
  TRACE("start");

  printf("%s[%d]",((node_a->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_a->start + a_offset );
  funk_print_scalar_element(*DATA(node_a, a_offset ));
  printf(" , ");
  printf("%s[%d]",((node_b->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_b->start + b_offset );
  funk_print_scalar_element(*DATA(node_b, b_offset ));

  printf(" = %s[%d]",((node_r->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_r->start + r_offset );
  funk_print_scalar_element(*DATA(node_r, r_offset ));
  printf(" )\n");

}

void funk_mul(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");
  if (type == type_double){
    *((double *)x) = (double)(*(double*)a) * (double)(*(double*)b);
  } else if (type == type_int) {
    *((int *)x) = (int)(*(int*)a) * (int)(*(int*)b);
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_div(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");
  if (type == type_double){
    *((double *)x) = (double)(*(double*)a) / (double)(*(double*)b);
  } else if (type == type_int){
    *((int *)x) = (int)(*(int*)a) / (int)(*(int*)b);
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_add(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");
  if (type == type_double){
    *((double *)x) = (double)(*(double*)a) + (double)(*(double*)b);
  } else if (type == type_int){
    *((int *)x) = (int)(*(int*)a) + (int)(*(int*)b);
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_sub(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");
  if (type == type_double){
    *((double *)x) = (double)(*(double*)a) - (double)(*(double*)b);
  } else if (type == type_int){
    *((int *)x) = (int)(*(int*)a) - (int)(*(int*)b);
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_mod(void *x, void *a, void *b, enum funk_types type){
    TRACE("start");
    *((int *)x) = (int)(*(int*)a) % (int)(*(int*)b);

}

void funk_slt(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) < (double)(*(double*)b)) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) < (int)(*(int*)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }

}

void funk_sgt(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) > (double)(*(double*)b)) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) > (int)(*(int*)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }

}

void funk_sge(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) >= (double)(*(double*)b)) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) >= (int)(*(int*)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }

}

void funk_eq(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) == (double)(*(double*)b)) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) == (int)(*(int*)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_ne(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) != (double)(*(double*)b)) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) != (int)(*(int*)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }
}

void funk_or(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) != 0.0 || (double)(*(double*)b) != 0.0) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) != 0 ||  (int)(*(int*)b) != 0) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }

}

void funk_and(void *x, void *a, void *b, enum funk_types type){
  TRACE("start");

  if (type == type_double){
    *((int *)x) = ((double)(*(double*)a) != 0.0 && (double)(*(double*)b) != 0.0) ? 1 :0 ;
  } else if (type == type_int){
    *((int *)x) = ((int)(*(int*)a) != 0 &&  (int)(*(int*)b) != 0) ? 1 : 0;
  } else {
    printf("-E- %s\n",__FUNCTION__);
  }

}

void _funk_arith_op_rr(struct tnode * node_r, uint32_t r_offset,
                 struct tnode * node_a, uint32_t a_offset,
                 struct tnode * node_b, uint32_t b_offset,
                 void (*f)(void *, void *, void *, enum funk_types )){
    TRACE("start");

    VALIDATE_NODE(node_a);
    VALIDATE_NODE(node_b);
    VALIDATE_NODE(node_r);

    if (a_offset > LEN(node_a)){
      printf("-E- Invalid index %d is greater than array size of %d", a_offset, LEN(node_a) );
    }

    if (b_offset > LEN(node_b)){
      printf("-E- Invalid index %d is greater than array size of %d", b_offset, LEN(node_b) );
    }

    if (r_offset > LEN(node_r)){
      printf("-E- Invalid index %d is greater than array size of %d", r_offset, LEN(node_r) );
    }

  struct tdata a = *DATA(node_a, a_offset);
  struct tdata b = *DATA(node_b, b_offset);
  struct tdata * r = DATA(node_r, r_offset);

  unsigned char t1 = a.type;
  unsigned char t2 = b.type;

  if (t2 == type_empty_array) t2 = type_int;

  if (t1 == type_empty_array) t1 = type_int;

  if (t1 == type_int && t2 == type_int){
      f((void*)&r->data.i, (void*)&a.data.i, (void*)&b.data.i, type_int);
      r->type = type_int;

  }else if (t1 == type_double && t2 == type_double){
      f((void*)&r->data.f, (void*)&a.data.f, (void*)&b.data.f, type_double);
      r->type = type_double;

  } else if (t1 == type_double && t2 == type_int){
      f((void*)&r->data.f, (void*)&a.data.f, (void*)&b.data.i, type_double);
      r->type = type_double;

  } else if (t1 == type_int && t2 == type_double){
      f((void*)&r->data.f, (void*)&a.data.i, (void*)&b.data.f, type_double);
      r->type = type_double;

  } else {
    printf("-E- %s: invalid types: ", __FUNCTION__);
    if (f == funk_mul) {
      printf("-E- funk_mul\n");
    }
    else if (f == funk_div){
      printf("-E- funk_div\n");
    }
    else if (f == funk_add){
      printf("-E- funk_add\n");
    }
    else if (f == funk_sub){
      printf("-E- funk_sub\n");
    }
    else if (f == funk_mod){
      printf("-E- funk_mod\n");
    }
    else if (f == funk_slt){
      printf("-E- funk_slt\n");
    }
    else if (f == funk_sgt){
      printf("-E- funk_sgt\n");
    }
    else if (f == funk_sge){
      printf("-E- funk_sge\n");
    }
    else if (f == funk_eq){
      printf("-E- funk_eq\n");
    }
    else if (f == funk_ne){
      printf("-E- funk_eq\n");
    }
    else if (f == funk_or){
      printf("-E- funk_or\n");
    }

    funk_print_type(t1);
    printf(" , ");
    funk_print_type(t2);
    printf("\n");

    r->type = type_invalid;
  }


  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled){
      debug_print_arith_operation(node_r, r_offset, node_a, a_offset, node_b, b_offset);
    }
  #endif

}

void funk_arith_op_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset,
                 void (*f)(void *, void *, void *, enum funk_types )){

      TRACE("start");
      struct tpool * pool = get_pool_ptr(function_pool);

      //check dimensions
      int32_t dim1 = (DIM_COUNT(node_a) == 0) ? 1 : DIM_COUNT(node_a);
      int32_t dim2 = (DIM_COUNT(node_b) == 0) ? 1 : DIM_COUNT(node_b);

      if (dim1 != dim2){
        printf("\n-E- cannot perform arithmetic operation in operand A of dimension %d and operand B of dimension %d\n",
      dim1, dim2);
      funk_print_node_info(node_a);
      funk_print_node_info(node_b);
      exit(1);
      }

      int32_t dim_count = dim1;
      if (dim_count > 1){
        for (int d = 0; d < dim_count; d++){
          if (DIM(node_a,d) != DIM(node_b,d)){
            printf("-E- invalid dimensions %d %d\n",
              DIM(node_a,d), DIM(node_b,d));
          }
        }
      }

      if (dim_count == 1){
        funk_create_node(node_r, LEN(node_a), function_pool,
          type_int, 0, NULL);
          for (uint32_t i = 0; i < LEN(node_a); i++){
              _funk_arith_op_rr(node_r, i, node_a, i, node_b, i,f);
          }
      } else if (dim_count == 2) {

        uint32_t array_len = DIM(node_a,0)*DIM(node_a,1);
        funk_create_node(node_r, array_len, function_pool,
          type_int, dim_count, NULL);


        SET_DIM(node_r,0, DIM(node_a,0) ) ;
        SET_DIM(node_r,1, DIM(node_a,1) );


        for (uint32_t i = 0; i < DIM(node_r,0); i++){
          for (uint32_t j = 0; j < DIM(node_r,1); j++){
            int32_t k = i*DIM(node_r,1) + j;
            _funk_arith_op_rr(node_r, k, node_a, k, node_b, k,f);
          }
        }

      } else {
        printf("-E- Arithmetic operation in %d is not currently supported\n", dim_count );
        exit(1);
      }
}

void funk_mul_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset){
                  TRACE("start");

                   funk_arith_op_rr(node_r, r_offset,
                                    node_a, a_offset,
                                    node_b, b_offset, funk_mul);
                 }

void funk_add_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");

                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_add);
                }

void funk_sub_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");

                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_sub);
                }

void funk_div_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){
                TRACE("start");

                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_div);
                }

void funk_mod_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_mod);
                }

void funk_or_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_or);
                }

void funk_and_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_and);
                }

void funk_ne_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_ne);
                }

void funk_eq_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_eq);
                }

void funk_add_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){
                  TRACE("start");
                  struct tnode node_b;
                  //TODO: maybe create a smaller pool for this?
                  funk_create_double_scalar(function_pool, &node_b, value);

                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_add);

                }

void funk_ne_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int32_t value){
                  TRACE("start");
                  struct tnode node_b;
                  funk_create_int_scalar(function_pool, &node_b, value);

                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_ne);

                }

void funk_sub_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_sub);
                }

void funk_mod_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_mod);
                }

void funk_add_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_add);
                }

void funk_div_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_div);
                }

void funk_mul_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_mul);
                }

void funk_sub_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_double_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_sub);
                }

void funk_mul_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){
                  TRACE("start");
                  struct tnode node_b;

                  funk_create_double_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_mul);
                }

void funk_slt_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_slt);

}

void funk_slt_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){

                  TRACE("start");
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_slt);
                }

      void funk_sgt_rr(struct tnode * node_r, int32_t r_offset,
                      struct tnode * node_a, int32_t a_offset,
                      struct tnode * node_b, int32_t b_offset){

                        TRACE("start");
                        funk_arith_op_rr(node_r, r_offset,
                                         node_a, a_offset,
                                         node_b, b_offset, funk_sgt);
                      }

void funk_flt_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){
                  TRACE("start");
                struct tnode node_b;

                funk_create_double_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_slt);

}

void funk_sgt_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sgt);

}

void funk_sge_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                  TRACE("start");
                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sge);

}

void funk_sge_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){
                TRACE("start");
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 node_b, b_offset, funk_sge);

}

void funk_eq_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){
                TRACE("start");
                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_eq);

}

void funk_print_dimension(struct tnode * n){
  TRACE("start");
  printf("( ");
  for (uint32_t i = 0; i < DIM_COUNT(n); i++){
    printf("%d ", DIM(n,i));
  }
  printf(")");
}

void _funk_print_node(struct tnode * n){

  TRACE("start");

  if (DIM_COUNT(n)  <= 1){


    if (LEN(n) > 1) printf("[");
    for (uint32_t i = 0; i < LEN(n); i++){
      funk_print_scalar_element(*DATA(n,i));
      if (i+1 < LEN(n)) printf(",");
    }
    if (LEN(n) > 1)  printf("]");


  } else if (DIM_COUNT(n) == 2){

    //funk_print_node_info(n);
    //printf("%d x %d \n",DIM(n,0), DIM(n,1));
    printf("[");
    for (uint32_t i = 0; i < DIM(n,1); i++){
      printf("[");
      for (uint32_t j = 0; j < DIM(n,0); j++){
          funk_print_scalar_element(*DATA(n, i * DIM(n,0) + j));
          if (j+1<DIM(n,0)) printf(",");
      }
      printf("]");
      //if (i+1<DIM(n,0)) printf(",");
    }
    printf("]");
  } else {
    printf(" [...] %d-dimensional with %d elements\n", DIM_COUNT(n), LEN(n));
  }

TRACE("\nend");
}

void funk_print_node(struct tnode * n){
  //printf("    %p LEN=%d\n",n, LEN(n));
  if (DIM_COUNT(n) > 1) printf("DIM %d\n", DIM_COUNT(n));


  int len = (DIM_COUNT(n) == 2) ? DIM(n,0) : LEN(n);

  if (LEN(n) > 1) printf("[ ");
  struct tnode node;
  funk_create_node(&node, 1, function_pool, type_int, 0, NULL);

  for (int i = 0; i < len; i++){

//printf("funk_print_node %d\n",n->start + i);
      funk_get_element_in_array(n,&node,i);
     _funk_print_node(&node);

      if (i+1 != LEN(n)) printf(" , ");
  }
  if (LEN(n) > 1) printf(" ]");

  //funk_print_pool(n->pool, 0, 80);
}

void print_2d_array_element_reg_reg(struct tnode * n, struct tnode * i, struct tnode * j){
  TRACE("start");
  funk_print_node_info(n);
  if (DIM_COUNT(n) != 2){
    printf("%s Error cannot address as a matrix since node has %d dimensions", __FUNCTION__, DIM_COUNT(n));
  }
  int i_idx = DATA(i,0)->data.i;
  int j_idx = DATA(j,0)->data.i;

  funk_print_scalar_element(*DATA(n, DIM(n,0)*i_idx + j_idx));
}

void print_2d_array_element_int_int(struct tnode * n, uint32_t i, uint32_t j){
  TRACE("start");
  funk_print_scalar_element(*DATA(n, DIM(n,0)*i + j));
}

float funk_ToFloat(struct tnode * n){
  TRACE("start");
  if (DATA(n,0)->type == type_int){
    return (float)DATA(n,0)->data.i;
  } else if (DATA(n,0)->type == type_double){
    return (float)DATA(n,0)->data.f;
  } else {
    DATA(n,0)->type = type_invalid;
    printf("ERROR %s",__FUNCTION__);
    exit(1);
    return 0.0f;
  }
}

void funk_read_list_from_file(enum pool_types  pool_type, struct tnode * dst, char * path ){
  TRACE("start");

  struct tpool * pool = get_pool_ptr(pool_type);
  FILE *fp;
  fp = fopen(path, "rt");

  if (fp == NULL)
  {
    printf("-E- File '%s' cannot be read\n", path);
    exit(1);
  }


  int value = 0;
  int count = 0;


  funk_create_node(dst, 0, pool_type, type_int, 0,  NULL);

  while(fscanf(fp,"%d",&value) == 1)
  {
    DATA(dst, pool->tail)->data.i = value;
    DATA(dst,pool->tail)->type = type_int;
    funk_increment_pool_tail(pool);


    count++;
  }

  LEN(dst) = count;
  fclose(fp);

}

void funk_get_len(struct tnode * src, struct tnode * dst){
  TRACE("start");
  int len = (DIM_COUNT(src) > 1) ? (LEN(src)/DIM(src,0)) : LEN(src);
  funk_create_int_scalar(function_pool, dst, len );

}

void funk_create_sub_matrix_lit_indexes(struct tnode * src, struct tnode * dst,
  int32_t r1, int32_t r2,
  int32_t c1, int32_t c2){
    TRACE("start");

    if (r1 > r2){
      printf("%s Error r1 (%d) > r2 (%d)\n", __FUNCTION__,r1,r2 );
      exit(1);
    }

    if (c1 > c2){
      printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__,c1,c2 );
      exit(1);
    }


    int32_t n = abs((r2 - r1)+1);
    int32_t m = abs((c2 - c1)+1);
    MEM_USAGE(__FUNCTION__);

    int32_t * list = (int32_t *)malloc(sizeof(int32_t)*n*m);

    int k = 0;
    for (int i = r1; i <= r2; i++){
      for (int j = c1; j <= c2; j++){

        int idx_i = (i < 0) ? i + DIM(src,0) : i;
        int idx_j = (j < 0) ? j + DIM(src,1) : j;

        idx_i %= DIM(src,0);
        idx_j %= DIM(src,1);

        list[k] = DATA(src, idx_i*DIM(src,0) +idx_j)->data.i;

        k++;

      }
    }


    funk_create_2d_matrix_int_literal(global_pool,  dst, list, n, m );
    free(list);

  }

void funk_create_sub_matrix(struct tnode * src, struct tnode * dst,
  struct tnode * R1,struct tnode * R2,
  struct tnode * C1, struct tnode *C2){
    TRACE("start");

  if (DIM_COUNT(src) != 2){
    //funk_print_node_info(src);
    printf("Error: %s shall have 2 dimensions and not %d\n", __FUNCTION__,
     DIM_COUNT(src));
    exit(1);
  }

  int32_t r1 = DATA(R1,0)->data.i;
  int32_t r2 = DATA(R2,0)->data.i;
  int32_t c1 = DATA(C1,0)->data.i;
  int32_t c2 = DATA(C2,0)->data.i;

  funk_create_sub_matrix_lit_indexes(src, dst, r1,  r2, c1,  c2);

}

void funk_create_sub_array_lit_indexes(struct tnode * src, struct tnode * dst,
  int32_t c1, int32_t c2){
    TRACE("start");
    c1 = (c1 < 0) ? c1 + LEN(src) : c1;
    c2 = (c2 < 0) ? c2 + LEN(src) : c2;

    if (c1 > c2){
      printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__,c1, c2 );
      exit(1);
    }

    int32_t n = abs((c2 - c1)+1);
    MEM_USAGE(__FUNCTION__);
    struct tnode * list = (struct tnode *)malloc(sizeof(struct tnode)*n);
    int k = 0;

    // struct tnode node;
    // funk_create_node(&node, 1, function_pool, type_int, 0, NULL);
//printf("%d -> %d", c1, c2);
    for (int j = c1; j <= c2; j++){

      int idx_j = j % LEN(src);
      //printf("idx = %d\n", idx_j);

      //list[k] = DATA(src,idx_j)->data.i;

      funk_get_element_in_array(src, list+k, idx_j);
      //list[k] = &node;
      k++;

    }

    funk_create_list_of_regs(global_pool, dst, list , n );
    //funk_create_list_i32_literal(global_pool,  dst, list, n );
    free(list);

  }

void funk_create_sub_array(struct tnode * src, struct tnode * dst,
  struct tnode * i,struct tnode * j){
  TRACE("start");


  int32_t c1 = DATA(i,0)->data.i;
  int32_t c2 = DATA(j,0)->data.i;

  funk_create_sub_array_lit_indexes(src, dst, c1,  c2);

}

void funk_set_node_dimensions(struct tnode  * node, int * dimensions, int dim_count){
  TRACE("start");


  if (dimensions == NULL)
    return;



  if (dim_count != DIM_COUNT(node)) {

    uint32_t dim_idx = 0;
    dim_idx = _funk_alloc_raw_tdata(node->pool, dim_count, type_int);


    SET_DIM_POOL_IDX(node, dim_idx); // set the new idx in the pool
    SET_DIM_COUNT(node,dim_count);
  }

  if (dim_count == 2 && dimensions[0] == 1 && dimensions[1] == LEN(node)) { //1 row
      SET_DIM_COUNT(node,1);
  }

  for (int i = 0; i < dim_count; i++){

    SET_DIM(node,i,dimensions[i]);
  }

}

void funk_set_node_dimensions_2d(struct tnode  * node, struct tnode  * d0_reg, struct tnode  * d1_reg){
  TRACE("start");
  uint32_t d0 = DATA(d0_reg,0)->data.i; //rows
  uint32_t d1 = DATA(d1_reg,0)->data.i; //cols

  int array[] = {d0, d1};
  funk_set_node_dimensions(node, array, 2);
}

void reshape(struct tnode * dst, int * dimensions, uint32_t dim_count){
  TRACE("start");




  if (DATA(dst,0)->type == type_empty_array){
    return;
  }

  funk_set_node_dimensions(dst, dimensions, dim_count);

}

double rand_double(double lower, double upper){
  TRACE("start");
  return (((double)rand()/(double)(RAND_MAX)) * (upper-lower)) + lower;


}

void funk_create_empty_list_element(enum pool_types pool_type, struct tnode  * dst){
  TRACE("start");
  funk_create_node(dst, 1, pool_type, type_empty_array, 0, NULL);
}

void funk_concatenate_lists(struct tnode  * dst, struct tnode  * L, struct tnode  * R){
  TRACE("start"); //printf("%d <- %d ++ %d", dst->start, L->start, R->start);

  VALIDATE_NODE(L);
  VALIDATE_NODE(R);


  if (DATA(L, 0)->type == type_empty_array && DATA(R, 0)->type == type_empty_array){
    funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
    printf("funk_concatenate_lists [] , [] -> []\n");
    return;
  }


  funk_create_node(dst,
      ((DATA(L,0)->type == type_empty_array) ? 0 : LEN(L)) +
      ((DATA(R,0)->type == type_empty_array) ? 0 : LEN(R)) ,
      function_pool, type_array, 0,  NULL);


  struct tpool * pool = R->pool;


  uint32_t k = 0;

  for (uint32_t i = 0; i < LEN(L); i++){
    if (DATA(L,i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(L,i)->type;
    DATA(dst, k)->data = DATA(L,i)->data;

    k++;
  }

  for (uint32_t i = 0; i < LEN(R); i++){
    if (DATA(R,i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(R,i)->type;
    DATA(dst, k)->data = DATA(R,i)->data;

    //funk_increment_pool_tail(pool);
    k++;
  }






}

uint32_t funk_get_node_start(struct tnode  * n){
  TRACE("start");
  VALIDATE_NODE(n);
  return n->start;
}

enum pool_types funk_get_node_pool(struct tnode  * n){
  TRACE("start");
  VALIDATE_NODE(n);
  enum pool_types pool_type;

  if (n->pool == &funk_global_memory_pool) {
    return global_pool;
  }
  else if (n->pool == &funk_functions_memory_pool)
  {
    return function_pool;
  } else {
    printf("-E- %s Invalid pool\n", __FUNCTION__);
    exit(1);
  }

  return pool_type;
}

void funk_set_node_len(struct tnode  * n, uint32_t len){
  TRACE("start");

  VALIDATE_NODE(n);
  LEN(n) = len;
  SET_DIM_COUNT(n,1);

}

void funk_set_node_pool(struct tnode  * n, enum pool_types pool_type ){
  TRACE("start");

  switch (pool_type){
    case global_pool:
      n->pool = &funk_global_memory_pool;
      break;
    case function_pool:
      n->pool = &funk_functions_memory_pool;
      break;
    default:
      printf("-E- %s Invalid pool\n", __FUNCTION__);
      exit(1);
      break;
  }
}

void funk_set_node_start(struct tnode  * n, uint32_t start){
  TRACE("start");
  VALIDATE_NODE(n);
  n->start = start;
}

void funk_alloc_tnode_array_from_range_regs(struct tnode  * dst,
  struct tnode  * l, struct tnode  * r, enum pool_types pool_type){
    TRACE("start");


    uint32_t left = DATA(l,0)->data.i;
    uint32_t right = DATA(r,0)->data.i;
    if (left >= right){
      printf("-E- %s Invalid range from %d to %d\n", __FUNCTION__, left, right);
      exit(1);
    }


    uint32_t len = right - left;


    funk_create_node(dst, len, pool_type, type_array, 0, NULL);



  }

  void funk_alloc_tnode_array_from_range_len(struct tnode  * dst,
    struct tnode  * len_reg,  enum pool_types pool_type){
      TRACE("start");
      uint32_t len = DATA(len_reg,0)->data.i;
      funk_create_node(dst, len, pool_type, type_array, 0, NULL);

    }

  void funk_set_tnode_array_element(struct tnode  * tnode_list,
    struct tnode  * iterator_reg, struct tnode  * value_reg){
      TRACE("start");

      uint32_t i = DATA(iterator_reg,0)->data.i;

      if ( i > LEN(tnode_list)){
        printf("-E- %s Index %d out of range [0:%d]\n", __FUNCTION__, i, LEN(tnode_list));
      }

      *DATA(tnode_list, i ) = *DATA(value_reg, 0 );

  }

  struct tnode  * funk_alloc_list_of_tnodes( struct tnode  * reg_len){
    TRACE("start");
    uint32_t len = DATA(reg_len,0)->data.i;

    MEM_USAGE(__FUNCTION__);
    return (struct tnode  *)malloc(len*sizeof(struct tnode));

  }

/*
;; call Function Pointer

        %{0} = getelementptr inbounds %struct.tdata, %struct.tdata* {fn_data}, i32 0, i32 1
        %{1} = bitcast %union.data_type* %{0} to void (%struct.tnode*, i32, %struct.tnode*)**
        %{2} = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %{1}, align 8
        call void %{2}(%struct.tnode* {result}, i32 {n}, %struct.tnode* {args})
*/
  void funk_call_fn_pointer(struct tnode  * n,
      struct tnode * result,
      int arity,
      struct tnode * arguments){

    TRACE("start");
    if (DATA(n,0)->type != type_function){
      printf("-E- calling node which is not a function!\n");
      exit(1);
    }
    //execute the function
    DATA(n,0)->data.fn(result, arity, arguments);
  }
