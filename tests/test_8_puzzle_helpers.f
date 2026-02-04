use assert, find, all

list_len3_test([]): 0.
list_len3_test(_ <~ [A]): 1 + list_len3_test(A).

inside_test([x1,y1],[x2,y2], [x, y] | x >= x1 /\ x < x2 /\ y >= y1 /\ y < y2):
    point <- [x,y]
    [point].
inside_test(_,_,_):
    [].

get_valid_deltas_test(_, [], _, _) : [].
get_valid_deltas_test(p, d <~ [deltas], tl, br | inside_test(tl, br ,p + d) != [] ):
    d ~> [get_valid_deltas_test(p, deltas, tl, br)].
get_valid_deltas_test(p, _ <~ [deltas], tl, br): 
    get_valid_deltas_test(p, deltas, tl, br).

hash_list_test([], acc): acc.
hash_list_test(v <~ [V], acc): hash_list_test(V, acc*9 + v).

hash_board_test(board): hash_list_test(flatten(board), 0).

get_initial_position_test(board):
    n <- find(0, flatten(board))
    [n/3, n %3].

get_cell_test(A, i, j):
    row <- A[i]
    row[j].

swap_cell_test(A, zi, zj, ni, nj, i, j | i = zi /\ j = zj): get_cell_test(A, ni, nj).
swap_cell_test(_, _, _, ni, nj, i, j | i = ni /\ j = nj): 0.
swap_cell_test(A, _, _, _, _, i, j): get_cell_test(A, i, j).

next_board_test(A, [zi,zj], [di, dj] ):
    ni <- zi + di
    nj <- zj + dj
    [ [ swap_cell_test(A, zi, zj, ni, nj, i, j) | 0 <= j < len(A[0]) ] | 0 <= i < (len(A) / len(A[0])) ].

prune_backtrack_test([], _): [].
prune_backtrack_test(b <~ [B], lb | b = lb): prune_backtrack_test(B, lb).
prune_backtrack_test(b <~ [B], lb): b ~> [prune_backtrack_test(B, lb)].

is_valid_move_test(a, b):
    pa <- get_initial_position_test(a)
    pb <- get_initial_position_test(b)
    delta <- pb - pa
    allowed <- [[-1,0], [1,0], [0,1], [0,-1]]
    valid_delta <- find(delta, allowed)
    nb <- next_board_test(a, pa, delta)
    is_valid_move2_test(valid_delta, nb, b).

is_valid_move2_test(v, nb, b | v != -1 /\ nb = b): 1.
is_valid_move2_test(_, _, _): 0.

test_8_puzzle_helpers():
    say('===== 8 puzzle extra tests =====')
    board <- [[1,2,3],[4,5,6],[7,0,8]]
    final <- [[1,2,3],[4,5,6],[7,8,0]]

    assert(inside_test([0,0],[3,3],[2,2]), [[2,2]])
    assert(inside_test([0,0],[3,3],[3,0]), [])

    assert(get_valid_deltas_test([1,1], [[-1,0],[1,0],[0,1],[0,-1]], [0,0], [3,3]), [[-1,0],[1,0],[0,1],[0,-1]])
    assert(get_valid_deltas_test([0,0], [[-1,0],[1,0],[0,1],[0,-1]], [0,0], [3,3]), [[1,0],[0,1]])

    assert(list_len3_test([1,2,3,4]), 4)
    assert(list_len3_test([[1],[2],[3]]), 3)

    assert(hash_list_test([1,2,3],0), 102)
    assert(hash_board_test(final), 54480996)

    assert(next_board_test(board, [2,1], [0,1]), final)
    assert(get_initial_position_test(final), [2,2])
    assert(get_initial_position_test(board), [2,1])

    assert(prune_backtrack_test([board, final], board), [final])

    assert(is_valid_move_test(board, final), 1)
    assert(is_valid_move_test(final, board), 1)
    assert(is_valid_move_test(board, board), 0)

    1.
