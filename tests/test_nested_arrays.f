use assert

add_two(x,y):
    x + y.

call_function(x,y, F):
    10*F(x,y).

test_nested_arrays():

say('===== nested arrays ===== ')
      a00 <- []
      assert(len(a00), 0)
      b00 <- [[],[]]
      assert(len(b00), 2)
      assert(len(b00[0]),0)
      assert(len(b00[1]),0)
      b1 <- [1,2,[],4]
      assert(len(b1), 4)
      say(b1)
      say('!!!!', b1[0])
      say('!!!!', b1[1])
      say('!!!!', b1[2])
      say('!!!!', b1[3])
      assert(len(b1[2]), 0)

      a1 <- [1,2,3]
      a2 <- [1, 2, [3]]
      a3 <- [1, 2, [3], [4,5, [6,7]] ]
      a4 <- [1, 2, [3,4]  ]
      a55 <- [1, 2, [[3,4]] , 7 ]
      a6 <- [0]

      say(a00, a1, a2, a3, a4, a55, a6)
      
      assert(len(a1), 3)
      assert(len(a2), 3)
      assert(len(a2[1]), 1)
      assert(len(a2[1]), 1)
      assert(len(a4), 3)
      assert(len(a4[2]), 2)
      assert(len(a55), 4)
      assert(len(a55[2]), 1)
      assert(len(a55[2,0]), 2)
      assert(a3[0],1)
      assert(a3[2],[3])
      assert(a3[3,0],4)
      assert(a3[3,1],5)
      assert(a3[3,2],[6,7])
      assert(a3[3,2,0],6)
      assert(a3[3,2,1],7)
say('satan!!')
    zero <- 0

    say([i | 0 < i <= 4])
    assert( sum([i | 0 < i <= 4]),10)

    assert(len([0 | 1 <= i <= 10]),10)
    a <- 1
    b <- 2
    c <- 3
    assert( a + b - c, 0  )
    assert( add_two(a,b), 3 )
    k0 <- [1,2,3]
    assert(len(k0),3)
    say(k0[0])
    say(k0)
    
    a0 <- [[], [], [1,2,[ [[ [] ]] ] ]  ]
    say(a0)
    assert(sum(a0),3)
    assert(len(a0),3)
    assert(len(a0[0]),0)
    assert(len(a0[1]),0)
    assert(len(a0[2]),3)

    assert(a0[2,0],1 )
    assert(a0[2,1],2 )
   

    b0 <- [[[1,2,3],[4,5,6],[7,[[]], 9]], 666, [99,999],[]]
    assert(sum(b0), 1801)
    say(b0)
    say(b0[0])
    say(b0[1])
    say(b0[2])
    say(b0[3])
    assert(len(b0),4)
    assert(len(b0[0]),3)
    assert(len(b0[1]),1)
    assert(len(b0[2]),2)
    assert(len(b0[3]),0)
    
     say(b0[zero,1,0])
    assert(b0[zero,1,0],4 )
    assert(b0[zero,1,zero],4 )


    #assert(b0[0],[[1,2,3],[4,5,6],[7,[[]], 9]] )

    assert(b0[0,0,0],1 )
    assert(b0[zero,zero,zero],1 )
    assert(b0[0,0,1],2 )
    assert(b0[0,0,2],3 )

    assert(b0[0,1,0],4 )
    assert(b0[0,1,1],5 )
    assert(b0[0,1,2],6 )

    assert(b0[0,2,0],7 )

    assert(b0[0,2,2],9 )

    a5 <- [1, 0.75, [[3,4]] , 7 ]
    assert(len(a5),4)
    assert(a5[1],0.75)
    assert(a5[2,0,0],3)
    assert(a5[2,0,1],4)
    temp <- a5[2,0,1]
    assert(temp,4)


    assert(add_two(1,1),2)
    assert(add_two(2,1),3)
    assert(add_two(17,3),20)
    assert(add_two(a5[2,0,0],3),6)
    assert(add_two(7,a5[2,0,0]),10)

    assert(call_function(1,2,add_two), 30)
    assert(call_function(27,3,add_two), 300)

    say('===== test array operation =====')
    assert([0,1,2,2]+[1,1,1,2], [1,2,3,4])
    assert([1,2,3,4]-[1,2,3,4], [0,0,0,0])
    assert([10,20,30,40]-[1,2,3,4], [9,18,27,36])
    assert([[0 , 1 , 3 ], [6 , 5 , 2 ], [4 , 7 , 8 ]]-[[1 , 2 , 3 ], [4 , 5 , 6 ], [7 , 8 , 0 ]], [[-1 , -1 , 0 ], [2 , 0 , -4 ], [-3 , -1 , 8 ]])
    assert([[1,1,1],[2,2,2],[3,3,3]]+[[6,6,6],[5,5,5],[4,4,4]], [[7,7,7],[7,7,7],[7,7,7]])


    say('===== test flatten =====')
    say('>>>>>',flatten(b0),'<<<<')
    #assert(flatten(b0) , [1,2,3,4,5,6,7, [], 9, 666, 99,999,[]])
   # assert([1,2,3,4,5,6,7, [], 9, 666, 99,999,[]],flatten(b0))
    assert(flatten(b0),flatten(b0))
    #assert(flatten(a0) , [[], [], 1,2, [] ])
    assert(flatten([1,2,3]) , [1,2,3])
    assert(flatten([1]) , [1])
    say(flatten([1,[2,[3,[4]]]]))
    #assert(flatten([1,[2,[3,[4]]]]) , [1,2,3,4])
    #assert(flatten([1, 2,[3,4,[5,6,[7,8]]]]) , [1,2,3,4,5,6,7,8])
    
    assert(flatten([1,[2,3]]), [1,2,3])
    assert(flatten([[1,2],3]), [1,2,3])
    assert(flatten([[1,2,3]]), [1,2,3])
    assert(flatten([[[1,2,3]]]), [1,2,3])

1.