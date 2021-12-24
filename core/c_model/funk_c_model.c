
#include "funk_c_model.h"

//#define FUNK_DEBUG_BUILD 0
#define MAX_NAME_SZ 64
#define MAX(a,b) ((a > b) ? a : b)
char gCurrentFunction[MAX_NAME_SZ];

#define ERROR(s) printf("-E- %s :: %s+%d %s\n", gCurrentFunction, __FUNCTION__, __LINE__, s);


#ifdef FUNK_DEBUG_BUILD
uint32_t g_funk_debug_current_executed_line = 0;
uint32_t g_funk_internal_function_tracing_enabled = 0;
uint32_t g_debug_continue = 0;
#endif
#ifdef FUNK_DEBUG_BUILD
#define TRACE(msg)                                                             \
  if (g_funk_internal_function_tracing_enabled) {                              \
    printf("%s %s \n", msg, __FUNCTION__);                                     \
    printf("<T> %d\n", funk_global_memory_pool.data[0].wrap_creation);         \
  }
#else
#define TRACE(msg)
#endif

#ifdef FUNK_DEBUG_BUILD
#warning Compiling for DEBUG
#endif
struct tpool funk_global_memory_pool, funk_functions_memory_pool;
;

static char funk_types_str[][100] = {
    "type_invalid",        "type_i32",
    "type_d64",         "type_array",
    "type_empty_array",    "type_scalar",
    "type_function",       "type_pointer_to_pool_entry",
    "type_pool_node_entry"};
#define POOL_STR(pool) ((pool == &funk_global_memory_pool) ? "gpool" : "fpool")

 struct tnode funky_get_element_in_array(struct tnode *src, int idx);
void funk_flatten(struct tnode *dst, struct tnode *src);
void funk_print_node_info(struct tnode *);
void funk_print_node(struct tnode *);
uint32_t _copy_node_to_pool(struct tnode *);
void _extract_tnode_from_pool(struct tnode *dst, uint32_t start,
                              struct tpool *pool);
void funk_print_pool(enum pool_types, int, int);
void funk_get_element_in_list_of_regs(struct tnode *, struct tnode *, uint32_t);
void funk_get_element_in_array(struct tnode *src, struct tnode *dst, int idx);
void _dereference(struct tnode *dst, struct tpool *pool, uint32_t start,
                  int idx, int current_depth, const char *func, int line);
                //  void funk_get_element_in_matrix_2d_lit(struct tnode *src, struct tnode *dst,
                //                                         int32_t idx_0, int32_t idx_1);

/*
  Exporting globals does not work very well with web-assembly
  this is why we use these enums instead
*/

enum pool_types get_pool_enum(struct tpool *pool) {
  TRACE("start");
  if (pool == &funk_global_memory_pool) {
    return global_pool;
  } else if (pool == &funk_functions_memory_pool) {
    return function_pool;
  } else {
    printf("Error\n");
    exit(1);
  }
}

struct tpool *get_pool_ptr(enum pool_types pool) {
  TRACE("start");
  switch (pool) {
  case global_pool:
    return &funk_global_memory_pool;
  case function_pool:
    return &funk_functions_memory_pool;
  default: {
    printf("-E- %s\n", __FUNCTION__);
    return NULL;
  }
  }
}
// when compiling an application using debug mode
// the compiler updates the  g_funk_debug_current_executed_line for
// every instruction executed, you can then use this set breakpoints
// using the interactive debugger

#ifdef FUNK_DEBUG_BUILD
#define MEM_USAGE(fn)                                                          \
  {                                                                            \
    struct rusage r_usage;                                                     \
    getrusage(RUSAGE_SELF, &r_usage);                                          \
    printf("'%s' : Memory usage: %ld kilobytes\n", fn, r_usage.ru_maxrss);     \
  }
#else
#define MEM_USAGE(fn) // optimized out
#endif

#define VALIDATE_NODE(n) validate_node(n, __FUNCTION__, __LINE__)
uint8_t _get_wrap_creation(struct tnode *n, uint32_t i);

struct tnode *validate_node(struct tnode *n, const char *function, int line) {
  char str[80];
  sprintf(str, "start: from %s:%d\n", function, line);
  TRACE(str);
  if (n == NULL) {
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' NULL node\n", function);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }
  if (n->pool != &funk_global_memory_pool &&
      n->pool != &funk_functions_memory_pool) {
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' n[%d:%d]{%p} pointer %p to memory pool is not "
           "valid\n",
           function, n->start, n->start + LEN(n), n, n->pool);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }

  return n;
}

void _funk_set_node_dimension_count(struct tnode *n, uint32_t i) {
  TRACE("start");
  n->dimension.count = i;
}

uint32_t _funk_get_node_dimension_count(struct tnode *n) {
  TRACE("start");
  return n->dimension.count;
}

uint32_t _funk_get_node_dimension(struct tnode *n, uint32_t idx) {
  TRACE("start");
  uint32_t dim_idx = GET_DIM_POOL_IDX(n);
  uint32_t dimension =
      (dim_idx == 0)
          ? 1
          : n->pool->data[(dim_idx + idx) % FUNK_MAX_POOL_SIZE].data.i32;

  return dimension;
}

void _funk_set_node_dimension(struct tnode *n, uint32_t idx, uint32_t val,
                              const char *caller, int line) {
  TRACE("start");
  if (idx > DIM_COUNT(n)) {
    printf("-E- %s Invalid dimension %d from %s +%d\n", __FUNCTION__, idx,
           caller, line);
    exit(1);
  }

  uint32_t dim_idx = GET_DIM_POOL_IDX(n);

  if (dim_idx == 0)
    return;

  uint32_t k = (dim_idx + idx) % FUNK_MAX_POOL_SIZE;

  n->pool->data[k].type = type_i32;
  n->pool->data[k].data.i32 = val;
}

struct tdata *get_node(struct tnode *n, uint32_t i, const char *caller,
                       int line, int check) {
  char str[80];
  sprintf(str, "start: from %s:%d ", caller, line);
  TRACE(str);

  if (n == NULL) {
    printf("INTERNAL ERROR: get_node from %s +%d NULL node pointer\n", caller,
           line);
    exit(1);
  }
  if (VALIDATE_NODE(n) == NULL) {
    printf("INTERNAL ERROR: called from %s:%d\n", caller, line);
    exit(1);
  }

  uint32_t idx = (n->start + i);

#ifdef FUNK_DEBUG_BUILD
  if (idx != 0 && (idx % FUNK_MAX_POOL_SIZE == 0)) {
    printf("%s wrapping around %d + %d = %d:%d\n", __FUNCTION__, n->start, i,
           idx, LEN(n));
  }

  if (n->pool != &funk_global_memory_pool &&
      n->pool != &funk_functions_memory_pool) {
    printf("%s pointer %p to memory pool is not valid\n", __FUNCTION__,
           n->pool);
  }
#endif

  struct tdata *data = &(n->pool->data[idx % FUNK_MAX_POOL_SIZE]);

  if (check && data->wrap_creation < n->pool->wrap_count &&
      n->start <= n->pool->tail) {
    printf("-E- %s:%d get_node: trying to access overwritten position %d:%d in "
           "'%s':%d\n",
           caller, line, idx, data->wrap_creation, POOL_STR(n->pool),
           n->pool->wrap_count);
    printf("%d : %d\n", funk_global_memory_pool.wrap_count,
           funk_functions_memory_pool.wrap_count);
    printf("Trying to access %s[%d:%d] len:%d, pool_tail = %d/%d\n",
           POOL_STR(n->pool), n->start,
           (n->start + n->len) % FUNK_MAX_POOL_SIZE, n->len, n->pool->tail,
           FUNK_MAX_POOL_SIZE);

    printf("wrap_creation: ");
    for (int i = 0; i < n->len; i++) {
      printf("%s %d ", POOL_STR(n->pool),
             n->pool->data[(n->start + i) % FUNK_MAX_POOL_SIZE].wrap_creation);
    }

    printf("wrap count: ");
    for (int i = 0; i < n->len + 40; i++) {
      printf("%s%d: %d \n", POOL_STR(n->pool),
             (n->start + i - 20) % FUNK_MAX_POOL_SIZE,
             n->pool->data[(n->start + i - 20) % FUNK_MAX_POOL_SIZE]
                 .wrap_creation);
    }

    printf("wrap count: ");
    for (int i = 0; i < n->len + 40; i++) {
      printf("%s%d: %d \n", "fpool", (n->start + i - 20) % FUNK_MAX_POOL_SIZE,
             funk_functions_memory_pool
                 .data[(n->start + i - 20) % FUNK_MAX_POOL_SIZE]
                 .wrap_creation);
    }

    funk_print_pool(global_pool, 0, 100);

    exit(1);
  }

  return data;
}

