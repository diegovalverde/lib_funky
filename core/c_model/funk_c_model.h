
#ifndef FUNK_C_MODEL_H_INCLUDED
#define FUNK_C_MODEL_H_INCLUDED

#include <iostream>
#include <vector>
#include <string>
#include <numeric>
#include <random>
#include <chrono> // for std::this_thread::sleep_for
#include <thread> // std::this_thread::sleep_for

extern std::default_random_engine g_funky_random_engine;

enum class funky_type{
invalid,
array ,
i32,
d64,
str,
function
};

class TData
{
  public:
    TData(): type(funky_type::invalid),  fn(nullptr) {}
    TData(const funky_type aType) : type(aType), fn(nullptr) {}
    TData(const int32_t aInt32 ): type(funky_type::i32), i32(aInt32){} 
    TData(const double aD64 ) : type(funky_type::d64), d64(aD64) {}
    TData(const std::vector<TData> & aArray ) :type(funky_type::array), array(aArray) {}
    TData(TData (*fn)(std::vector<TData> &) ) : fn(fn), type(funky_type::function) {}

    std::string Print() const;
    TData GetLen() const;
    TData Flatten() ;

    struct RangeType{
      int32_t start, end;
      bool isRange;
    };
    TData GetRange(std::vector<RangeType> ranges ) const;
    TData Abs() const;
  
    funky_type type = funky_type::invalid;
    std::vector<TData> array;
    double d64;
    int32_t i32;
    std::string str;
    TData (*fn)(std::vector<TData> &);
     
    friend TData operator+(const TData &a, const TData &b);
    friend TData operator-(const TData &a, const TData &b);
    friend TData operator*(const TData &a, const TData &b);
    friend TData operator/(const TData &a, const TData &b);
    friend TData operator==(const TData &a, const TData &b);
    friend TData operator!=(const TData &a, const TData &b);
    friend TData operator<(const TData &a, const TData &b);
    friend TData operator<=(const TData &a, const TData &b);
    friend TData operator>(const TData &a, const TData &b);
    friend TData operator>=(const TData &a, const TData &b);
    friend TData operator&&(const TData &a, const TData &b);
    friend TData operator||(const TData &a, const TData &b);
    friend TData operator%(const TData &a, const TData &b);
    friend std::ostream& operator<<(std::ostream& os, const TData& data);

};
namespace funky{
TData Reshape(const TData & L, int32_t r, int32_t c);
}
#endif
