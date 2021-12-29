use assert


      test_flatten():
    say(' ======  test flatten ======')
      assert(flatten([1,2,3]),[1,2,3])
      assert(flatten([1,[2,3]]),[1,2,3])

      assert(flatten([1,[2,[3,4]]]),[1,2,3,4])
      assert(flatten([[1,1,1],[2,2,2],[3,3,3]]),[1,1,1,2,2,2,3,3,3])
      1.
