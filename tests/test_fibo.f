use assert

fibo(0, a, b): a.
fibo(1, a, b): b.
fibo(n, a, b): fibo(n - 1, b, a + b).

fib(n): fibo(n,0,1).

test_fibo():
    say(' ==== test fibo =====')
    fib_nums <- [0,1,1,2,3,5,8,13,21,34]

    [ assert(fib(i), fib_nums[i]) | 0 <= i < len(fib_nums)]

    1.