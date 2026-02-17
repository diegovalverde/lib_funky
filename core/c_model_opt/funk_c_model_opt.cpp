#include "funk_c_model_opt.h"
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <numeric>
#include <sstream>

std::default_random_engine g_funky_random_engine;
OptStats &opt_stats() {
  static OptStats stats;
  return stats;
}

ArrayStorage::ArrayStorage() : data(nullptr) {}
ArrayStorage::ArrayStorage(const Storage &v) : data(std::make_shared<Storage>(v)) {}
ArrayStorage::ArrayStorage(Storage &&v) : data(std::make_shared<Storage>(std::move(v))) {}
ArrayStorage::ArrayStorage(const ArrayStorage &other) = default;
ArrayStorage::ArrayStorage(ArrayStorage &&other) noexcept : data(std::move(other.data)) {}
ArrayStorage &ArrayStorage::operator=(const ArrayStorage &other) = default;
ArrayStorage &ArrayStorage::operator=(ArrayStorage &&other) noexcept {
  if (this != &other) {
    data = std::move(other.data);
  }
  return *this;
}
ArrayStorage::~ArrayStorage() = default;

static const ArrayStorage::Storage &empty_storage() {
  static const ArrayStorage::Storage empty;
  return empty;
}

const ArrayStorage::Storage &ArrayStorage::get_const() const {
  return data ? *data : empty_storage();
}

std::size_t ArrayStorage::size() const { return data ? data->size() : 0; }
bool ArrayStorage::empty() const { return size() == 0; }

ArrayStorage::const_iterator ArrayStorage::begin() const { return get_const().begin(); }
ArrayStorage::const_iterator ArrayStorage::end() const { return get_const().end(); }
ArrayStorage::iterator ArrayStorage::begin() { ensure_unique(); return data->begin(); }
ArrayStorage::iterator ArrayStorage::end() { ensure_unique(); return data->end(); }

void ArrayStorage::reserve(std::size_t n) { ensure_unique(); data->reserve(n); }
void ArrayStorage::push_back(const TData &v) { ensure_unique(); data->push_back(v); }
void ArrayStorage::push_back(TData &&v) { ensure_unique(); data->push_back(std::move(v)); }
ArrayStorage::iterator ArrayStorage::insert(iterator pos, const TData &v) { ensure_unique(); return data->insert(pos, v); }
ArrayStorage::iterator ArrayStorage::insert(iterator pos, TData &&v) { ensure_unique(); return data->insert(pos, std::move(v)); }
ArrayStorage::iterator ArrayStorage::erase(iterator pos) { ensure_unique(); return data->erase(pos); }

TData &ArrayStorage::operator[](std::size_t idx) { ensure_unique(); return (*data)[idx]; }
const TData &ArrayStorage::operator[](std::size_t idx) const { return get_const()[idx]; }
TData &ArrayStorage::front() { ensure_unique(); return data->front(); }
const TData &ArrayStorage::front() const { return get_const().front(); }

ArrayStorage::Storage &ArrayStorage::raw() { ensure_unique(); return *data; }
const ArrayStorage::Storage &ArrayStorage::raw() const { return get_const(); }

void ArrayStorage::ensure_unique() {
  if (!data) {
    data = std::make_shared<Storage>();
    return;
  }
  if (data.use_count() > 1) {
    data = std::make_shared<Storage>(*data);
  }
}

OptStats::~OptStats() {
  const char *env = std::getenv("FUNK_OPT_TRACE");
  if (env == nullptr || env[0] == '0') {
    return;
  }
  std::fprintf(stderr, "=== FUNK OPT STATS ===\n");
  std::fprintf(stderr, "ctor_default: %llu\n", ctor_default.load());
  std::fprintf(stderr, "ctor_type: %llu\n", ctor_type.load());
  std::fprintf(stderr, "ctor_i32: %llu\n", ctor_i32.load());
  std::fprintf(stderr, "ctor_d64: %llu\n", ctor_d64.load());
  std::fprintf(stderr, "ctor_array_copy: %llu\n", ctor_array_copy.load());
  std::fprintf(stderr, "ctor_array_move: %llu\n", ctor_array_move.load());
  std::fprintf(stderr, "ctor_str_copy: %llu\n", ctor_str_copy.load());
  std::fprintf(stderr, "ctor_str_move: %llu\n", ctor_str_move.load());
  std::fprintf(stderr, "copy_ctor: %llu\n", copy_ctor.load());
  std::fprintf(stderr, "move_ctor: %llu\n", move_ctor.load());
  std::fprintf(stderr, "copy_assign: %llu\n", copy_assign.load());
  std::fprintf(stderr, "move_assign: %llu\n", move_assign.load());
  std::fprintf(stderr, "array_shares: %llu\n", array_shares.load());
  std::fprintf(stderr, "array_elems_copied: %llu\n", array_elems_copied.load());
  std::fprintf(stderr, "array_elems_moved: %llu\n", array_elems_moved.load());
}