uint8_t _get_wrap_creation(struct tnode *n, uint32_t i) {
  TRACE("start");
  return DATA(n, i)->wrap_creation;
  // return n->wrap_creation;
}

void _set_wrap_creation(struct tnode *n, uint32_t i, uint8_t d) {
  TRACE("start");
  // dont do checks since we are overwritting
  // DATA_NO_CHECK(n,i)->wrap_creation = n->pool->wrap_count;

  n->pool->data[(n->start + i) % FUNK_MAX_POOL_SIZE].wrap_creation =
      n->pool->wrap_count;
  // n->wrap_creation = d;
}

#ifdef FUNK_DEBUG_BUILD

#define SZ_DBG_NODES 1024
struct tnode g_debug_nodes[SZ_DBG_NODES];
int32_t g_debug_node_tail = 0;

void funk_print_nodes(struct tpool *pool) {
  for (int i = 0; i < g_debug_node_tail; i++) {
    if (pool == g_debug_nodes[i].pool) {
      printf("%d: ", i);
      funk_print_node_info(&g_debug_nodes[i]);
      printf("\n");
    }
  }
}

#endif

void funk_sleep(int aSeconds) {
  TRACE("start");

  static int first = 1;
  if (first) {
    first = 0;
    return;
  }
  sleep(aSeconds);
}

void funk_increment_pool_tail(struct tpool *pool, const char *function,
                              int line) {
  TRACE("start");

  if ((pool->tail + 1 >= FUNK_MAX_POOL_SIZE)) {
    pool->wrap_count++;
    if (pool == &funk_global_memory_pool) {
      printf("%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count "
             "%d\n",
             __FUNCTION__,
             ((pool == &funk_global_memory_pool) ? "gpool" : "fpool"),
             pool->tail, FUNK_MAX_POOL_SIZE, pool->wrap_count);
      // g_debug_continue = 0;
    }
  }
  pool->tail = (pool->tail + 1) % FUNK_MAX_POOL_SIZE;
}

void funk_print_type(unsigned char type) {
  TRACE("start");

  if (type >= 0 && type < max_types) {
    printf("%s", funk_types_str[type]);
  } else {
    printf("-E- %s Invalid type %d\n", __FUNCTION__, type);
  }
}
void _print_array_info(struct tnode *n, int tabs) {
  struct tnode node_array;
  int pool_idx =  DATA(n, 0)->data.i32;
  _extract_tnode_from_pool(&node_array, pool_idx, n->pool);
  printf(" Array Len: %d\n", node_array.len );
  for (uint32_t i = 0; i < node_array.len; i++) {
    for (int k = 0; k < tabs; k++) printf("\t");
    funk_print_type(DATA(&node_array, i)->type);
    printf("\n");
    if (DATA(&node_array, i)->type == type_array){
      struct tnode tmp;
      pool_idx = DATA(&node_array, i)->data.i32;
      _extract_tnode_from_pool(&tmp, pool_idx, node_array.pool);
      _print_array_info( &tmp, tabs+1);
    } else if (DATA(&node_array, i)->type == type_i32) {
      printf(" %d\n", DATA(&node_array, i)->data.i32);
    }
    printf("\n");
  }
}
void _funk_print_node_info(struct tnode n_) {
  struct tnode * n = &n_;
  TRACE("start");

  printf("\n\n");
//  printf("%p\n", n);
//  printf("pool DIM idx: %d\n", GET_DIM_POOL_IDX(n));
  printf("len %d\n", LEN(n));
  printf("%s[%d :%d] %d-d\n", POOL_STR(n->pool), n->start,
         (n->start + LEN(n)) % FUNK_MAX_POOL_SIZE, DIM_COUNT(n));
  printf("types: ");
  for (uint32_t i = 0; i < LEN(n); i++) {
    printf("%d, ", DATA(n, i)->type);
  }

  printf("wrap_creation: ");
  for (uint32_t i = 0; i < LEN(n); i++) {
    printf("%d, ", DATA(n, i)->wrap_creation);
  }

  printf("\n");
  printf("int: %d\n", DATA(n, 0)->data.i32);
  printf("double: %f\n", DATA(n, 0)->data.d64);
  funk_print_type(DATA(n, 0)->type);
  printf("\nglobal tail: %d:%d\n", funk_global_memory_pool.tail,
         funk_global_memory_pool.wrap_count);
  printf("function tail: %d:%d\n", funk_functions_memory_pool.tail,
         funk_functions_memory_pool.wrap_count);


  if (DATA(n, 0)->type == type_array){
    _print_array_info(n,0);
  }
  printf("\n\n");

  TRACE("end");
}
void funk_print_node_info(struct tnode *n){
  _funk_print_node_info(*n);
}
uint32_t _funk_alloc_raw_tdata(struct tpool *pool, uint32_t len,
                               enum funk_types type) {
  TRACE("start");

  uint32_t start = pool->tail;

  for (uint32_t i = 0; i < len; i++) {

    pool->data[pool->tail].type = type;
    pool->data[pool->tail].wrap_creation = pool->wrap_count;

    INC_TAIL(pool);
  }

  TRACE("end");
  return start;
}

void funk_create_node(struct tnode *dst, uint32_t data_len,
                      enum pool_types pool_type, enum funk_types type,
                      uint8_t dim_count, void *val) {
  TRACE("start");

  dim_count = (dim_count < 2) ? 1 : dim_count;
  uint32_t len = (data_len == 0) ? 1 : data_len;

  struct tpool *pool = get_pool_ptr(pool_type);

  dst->start = pool->tail;
  dst->pool = pool;

  LEN(dst) = len;

  if (dim_count >= 2) {

    SET_DIM_POOL_IDX(dst, dst->start + data_len);

  } else {

    SET_DIM_POOL_IDX(dst, 0);
  }

  SET_DIM_COUNT(dst, dim_count);

  for (uint32_t i = 0; i < len; i++) {
    DATA_NO_CHECK(dst, i)->type = type;

    SET_WRAP_CREATION(dst, i, pool->wrap_count);
    INC_TAIL(pool);

    if (val == NULL)
      continue;

    switch (type) {
    case type_i32:
      DATA(dst, i)->data.i32 = ((int *)val)[i];
      break;

    case type_d64:
      DATA(dst, i)->data.d64 = ((double *)val)[i];
      break;

    case type_empty_array:
      DATA(dst, i)->data.i32 = 0;
      DATA(dst, i)->data.d64 = 0;
      break;

    case type_function:
      DATA(dst, i)->data.fn = ((FunkyFunctionPointer)val);
      break;

    default:
      break;
    }
  }

  if (dim_count >= 2) {
    for (uint32_t i = 0; i < dim_count; i++) {
      SET_WRAP_CREATION(dst, len + i, pool->wrap_count);
      INC_TAIL(pool);
    }
  }

  TRACE("end");
}

void funk_deep_copy_node(struct tnode *dst, struct tnode *src) {
  TRACE("start");
  struct tnode *psrc = src;
  struct tnode tmp;
  if (IS_PTR(src, 0)) {

    DEREF(&tmp, src, 0);
    psrc = &tmp;
  }
  uint32_t len = (IS_PTR(src, 0)) ? LEN(psrc) : 1;

  funk_create_node(dst, LEN(src), get_pool_enum(src->pool), type_i32, DIM_COUNT(src),
                   NULL);

  FATAL_ERROR_IF( (IS_PTR(src, 0) && LEN(src) != tmp.len && LEN(src) != 1), "");

if (tmp.len == LEN(src)){
  for (uint32_t i = 0; i < len; i++) {
    DATA(dst, i)->data = DATA(psrc, i)->data;
    DATA(dst, i)->type = DATA(psrc, i)->type;
  }
} else if (LEN(dst) == 1){
    DATA_NO_CHECK(dst, 0)->type = type_pointer_to_pool_entry;
    DATA_NO_CHECK(dst, 0)->data.i32 = _copy_node_to_pool(&tmp);
}

  if (len == 1) {
    SET_DIM_COUNT(dst, 0);
    SET_DIM_POOL_IDX(dst, 0);
    return;
  }
  for (uint32_t i = 0; i < DIM_COUNT(psrc); i++) {
    SET_DIM(dst, i, DIM(psrc, i));
  }

  // funk_print_node(dst);
}

