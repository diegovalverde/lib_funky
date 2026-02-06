use assert, arr_eq
use binary_search, argmin, find_all, inverse, len, shift_matrix, abs, get_first_not_of

test_include_misc():
    say('===== include misc tests =====')

    # binary_search (returns [index] or [])
    bs_a <- [1,3,5,7,9]
    assert(arr_eq(binary_search(bs_a, 7, 0, 4), [3]), 1)
    assert(arr_eq(binary_search(bs_a, 2, 0, 4), []), 1)

    # argmin
    assert(argmin([3,1,2]), 1)

    # find_all
    assert(arr_eq(find_all([1,2,3,2,4], 2), [1,3]), 1)

    # inverse
    assert(arr_eq(inverse([1,2,3]), [3,2,1]), 1)

    # len
    assert(len([]), 0)
    assert(len([9,8,7]), 3)

    # shift_matrix (currently a no-op)
    misc_m <- [[1,2],[3,4]]
    assert(arr_eq(shift_matrix(misc_m, [1,0]), misc_m), 1)

    # abs
    assert(abs(0-5), 5)
    assert(arr_eq(abs([-1,0,2]), [1,0,2]), 1)

    # get_first_not_of (returns the value or -1)
    assert(get_first_not_of(0, [0,0,2,0]), 2)
    assert(get_first_not_of(1, [1,1]), -1)

    1.