static inline bool is_numeric_type(const funky_type t) {
  return t == funky_type::i32 || t == funky_type::d64;
}

static inline double as_d64(const TData &x) {
  return (x.type == funky_type::d64) ? x.d64 : static_cast<double>(x.i32);
}

TData ArithOpDifferentType(const TData &, const TData &){ return TData(funky_type::invalid); }
TData BoolOpEq(const TData &, const TData &){ return TData(0); }
TData BoolOpNe(const TData &, const TData &){ return TData(1); }
TData DefaultRetVal(const TData &r) { return TData(r); }

#define BOOL_RETVAL(F,op) TData F(const TData &r){ \
  if (r.type != funky_type::array) return r; \
  const bool eq = std::op(r.array.begin(),r.array.end(),[](const TData & d){ return d.i32 == 1;}); \
  return (eq) ? TData(1) : TData(0); }

BOOL_RETVAL(BoolEqRetVal, all_of)
BOOL_RETVAL(BoolNeRetVal, any_of)

#define D64_BOOL(op)  TData((std::int32_t) (a.d64 op b.d64))
#define D64_DEFAULT(op)  TData(a.d64 op b.d64)

#define OPERATOR_ARITH(op, a, b) \
TData operator op(const TData &a, const TData &b) {\
    if (a.type != b.type) { \
      if (is_numeric_type(a.type) && is_numeric_type(b.type)) { \
        return TData(as_d64(a) op as_d64(b)); \
      } \
      return ArithOpDifferentType(a,b); \
    } \
    switch (a.type) { \
    case funky_type::i32: return TData((std::int32_t) (a.i32 op b.i32)); \
    case funky_type::d64: return D64_DEFAULT(op); \
    case funky_type::array: {\
      if (a.array.size() != b.array.size()) return ArithOpDifferentType(a,b); \
      TData result(funky_type::array); \
      result.array.reserve(a.array.size()); \
      for (std::size_t i = 0; i < a.array.size(); i++) { \
        result.array.emplace_back(TData(a.array[i] op b.array[i])); }\
      return result; \
    } \
    default: \
      return TData(funky_type::invalid); \
    }\
}

#define OPERATOR_BOOL(op, a, b, MismatchFn, RetFn) \
TData operator op(const TData &a, const TData &b) {\
    if (a.type != b.type) { \
      if (is_numeric_type(a.type) && is_numeric_type(b.type)) { \
        return TData((std::int32_t) (as_d64(a) op as_d64(b))); \
      } \
      return MismatchFn(a,b); \
    } \
    switch (a.type) { \
    case funky_type::i32: return TData((std::int32_t) (a.i32 op b.i32)); \
    case funky_type::d64: return D64_BOOL(op); \
    case funky_type::array: {\
      if (a.array.size() != b.array.size()) return MismatchFn(a,b); \
      TData result(funky_type::array); \
      result.array.reserve(a.array.size()); \
      for (std::size_t i = 0; i < a.array.size(); i++) { \
        result.array.emplace_back(TData(a.array[i] op b.array[i])); }\
      return RetFn(result); \
    } \
    default: \
      return TData(funky_type::invalid); \
    }\
}

