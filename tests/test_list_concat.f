use assert


f([x,y]): [x+1,y+2].

concat(x,y,F):
    [F(x)] ++ [F(y)].

concat(x,y):
    [x] ++ [y].




test_list_concat():
    say('=== testing list concatenations ===')
    assert(concat([1,2,3],[4,5]), [1,2,3,4,5])
    assert(concat([1,2,3],[]), [1,2,3])
    assert(concat([],[1,2,3]), [1,2,3])
    assert(concat([],[]), [])
    assert(concat([i | 0 <= i <= 10],[]), [i | 0 <= i <= 10])
    assert(concat([1],[2,3,4]), [1,2,3,4])
    #assert(concat([1],[[2],[3],[4]]), [1,[2],[3],[4]])
    #assert(concat([[1]],[[2],[3],[4]]), [[1],[2],[3],[4]])
    assert(concat([[1,2]],[[3,4],[5,6]]), [[1,2],[3,4],[5,6]])
    assert(concat([1,2],[3,4],f),[2,4,4,6])
    #assert(concat([[]],[[]]), [[],[]])
  

    
    1.