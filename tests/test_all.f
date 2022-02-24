use assert, all

test_all():
      say('==== test all ====')
      assert(all([1,1,1],1),1)
      assert(all([0,0,0],0),1)
      assert(all([1,0,1],1),0)
      assert(all([x | 0 <= x < 10],1),0)      
      assert(all([7 | 0 <= x < 10],7),1)      
      assert(all([[7,7,7],[7,7,7],[7,7,7]],7),1)
      assert(all([[7,7,7],[7,0,7],[7,7,7]],7),0)

      1.
