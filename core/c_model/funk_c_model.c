
#include "funk_c_model.h"

//#define FUNK_DEBUG_BUILD 0

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
    "type_invalid",        "type_int",
    "type_double",         "type_array",
    "type_empty_array",    "type_scalar",
    "type_function",       "type_pointer_to_pool_entry",
    "type_pool_node_entry"};
#define POOL_STR(pool) ((pool == &funk_global_memory_pool) ? "gpool" : "fpool")

void funk_flatten(struct tnode *dst, struct tnode *src);
void funk_print_node_info(struct tnode *);
void funk_print_node(struct tnode *);
uint32_t _copy_node_to_pool(struct tnode *);
void funk_print_pool(enum pool_types, int, int);
void funk_get_element_in_list_of_regs(struct tnode *, struct tnode *, uint32_t);
void funk_get_element_in_array(struct tnode *src, struct tnode *dst, int idx);
void _dereference(struct tnode *dst, struct tpool *pool, uint32_t start,
                  int idx, int current_depth, const char *func, int line);
                  void funk_get_element_in_matrix_2d_lit(struct tnode *src, struct tnode *dst,
                                                         int32_t idx_0, int32_t idx_1);

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
          : n->pool->data[(dim_idx + idx) % FUNK_MAX_POOL_SIZE].data.i;

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

  n->pool->data[k].type = type_int;
  n->pool->data[k].data.i = val;
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

