use assert


test_reshape():
    say('==== test reshape ====')
      assert(reshape([1,2,3,4,5,6],2,3), [[1,2,3],[4,5,6]])
      assert(reshape([1,2,3,4,5,6],6,1), [[1],[2],[3],[4],[5],[6]])
      assert(reshape([1,2,3,4,5,6],3,2), [[1,2],[3,4],[5,6]])
      1.
