use assert
    push_me(a, A):
      a ~> [A].


      test_push():
      say('=== test push ===')
      assert(push_me(1, [2,3]), [1,2,3])
      say(push_me([1],[2,3]))
      assert(push_me([1], [2,3]), [[1],2,3])

      assert(push_me([1,2,3], [[4],[5],[6]]), [[1,2,3],[4],[5],[6]])
      1.