void funk_print_node_info(struct tnode *n) {
  TRACE("start");

  printf("\n\n");
  printf("%p\n", n);
  printf("pool DIM idx: %d\n", GET_DIM_POOL_IDX(n));
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
  printf("int: %d\n", DATA(n, 0)->data.i);
  printf("double: %f\n", DATA(n, 0)->data.f);
  funk_print_type(DATA(n, 0)->type);
  printf("\nglobal tail: %d:%d\n", funk_global_memory_pool.tail,
         funk_global_memory_pool.wrap_count);
  printf("function tail: %d:%d\n", funk_functions_memory_pool.tail,
         funk_functions_memory_pool.wrap_count);
  printf("\n\n");

  TRACE("end");
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
    case type_int:
      DATA(dst, i)->data.i = ((int *)val)[i];
      break;

    case type_double:
      DATA(dst, i)->data.f = ((double *)val)[i];
      break;

    case type_empty_array:
      DATA(dst, i)->data.i = 0;
      DATA(dst, i)->data.f = 0;
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

  if (IS_PTR(src, 0)) {
    struct tnode tmp;
    DEREF(&tmp, src, 0);
    psrc = &tmp;
  }
  uint32_t len = (IS_PTR(src, 0)) ? LEN(psrc) : 1;

  funk_create_node(dst, len, get_pool_enum(src->pool), type_int, DIM_COUNT(src),
                   NULL);

  for (uint32_t i = 0; i < len; i++) {
    DATA(dst, i)->data = DATA(psrc, i)->data;
    DATA(dst, i)->type = DATA(psrc, i)->type;
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

void funk_roll(struct tnode *dst, struct tnode *src, struct tnode *deltas,
               uint32_t delta_count) {
  TRACE("start");
  FATAL_ERROR_IF( !src , "");
  FATAL_ERROR_IF( !deltas, "" );
  FATAL_ERROR_IF( !IS_PTR(src,0), "" );
  FATAL_ERROR_IF( delta_count != 2, "Only 2 dimensions supported" );

  int di_ = DATA(deltas, 0)->data.i;
  int dj_ = DATA((deltas + 1), 0)->data.i;

int r = LEN(src);

struct tnode tmp;
DEREF(&tmp, src, 0);

int c = tmp.len;
int *arr = (int *)malloc(r * c * sizeof(int));
for (int i = 0; i < r; i++) {
  struct tnode src_row;
  funk_get_element_in_array(src, &src_row,i);

  for (int j = 0; j < c; j++) {
    struct tnode col_dst;
    funk_create_node(&col_dst, LEN(src),
                     get_pool_enum(src->pool),
                     type_pointer_to_pool_entry, 0, NULL);

    int di = (i + di_) % r;
    int dj = (j + dj_) % c;
    di = (di < 0) ? r + di : di;
    dj = (dj < 0) ? c + dj : dj;
    struct tnode tmp;
    funk_get_element_in_matrix_2d_lit(src, &tmp, i,j);
    *(arr + di * c + dj) =  DATA(&tmp,0)->data.i;//DATA(src, i * c + j)->data.i;
  }
}

 funk_create_node(dst, r,
                 get_pool_enum(src->pool),
                 type_pointer_to_pool_entry, 0, NULL);

  for (int i = 0; i < r; i++) {
    struct tnode dst_row;
    funk_create_node(&dst_row, c,
                     get_pool_enum(src->pool),
                     type_int, 0, NULL);

    for (int j = 0; j < c; j++) {
      DATA(&dst_row,j)->data.i = *(arr +i*c +j);
    }
    DATA_NO_CHECK(dst, i)->type = type_pointer_to_pool_entry;
    DATA_NO_CHECK(dst, i)->data.i = _copy_node_to_pool(&dst_row);
  }

  free(arr);
}

void funk_not(struct tnode *dst, struct tnode *src) {
  TRACE("start");

  funk_create_node(dst, LEN(src),
                  get_pool_enum (src->pool),
                   DATA(src, 0)->type, DIM_COUNT(src), NULL);


  for (uint32_t i = 0; i < LEN(src); i++) {
    struct tnode element;
    funk_get_element_in_array(src, &element, i);

    if (element.len > 1){
      struct tnode row;
      funk_not(&row,&element);

      DATA(dst, i)->type = type_pointer_to_pool_entry;
      DATA(dst, i)->data.i = _copy_node_to_pool(&row);
    } else {

      DATA(dst, i)->data.i =
        (DATA(&element, 0)->data.i == 0) ? 1 : 0;
    }
  }


}

int _funk_sum_list(struct tnode *src) {
  TRACE("START");
  int total = 0;
  for (uint32_t i = 0; i < LEN(src); i++) {
    if (IS_PTR(src, i)) {
      struct tnode tmp;
      DEREF(&tmp, src, i)
      total += _funk_sum_list(&tmp);

    } else {
      total += DATA(src, i)->data.i;
    }
  }

  return total;
}
void funk_sum_list(struct tnode *dst, struct tnode *src) {
  TRACE("start");

  int total = _funk_sum_list(src);

  funk_create_node(dst, 1, get_pool_enum(src->pool), type_int, 0,
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

void funk_get_element_in_matrix_ptr(struct tnode *src, struct tnode *dst,
                                    int32_t idx_0, int32_t idx_1) {
  TRACE("start");

  struct tnode tmp;
  idx_0 = (idx_0 < 0) ? LEN(src) + idx_0 : idx_0;
  idx_0 %= LEN(src);

  DEREF(&tmp, src, idx_0);

  //  funk_print_node(&tmp);
  idx_1 = (idx_1 < 0) ? tmp.len + idx_1 : idx_1;
  idx_1 %= tmp.len;

  struct tdata *data = NULL;
  data = DATA(&tmp, idx_1);
  funk_copy_node(dst, &tmp);
  dst->start += idx_1;
  dst->len = 1;
}
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

  if (DATA(node_i, 0)->type != type_int) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_i, 0)->type);
  }

  if (DATA(node_j, 0)->type != type_int) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_j, 0)->type);
  }

  int32_t idx_0 = DATA(node_i, 0)->data.i;
  int32_t idx_1 = DATA(node_j, 0)->data.i;

  funk_get_element_in_matrix_2d_lit(src, dst, idx_0, idx_1);
}
void _dereference(struct tnode *dst, struct tpool *pool, uint32_t start,
                  int idx, int current_depth, const char *function, int line) {
  TRACE("start");

  int type = pool->data[(start + idx) % FUNK_MAX_POOL_SIZE].type;

  if (current_depth == 0) {
    printf("-E- %s max depth\n", __FUNCTION__);
    exit(1);
  }

  if (type == type_pointer_to_pool_entry) {

    _dereference(dst, pool,
                 pool->data[(start + idx) % FUNK_MAX_POOL_SIZE].data.i, 0,
                 current_depth - 1, function, line);
  } else if (type == type_pool_node_entry) {

    dst->pool = pool;
    dst->start = pool->data[(start + idx + 0) % FUNK_MAX_POOL_SIZE].data.i;
    dst->len = pool->data[(start + idx + 1) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.count =
        pool->data[(start + idx + 2) % FUNK_MAX_POOL_SIZE].data.i;
    dst->dimension.ptr_idx =
        pool->data[(start + idx + 3) % FUNK_MAX_POOL_SIZE].data.i;

  } else {
    printf("-E- %s unknown type %d from %s +%d %s\n", __FUNCTION__, type,
           function, line, POOL_STR(pool));
    exit(1);
  }
}
void funk_get_element_in_array(struct tnode *src, struct tnode *dst, int idx) {
  TRACE("start");
  VALIDATE_NODE(src);

  // negative indexes allow getting last elemets like in python
  idx = (idx < 0) ? LEN(src) + idx : idx;
  idx %= LEN(src);

  if (IS_PTR(src, idx) || IS_NODE_IN_POOL(src, idx)) {

    // copy source
    DEREF(dst, src, idx)

  } else {

    funk_copy_node(dst, src);
    if (DIM_COUNT(src) == 2) {

      dst->start = src->start + DIM(src, 0) * idx;
      LEN(dst) = DIM(src, 0);
    } else {
      dst->start = src->start + idx;
      LEN(dst) = 1;
    }

    dst->dimension.ptr_idx = 0;
    dst->dimension.count = 0;
  }
}

void funk_get_element_in_array_var(struct tnode *src, struct tnode *dst,
                                   struct tnode *node_i) {
  TRACE("start");
  if (DATA(node_i, 0)->type != type_int) {
    printf("-E- %s node lhs data type is %d but shall be int\n", __FUNCTION__,
           DATA(node_i, 0)->type);
  }

  int32_t idx_0 = DATA(node_i, 0)->data.i;

  funk_get_element_in_array(src, dst, idx_0);
}

void add_node_to_nodelist(struct tnode *list, struct tnode *node,
                          struct tnode *idx_node, uint32_t list_len) {
  TRACE("start");

  VALIDATE_NODE(node);
  VALIDATE_NODE(idx_node);

  int32_t idx = DATA(idx_node, 0)->data.i;

  uint32_t k = 0;
  for (uint32_t i = idx; (k < LEN(node)) && (i < list_len); i++) {

    struct tnode *l = (list + i);
    l->pool = node->pool;

    l->start = node->start + k;
    LEN(l) = 1;
    SET_DIM_COUNT(l, 1);

    SET_DIM_POOL_IDX(l, GET_DIM_POOL_IDX(node));

    DATA(idx_node, 0)->data.i += 1;
    k++;
  }
}

void funk_create_double_scalar(enum pool_types pool, struct tnode *dst,
                               double val) {
  TRACE("start");
  funk_create_node(dst, 1, pool, type_double, 0, (void *)&val);
  VALIDATE_NODE(dst);
}

void funk_create_int_scalar(enum pool_types pool, struct tnode *dst,
                            int32_t val) {
  TRACE("start");

  funk_create_node(dst, 1, pool, type_int, 0, (void *)&val);
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
  src->pool->data[idx % FUNK_MAX_POOL_SIZE].data.i = src->start;
  src->pool->data[(idx + 1) % FUNK_MAX_POOL_SIZE].data.i = src->len;
  src->pool->data[(idx + 2) % FUNK_MAX_POOL_SIZE].data.i = src->dimension.count;
  src->pool->data[(idx + 3) % FUNK_MAX_POOL_SIZE].data.i =
      src->dimension.ptr_idx;

  return idx;
}

void funk_create_list_of_regs(struct tnode *dst, struct tnode *list,
                              int32_t size) {
  TRACE("start");
  // Check that all of the nodes in list are in the same pool, and use that pool

  enum pool_types pool_type = get_pool_enum(list[0].pool);

  funk_create_node(dst, size, global_pool, type_int, 0, NULL);

  for (int32_t i = 0; i < size; i++) {

    if (list[i].len > 1) {
      // if this node contains other nodes then save the node
      // in the pool and create a pointer to the position in
      // the pool to where this node node lives

      DATA_NO_CHECK(dst, i)->type = type_pointer_to_pool_entry;
      DATA_NO_CHECK(dst, i)->data.i = _copy_node_to_pool(&list[i]);

    } else {
      // careful not to copy the pool_wrap count
      DATA_NO_CHECK(dst, i)->type = DATA(&list[i], 0)->type;
      DATA_NO_CHECK(dst, i)->data = DATA(&list[i], 0)->data;
    }
  }
}

void funk_create_list_i32_literal(enum pool_types pool_type, struct tnode *dst,
                                  int32_t *list, int32_t size) {
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_int, 0, (void *)list);
}