void funk_copy_node(struct tnode *dst, struct tnode *src) {
  TRACE("start");

  dst->start = src->start;

  LEN(dst) = LEN(src);
  SET_DIM_COUNT(dst, DIM_COUNT(src));

  dst->pool = src->pool;
  uint32_t idx = GET_DIM_POOL_IDX(src);

  SET_DIM_POOL_IDX(dst, idx);

  TRACE("end");
}

void funk_exit() {
  TRACE("start");

  printf("-I- Exiting\n");
  exit(0);
}

struct tnode funk_roll(  struct tnode *src, struct tnode *deltas,
               uint32_t delta_count) {
  TRACE("start");
  struct tnode dst;
  FATAL_ERROR_IF( !src , "");
  FATAL_ERROR_IF( !deltas, "" );
  FATAL_ERROR_IF( !IS_PTR(src,0), "" );
  FATAL_ERROR_IF( delta_count != 2, "Only 2 dimensions supported" );

  int di_ = DATA(deltas, 0)->data.i32;
  int dj_ = DATA((deltas + 1), 0)->data.i32;

int r = LEN(src);

struct tnode tmp;
DEREF(&tmp, src, 0);

int c = tmp.len;
int arr[r*c];


for (int i = 0; i < r; i++) {
  struct tnode src_row;

  funk_get_element_in_array(src, &src_row,i);

  for (int j = 0; j < c; j++) {

    int di = (i + di_) % r;
    int dj = (j + dj_) % c;
    di = (di < 0) ? r + di : di;
    dj = (dj < 0) ? c + dj : dj;

    struct tnode row = funky_get_element_in_array(src,i);
    struct tnode element = funky_get_element_in_array(&row,j);

    struct tnode tmp;
   // funk_get_element_in_matrix_2d_lit(src, &tmp, i,j);
    int xx = DATA(&element,0)->data.i32;
    *(arr + di * c + dj) =  DATA(&element,0)->data.i32;//DATA(src, i * c + j)->data.i32;
  }
}


struct tnode reg_rows[r];
for (int i = 0; i < r; i++){
  struct tnode row[c];
  for (int j = 0; j < c; j++){
    funk_create_i32_scalar(get_pool_enum(src->pool), row+j, *(arr + c*i + j));
  }

  funk_create_list_of_regs(reg_rows + i, row,r);
}
funk_create_list_of_regs(&dst, reg_rows, r);


  return dst;
}

struct tnode funk_not(struct tnode *src) {
  TRACE("start");

struct tnode dst;

    if (DATA(src,0)->type == type_array){
      int len = __get_len(src);
      struct tnode elements[len];
      for (uint32_t i = 0; i < len; i++) {
        struct tnode element = funky_get_element_in_array(src,i);
        elements[i] = funk_not(&element);
      }
     funk_create_list_of_regs(&dst,elements,len);

    } else {
        funk_create_node(&dst, 1,
                  get_pool_enum (src->pool),
                   DATA(src, 0)->type, 0, NULL);

        DATA(&dst, 0)->data.i32 =
        (DATA(src, 0)->data.i32 == 0) ? 1 : 0;
    }

return dst;

}

struct tnode funk_abs(struct tnode *src) {
  TRACE("start");

struct tnode dst;

    if (DATA(src,0)->type == type_array){
      int len = __get_len(src);
      struct tnode elements[len];
      for (uint32_t i = 0; i < len; i++) {
        struct tnode element = funky_get_element_in_array(src,i);
        elements[i] = funk_abs(&element);
      }
     funk_create_list_of_regs(&dst,elements,len);

    } else {
        funk_create_node(&dst, 1,
                  get_pool_enum (src->pool),
                   DATA(src, 0)->type, 0, NULL);

        DATA(&dst, 0)->data.i32 = abs(DATA(src, 0)->data.i32);
        
    }

return dst;

}

int _funk_sum_list(struct tnode *src) {
  TRACE("START");

  int total = 0;
  if (DATA(src,0)->type != type_array){
    printf("Not a list");
  }
  for (uint32_t i = 0; i < LEN(src); i++) {
    struct tnode tmp;
    funk_get_element_in_array(src,&tmp,i);
    if (DATA(&tmp,0)->type == type_array){
      total += _funk_sum_list(&tmp);
    } else {
      total += DATA(&tmp,0)->data.i32;
    }


  }

  return total;
}
void funk_sum_list(struct tnode *dst, struct tnode *src) {
  TRACE("start");

  int total = _funk_sum_list(src);

  funk_create_node(dst, 1, get_pool_enum(src->pool), type_i32, 0,
                   (void *)&total);
}

