#ifndef FUNK_C_MODEL_OPT_H_INCLUDED
#define FUNK_C_MODEL_OPT_H_INCLUDED

#include <atomic>
#include <chrono>
#include <iostream>
#include <memory>
#include <numeric>
#include <random>
#include <string>
#include <thread>
#include <utility>
#include <vector>

extern std::default_random_engine g_funky_random_engine;

enum class funky_type{
invalid,
array,
i32,
d64,
str,
function
};

struct OptStats {
    std::atomic<unsigned long long> ctor_default{0};
    std::atomic<unsigned long long> ctor_type{0};
    std::atomic<unsigned long long> ctor_i32{0};
    std::atomic<unsigned long long> ctor_d64{0};
    std::atomic<unsigned long long> ctor_array_copy{0};
    std::atomic<unsigned long long> ctor_array_move{0};
    std::atomic<unsigned long long> ctor_str_copy{0};
    std::atomic<unsigned long long> ctor_str_move{0};
    std::atomic<unsigned long long> copy_ctor{0};
    std::atomic<unsigned long long> move_ctor{0};
    std::atomic<unsigned long long> copy_assign{0};
    std::atomic<unsigned long long> move_assign{0};
    std::atomic<unsigned long long> array_shares{0};
    std::atomic<unsigned long long> array_elems_copied{0};
    std::atomic<unsigned long long> array_elems_moved{0};

    ~OptStats();
};

OptStats &opt_stats();

class TData;

class ArrayStorage {
  public:
    using Storage = std::vector<TData>;
    using iterator = Storage::iterator;
    using const_iterator = Storage::const_iterator;

    ArrayStorage();
    ArrayStorage(const Storage &v);
    ArrayStorage(Storage &&v);
    ArrayStorage(const ArrayStorage &other);
    ArrayStorage(ArrayStorage &&other) noexcept;
    ArrayStorage &operator=(const ArrayStorage &other);
    ArrayStorage &operator=(ArrayStorage &&other) noexcept;
    ~ArrayStorage();

    std::size_t size() const;
    bool empty() const;

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();

    void reserve(std::size_t n);
    void push_back(const TData &v);
    void push_back(TData &&v);
    template <class... Args> void emplace_back(Args&&... args) {
        ensure_unique();
        data->emplace_back(std::forward<Args>(args)...);
    }
    iterator insert(iterator pos, const TData &v);
    iterator insert(iterator pos, TData &&v);
    template <class InputIt> iterator insert(iterator pos, InputIt first, InputIt last) {
        ensure_unique();
        return data->insert(pos, first, last);
    }
    iterator erase(iterator pos);

    TData &operator[](std::size_t idx);
    const TData &operator[](std::size_t idx) const;
    TData &front();
    const TData &front() const;

    Storage &raw();
    const Storage &raw() const;

  private:
    const Storage &get_const() const;
    void ensure_unique();
    std::shared_ptr<Storage> data;
};

class TData
{
  public:
    TData(): type(funky_type::invalid), fn(nullptr) { opt_stats().ctor_default++; }
    TData(const funky_type aType) : type(aType), fn(nullptr) { opt_stats().ctor_type++; }
    TData(const std::int32_t aInt32): type(funky_type::i32), i32(aInt32) { opt_stats().ctor_i32++; }
    TData(const double aD64): type(funky_type::d64), d64(aD64) { opt_stats().ctor_d64++; }
    TData(const std::vector<TData> & aArray): type(funky_type::array), array(aArray) {
        opt_stats().ctor_array_copy++;
        opt_stats().array_elems_copied += aArray.size();
    }
    TData(std::vector<TData> && aArray): type(funky_type::array), array(std::move(aArray)) {
        opt_stats().ctor_array_move++;
        opt_stats().array_elems_moved += array.size();
    }
    TData(const std::string & aStr): type(funky_type::str), str(aStr) { opt_stats().ctor_str_copy++; }
    TData(std::string && aStr): type(funky_type::str), str(std::move(aStr)) { opt_stats().ctor_str_move++; }
    TData(TData (*fn)(std::vector<TData> &)) : fn(fn), type(funky_type::function) { opt_stats().ctor_type++; }

    TData(const TData &other)
        : type(other.type),
          array(other.array),
          d64(other.d64),
          i32(other.i32),
          str(other.str),
          fn(other.fn) {
        opt_stats().copy_ctor++;
        if (type == funky_type::array) {
            opt_stats().array_shares++;
        }
    }

