
#include "funk_c_model.h"
#include <sstream>
#include <algorithm>
#include <numeric>
std::default_random_engine g_funky_random_engine;

TData ArithOpDifferentType(const TData &a, const TData & b){ return TData(funky_type::invalid); }
TData BoolOpEq(const TData &a, const TData & b){ return TData(0); }
TData BoolOpNe(const TData &a, const TData & b){ return TData(1); }
TData DefaultRetVal(const TData &r) { return TData(r);}

#define BOOL_RETVAL(F,op) TData F(const TData &r){ \
  if (r.type != funky_type::array) return r; \
  const bool eq = std::op(r.array.begin(),r.array.end(),[](const TData & d){ return d.i32 == 1;}); \
  return (eq) ? TData(1) : TData(0); }

BOOL_RETVAL(BoolEqRetVal, all_of)
BOOL_RETVAL(BoolNeRetVal, any_of)

#define D64_DEFAULT_OPERATION(op)  result.d64 = a.d64 op b.d64 
#define D64_BOOL_OPERATION(op)  result.type = funky_type::i32; result.i32 = a.d64 op b.d64 
#define D64_UNSUPPORTED_OPERATION(op) result.type = funky_type::invalid

# define OPERATOR(op, a, b, D64OPERATION, WheDifferentTypes, RetFunct ) \
TData operator op(const TData &a, const TData &b) {\
    TData result;\
    if (a.type != b.type) return WheDifferentTypes(a,b); \
    result.type = a.type; \
    switch (result.type) { \
    case funky_type::i32: result.i32 = (int32_t) (a.i32 op b.i32);  break; \
    case funky_type::d64: D64OPERATION; break; \
    case funky_type::array: {\
      if (a.array.size() != b.array.size()) return WheDifferentTypes(a,b); \
      for (std::size_t i = 0; i < a.array.size(); i++) { \
        result.array.push_back( TData(a.array[i] op b.array[i]) ); }\
      break;\
    } \
    default: \
      break; \
    }\
    return RetFunct(result); \
}

OPERATOR(+,a,b, D64_DEFAULT_OPERATION(+), ArithOpDifferentType, DefaultRetVal)
OPERATOR(-,a,b, D64_DEFAULT_OPERATION(-), ArithOpDifferentType, DefaultRetVal)
OPERATOR(*,a,b, D64_DEFAULT_OPERATION(*), ArithOpDifferentType, DefaultRetVal)
OPERATOR(/,a,b, D64_DEFAULT_OPERATION(/), ArithOpDifferentType, DefaultRetVal)
OPERATOR(%,a,b, D64_UNSUPPORTED_OPERATION(%), ArithOpDifferentType, DefaultRetVal)
OPERATOR(==,a,b, D64_DEFAULT_OPERATION(==), BoolOpEq, BoolEqRetVal)
OPERATOR(!=,a,b, D64_DEFAULT_OPERATION(!=), BoolOpNe, BoolNeRetVal)
OPERATOR(<,a,b, D64_BOOL_OPERATION(<), BoolOpEq, BoolEqRetVal)
OPERATOR(>,a,b, D64_BOOL_OPERATION(>), BoolOpEq, BoolEqRetVal)
OPERATOR(<=,a,b, D64_DEFAULT_OPERATION(<=), BoolOpEq, BoolEqRetVal)
OPERATOR(>=,a,b, D64_DEFAULT_OPERATION(>=), BoolOpEq, BoolEqRetVal)
OPERATOR(&&,a,b, D64_UNSUPPORTED_OPERATION(&&), BoolOpEq, BoolEqRetVal)
OPERATOR(||,a,b, D64_UNSUPPORTED_OPERATION(||), BoolOpEq, BoolEqRetVal)
//-------------------------------------------------------
std::string TData::Print() const{
  std::ostringstream oss;
  oss << "";
  switch (type){
  case funky_type::i32: oss << i32; break;
  case funky_type::d64: oss << d64; break;
  case funky_type::function: oss << "<fn: " << str << ">"; break;
  case funky_type::array: 
    oss << "[";
    for (std::size_t i = 0; i < array.size(); i++){
      oss << array[i] << ((i + 1 < array.size()) ? "," : ""); 
    }
    oss << "]";
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
    return TData(static_cast<int32_t>(array.size()));
  } else {
    return TData(1);
  }
}
//-------------------------------------------------------
TData TData::GetRange(std::vector<TData::RangeType>  ranges ) const {
  const auto range = ranges.front();
  ranges.erase(ranges.begin());
  if (array.size() == 0 ) return TData(funky_type::array); //return empty array
  std::size_t start = (range.start > 0) ? (range.start) % array.size() : (array.size() + range.start) % array.size();
  std::size_t end = (range.end > 0) ? (range.end) % array.size() : (array.size() + range.end) % array.size();
  if (ranges.size() == 0 && !range.isRange && start == end){
      return TData(array[start]);
  }
  TData result(funky_type::array);
  for (int i = start; i <= end; i++){
    TData element = (ranges.size() > 0) ? array[i].GetRange(ranges) : array[i];     
    if (range.isRange){
      result.array.push_back(element);
    } else {
      result = element;
    }
  }
  return result;
}
//-------------------------------------------------------
TData TData::Flatten() { 
  if (type != funky_type::array) return TData(*this);
  TData result = std::accumulate(array.begin(), array.end(), decltype(array)::value_type{ },
            []( TData& dest,  TData& src) {
              if (src.type == funky_type::array) {
                TData n = src.Flatten();
                dest.array.insert(dest.array.end(), n.array.begin(), n.array.end());
              } else {
                dest.array.insert(dest.array.end(), src);
              }
        return dest;
    });
  result.type = funky_type::array;
  return result;
}
//-------------------------------------------------------
TData TData::Abs() const {
  TData ret;
  switch (type) {
    case funky_type::i32: ret = TData(std::abs(i32)); break;
    case funky_type::d64: ret = TData(std::abs(d64)); break;
    case funky_type::array: {
      for (auto & e : array) ret.array.push_back( e.Abs() ); 
      ret.type = funky_type::array; 
      } break;
    default: ret.type = funky_type::invalid;
  } 
  return ret;
}

namespace funky
{
//-------------------------------------------------------
TData Reshape(const TData & L, int32_t r, int32_t c){
  const std::vector<TData> tmp(r);
  TData ret(tmp);
  if (r * c != L.GetLen().i32 * L.array[0].GetLen().i32) return L;
      for (int i = 0, k =0; i < r; i++) {
        ret.array[i].type = funky_type::array;
         for (int j = 0; j < c; j++) {
            ret.array[i].array.push_back(L.array[k++]);
         }
      }
  return ret;
}
//-------------------------------------------------------

  
} // namespace name

