use astar, bst, sem_matrix, shift_matrix, sort, count, all, find
use roll, neg

#FINAL <-> [[1, 2, 3],[5, 8, 6],[0, 7, 4]]
#INITIAL <-> [[1, 2, 3],[5, 6, 0],[7, 8, 4]]

FINAL <-> [[1, 2, 3],[4, 5, 6],[7, 8, 0]]
INITIAL <-> [[0, 1, 3],[6, 5, 2],[4, 7, 8]]

inside([x1,y1],[x2,y2], [x, y] | x >= x1 /\ x < x2 /\ y >= y1 /\ y < y2):
    point <- [x,y]
    #say('inside', point)
    [point].
inside(_,_,p):
    #say('out',p)
    [].

points_in_rec([], _, _ ): [].
points_in_rec(p <~ [points], p1, p2  ):
    [inside(p1, p2, p)] ++ [points_in_rec(points, p1,p2)].

# heuristic: count of misplaced cells
h([]): [].
h(board): abs(flatten(board - FINAL)).

is_goal([board, prev_boards,_,_] | all(h(board),0) = 1 ):
    say('solution found: ', prev_boards, board)
    1.
is_goal(b): 0.

# Use A* sort style
sort_criteria([board1, _, cost1, _], [board2, _, cost2, _] |
        (cost1 + sum(h(board1))) < (cost2 + sum(h(board2)))):
        # say('sort_criteria baord1', board1, 'cost1', cost1, '+', sum(h(board1)) )
        # say('baord2', board2, 'cost2', cost2, '+', sum(h(board2)) )
        1.
sort_criteria(_, _):0.

unexplored([], _ , _): [].
unexplored(b <~ [next_boards], explored_list, i | find(b, explored_list) = -1):
    i ~> [unexplored(next_boards,explored_list, i+1)].
unexplored(b <~ [next_boards], explored_list, i ):
    unexplored(next_boards, explored_list, i+1 ).

next_board(A, [zi,zj], [di, dj] ):
    E <- sem_matrix(3,3, zi + di, zj + dj )
    # say('E',E)
    # say('neg(E)', neg(E))
    # say('A * E', A * E)
    # say('roll(A * E, -1*di, -1*dj)', roll(A * E, -1*di, -1*dj))
    # say('roll(A * E, -1*di, -1*dj) + A', roll(A * E, -1*di, -1*dj) + A)
    # say('(roll(A * E, -1*di, -1*dj) + A) * neg(E)',(roll(A * E, -1*di, -1*dj) + A) * neg(E))
    (roll(A * E, -1*di, -1*dj) + A) * neg(E).

    get_valid_deltas(_, [], _, _) : [].
    get_valid_deltas(p, d <~ [deltas], tl, br | inside( tl, br ,p + d) != [] ):
        #say('adding delta ', d)
        d ~> [get_valid_deltas(p, deltas, tl, br)].
    get_valid_deltas(p, d <~ [deltas], tl, br): 
        #say('dropping delta ', d)
        get_valid_deltas(p, deltas, tl, br).

get_children([]): [].
get_children([ board , prev_boards, cost, pos ]):
    # say(' &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& get_children ==============')
    # say('board', board , 'prev_boards', prev_boards, 'cost', cost, 'pos', pos)
    delta <- get_valid_deltas(pos, [[-1,0], [1,0], [0,1], [0,-1]], [0,0], [3,3])
    #say('delta', delta)
    
    next_boards <- [next_board(board, pos, delta[k])   |
        0 <= k < len(delta)  ]

    #say('next boards', next_boards)
    #exit()
    idx <- unexplored(next_boards, prev_boards ,0)

    [ [next_boards[ idx[k] ] ,
            [prev_boards] <~ board,
            cost+1, pos + delta[idx[k]]] | 0 <= k < len(idx) ].

# get position of the empty (0) cell        
get_initial_position(board):
    n <- find(0, flatten(board))
    [n/3, n %3].

puzzle_8(board):
    initial_pos <- get_initial_position(board)
    initial_cost <- 0
    say('initial_pos',  initial_pos)
    astar(is_goal, get_children, sort_criteria, [[board,[[]],initial_cost,initial_pos]] ).