void funk_create_list_double_literal(enum pool_types pool_type,
                                     struct tnode *dst, double *list,
                                     int32_t size) {
  TRACE("start");
  funk_create_node(dst, size, pool_type, type_double, 0, (void *)list);
}

void funk_print_scalar_element(struct tdata n) {
  TRACE("start");

  switch (n.type) {
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
    printf("<function> %p", n.data.fn);
    break;
  case type_pointer_to_pool_entry:
    printf("*-> %d", n.data.i);
    break;
  case type_pool_node_entry:
    printf("* %d", n.data.i);
    break;
  default:
    printf("%5s", "?");
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
  DATA(node, 0)->data.i++;
}

void funk_copy_node_into_node_list(struct tnode *dst_list, struct tnode *src,
                                   struct tnode *idx_node) {
  TRACE("start");
  // VALIDATE_NODE(src);
  int32_t idx = DATA(idx_node, 0)->data.i;

  funk_copy_node(&dst_list[idx], src);
}

void funk_set_node_value_int(struct tnode *node, uint32_t offset,
                             uint32_t value) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type_int;
  DATA(node, offset)->data.i = value;

  TRACE("\nend");
}

void funk_set_node_value_fn_ptr(struct tnode *node, uint32_t offset,
                                void (*fn)(struct tnode *, int,
                                           struct tnode *)) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type_function;
  DATA(node, offset)->data.fn = fn;
}

