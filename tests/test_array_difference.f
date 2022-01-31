use assert, unique

diff(a,b): [a] --[b].

test_array_difference():
    say(' ==== test array difference ====')
      assert(diff([1,2,3,4], [2,4]), [1,3]  )
      assert(diff([1], [1]), []  )
      assert(diff(unique([6, 6, 666]), [6]), [666]  )
      1.