void funk_init(void) {
  TRACE("start");

  unsigned int seed = (unsigned int)time(NULL);
  srand(seed);
  funk_global_memory_pool.tail = 0;
  funk_global_memory_pool.wrap_count = 0;
  funk_functions_memory_pool.tail = 0;
  funk_functions_memory_pool.wrap_count = 0;

  // clear out the memory
  memset(&funk_global_memory_pool.data, 0,
         FUNK_MAX_POOL_SIZE * sizeof(struct tdata));

#ifdef FUNK_DEBUG_BUILD
  for (int i = 0; i < FUNK_MAX_POOL_SIZE; i++) {
    funk_global_memory_pool.data[i].data.i32 = 0;
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

void funk_get_element_in_matrix_ptr(struct tnode *src, struct tnode *dst,
                                    int32_t idx_0, int32_t idx_1) {
  TRACE("start");

  struct tnode tmp;
  idx_0 = (idx_0 < 0) ? LEN(src) + idx_0 : idx_0;
  idx_0 %= LEN(src);

  DEREF(&tmp, src, idx_0);


  idx_1 = (idx_1 < 0) ? tmp.len + idx_1 : idx_1;
  idx_1 %= tmp.len;

  struct tdata *data = NULL;
  data = DATA(&tmp, idx_1);
  funk_copy_node(dst, &tmp);
  dst->start += idx_1;
  dst->len = 1;
}
/*
void funk_get_element_in_matrix_2d_lit(struct tnode *src, struct tnode *dst,
                                       int32_t idx_0, int32_t idx_1) {
  TRACE("start");
  if (IS_PTR(src, 0)) {
    return funk_get_element_in_matrix_ptr(src, dst, idx_0, idx_1);
  }

  // negative indexes allow getting last elemets like in python
  uint32_t d0 = DIM(src, 0);
  uint32_t d1 = DIM(src, 1);

  if (d0 == 0 || d1 == 0) {
    printf("-E- %s Invalid dimensions %d x %d\n", __FUNCTION__, d0, d1);
    funk_print_node_info(src);
    exit(1);
  }

  idx_0 = (idx_0 < 0) ? d0 + idx_0 : idx_0;
  idx_1 = (idx_1 < 0) ? d1 + idx_1 : idx_1;

  idx_0 %= d0;
  idx_1 %= d1;

  // struct tdata * data = NULL;
  // data = DATA(src, d0* idx_0 + idx_1);

  funk_copy_node(dst, src);
  dst->start += d0 * idx_0 + idx_1;
  dst->len = 1;

  // funk_create_node(dst,
  //   1, function_pool,
  //   data->type, 0, (void *) &data->data);
}

void funk_get_element_in_matrix_2d_var(struct tnode *src, struct tnode *dst,
                                       struct tnode *node_i,
                                       struct tnode *node_j) {
  TRACE("start");

  if (DATA(node_i, 0)->type != type_i32) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_i, 0)->type);
  }

  if (DATA(node_j, 0)->type != type_i32) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_j, 0)->type);
  }

  int32_t idx_0 = DATA(node_i, 0)->data.i32;
  int32_t idx_1 = DATA(node_j, 0)->data.i32;

  funk_get_element_in_matrix_2d_lit(src, dst, idx_0, idx_1);
}
*/
void _dereference(struct tnode *dst, struct tpool *pool, uint32_t start,
                  int idx, int current_depth, const char *function, int line) {
  TRACE("start");

  int type = pool->data[(start + idx) % FUNK_MAX_POOL_SIZE].type;

  if (current_depth == 0) {
    printf("-E- %s max depth\n", __FUNCTION__);
    exit(1);
  }

  if (type == type_pointer_to_pool_entry || type == type_array) {

    _dereference(dst, pool,
                 pool->data[(start + idx) % FUNK_MAX_POOL_SIZE].data.i32, 0,
                 current_depth - 1, function, line);
  } else if (type == type_pool_node_entry) {

    dst->pool = pool;
    dst->start = pool->data[(start + idx + 0) % FUNK_MAX_POOL_SIZE].data.i32;
    dst->len = pool->data[(start + idx + 1) % FUNK_MAX_POOL_SIZE].data.i32;
    dst->dimension.count =
        pool->data[(start + idx + 2) % FUNK_MAX_POOL_SIZE].data.i32;
    dst->dimension.ptr_idx =
        pool->data[(start + idx + 3) % FUNK_MAX_POOL_SIZE].data.i32;

  } else {
    printf("-E- %s unknown type %d from %s +%d %s\n", __FUNCTION__, type,
           function, line, POOL_STR(pool));
    exit(1);
  }
}

int  funky_cmp_element_in_array_int(struct tnode *src, int idx, int value) {
  TRACE("start");
  VALIDATE_NODE(src);
  struct tnode dst;

    if (DATA(src, 0)->type != type_array){
      return 0;
    }

    struct tnode node_array;
    int pool_idx =  DATA(src, 0)->data.i32;
    _extract_tnode_from_pool(&node_array, pool_idx, src->pool);

    // negative indexes allow getting last elemets like in python
    idx = (idx < 0) ? node_array.len + idx : idx;
    idx %= MAX(1,node_array.len);


    struct tnode node;
    dst.start = node_array.start + idx;

    if  (DATA(&node_array, idx)->type == type_i32) {
      return (DATA(&node_array, idx)->data.i32 == value) ? 1 : 0;
    }

    return 0;
}


struct tnode funky_get_element_in_array(struct tnode *src, int idx)
{
    TRACE("start");
    VALIDATE_NODE(src);
    struct tnode dst;

    if (DATA(src, 0)->type != type_array){
      dst.start = src->start;
      dst.len = src->len;
      dst.pool = src->pool;
      return dst;
    }

    // negative indexes allow getting last elemets like in python

    struct tnode node_array;
    int pool_idx =  DATA(src, 0)->data.i32;
    _extract_tnode_from_pool(&node_array, pool_idx, src->pool);

    idx = (idx < 0) ? node_array.len + idx : idx;
    idx %= MAX(1,node_array.len);


    struct tnode node;
    dst.start = node_array.start + idx;

    switch  (DATA(&node_array, idx)->type)
    {
      case type_i32:
      case type_d64:
        dst.len = 1;
        break;
      case type_empty_array:
        dst.len = 0;
        break;
      case type_array:
      {
        int node_entry_idx = DATA(&node_array, idx)->data.i32;
        dst.len = node_array.pool->data[(node_entry_idx+1) % FUNK_MAX_POOL_SIZE].data.i32;
      }
        break;
      case type_pool_node_entry:
        dst.len = DATA(&node_array, idx+1)->data.i32;
        break;
      default:
        ERROR("wtf");
    }

    dst.pool = src->pool;
    dst.dimension.ptr_idx = 0;
    dst.dimension.count = 0;
    return dst;

}

void funk_get_element_in_array(struct tnode *src, struct tnode *dst, int idx) {
    TRACE("start");
    VALIDATE_NODE(src);

    if (DATA(src, 0)->type != type_array){
      dst->start = src->start;
      dst->len = src->len;
      dst->pool = src->pool;
      return;
    }

    // negative indexes allow getting last elemets like in python

    struct tnode node_array;
    int pool_idx =  DATA(src, 0)->data.i32;
    _extract_tnode_from_pool(&node_array, pool_idx, src->pool);

    idx = (idx < 0) ? node_array.len + idx : idx;
    idx %= MAX(1,node_array.len);


    struct tnode node;
    dst->start = node_array.start + idx;

    switch  (DATA(&node_array, idx)->type)
    {
      case type_i32:
      case type_d64:
        dst->len = 1;
        break;
      case type_empty_array:
        dst->len = 0;
        break;
      case type_array:
      {
        int node_entry_idx = DATA(&node_array, idx)->data.i32;
        dst->len = node_array.pool->data[(node_entry_idx+1) % FUNK_MAX_POOL_SIZE].data.i32;
      }
        break;
      case type_pool_node_entry:
        dst->len = DATA(&node_array, idx+1)->data.i32;
        break;
      default:
        ERROR("wtf");
    }

    dst->pool = src->pool;
    dst->dimension.ptr_idx = 0;
    dst->dimension.count = 0;

}

void funk_get_element_in_array_var(struct tnode *src, struct tnode *dst,
                                   struct tnode *node_i) {
  TRACE("start");
  if (DATA(node_i, 0)->type != type_i32) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_i, 0)->type);
  }

  int32_t idx_0 = DATA(node_i, 0)->data.i32;

  funk_get_element_in_array(src, dst, idx_0);
}

void add_node_to_nodelist(struct tnode *list, struct tnode *node,
                          struct tnode *idx_node, uint32_t list_len) {
  TRACE("start");

  VALIDATE_NODE(node);
  VALIDATE_NODE(idx_node);

  int32_t idx = DATA(idx_node, 0)->data.i32;

  uint32_t k = 0;
  for (uint32_t i = idx; (k < LEN(node)) && (i < list_len); i++) {

    struct tnode *l = (list + i);
    l->pool = node->pool;

    l->start = node->start + k;
    LEN(l) = 1;
    SET_DIM_COUNT(l, 1);

    SET_DIM_POOL_IDX(l, GET_DIM_POOL_IDX(node));

    DATA(idx_node, 0)->data.i32 += 1;
    k++;
  }
}

void funk_create_d64_scalar(enum pool_types pool, struct tnode *dst,
                               double val) {
  TRACE("start");
  funk_create_node(dst, 1, pool, type_d64, 0, (void *)&val);
  VALIDATE_NODE(dst);
}

void funk_create_i32_scalar(enum pool_types pool, struct tnode *dst,
                            int32_t val) {
  TRACE("start");

  funk_create_node(dst, 1, pool, type_i32, 0, (void *)&val);
  VALIDATE_NODE(dst);
}

void funk_get_element_in_list_of_regs(struct tnode *dst, struct tnode *src,
                                      uint32_t i) {
  TRACE("start");
  funk_get_element_in_array(src, dst, i);

  TRACE("end");
}

uint32_t _copy_node_to_pool(struct tnode *src) {
  TRACE("start");
  uint32_t idx =
      _funk_alloc_raw_tdata(src->pool, POOL_ENTRY_LEN, type_pool_node_entry);

  struct tnode tmp;
  // funk_deep_copy_node(&tmp, src);
  src->pool->data[idx % FUNK_MAX_POOL_SIZE].data.i32 = src->start;
  src->pool->data[(idx + 1) % FUNK_MAX_POOL_SIZE].data.i32 = src->len;
  src->pool->data[(idx + 2) % FUNK_MAX_POOL_SIZE].data.i32 = src->dimension.count;
  src->pool->data[(idx + 3) % FUNK_MAX_POOL_SIZE].data.i32 =
      src->dimension.ptr_idx;

  return idx;
}

void funk_create_list_of_regs(struct tnode *dst, struct tnode *list,
                              int32_t size) {
  TRACE("start");
  // Check that all of the nodes in list are in the same pool, and use that pool

  enum pool_types pool_type = get_pool_enum(list[0].pool);

  struct tnode tmp;
  funk_create_node(&tmp, size, pool_type, type_array, 0, NULL);

  for (int32_t i = 0; i < size; i++) {
   /* if (list[i].len > 1 || DATA(list+i,0)->type == type_array) {

      // if this node contains other nodes then save the node
      // in the pool and create a pointer to the position in
      // the pool to where this node node lives

      DATA_NO_CHECK(&tmp, i)->type = type_array;
      DATA_NO_CHECK(&tmp, i)->data.i32 = _copy_node_to_pool(&list[i]);

  } else {*/
      // careful not to copy the pool_wrap count
      DATA_NO_CHECK(&tmp, i)->type = DATA(&list[i], 0)->type;
      DATA_NO_CHECK(&tmp, i)->data = DATA(&list[i], 0)->data;
   // }
  }

  funk_create_node(dst, 1, pool_type, type_array, 0, NULL);
  dst->len = tmp.len;

  DATA_NO_CHECK(dst, 0)->data.i32 = _copy_node_to_pool(&tmp);

}

