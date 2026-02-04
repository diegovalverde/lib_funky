use assert
    push_me(a, A):
      a ~> [A].

    push_back(a, A):
      [A] <~ a.

      test_push():
      say('=== test push ===')
      assert(push_me(1, [2,3]), [1,2,3])
      say(push_me([1],[2,3]))
      assert(push_me([1], [2,3]), [[1],2,3])

      assert(push_me([1,2,3], [[4],[5],[6]]), [[1,2,3],[4],[5],[6]])

      assert(push_me([1,2,3], []), [[1,2,3]])
      assert(push_me(1, []), [1])

      
      x <- [2,3]
      assert( [x] ++ [x], [2,3,2,3])
      say([x] <~ x)
      #assert([x] <~ x, [2,3,[2,3]])
      #exit()

       
      b <- []
      board <- [[1, 2, 3],[4, 5, 6],[7, 0, 8]] 
      
      # TODO(stable_2026): push semantics for nested arrays are currently inconsistent
      # assert([b] <~ board, [ [[1, 2, 3],[4, 5, 6],[7, 0, 8]] ])

      c <- [1,2,3]
      # TODO(stable_2026): push semantics for nested arrays are currently inconsistent
      # assert([c] <~ board, [ 1,2,3, [[1, 2, 3],[4, 5, 6],[7, 0, 8]] ])
      1.
