use assert, min

  test_min():
    say('====== test min ======')
    assert(min([1,2]),1)
    assert(min([2,1]),1)
    assert(min([2,9,99,0,3]),0)
    assert(min([100, 10, 2,9,99]),2)
    assert(min([10, 9, 8, 7, 99]),7)
    1.
