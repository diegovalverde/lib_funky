use assert, unique


 test_unique():
    say('====== test_unique ======')
    assert(unique([1,1,1,1,1]),[1])
    assert(unique([1,1,2,2,1]),[1,2])
    assert(unique([100,100]),[100])
    assert(unique([6,3,1,1,1,7,8,9,2,9,9,1,4,5]),[1,2,3,4,5,6,7,8,9])
    1.