    TData(TData &&other) noexcept
        : type(other.type),
          array(std::move(other.array)),
          d64(other.d64),
          i32(other.i32),
          str(std::move(other.str)),
          fn(other.fn) {
        opt_stats().move_ctor++;
        if (type == funky_type::array) {
            opt_stats().array_elems_moved += array.size();
        }
    }

    TData &operator=(const TData &other) {
        if (this != &other) {
            type = other.type;
            array = other.array;
            d64 = other.d64;
            i32 = other.i32;
            str = other.str;
            fn = other.fn;
        }
        opt_stats().copy_assign++;
        if (type == funky_type::array) {
            opt_stats().array_shares++;
        }
        return *this;
    }

    TData &operator=(TData &&other) noexcept {
        if (this != &other) {
            type = other.type;
            auto moved_count = other.array.size();
            array = std::move(other.array);
            d64 = other.d64;
            i32 = other.i32;
            str = std::move(other.str);
            fn = other.fn;
            if (type == funky_type::array) {
                opt_stats().array_elems_moved += moved_count;
            }
        }
        opt_stats().move_assign++;
        return *this;
    }

    std::string Print() const;
    TData GetLen() const;
    TData Flatten();

    struct RangeType{
      std::int32_t start, end;
      bool isRange;
    };
    TData GetRange(std::vector<RangeType> ranges) const;
    TData Abs() const;

    funky_type type{ funky_type::invalid };
    ArrayStorage array;
    double d64;
    std::int32_t i32;
    std::string str;
    TData (*fn)(std::vector<TData> &);

    friend TData operator+(const TData &a, const TData &b);
    friend TData operator-(const TData &a, const TData &b);
    friend TData operator*(const TData &a, const TData &b);
    friend TData operator/(const TData &a, const TData &b);
    friend TData operator+(TData &&a, const TData &b);
    friend TData operator-(TData &&a, const TData &b);
    friend TData operator*(TData &&a, const TData &b);
    friend TData operator/(TData &&a, const TData &b);
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
    friend std::istream& operator>>(std::istream& in, TData& data);

};
namespace funky{
TData Reshape(const TData & L, const std::int32_t r, const std::int32_t c);

// small-arity call helpers to avoid per-call vector allocations
// Note: must be re-entrant for recursion, so we use a thread-local stack.
struct ArgStack {
    std::vector<std::vector<TData>> pool;
    std::size_t depth = 0;

    std::vector<TData> &get(std::size_t n) {
        if (depth >= pool.size()) {
            pool.emplace_back();
        }
        auto &v = pool[depth++];
        if (v.capacity() < n) v.reserve(n);
        v.clear();
        return v;
    }

    void pop() {
        if (depth > 0) depth--;
    }
};

inline ArgStack &arg_stack() {
    thread_local ArgStack stack;
    return stack;
}

inline TData call0(TData (*fn)(std::vector<TData> &)) {
    auto &stack = arg_stack();
    auto &v = stack.get(0);
    TData res = fn(v);
    stack.pop();
    return res;
}

inline TData call1(TData (*fn)(std::vector<TData> &), TData a) {
    auto &stack = arg_stack();
    auto &v = stack.get(1);
    v.emplace_back(std::move(a));
    TData res = fn(v);
    stack.pop();
    return res;
}

inline TData call2(TData (*fn)(std::vector<TData> &), TData a, TData b) {
    auto &stack = arg_stack();
    auto &v = stack.get(2);
    v.emplace_back(std::move(a));
    v.emplace_back(std::move(b));
    TData res = fn(v);
    stack.pop();
    return res;
}

inline TData call3(TData (*fn)(std::vector<TData> &), TData a, TData b, TData c) {
    auto &stack = arg_stack();
    auto &v = stack.get(3);
    v.emplace_back(std::move(a));
    v.emplace_back(std::move(b));
    v.emplace_back(std::move(c));
    TData res = fn(v);
    stack.pop();
    return res;
}

inline TData call4(TData (*fn)(std::vector<TData> &), TData a, TData b, TData c, TData d) {
    auto &stack = arg_stack();
    auto &v = stack.get(4);
    v.emplace_back(std::move(a));
    v.emplace_back(std::move(b));
    v.emplace_back(std::move(c));
    v.emplace_back(std::move(d));
    TData res = fn(v);
    stack.pop();
    return res;
}
}
#endif