void funk_set_node_value_double(struct tnode *node, uint32_t offset,
                                double value) {
  TRACE("start");

  if (offset >= LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  DATA(node, offset)->type = type_double;
  DATA(node, offset)->data.f = value;
}

int32_t funk_get_node_value_int(struct tnode *node, uint32_t offset) {
  TRACE("start");
  if (offset > LEN(node)) {
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset,
           LEN(node));
  }
  return DATA(node, offset)->data.i;
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

#ifdef FUNK_DEBUG_BUILD

  char str[8];

  if (funk_global_memory_pool.tail + 1 == FUNK_MAX_POOL_SIZE) {
    printf("\n\n\n=== funk_global_memory_pool.tail = %d about to reach max of "
           "%d\n",
           funk_global_memory_pool.tail, FUNK_MAX_POOL_SIZE);
  } else if (g_debug_continue == 1) {
    return;
  }

  printf("\n\n\n=== %s arity %d  ========= \n", function_name, arity);
  for (int i = 0; i < arity; i++) {
    printf("input %d:\n", i);
    funk_print_node(&inputs[i]);
    printf("\n");
  }
  do {
    printf("\n>");
    fgets(str, 8, stdin);

    if (!strncmp(str, "gpool", 5)) {
      int begin, len;
      printf("begin len:");
      scanf("%d %d", &begin, &len);

      funk_print_pool(global_pool, begin, len);
    } else if (!strncmp(str, "fpool", 5)) {
      funk_print_pool(function_pool, 0, 256);
    } else if (!strncmp(str, "r", 1)) {
      g_debug_continue = 1;
    } else if (!strncmp(str, "q", 1)) {
      exit(0);
    } else if (!strncmp(str, "fnod", 4)) {
      funk_print_nodes(&funk_functions_memory_pool);
    } else if (!strncmp(str, "gnod", 4)) {
      funk_print_nodes(&funk_global_memory_pool);
    } else if (!strncmp(str, "rs", 2)) {

      printf("\n");

    } else if (!strncmp(str, "ftrace", 6)) {
      g_funk_internal_function_tracing_enabled =
          !g_funk_internal_function_tracing_enabled;
    } else {
      return;
    }

  } while (strncmp(str, "c", 1) && strncmp(str, "r", 1));

#endif
}

void funk_debug_function_exit_hook(const char *function_name,
                                   struct tnode *retval) {
  TRACE("start");

#ifdef FUNK_DEBUG_BUILD
  printf("'%s' returned:", function_name);
  funk_print_node(retval);
  if (g_debug_continue != 1)
    getchar();
  printf("\n==========================\n\n");
#endif
}

void debug_print_arith_operation(struct tnode *r, struct tnode *a,
                                 struct tnode *b) {
  VALIDATE_NODE(r);
  VALIDATE_NODE(a);
  VALIDATE_NODE(b);
  TRACE("start");

  printf("%s[%d]", get_pool_ptr(a), a->start);
  funk_print_scalar_element(*DATA(a, 0));
  printf(" , ");
  printf("%s[%d]", get_pool_ptr(b), b->start);
  funk_print_scalar_element(*DATA(b, 0));

  printf(" = %s[%d]", get_pool_ptr(r), r->start);
  funk_print_scalar_element(*DATA(r, 0));
  printf(" )\n");
}