void funk_create_list_i32_literal(enum pool_types pool_type, struct tnode *dst,
                                  int32_t *list, int32_t size) {
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_i32, 0, (void *)list);
}

void funk_create_list_double_literal(enum pool_types pool_type,
                                     struct tnode *dst, double *list,
                                     int32_t size) {
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_d64, 0, (void *)list);
}

void funk_print_scalar_element(struct tdata n) {
  TRACE("start");

  switch (n.type) {
  case type_i32:
    printf("%d ", n.data.i32);
    break;
  case type_d64:
    printf("%5.5f", n.data.d64);
    break;
  case type_empty_array:
    printf("%5s", "[]");
    break;
  case type_function:
    printf("<function> %p", n.data.fn);
    break;
  case type_pointer_to_pool_entry:
    printf("*-> %d", n.data.i32);
    break;
  case type_pool_node_entry:
    printf("* %d", n.data.i32);
    break;
  case type_array:
    printf("[type_array]");
    break;
  default:
    printf("%5d?", n.type);
  }
  TRACE("\nend");
}

void funk_get_node_type(struct tnode *node, uint32_t offset,
                        unsigned char *type) {
  TRACE("start");

  if (LEN(node) > 0 && offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  *type = DATA(node, offset)->type;

  TRACE("end");
}

void funk_set_node_type(struct tnode *node, uint32_t offset,
                        enum funk_types type) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type;
}

void funk_increment_node_data_int(struct tnode *node) {
  TRACE("start");
  DATA(node, 0)->data.i32++;
}

void funk_copy_node_into_node_list(struct tnode *dst_list, struct tnode *src,
                                   struct tnode *idx_node) {
  TRACE("start");
  // VALIDATE_NODE(src);
  int32_t idx = DATA(idx_node, 0)->data.i32;

  funk_copy_node(&dst_list[idx], src);
}

void funk_set_node_value_int(struct tnode *node, uint32_t offset,
                             uint32_t value) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type_i32;
  DATA(node, offset)->data.i32 = value;

  TRACE("\nend");
}


void funk_set_node_value_double(struct tnode *node, uint32_t offset,
                                double value) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type_d64;
  DATA(node, offset)->data.d64 = value;
}

int32_t funk_get_node_value_int(struct tnode *node, uint32_t offset) {
  TRACE("start");
  if (offset > LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  return DATA(node, offset)->data.i32;
}

void funk_print_pool(enum pool_types pool_type, int begin, int len) {
  TRACE("start");
  struct tpool *pool = get_pool_ptr(pool_type);
  printf("tail @: %d\n", pool->tail);
  for (int i = begin; i < begin + len; i++) {

    printf("%d(%d):", i, pool->data[i].wrap_creation);
    funk_print_scalar_element(pool->data[i]);
    printf("  ");
    if (i > 0 && (i + 1) % 7 == 0)
      printf("\n");
  }
  printf("\n");
}

void funk_get_next_node(struct tnode *dst, struct tnode *n) {
  TRACE("start");
  VALIDATE_NODE(n);

  funk_copy_node(dst, n);

  LEN(dst) = LEN(n) - 1;

  if (LEN(dst) == 0) {
    funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
  } else {
    dst->start = n->start + 1;
  }
  // CHECK_TYPES(dst);
}

void funk_debug_function_entry_hook(char *function_name, struct tnode *inputs,
                                    int arity) {
  TRACE("start");
  MEM_USAGE(function_name);
  snprintf(gCurrentFunction,MAX_NAME_SZ,"%s", function_name);

}

void funk_debug_function_exit_hook(const char *function_name,
                                   struct tnode *retval) {
  TRACE("start");

}

void funk_mul(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_d64) {
    *((double *)x) = (double)(*(double *)a) * (double)(*(double *)b);
  } else if (type == type_i32) {
    *((int *)x) = (int)(*(int *)a) * (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_div(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_d64) {
    *((double *)x) = (double)(*(double *)a) / (double)(*(double *)b);
  } else if (type == type_i32) {
    *((int *)x) = (int)(*(int *)a) / (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_add(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_d64) {
    *((double *)x) = (double)(*(double *)a) + (double)(*(double *)b);
  } else if (type == type_i32) {
    *((int *)x) = (int)(*(int *)a) + (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sub(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_d64) {
    *((double *)x) = (double)(*(double *)a) - (double)(*(double *)b);
  } else if (type == type_i32) {
    *((int *)x) = (int)(*(int *)a) - (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_mod(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  *((int *)x) = (int)(*(int *)a) % (int)(*(int *)b);
}

void funk_slt(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) = ((double)(*(double *)a) < (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) < (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sgt(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) = ((double)(*(double *)a) > (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) > (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sge(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) = ((double)(*(double *)a) >= (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) >= (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_eq(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) = ((double)(*(double *)a) == (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) == (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_ne(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) = ((double)(*(double *)a) != (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) != (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_or(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) =
        ((double)(*(double *)a) != 0.0 || (double)(*(double *)b) != 0.0) ? 1
                                                                         : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) != 0 || (int)(*(int *)b) != 0) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_and(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_d64) {
    *((int *)x) =
        ((double)(*(double *)a) != 0.0 && (double)(*(double *)b) != 0.0) ? 1
                                                                         : 0;
  } else if (type == type_i32) {
    *((int *)x) = ((int)(*(int *)a) != 0 && (int)(*(int *)b) != 0) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void _print_arith_op(void (*f)(void *, void *, void *, enum funk_types)) {
  if (f == funk_mul) {
    printf(" * ");
  } else if (f == funk_div) {
    printf(" / ");
  } else if (f == funk_add) {
    printf(" + ");
  } else if (f == funk_sub) {
    printf(" - ");
  } else if (f == funk_mod) {
    printf(" mod ");
  } else if (f == funk_slt) {
    printf(" < ");
  } else if (f == funk_sgt) {
    printf(" > ");
  } else if (f == funk_sge) {
    printf(" >= ");
  } else if (f == funk_eq) {
    printf(" == ");
  } else if (f == funk_ne) {
    printf("!= ");
  } else if (f == funk_or) {
    printf(" or ");
  } else if (f == funk_and) {
    printf(" and ");
  } else {
    printf("Unknown arith operation\n");
  }
}

void _funk_arith_op_rr(struct tnode *node_r, uint32_t r_offset,
                       struct tnode *node_a, struct tnode *node_b,
                       void (*f)(void *, void *, void *, enum funk_types)) {
  TRACE("start");

  VALIDATE_NODE(node_a);
  VALIDATE_NODE(node_b);
  VALIDATE_NODE(node_r);

  struct tdata a = *DATA(node_a, 0);
  struct tdata b = *DATA(node_b, 0);
  struct tdata *r = DATA(node_r, r_offset);

  unsigned char t1 = a.type;
  unsigned char t2 = b.type;

  if (t2 == type_empty_array)
    t2 = type_i32;

  if (t1 == type_empty_array)
    t1 = type_i32;

  if (t1 == type_i32 && t2 == type_i32) {
    f((void *)&r->data.i32, (void *)&a.data.i32, (void *)&b.data.i32, type_i32);
    r->type = type_i32;

  } else if (t1 == type_d64 && t2 == type_d64) {
    f((void *)&r->data.d64, (void *)&a.data.d64, (void *)&b.data.d64, type_d64);
    r->type = type_d64;

  } else if (t1 == type_d64 && t2 == type_i32) {
    f((void *)&r->data.d64, (void *)&a.data.d64, (void *)&b.data.i32, type_d64);
    r->type = type_d64;

  } else if (t1 == type_i32 && t2 == type_d64) {
    f((void *)&r->data.d64, (void *)&a.data.i32, (void *)&b.data.d64, type_d64);
    r->type = type_d64;

  } else {

    ERROR("Invalid types")
    printf("-E- %s: invalid types: ", __FUNCTION__);
    _print_arith_op(f);
    printf("\n");
    funk_print_type(t1);
    printf(" , ");
    funk_print_type(t2);
    printf("\n");
    exit(1);

    r->type = type_invalid;
  }


}

void funk_arith_op_rr(struct tnode *r, struct tnode *a, struct tnode *b,
                      void (*f)(void *, void *, void *, enum funk_types)) {



  if (DATA(b,0)->type == type_empty_array){
    funk_copy_node(r,a);
    return;
  }

 /* if (DATA(a,0)->type == type_empty_array){
    funk_copy_node(r,b);
    return;
  }*/

  if (LEN(a) != LEN(b)) {
    ERROR("length mismatch");
    printf("'%s' length mismatch %d != %d !\n", __FUNCTION__, LEN(a), LEN(b));
    funk_print_node(a);
    printf("\n");
    funk_print_node(b);
    exit(1);
  }

  if (DATA(a,0)->type == type_i32 || DATA(a,0)->type == type_d64){
    funk_create_node(r, 1, get_pool_enum(a->pool), type_i32, 0, NULL);
    _funk_arith_op_rr(r, 0, a, b, f);
    return;
  }

  funk_create_node(r, LEN(a), get_pool_enum(a->pool), type_array, 0, NULL);

  struct tnode node;
  struct tnode list_of_regs[LEN(a)];

  for (uint32_t i = 0; i < LEN(a); i++) {


    struct tnode tmp_a, tmp_b;
    funk_get_element_in_array(a, &tmp_a, i);
    funk_get_element_in_array(b, &tmp_b, i);

      if (DATA(&tmp_a,0 )->type == type_array || DATA(&tmp_b, 0)->type == type_array) {
        struct tnode row;
        funk_create_node(list_of_regs+i, tmp_a.len, get_pool_enum(a->pool), type_i32, 0, NULL);
        funk_arith_op_rr(list_of_regs+i, &tmp_a, &tmp_b,f);

      } else {
        funk_create_node(list_of_regs+i, 1, get_pool_enum(a->pool), type_i32, 0, NULL);
        _funk_arith_op_rr(list_of_regs+i, 0, &tmp_a, &tmp_b, f);
      }

    }
    funk_create_list_of_regs(r,list_of_regs,LEN(a));


}

void funk_mul_rr(struct tnode *r, struct tnode *a, struct tnode *b) {
  TRACE("start");

  funk_arith_op_rr(r, a, b, funk_mul);
}

void funk_add_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");

  funk_arith_op_rr(r, a, b, funk_add);
}

void funk_sub_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");

  funk_arith_op_rr(r, a, b, funk_sub);
}

void funk_div_rr(struct tnode *r, struct tnode *a, struct tnode *b) {
  TRACE("start");

  funk_arith_op_rr(r, a, b, funk_div);
}

void funk_mod_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_mod);
}

void funk_or_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_or);
}

void funk_and_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_and);
}

void funk_ne_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_eq_rr(r, a, b);
  DATA(r,0)->data.i32 = (DATA(r,0)->data.i32 == 0) ? 1 : 0;
}

void funk_eq_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  struct tnode tmp1;
  if ((DATA(a,0)->type != DATA(b,0)->type) ||
      (a->len > 0 && b->len >0 && a->len != b->len)){
    funk_create_node(r, 1, get_pool_enum(a->pool), type_i32, 0, NULL);
    return;
  }
  funk_arith_op_rr(&tmp1, a, b, funk_eq);
  struct tnode tmp2;
  funk_flatten(&tmp2, &tmp1);


  funk_create_node(r, 1, get_pool_enum(a->pool), type_i32, 0, NULL);
  DATA(r, 0)->data.i32 = 1;

  for (uint32_t i = 0; i < tmp2.len; i++) {
    struct tnode e = funky_get_element_in_array(&tmp2,i);
    if (DATA(&e,0)->data.i32 != 1 && DATA(&e,0)->type != type_empty_array) {
      DATA(r, 0)->data.i32 = 0;
      break;
    }
  }
}

void funk_add_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;
  // TODO: maybe create a smaller pool for this?
  funk_create_d64_scalar(function_pool, &node_b, value);

  funk_arith_op_rr(node_r, node_a, &node_b, funk_add);
}

void funk_ne_ri(struct tnode *node_r, struct tnode *node_a, int32_t value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_i32_scalar(function_pool, &node_b, value);

  funk_arith_op_rr(node_r, node_a, &node_b, funk_ne);
}

void funk_sub_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sub);
}

void funk_mod_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mod);
}

void funk_add_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_add);
}

void funk_div_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_div);
}

