use assert


test_arrays_simple():
    say('===== test arrays simple =====')
    a <- [1,2,3,4,5,6]
    assert(a[0],1)
    assert(a[1],2)
    assert(a[2],3)
    assert(a[3],4)
    assert(a[4],5)
    assert(a[5],6)
    assert(a[-1],a[5])

    assert(a[0..1],[1,2])
    assert(a[1..2],[2,3])
    assert(a[0..2],[1,2,3])
    assert(a[0..0],[1])
    assert(a[1..1],[2])
    assert(a[2..2],[3])

    b <- [ [1], [2,2], [3,3,3] ]

    assert( b[0], [1] )
    assert( b[1], [2,2] )
    assert( b[2], [3,3,3] )

    assert( b[0..0], [[1]] )
    assert( b[0..1], [[1], [2,2]] )

    assert(b[1,0],2)
    assert(b[1,0],b[1,1])

    assert(b[2,0..1 ], [3,3])

      1.
