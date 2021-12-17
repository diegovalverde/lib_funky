use assert

get_an_array(): [1, 2, 3, 4].

test_matrix():
    zero <- 0
    say('====== Test Matrix =====')      
      M1 <- [[1,0,0,0],
            [0,1,0,0],
            [0,0,1,0],
            [0,0,0,1]]
      
      #assert(count(M1,1),4)
      
      say(M1)
      assert(len(M1[0 .. 1]),2)
      
      assert(len(M1)*len(M1[0]),16)
      assert(sum(M1),4)
      

      B <- [1, 2, 3, 4]
      say( [B | 0 <= k < len(B)])
      assert(sum([ B | 0 <= k < len(B)]), 4*sum(B))
      assert(sum([ get_an_array() | 0 <= k < len(B)]), 4*sum(B))
      assert(sum([ [1,2,3,4] | 0 <= k < len(B)]), 4*sum(B))
      assert(sum([ [1,2,3,4] | zero <= k < len(B)]), 4*sum(B))
      assert(sum([ [1,2,3,4] | zero+0 <= k < len(B)]), 4*sum(B))

      M2 <- [[j | 0<= j <= 3] | 0 <= i <= 3]
      say(M2)
      assert(len(M2),4)
      assert(sum(M2[0]),6)
      assert(sum(M2[1]),6)
      assert(sum(M2[2]),6)
      assert(sum(M2[3]),6)
      
      assert(M2[zero,zero],0)
      assert(M2[zero,1],1)
      assert(M2[zero,zero+1],1)

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
    say('yyyy')
    temp <- a5[2,0,1]
    
    assert(temp,4)

      say('b0', b0)
      say('b0[0]', b0[0])
      assert(b0[2],[99 , 999 ])
      assert(b0[2,0],99)
      #assert(b0[0], [[1 , 2 , 3 ], [4 , 5 , 6 ], [7 , [ [] ], 9 ]] )
      assert(b0[0,0], [1 , 2 , 3 ] )
      x <- [6,66,666]
      assert(x[0..0],[6])
      assert(x[0..1],[6,66])
      assert(x[0..2],[6,66,666])
      assert(x[0..len(x)-1],[6,66,666])
      assert(x[0..-1],[6,66,666])
      y <- b0[0]
      assert(y[0..1],[[1 , 2 , 3 ],[4,5,6]])

      # WTF
      assert(b0[0,0..1], [[1 , 2 , 3 ],[4,5,6]] )
      assert(b0[0,1], [4 , 5 , 6 ] )
      
      say('b0[0,1 .. 2]',b0[0,1 .. 2])
      say(b0[0,1 .. 2, 0])
      say(b0[0,1 .. 2, 1])
      
      assert(len(b0[0,1 .. 2]),2)

      assert(b0[0, 0], [1,2,3])
      assert(b0[0, 0, 0],1)
      assert(b0[0, 0, 1],2)
      assert(b0[0, 0, 2],3)

      assert(b0[0, 1], [4,5,6])
      assert(b0[0, 1, 0],4)
      assert(b0[0, 1, 1],5)
      assert(b0[0, 1, 2],6)
        
      #assert(b0[0, 0..2], [[1,2,3],[4,5,6], [7,[[], 9]]])
      assert(b0[0, 0..1], [[1,2,3],[4,5,6]])
     
      assert(b0[0, 0..0], [[1,2,3]])
      assert(b0[0, 1..1], [[4,5,6]])
       
      say(b0[0])
      assert(b0[0,1 .. 2,0],[4,7])
      #assert(b0[0,1 .. 2,1],[5,[[]] ])
      temp0 <- b0[0,1 .. 2,0]
      assert(temp0,[4,7])
      assert(len(b0[0,1 .. 2, 1]),2)
      #assert(b0[0,1 .. 2,1],[7,[[]],9])
      
      i <- 0
      j <- 2
     
      
      say(M2[0..2 , 0..2])
      assert(M2[0..2 , 0..2], [[0 , 1 , 2  ], [0 , 1 , 2 ], [0 , 1 , 2 ]])

      ttt <- M2[0..2 , 0..2]
      assert(ttt, [[0 , 1 , 2 ], [0 , 1 , 2  ], [0 , 1 , 2  ]])
      sub_matrix <- M2[i..j , i..j]
      
      assert(sum(sub_matrix),9)
      assert(sum(M2[i..j , i..j]),9)
      assert(sum(M2[i..j , i..j]),sum(sub_matrix))
      assert(sum(M2[i..j , i..j]),sum([[j | 0<= j <= 2] | 0 <= i <= 2]))
      
      assert(sum(sub_matrix), M2[i,i] + M2[i+1,i] + M2[i+2,i] +
                               M2[i,i+1] + M2[i+1,i+1] + M2[i+2,i+1] +
                               M2[i,i+2] + M2[i+1,i+2] + M2[i+2,i+2])


     

      assert(sum([0 | 1<= j <= 10]),0)
      assert(sum([1 | 1<= j <= 10]),10)
    1.