void funk_mul_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mul);
}

void funk_sub_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_d64_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sub);
}

void funk_mul_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_d64_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mul);
}

void funk_slt_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_slt);
}

void funk_slt_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_slt);
}

void funk_sgt_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_sgt);
}

void funk_flt_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_d64_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_slt);
}

void funk_sgt_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sgt);
}

void funk_sge_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sge);
}

void funk_sge_rr(struct tnode *r, struct tnode *a, struct tnode *b) {
  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_sge);
}

void funk_eq_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_i32_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_eq);
}

void funk_print_dimension(struct tnode *n) {
  TRACE("start");
  printf("( ");
  for (uint32_t i = 0; i < DIM_COUNT(n); i++) {
    printf("%d ", DIM(n, i));
  }
  printf(")");
}

int __get_len(struct tnode *src){
  if (DATA(src,0)->type == type_array){
        struct tnode node_array;
       int pool_idx =  DATA(src, 0)->data.i32;
       _extract_tnode_from_pool(&node_array, pool_idx, src->pool);
       return node_array.len;
  } else {
    return src->len;
  }
}

void funky_print_node(struct tnode src ){
  fflush(stdout);
  switch (DATA(&src,0)->type){
    case type_array:
    {
       struct tnode node_array;
       int pool_idx =  DATA(&src, 0)->data.i32;
       _extract_tnode_from_pool(&node_array, pool_idx, src.pool);
       printf("[");

       for (int j = 0; j < node_array.len; j++){
         struct tnode tmp;
         tmp.start = node_array.start + j;
         tmp.len = 1;
         tmp.pool = node_array.pool;
         funky_print_node(tmp);
         if (j+1 < node_array.len) printf(", ");
       }
       printf("]");
       break;
    }
    case type_empty_array:
      printf(" [] ");
      break;
    case type_pool_node_entry:
      break;

    default:
      for (uint32_t i = 0; i < src.len; i++) {
        funk_print_scalar_element(*DATA(&src, i));

      }
  }
   fflush(stdout);
}

void __funk_print_node(struct tnode n_) {
  funky_print_node(n_);

}

void funk_print_node(struct tnode * n){
  __funk_print_node(*n);

}
float funk_ToFloat(struct tnode *n) {
  TRACE("start");
  if (DATA(n, 0)->type == type_i32) {
    return (float)DATA(n, 0)->data.i32;
  } else if (DATA(n, 0)->type == type_d64) {
    return (float)DATA(n, 0)->data.d64;
  } else {
    DATA(n, 0)->type = type_invalid;
    printf("ERROR %s", __FUNCTION__);
    exit(1);
    return 0.0f;
  }
}

void funk_read_list_from_file(enum pool_types pool_type, struct tnode *dst,
                              char *path) {
  TRACE("start");

  struct tpool *pool = get_pool_ptr(pool_type);
  FILE *fp;
  fp = fopen(path, "rt");

  if (fp == NULL) {
    printf("-E- File '%s' cannot be read\n", path);
    exit(1);
  }
  int value = 0;
  int count = 0;
  funk_create_node(dst, 0, pool_type, type_i32, 0, NULL);

  while (fscanf(fp, "%d", &value) == 1) {
    DATA(dst, count)->data.i32 = value;
    DATA(dst, count)->type = type_i32;
    SET_WRAP_CREATION(dst, count, pool->wrap_count);
    INC_TAIL(pool);
    count++;
  }

  LEN(dst) = count;
  fclose(fp);
}

void funk_get_len(struct tnode *dst, struct tnode *src) {
  TRACE("start");

  if (DATA(src, 0)->type == type_empty_array){
    funk_create_i32_scalar(function_pool, dst, 0);
    return;
  }
  /*if (DATA(src, 0)->type == type_array){
    struct tnode node_array;
    int pool_idx =  DATA(src, 0)->data.i32;
    _extract_tnode_from_pool(&node_array, pool_idx, src->pool);
    funk_create_i32_scalar(function_pool, dst, node_array.len);
    return;
  }*/
  funk_create_i32_scalar(function_pool, dst, src->len);
}

void funk_get_extended_len(struct tnode *dst, struct tnode *src){
  TRACE("start");
  funk_get_len(dst, src);
  return;
  printf("%d ?????\n", src->len);
  funk_print_node(src);
  if (LEN(src) == 1 && IS_PTR(src,0)){
    struct tnode tmp;
    DEREF(&tmp,src,0);

    funk_get_len(dst, &tmp);

  } else {
    funk_get_len(dst, src);
  }

}

