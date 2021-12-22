use test_matrix, test_nested_arrays, test_sort, puzzle_8, test_bfs
use assert, test_list_concat, test_not, test_roll, test_ranges
use test_arrays_simple, test_pop, test_push, test_find, test_count
use test_comparisons

main():
    test_comparisons()

    test_count()

    test_push()
    
    test_pop() 

    test_arrays_simple()

    test_ranges()
    
    test_list_concat()

    test_matrix()

    test_nested_arrays()

    test_sort()

    test_bfs()

    test_not()

    test_roll()

    test_find()

    say('===== 8 puzzle tests =====')
    puzzle_8([[1, 2, 3],[4, 5, 6],[7, 0, 8]], [2,1])

    #puzzle_8([[0, 1, 3],[6, 5, 2],[4, 7, 8]])

    say('==== all test passed ====')


    
    1.