void funk_mul(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_double) {
    *((double *)x) = (double)(*(double *)a) * (double)(*(double *)b);
  } else if (type == type_int) {
    *((int *)x) = (int)(*(int *)a) * (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_div(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_double) {
    *((double *)x) = (double)(*(double *)a) / (double)(*(double *)b);
  } else if (type == type_int) {
    *((int *)x) = (int)(*(int *)a) / (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_add(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_double) {
    *((double *)x) = (double)(*(double *)a) + (double)(*(double *)b);
  } else if (type == type_int) {
    *((int *)x) = (int)(*(int *)a) + (int)(*(int *)b);
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sub(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");
  if (type == type_double) {
    *((double *)x) = (double)(*(double *)a) - (double)(*(double *)b);
  } else if (type == type_int) {
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

  if (type == type_double) {
    *((int *)x) = ((double)(*(double *)a) < (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) < (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sgt(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) = ((double)(*(double *)a) > (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) > (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_sge(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) = ((double)(*(double *)a) >= (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) >= (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_eq(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) = ((double)(*(double *)a) == (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) == (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_ne(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) = ((double)(*(double *)a) != (double)(*(double *)b)) ? 1 : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) != (int)(*(int *)b)) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_or(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) =
        ((double)(*(double *)a) != 0.0 || (double)(*(double *)b) != 0.0) ? 1
                                                                         : 0;
  } else if (type == type_int) {
    *((int *)x) = ((int)(*(int *)a) != 0 || (int)(*(int *)b) != 0) ? 1 : 0;
  } else {
    printf("-E- %s\n", __FUNCTION__);
  }
}

void funk_and(void *x, void *a, void *b, enum funk_types type) {
  TRACE("start");

  if (type == type_double) {
    *((int *)x) =
        ((double)(*(double *)a) != 0.0 && (double)(*(double *)b) != 0.0) ? 1
                                                                         : 0;
  } else if (type == type_int) {
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
    t2 = type_int;

  if (t1 == type_empty_array)
    t1 = type_int;

  if (t1 == type_int && t2 == type_int) {
    f((void *)&r->data.i, (void *)&a.data.i, (void *)&b.data.i, type_int);
    r->type = type_int;

  } else if (t1 == type_double && t2 == type_double) {
    f((void *)&r->data.f, (void *)&a.data.f, (void *)&b.data.f, type_double);
    r->type = type_double;

  } else if (t1 == type_double && t2 == type_int) {
    f((void *)&r->data.f, (void *)&a.data.f, (void *)&b.data.i, type_double);
    r->type = type_double;

  } else if (t1 == type_int && t2 == type_double) {
    f((void *)&r->data.f, (void *)&a.data.i, (void *)&b.data.f, type_double);
    r->type = type_double;

  } else {
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

#ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled) {
    debug_print_arith_operation(node_r, node_a, node_b);
  }
#endif
}

void funk_arith_op_rr(struct tnode *r, struct tnode *a, struct tnode *b,
                      void (*f)(void *, void *, void *, enum funk_types)) {

  TRACE("start");

  if (LEN(a) != LEN(b)) {
    printf("'%s' length mismatch %d != %d !\n", __FUNCTION__, LEN(a), LEN(b));
    funk_print_node(a);
    printf("\n");
    funk_print_node(b);
    exit(1);
  }

  funk_create_node(r, LEN(a), get_pool_enum(a->pool), type_int, 0, NULL);

  for (uint32_t i = 0; i < LEN(a); i++) {
    struct tnode tmp_a, tmp_b;
    funk_get_element_in_array(a, &tmp_a, i);
    funk_get_element_in_array(b, &tmp_b, i);

    if (tmp_a.len != tmp_b.len) {
      printf("CRAP!\n");
      exit(1);
    } else if (tmp_a.len == 1) {

      _funk_arith_op_rr(r, i, &tmp_a, &tmp_b, f);
    } else {
      struct tnode tmp_dst;
      funk_create_node(&tmp_dst, tmp_a.len, get_pool_enum(tmp_a.pool), type_int,
                       0, NULL);
      funk_arith_op_rr(&tmp_dst, &tmp_a, &tmp_b, f);
      DATA(r, i)->type = type_pointer_to_pool_entry;
      DATA(r, i)->data.i = _copy_node_to_pool(&tmp_dst);
    }
  }
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
  funk_arith_op_rr(r, a, b, funk_ne);
}

void funk_eq_rr(struct tnode *r, struct tnode *a, struct tnode *b) {

  TRACE("start");
  struct tnode tmp1;
  funk_arith_op_rr(&tmp1, a, b, funk_eq);
  struct tnode tmp2;
  funk_flatten(&tmp2, &tmp1);

  funk_create_node(r, 1, get_pool_enum(a->pool), type_int, 0, NULL);
  DATA(r, 0)->data.i = 1;

  for (uint32_t i = 0; i < tmp2.len; i++) {
    if (DATA(&tmp2, i)->data.i != 1) {
      DATA(r, 0)->data.i = 0;
      break;
    }
  }
}

void funk_add_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;
  // TODO: maybe create a smaller pool for this?
  funk_create_double_scalar(function_pool, &node_b, value);

  funk_arith_op_rr(node_r, node_a, &node_b, funk_add);
}

void funk_ne_ri(struct tnode *node_r, struct tnode *node_a, int32_t value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_int_scalar(function_pool, &node_b, value);

  funk_arith_op_rr(node_r, node_a, &node_b, funk_ne);
}

void funk_sub_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sub);
}

void funk_mod_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mod);
}

void funk_add_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_add);
}

void funk_div_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_div);
}

void funk_mul_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mul);
}

void funk_sub_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_double_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sub);
}

