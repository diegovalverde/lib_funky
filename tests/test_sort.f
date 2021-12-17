use sort, assert, arr_eq

custom_comparator(a,b | sum(a) >= sum(b)): 1.
custom_comparator(_,_): 0.

test_sort():


say('===== test sort =======')

      say(sort([12,8,2,9,15,4,13,0,6,11,7,1,14,5,3,10]))

      assert(arr_eq([1,2,3], [1,2,3]), 1)
      assert([1,2,3], [1,2,3])
      assert(arr_eq([1,2,3,4], [1,2,3,4]), 1)
      assert([1,2,3,4], [1,2,3,4])
      assert(arr_eq([1,2,3], [1,2,3,4]), 0)
      assert(arr_eq([1,2,3], [5,2,3]), 0)



      assert(arr_eq([10,100], sort([100,10]) ), 1)
      assert([10,100], sort([100,10]))
      assert(arr_eq(sort([3,2,1]), [1,2,3]), 1)
      assert(sort([3,2,1]), [1,2,3])
      assert(arr_eq(sort([2, 5, 4, 3, 1]), [1,2,3,4,5]), 1)
      assert(sort([2, 5, 4, 3, 1]), [1,2,3,4,5])

      assert(arr_eq(sort([12,8,2,9,15,4,13,0,6,11,7,1,14,5,3,10]), [i | 0 <= i <= 15]), 1)
      assert(sort([12,8,2,9,15,4,13,0,6,11,7,1,14,5,3,10]), [i | 0 <= i <= 15])
      assert(arr_eq(sort([98,95,92,90,93,96,91,99,94,97]), [i | 90 <= i <= 99]), 1)
      assert(sort([98,95,92,90,93,96,91,99,94,97]), [i | 90 <= i <= 99])

      assert(sort([ 10000000, 1979, 5, -10, 300, 99999]), [-10,5,300,1979,99999,10000000])
      assert(sort([ 1, -2, -1, 0, 2]), [-2, -1, 0, 1, 2])
      assert(sort([ 1, -2, 0, 2, -1]), [-2, -1, 0, 1, 2])
      assert(sort([ 0, -1, 1, 2, -2]), [-2, -1, 0, 1, 2])

      
      say('sorted is:', sort([[1,1,1,1], [1], [1,1,1], [1,1] ], custom_comparator))
      exit()


1.