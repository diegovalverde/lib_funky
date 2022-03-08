use assert, max

  test_max():
    say('====== test min ======')
    assert(max([1,2]),2)
    assert(max([2,1]),2)
    assert(max([2,9,99,0,3]),99)
    assert(max([100, 10, 2,9,99]),100)
    assert(max([10, 9, 8, 7, 99]),99)
    assert(max([10, 9, 888, 7, 99]),888)
    1.
