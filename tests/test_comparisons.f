use assert

eq(a,b | a = b): 1.
eq(_,_): 0.

ne(a,b | a != b): 1.
ne(_,_): 0.



test_comparisons():
    say('======== test comparisons ========')
    assert(eq(1,1),1)
    assert(eq(1,2),0)
    assert(eq([1],[1]),1)
    assert(eq([1],[2]),0)
    assert(eq([],[]),1)
    assert(eq([1,2,3], [1,2,3]),1)

    
    assert(ne(1,2),1)
    assert(ne(1,1),0)
    say('ne')
    assert(ne([1,2],[]),1)
    assert(ne([],1),1)
    assert(ne(1,[]),1)
    assert(ne([],[]),0)
    assert(ne([1,2,3], [1,2,3]),0)
    1.
