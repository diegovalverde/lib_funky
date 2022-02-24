use assert, any

      test_any():
      say('===== test_any =====')
      assert(any([],1),0)
      assert(any([1,1,1],1),1)
      assert(any([0,0,0],1),0)
      assert(any([0,0,1],1),1)
      assert(any([1,0,1],1),1)
      assert(any([x | 0 <= x < 10],1),1)      
      assert(any([7 | 0 <= x < 10],7),1)  
      assert(any([8 | 0 <= x < 10],7),0)      
      assert(any([[7,7,7],[7,7,7],[7,7,7]],7),1)
      assert(any([[7,7,7],[7,0,7],[7,7,7]],0),1)
      assert(any([[7,7,7],[7,0,7],[7,7,7]],8),0)
      assert(any([[7,7,7],[7,0,7],[7,7,7]],0),1)
      assert(any([[7,7,7],[7,666,7],[7,7,7]],666),1)
      1.
