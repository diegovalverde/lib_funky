use assert
popme([]) : [].
popme( a <~ [A] ): a.


test_pop():
      say('==== test pop ===')
      assert(popme([]),[])
      assert(popme([7]),7)
      assert(popme([1,2,3,4]),1)
      assert(popme([[1,2,3],[4,5,6]]),[1,2,3])
      assert(popme([[[1,1,1],[2,2,2],[3,3,3]],[4,5,6]]),[[1,1,1],[2,2,2],[3,3,3]])
      1.