OPERATOR_ARITH(+,a,b)
OPERATOR_ARITH(-,a,b)
OPERATOR_ARITH(*,a,b)
OPERATOR_ARITH(/,a,b)
TData operator%(const TData &a, const TData &b) {
    if (a.type != b.type) return ArithOpDifferentType(a,b);
    switch (a.type) {
    case funky_type::i32: return TData((std::int32_t) (a.i32 % b.i32));
    case funky_type::d64: return TData(funky_type::invalid);
    case funky_type::array: {
      if (a.array.size() != b.array.size()) return ArithOpDifferentType(a,b);
      TData result(funky_type::array);
      result.array.reserve(a.array.size());
      for (std::size_t i = 0; i < a.array.size(); i++) {
        result.array.emplace_back(TData(a.array[i] % b.array[i])); }
      return result;
    }
    default:
      return TData(funky_type::invalid);
    }
}
OPERATOR_BOOL(==,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(!=,a,b, BoolOpNe, BoolNeRetVal)
OPERATOR_BOOL(<,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(>,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(<=,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(>=,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(&&,a,b, BoolOpEq, BoolEqRetVal)
OPERATOR_BOOL(||,a,b, BoolOpEq, BoolEqRetVal)

#define OPERATOR_MOVE_LR(op) \
TData operator op(TData &&a, const TData &b) {\
    if (a.type != b.type) { \
      if (is_numeric_type(a.type) && is_numeric_type(b.type)) { \
        const double lhs = as_d64(a); \
        const double rhs = as_d64(b); \
        a.type = funky_type::d64; \
        a.d64 = lhs op rhs; \
        return std::move(a); \
      } \
      return ArithOpDifferentType(a,b); \
    } \
    switch (a.type) { \
    case funky_type::i32: a.i32 = (std::int32_t) (a.i32 op b.i32); return std::move(a); \
    case funky_type::d64: a.d64 = a.d64 op b.d64; return std::move(a); \
    case funky_type::array: { \
      if (a.array.size() != b.array.size()) return ArithOpDifferentType(a,b); \
      for (std::size_t i = 0; i < a.array.size(); i++) { \
        a.array[i] = a.array[i] op b.array[i]; } \
      return std::move(a); \
    } \
    default: \
      break; \
    } \
    return TData(funky_type::invalid); \
}

OPERATOR_MOVE_LR(+)
OPERATOR_MOVE_LR(-)
OPERATOR_MOVE_LR(*)
OPERATOR_MOVE_LR(/)
//-------------------------------------------------------
std::string TData::Print() const{
  std::ostringstream oss;
  oss << "";
  switch (type){
  case funky_type::i32:
    if (i32 == std::numeric_limits<std::int32_t>::max())
      oss << "inf";
    else if (i32 == -1*std::numeric_limits<std::int32_t>::max())
      oss << "-inf";
    else
      oss << i32; break;
  case funky_type::d64: oss << d64; break;
  case funky_type::function: oss << "<fn: " << str << ">"; break;
  case funky_type::array:
    oss << "[";
    for (std::size_t i = 0; i < array.size(); i++){
      oss << array[i] << ((i + 1 < array.size()) ? "," : "");
    }
    oss << "]\n";
    break;
  default: oss << "[unknown]"; break;
  }
  oss << " ";
  return oss.str();
}
//-------------------------------------------------------
std::ostream& operator<<(std::ostream& os, const TData& dt) {
    return os << dt.Print();
}
//-------------------------------------------------------
std::istream& operator>>(std::istream& in, TData& data) {
 switch (data.type){
 case funky_type::i32: return in >> data.i32;
 case funky_type::d64: return in >> data.d64;
 default: return in;
 }
}
//-------------------------------------------------------
TData TData::GetLen() const {
  if (type == funky_type::array){
    std::int32_t total = 0;
    for (const auto &el : array) {
      if (el.type == funky_type::array) {
        total += el.GetLen().i32;
      } else {
        total += 1;
      }
    }
    return TData(total);
  } else {
    return TData(1);
  }
}
//-------------------------------------------------------
static TData get_range_impl(const TData &node, const std::vector<TData::RangeType> &ranges, std::size_t idx) {
  if (ranges.empty() || node.array.size() == 0) return TData(funky_type::array);

  const auto &range = ranges[idx];
  const std::size_t start = (range.start > 0) ? (range.start) % node.array.size()
                                               : (node.array.size() + range.start) % node.array.size();
  const std::size_t end = (range.end > 0) ? (range.end) % node.array.size()
                                           : (node.array.size() + range.end) % node.array.size();

  if ((idx + 1) == ranges.size() && !range.isRange && start == end) {
    return TData(node.array[start]);
  }

  TData result(funky_type::array);
  if (end >= start) {
    result.array.reserve((end - start) + 1);
  }
  for (int i = static_cast<int>(start); i <= static_cast<int>(end); i++) {
    TData element = ((idx + 1) < ranges.size())
                        ? get_range_impl(node.array[i], ranges, idx + 1)
                        : TData(node.array[i]);
    if (range.isRange) {
      result.array.push_back(std::move(element));
    } else {
      result = std::move(element);
    }
  }
  return result;
}

TData TData::GetRange(std::vector<TData::RangeType> ranges) const {
  return get_range_impl(*this, ranges, 0);
}
//-------------------------------------------------------
static void flatten_into(const TData &src, ArrayStorage &out){
  if (src.type == funky_type::array) {
    for (const auto &el : src.array) {
      flatten_into(el, out);
    }
  } else {
    out.emplace_back(src);
  }
}

TData TData::Flatten() {
  if (type != funky_type::array) return TData(*this);
  TData result(funky_type::array);
  result.array.reserve(GetLen().i32);
  flatten_into(*this, result.array);
  return result;
}
//-------------------------------------------------------
TData TData::Abs() const {
  TData ret;
  switch (type) {
    case funky_type::i32: ret = TData(std::abs(i32)); break;
    case funky_type::d64: ret = TData(std::abs(d64)); break;
    case funky_type::array: {
      ret.type = funky_type::array;
      ret.array.reserve(array.size());
      for (const auto & e : array) ret.array.emplace_back(e.Abs());
      } break;
    default: ret.type = funky_type::invalid;
  }
  return ret;
}

namespace funky
{
//-------------------------------------------------------
TData Reshape(const TData & L, const std::int32_t r, const std::int32_t c){
  TData ret(funky_type::array);
  ret.array.reserve(r);
  if (r * c != L.GetLen().i32 * L.array[0].GetLen().i32) return L;
      for (int i = 0, k =0; i < r; i++) {
        TData row(funky_type::array);
        row.array.reserve(c);
         for (int j = 0; j < c; j++) {
            row.array.push_back(L.array[k++]);
         }
         ret.array.push_back(std::move(row));
      }
  return ret;
}
//-------------------------------------------------------


} // namespace
