use find, unique, do_until_success, replace_matrix_element

is_valid(B, v, [i,j]):
    # look into the current row and column
    x <- [B[i]] ++ [B[0..-1, j]]
    # look into the current 3x3 square. with this create a unique list of numbers
    # and check if v is there. Multiply by -1 since find() returns -1 when the number is not found
    -1* find(v,unique([x] ++ [flatten(B[3*(i/3)  .. 3*(i/3)+2, 3*(j/3) .. 3*(j/3)+2])])).

get_next_empty_position(B): 
    p <- find(0,flatten(B))
    [p / 9, p % 9].

# if there are no more 0 cells then we found the solution :)
sudoku_backtracking(B | find(0,flatten(B)) = -1): [1,B]. 
# try out this branch of the tree
sudoku_backtracking(B):
    pos <- get_next_empty_position(B)
    do_until_success([ [solve, [B,v,pos]  ] | 1 <= v <=  9]).

# backtrack if the candidate is not valid
solve([B, v, pos] | is_valid(B,v,pos) != 1): [0,[]].
# otherwise keep exploring DFS style
solve([B, v, pos]): 
    M <- replace_matrix_element(B, v, pos)
    sudoku_backtracking(M).