void funk_create_sub_matrix_lit_indexes(struct tnode *src, struct tnode *dst,
                                        int32_t r1, int32_t r2, int32_t c1,
                                        int32_t c2) {
  TRACE("start");

  enum pool_types pool = get_pool_enum(src->pool);

  if (r1 > r2) {
    printf("%s Error r1 (%d) > r2 (%d)\n", __FUNCTION__, r1, r2);
    exit(1);
  }

  if (c1 > c2) {
    printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__, c1, c2);
    exit(1);
  }

  int32_t n = abs((r2 - r1) + 1);
  int32_t m = abs((c2 - c1) + 1);

  funk_create_node(dst, n, pool, type_pointer_to_pool_entry, 0, NULL);

  for (int i = r1, new_i = 0; i <= r2 && new_i < n; i++, new_i++) {
    int idx_i = (i < 0) ? i + 5 : i;
    // idx_i = 50;
    //  printf("src->len = %d idx_i = %d\n", src->len, idx_i);
    struct tnode current_row;
    funk_get_element_in_array(src, &current_row, idx_i);


    struct tnode new_column;
    funk_create_node(&new_column, m, pool, type_pointer_to_pool_entry, 0, NULL);

    for (int j = c1, new_j = 0; j <= c2 && new_j < m; j++, new_j++) {
      struct tnode element;
      int idx_j = (j < 0) ? j + current_row.len : j;
      idx_j %= current_row.len;
      funk_get_element_in_array(&current_row, &element, idx_j);
      DATA(&new_column, new_j)->data = DATA(&element, 0)->data;
      DATA(&new_column, new_j)->type = DATA(&element, 0)->type;
    }
    DATA_NO_CHECK(dst, new_i)->type = type_pointer_to_pool_entry;
    DATA_NO_CHECK(dst, new_i)->data.i32 = _copy_node_to_pool(&new_column);
  }
}

void funk_create_sub_matrix(struct tnode *src, struct tnode *dst,
                            struct tnode *R1, struct tnode *R2,
                            struct tnode *C1, struct tnode *C2) {
  TRACE("start");

  int32_t r1 = DATA(R1, 0)->data.i32;
  int32_t r2 = DATA(R2, 0)->data.i32;
  int32_t c1 = DATA(C1, 0)->data.i32;
  int32_t c2 = DATA(C2, 0)->data.i32;

  funk_create_sub_matrix_lit_indexes(src, dst, r1, r2, c1, c2);
}

void funk_create_sub_array_lit_indexes(struct tnode *src, struct tnode *dst,
                                       int32_t c1, int32_t c2) {
  TRACE("start");
  c1 = (c1 < 0) ? c1 + LEN(src) : c1;
  c2 = (c2 < 0) ? c2 + LEN(src) : c2;

  if (c1 > c2) {
    printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__, c1, c2);
    exit(1);
  }

  int32_t n = abs((c2 - c1) + 1);
  MEM_USAGE(__FUNCTION__);
  struct tnode *list = (struct tnode *)malloc(sizeof(struct tnode) * n);
  int k = 0;

  // struct tnode node;
  // funk_create_node(&node, 1, function_pool, type_i32, 0, NULL);

  for (int j = c1; j <= c2; j++) {

    int idx_j = j % LEN(src);

    // list[k] = DATA(src,idx_j)->data.i32;

    funk_get_element_in_array(src, list + k, idx_j);

    k++;
  }

  funk_create_list_of_regs(dst, list, n);

  // funk_create_list_i32_literal(global_pool,  dst, list, n );
  free(list);
}

void funk_create_sub_array(struct tnode *src, struct tnode *dst,
                           struct tnode *i, struct tnode *j) {
  TRACE("start");

  int32_t c1 = DATA(i, 0)->data.i32;
  int32_t c2 = DATA(j, 0)->data.i32;

  funk_create_sub_array_lit_indexes(src, dst, c1, c2);
}

uint32_t _funk_set_node_dimensions(struct tnode *src, enum pool_types pool,
                                   uint32_t dim, uint32_t *dimensions,
                                   uint32_t dim_count, uint32_t offset) {
  TRACE("start");
  struct tnode new_column;

  uint32_t n = dimensions[dim];
  // printf("\nLEN %d offset %d, n = %d dim = %d\n\n", LEN(src), offset, n,
  // dim);
  funk_create_node(&new_column, n, pool, type_pointer_to_pool_entry, 0, NULL);
  for (uint32_t j = 0; j < n; j++) {

    if (dim + 1 < dim_count) {
      DATA(&new_column, j)->type = type_pointer_to_pool_entry;
      DATA(&new_column, j)->data.i32 =
          _funk_set_node_dimensions(src, pool, dim + 1, dimensions, dim_count,
                                    offset + j * dimensions[dim + 1]);
    } else {

      DATA(&new_column, j)->type = DATA(src, offset + j)->type;
      DATA(&new_column, j)->data.i32 = DATA(src, offset + j)->data.i32;
      // printf("er[%d] %d %d\n",offset+j, DATA(src, offset + j)->data.i32,
      // DATA(&new_column, j)->type);
    }
  }

  return _copy_node_to_pool(&new_column);
}

void _extract_tnode_from_pool(struct tnode *dst, uint32_t start,
                              struct tpool *pool) {
  TRACE("start");

  dst->pool = pool;
  dst->start = pool->data[(start + 0) % FUNK_MAX_POOL_SIZE].data.i32;
  dst->len = pool->data[(start + 1) % FUNK_MAX_POOL_SIZE].data.i32;
  dst->dimension.count = pool->data[(start + 2) % FUNK_MAX_POOL_SIZE].data.i32;
  dst->dimension.ptr_idx = pool->data[(start + 3) % FUNK_MAX_POOL_SIZE].data.i32;
}
void _flatten(struct tnode *dst, struct tnode *src, uint32_t offset) {

  if (DATA(src,0)->type == type_array){

    for (uint32_t i = 0; i < LEN(src); i++) {
      struct tnode row;
      funk_get_element_in_array(src, &row, i);
      _flatten(dst, &row, offset + i * row.len);
    }
  } else {
      DATA_NO_CHECK(dst,offset)->type = DATA(src, 0)->type;
      DATA_NO_CHECK(dst, offset)->data = DATA(src, 0)->data;
      SET_WRAP_CREATION(dst, offset , dst->pool->wrap_count);
      INC_TAIL(dst->pool);

      dst->len++;
  }

}

void funk_flatten(struct tnode *dst, struct tnode *src) {

if (DATA(src,0)->type != type_array){
  dst->pool = src->pool;
  dst->start = src->start;
  dst->len= src->len;
  return;
}

  struct tnode row;
  struct tnode node;
  funk_create_node(&node, 1, get_pool_enum(src->pool), type_array, 0, NULL);

  dst->len = 0;
  int offset =0;
  for (uint32_t i = 0; i < LEN(src); i++) {
    funk_get_element_in_array(src, &row, i);
    // printf("%d ", i*row.len);
    _flatten(&node, &row, offset);
    offset = node.len-1;
  }
  node.len--;

  funk_create_node(dst, 0, get_pool_enum(src->pool), type_array, 0, NULL);
  DATA(dst, 0)->data.i32 = _copy_node_to_pool(&node);
  dst->len = node.len;



}

void funk_set_node_dimensions(struct tnode *dst, uint32_t *dimensions,
                              uint32_t dim_count) {
  TRACE("start");
  if (dimensions == NULL)
    return;

  enum pool_types pool = get_pool_enum(dst->pool);

  _extract_tnode_from_pool(
      dst, _funk_set_node_dimensions(dst, pool, 0, dimensions, dim_count, 0),
      dst->pool);

  return;
}

void reshape(struct tnode *dst, uint32_t *dimensions, uint32_t dim_count) {
  TRACE("start");

  if (DATA(dst, 0)->type == type_empty_array) {
    return;
  }

  funk_set_node_dimensions(dst, dimensions, dim_count);
}

double rand_double(double lower, double upper) {
  TRACE("start");
  return (((double)rand() / (double)(RAND_MAX)) * (upper - lower)) + lower;
}

void funk_create_empty_list_element(enum pool_types pool_type,
                                    struct tnode *dst) {
  TRACE("start");
  funk_create_node(dst, 0, pool_type, type_empty_array, 0, NULL);
  dst->len = 0;
}

