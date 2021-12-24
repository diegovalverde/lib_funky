use assert, puzzle_8

check_solution(expected, solution):
    say('final state')
    assert(solution[0], expected[0])
    say('history')
    assert( solution[1] , expected[1])
    say('cost')
    assert(solution[2], expected[2]).


test_8_puzzle():

    say('===== 8 puzzle tests =====')
    expected_board <- [[1 , 2 , 3 ], [4 , 5 , 6 ], [7 , 8 , 0 ]]

    say('1 =================================' )
   
    check_solution([expected_board,
    [[], [[1,2,3],[4,5,6],[7,0,8]]], 1], puzzle_8([[1, 2, 3],[4, 5, 6],[7, 0, 8]], [2,1]))
   
    say('2 =================================' )
    check_solution([expected_board,
    [ [] , [[1 , 2 , 3 ], [4 , 0 , 6 ], [7 , 5 , 8 ]], [[1 , 2 , 3 ], [4 , 5 , 6 ], [7 , 0 , 8 ]]],2], puzzle_8([[1, 2, 3],[4, 0, 6],[7, 5, 8]], [1,1]))

    say('3 =================================' )
    check_solution([expected_board,
    [ [] , [[1 , 0 , 3 ], [4 , 2 , 6 ], [7 , 5 , 8 ]], [[1 , 2 , 3 ], [4 , 0 , 6 ], [7 , 5 , 8 ]], [[1 , 2 , 3 ], [4 , 5 , 6 ], [7 , 0 , 8 ]]],3], puzzle_8([[1, 0, 3],[4, 2, 6],[7, 5, 8]], [0,1]))

    
    
    1.