void funk_mul_rf(struct tnode *node_r, struct tnode *node_a, double value) {
  TRACE("start");
  struct tnode node_b;

  funk_create_double_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_mul);
}

void funk_slt_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_int_scalar(function_pool, &node_b, value);
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

  funk_create_double_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_slt);
}

void funk_sgt_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sgt);
}

void funk_sge_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_int_scalar(function_pool, &node_b, value);
  funk_arith_op_rr(node_r, node_a, &node_b, funk_sge);
}

void funk_sge_rr(struct tnode *r, struct tnode *a, struct tnode *b) {
  TRACE("start");
  funk_arith_op_rr(r, a, b, funk_sge);
}

void funk_eq_ri(struct tnode *node_r, struct tnode *node_a, int value) {
  TRACE("start");
  struct tnode node_b;
  funk_create_int_scalar(function_pool, &node_b, value);
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

void _funk_print_node(struct tnode *n) {
  TRACE("start");
  if (LEN(n) > 1)
    printf("[");
  for (uint32_t i = 0; i < LEN(n); i++) {
    if (IS_PTR(n, i)) {
      struct tnode tmp;
      DEREF(&tmp, n, i);
      funk_print_node(&tmp);
      printf("\n");

    } else {
      funk_print_scalar_element(*DATA(n, i));
    }
    if (i + 1 < LEN(n))
      printf(",");
  } // for
  if (LEN(n) > 1)
    printf("]");
}

void funk_print_node(struct tnode *n) {

  uint32_t len = LEN(n);

  if (LEN(n) > 1)
    printf("[ ");
  struct tnode node;
  funk_create_node(&node, 1, function_pool, type_int, 0, NULL);

  for (uint32_t i = 0; i < len; i++) {

    funk_get_element_in_array(n, &node, i);
    _funk_print_node(&node);

    if (i + 1 != LEN(n))
      printf(" , ");
  }
  if (LEN(n) > 1)
    printf(" ]");
}

float funk_ToFloat(struct tnode *n) {
  TRACE("start");
  if (DATA(n, 0)->type == type_int) {
    return (float)DATA(n, 0)->data.i;
  } else if (DATA(n, 0)->type == type_double) {
    return (float)DATA(n, 0)->data.f;
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
  funk_create_node(dst, 0, pool_type, type_int, 0, NULL);

  while (fscanf(fp, "%d", &value) == 1) {
    DATA(dst, count)->data.i = value;
    DATA(dst, count)->type = type_int;
    SET_WRAP_CREATION(dst, count, pool->wrap_count);
    INC_TAIL(pool);
    count++;
  }

  LEN(dst) = count;
  fclose(fp);
}

void funk_get_len(struct tnode *src, struct tnode *dst) {
  TRACE("start");

  funk_create_int_scalar(function_pool, dst, src->len);
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
    // funk_print_node(&current_row);

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
    DATA_NO_CHECK(dst, new_i)->data.i = _copy_node_to_pool(&new_column);
  }
}

void funk_create_sub_matrix(struct tnode *src, struct tnode *dst,
                            struct tnode *R1, struct tnode *R2,
                            struct tnode *C1, struct tnode *C2) {
  TRACE("start");

  int32_t r1 = DATA(R1, 0)->data.i;
  int32_t r2 = DATA(R2, 0)->data.i;
  int32_t c1 = DATA(C1, 0)->data.i;
  int32_t c2 = DATA(C2, 0)->data.i;

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
  // funk_create_node(&node, 1, function_pool, type_int, 0, NULL);

  for (int j = c1; j <= c2; j++) {

    int idx_j = j % LEN(src);

    // list[k] = DATA(src,idx_j)->data.i;

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

  int32_t c1 = DATA(i, 0)->data.i;
  int32_t c2 = DATA(j, 0)->data.i;

  funk_create_sub_array_lit_indexes(src, dst, c1, c2);
}

uint32_t _funk_set_node_dimensions(struct tnode *src, enum pool_types pool,
                                   uint32_t dim, uint32_t *dimensions,
                                   uint32_t dim_count, uint32_t offset) {
  TRACE("start");
  struct tnode new_column;
  // printf("%p\n",src);
  // funk_print_node_info(src);
  // funk_print_node(src);
  uint32_t n = dimensions[dim];
  // printf("\nLEN %d offset %d, n = %d dim = %d\n\n", LEN(src), offset, n,
  // dim);
  funk_create_node(&new_column, n, pool, type_pointer_to_pool_entry, 0, NULL);
  for (uint32_t j = 0; j < n; j++) {

    if (dim + 1 < dim_count) {
      DATA(&new_column, j)->type = type_pointer_to_pool_entry;
      DATA(&new_column, j)->data.i =
          _funk_set_node_dimensions(src, pool, dim + 1, dimensions, dim_count,
                                    offset + j * dimensions[dim + 1]);
    } else {

      DATA(&new_column, j)->type = DATA(src, offset + j)->type;
      DATA(&new_column, j)->data.i = DATA(src, offset + j)->data.i;
      // printf("er[%d] %d %d\n",offset+j, DATA(src, offset + j)->data.i,
      // DATA(&new_column, j)->type);
    }
  }

  return _copy_node_to_pool(&new_column);
}

void _extract_tnode_from_pool(struct tnode *dst, uint32_t start,
                              struct tpool *pool) {
  TRACE("start");

  dst->pool = pool;
  dst->start = pool->data[(start + 0) % FUNK_MAX_POOL_SIZE].data.i;
  dst->len = pool->data[(start + 1) % FUNK_MAX_POOL_SIZE].data.i;
  dst->dimension.count = pool->data[(start + 2) % FUNK_MAX_POOL_SIZE].data.i;
  dst->dimension.ptr_idx = pool->data[(start + 3) % FUNK_MAX_POOL_SIZE].data.i;
}
void _flatten(struct tnode *dst, struct tnode *src, uint32_t offset) {

  for (uint32_t i = 0; i < LEN(src); i++) {
    if (IS_PTR(src, i)) {
      // funk_print_node(src);
      struct tnode tmp;
      DEREF(&tmp, src, i)
      DATA_NO_CHECK(dst, offset + i)->type = DATA(&tmp, 0)->type;
      DATA_NO_CHECK(dst, offset + i)->data = DATA(&tmp, 0)->data;
    } else {
      DATA_NO_CHECK(dst, offset + i)->type = DATA(src, i)->type;
      DATA_NO_CHECK(dst, offset + i)->data = DATA(src, i)->data;
    }
    SET_WRAP_CREATION(dst, offset + i, dst->pool->wrap_count);
    INC_TAIL(dst->pool);

    dst->len++;
  }
}

void funk_flatten(struct tnode *dst, struct tnode *src) {

  struct tnode row;

  // funk_create_node(dst, 1, function_pool, type_int, 0, NULL);
  funk_create_node(dst, 1, get_pool_enum(src->pool), type_int, 0, NULL);

  dst->len = 0;
  for (uint32_t i = 0; i < LEN(src); i++) {
    funk_get_element_in_array(src, &row, i);
    // printf("%d ", i*row.len);
    _flatten(dst, &row, i * row.len);
  }
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
  funk_create_node(dst, 1, pool_type, type_empty_array, 0, NULL);
}

/**
  [A] <~ e
**/

void funk_append_element_to_list(struct tnode *dst, struct tnode *L,
                                 struct tnode *R) {
  TRACE("start");
  printf("funk_append_element_to_list\n");
  VALIDATE_NODE(L);
  VALIDATE_NODE(R);

  if (DATA(L, 0)->type == type_empty_array &&
      DATA(R, 0)->type == type_empty_array) {
    funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
    printf("funk_concatenate_lists [] , [] -> []\n");
    return;
  }

  funk_create_node(dst,
                   ((DATA(L, 0)->type == type_empty_array) ? 0 : LEN(L)) +
                       ((DATA(R, 0)->type == type_empty_array) ? 0 : 1),
                   get_pool_enum(R->pool), type_array, 0, NULL);

  uint32_t k = 0;
  for (uint32_t i = 0; i < LEN(L); i++) {
    if (DATA(L, i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(L, i)->type;
    DATA(dst, k)->data = DATA(L, i)->data;

    k++;
  }

  if (DATA(R, 0)->type != type_empty_array) {
    DATA_NO_CHECK(dst, dst->len - 1)->type = type_pointer_to_pool_entry;
    DATA_NO_CHECK(dst, dst->len - 1)->data.i = _copy_node_to_pool(R);
  }

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

  funk_create_node(dst,
                   ((DATA(L, 0)->type == type_empty_array) ? 0 : 1) +
                       ((DATA(R, 0)->type == type_empty_array) ? 0 : LEN(R)),
                   get_pool_enum(L->pool), type_array, 0, NULL);

  if (LEN(L) > 1) {
    // if is another list, then prepend as one element
    DATA_NO_CHECK(dst, 0)->type = type_pointer_to_pool_entry;
    DATA_NO_CHECK(dst, 0)->data.i = _copy_node_to_pool(L);
  } else if (DATA(L, 0)->type != type_empty_array) {
    DATA(dst, 0)->type = DATA(L, 0)->type;
    DATA(dst, 0)->data = DATA(L, 0)->data;
  }

  uint32_t k = 1;
  for (uint32_t i = 0; i < LEN(R); i++) {
    if (DATA(R, i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(R, i)->type;
    DATA(dst, k)->data = DATA(R, i)->data;

    k++;
  }
}

void funk_concatenate_lists(struct tnode *dst, struct tnode *L,
                            struct tnode *R) {
  TRACE("start");

  VALIDATE_NODE(L);
  VALIDATE_NODE(R);

  if (DATA(L, 0)->type == type_empty_array &&
      DATA(R, 0)->type == type_empty_array) {
    funk_create_node(dst, 1, function_pool, type_empty_array, 0, NULL);
    printf("funk_concatenate_lists [] , [] -> []\n");
    return;
  }

  funk_create_node(dst,
                   ((DATA(L, 0)->type == type_empty_array) ? 0 : LEN(L)) +
                       ((DATA(R, 0)->type == type_empty_array) ? 0 : LEN(R)),
                   function_pool, type_array, 0, NULL);

  uint32_t k = 0;
  for (uint32_t i = 0; i < LEN(L); i++) {
    if (DATA(L, i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(L, i)->type;
    DATA(dst, k)->data = DATA(L, i)->data;

    k++;
  }

  for (uint32_t i = 0; i < LEN(R); i++) {
    if (DATA(R, i)->type == type_empty_array)
      break;

    DATA(dst, k)->type = DATA(R, i)->type;
    DATA(dst, k)->data = DATA(R, i)->data;

    k++;
  }
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

  uint32_t i = DATA(iterator_reg, 0)->data.i;

  if (i >= len) {
    printf("-E- %s Index %d out of range [0:%d]\n", __FUNCTION__, i, len);
  }
  tnode_list[i] = *value_reg;
}

struct tnode *funk_alloc_list_of_tnodes(struct tnode *reg_len) {
  TRACE("start");
  uint32_t len = DATA(reg_len, 0)->data.i;

  MEM_USAGE(__FUNCTION__);
  return (struct tnode *)malloc(len * sizeof(struct tnode));
}

void funk_call_fn_pointer(struct tnode *n, struct tnode *result, int arity,
                          struct tnode *arguments) {

  TRACE("start");
  if (DATA(n, 0)->type != type_function) {
    printf("-E- calling node which is not a function!\n");
    exit(1);
  }
  // execute the function
  DATA(n, 0)->data.fn(result, arity, arguments);
}