void funky_print_type(struct tnode n){
  switch (DATA(&n,0)->type){
    case type_array: printf(" [%d..%d] ", 0, n.len); break;
    case type_empty_array: printf(" [] "); break;
    case type_i32: printf(" i32 "); break;
    case type_d64: printf(" d64 "); break;
    case type_function: printf( " fn "); break;
    default: printf( " internal "); break;
  }
}

struct tnode funky_pop_first(struct tnode *dst, struct tnode *src){
  //create dst outside of fn
  if (DATA(src,0)->type == type_i32 && src->len == 1){

    return *src;
  } else if (DATA(src,0)->type == type_array && src->len >= 1){

    // create a new node to honor the read-only properties
    // of the pool
    struct tnode node_regs[src->len];
    for (int i = 0; i < src->len; i++){
      node_regs[i] = funky_get_element_in_array(src,i);
    }

    struct tnode ret_val = node_regs[0];
    if (src->len > 1){
      funk_create_list_of_regs(dst,node_regs+1,src->len-1);
    } else {
      funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
    }


/*
    struct tnode new_node;
    _extract_tnode_from_pool(&new_node, DATA(src,0)->data.i32,src->pool);
    struct tnode ret_val = funky_get_element_in_array(src,0);

    new_node.len--;
    new_node.start = ((new_node.start + 1) % FUNK_MAX_POOL_SIZE);


    DATA_NO_CHECK(dst, 0)->data.i32 = _copy_node_to_pool(&new_node);
    dst->len = src->len-1;
     DATA(dst,0)->type = (new_node.len <= 0) ? type_empty_array: type_array;


  printf("WWWWWWWW{\n");
  funk_print_node(&ret_val);
  printf("}WWWWWWWW\n");*/
    return ret_val;

  } else if (DATA(src,0)->type == type_empty_array){
    return *src;
  } else {
    struct tnode ret_val;
    ret_val.pool = src->pool;

    ret_val.len = 0;
    DATA(&ret_val,0)->type = type_empty_array;
    return ret_val;
  }

}
/**
  [A] <~ e
**/

struct tnode funk_append_element_to_list(struct tnode *L,
                                 struct tnode *R) {
  TRACE("start");
 struct tnode dst;
  VALIDATE_NODE(L);
  VALIDATE_NODE(R);

  // if (DATA(L, 0)->type == type_empty_array){
  //   funk_copy_node(dst,R);
  //   return;
  // }

  if (DATA(L, 0)->type == type_empty_array &&
      DATA(R, 0)->type == type_empty_array) {
    funk_create_node(&dst, 1, function_pool, type_empty_array, 0, NULL);
    printf("funk_prepend_element_to_list [] , [] -> []\n");
    return dst;
  }

  
  struct tnode new_array[L->len+1];
  new_array[L->len] = *R;
  for (int i = 0; i < L->len; i++){
      struct tnode element;
      new_array[i] = funky_get_element_in_array(L,i);
      
  }
  funk_create_list_of_regs(&dst, new_array, L->len+1);
  return dst;
}
/*
  x ~> [A]
*/
void funk_prepend_element_to_list(struct tnode *dst, struct tnode *L,
                                  struct tnode *R) {
  TRACE("start");

  VALIDATE_NODE(L);
  VALIDATE_NODE(R);

  if (DATA(L, 0)->type == type_empty_array){
    funk_copy_node(dst,R);
    return;
  }

  if (DATA(L, 0)->type == type_empty_array &&
      DATA(R, 0)->type == type_empty_array) {
    funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
    printf("funk_prepend_element_to_list [] , [] -> []\n");
    return;
  }

  
  struct tnode new_array[R->len+1];
  new_array[0] = *L;
  for (int i = 0; i < R->len; i++){
      struct tnode element;
      new_array[i+1] = funky_get_element_in_array(R,i);
      
  }
  funk_create_list_of_regs(dst, new_array, R->len+1);

  
}

/*
  x <~ [A]
*/
void funk_copy_first_element_from_list(struct tnode *dst, struct tnode *src){
  TRACE("start");
  funk_create_node(dst, 1, get_pool_enum(src->pool), type_empty_array, 0, NULL);

  struct tnode tmp;
  funk_get_element_in_array(src,&tmp, 0);
  funk_copy_node(dst,&tmp);
 
}

struct tnode funk_concatenate_lists(struct tnode *L,
                            struct tnode *R) {
  TRACE("start");

  struct tnode dst;

  VALIDATE_NODE(L);
  VALIDATE_NODE(R);

  if (DATA(L, 0)->type == type_empty_array &&
      DATA(R, 0)->type == type_empty_array) {
    funk_create_node(&dst, 1, get_pool_enum(L->pool), type_empty_array, 0, NULL);

    return dst;
  }

  if (DATA(R, 0)->type == type_empty_array) {
        funk_copy_node(&dst, L);

        return dst;
  }

  if (DATA(L, 0)->type == type_empty_array ) {
    funk_copy_node(&dst, R);

    return dst;
  }

  struct tnode node;
  funk_create_node(&node,
                   ((DATA(L, 0)->type == type_empty_array) ? 0 : LEN(L)) +
                       ((DATA(R, 0)->type == type_empty_array) ? 0 : LEN(R)),
                   get_pool_enum(L->pool), type_array, 0, NULL);

  uint32_t k = 0;

  for (uint32_t i = 0; i < LEN(L); i++) {
    struct tnode tmp;
    funk_get_element_in_array(L , &tmp, i);
    if (DATA(&tmp, 0)->type == type_empty_array)
      break;

    DATA(&node, k)->type = DATA(&tmp, 0)->type;
    DATA(&node, k)->data = DATA(&tmp, 0)->data;

    k++;
  }

  for (uint32_t i = 0; i < LEN(R); i++) {
    struct tnode tmp;
    funk_get_element_in_array(R , &tmp, i);
    if (DATA(&tmp, 0)->type == type_empty_array)
      break;

    DATA(&node, k)->type = DATA(&tmp, 0)->type;
    DATA(&node, k)->data = DATA(&tmp, 0)->data;

    k++;
  }

  funk_create_node(&dst, 1, get_pool_enum(L->pool), type_array, 0, NULL);
  DATA_NO_CHECK(&dst, 0)->data.i32 = _copy_node_to_pool(&node);
  dst.len = node.len;


  return dst;
}

uint32_t funk_get_node_start(struct tnode *n) {
  TRACE("start");
  VALIDATE_NODE(n);
  return n->start;
}

enum pool_types funk_get_node_pool(struct tnode *n) {
  TRACE("start");
  VALIDATE_NODE(n);
  enum pool_types pool_type;

  if (n->pool == &funk_global_memory_pool) {
    return global_pool;
  } else if (n->pool == &funk_functions_memory_pool) {
    return function_pool;
  } else {
    printf("-E- %s Invalid pool\n", __FUNCTION__);
    exit(1);
  }

  return pool_type;
}

void funk_set_tnode_array_elementEX(struct tnode *tnode_list,
                                    struct tnode *iterator_reg,
                                    struct tnode *value_reg, uint32_t len) {
  TRACE("start");

  uint32_t i = DATA(iterator_reg, 0)->data.i32;

  if (i >= len) {
    printf("-E- %s Index %d out of range [0:%d]\n", __FUNCTION__, i, len);
  }
  tnode_list[i] = *value_reg;
}

struct tnode *funk_alloc_list_of_tnodes(struct tnode *reg_len) {
  TRACE("start");
  uint32_t len = DATA(reg_len, 0)->data.i32;

  MEM_USAGE(__FUNCTION__);
  return (struct tnode *)malloc(len * sizeof(struct tnode));
}


struct tnode funky_get_element_range(unsigned int level, struct tnode * node, int * start, int * end, int * is_range){
         struct tnode result;

            if (level-1 == 0){
                if (*is_range == 1)
                  funk_create_sub_array_lit_indexes(node, &result, *start, *end);
                else
                  funk_get_element_in_array(node, &result, *start);
                return result;
            }

            if (*is_range == 0){
              struct tnode new_array;
              funk_get_element_in_array(node, &new_array, *start);
              return funky_get_element_range( level - 1, &new_array, start+1, end+1, is_range+1);
            } else {
              int len = (*end - *start)+1;
              struct tnode new_array[len];
              for (int i = 0; i < len; i++){
                  struct tnode element;
                  funk_get_element_in_array(node, &element, *start + i);
                  new_array[i] = funky_get_element_range( level - 1, &element, start+1, end+1, is_range+1);
              }
              funk_create_list_of_regs(&result, new_array, len);
            }

            return result;
        }
