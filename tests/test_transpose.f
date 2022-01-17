use assert, transpose

test_transpose():
    say('==== test transpose ===')
    assert(transpose( [[1,2,3],[4,5,6],[7,8,9]]) ,[[1,4,7],[2,5,8],[3,6,9]])
    assert(transpose( [[-3,2],[5,1]]), [[-3,5],[2,1]] )
    1.
