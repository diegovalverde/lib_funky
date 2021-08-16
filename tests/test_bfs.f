use bfs, assert, arr_eq


tree(0): [1,2,3,4].
tree(1): [5,6].
tree(4): [7,8].
tree(7): [9,10].
tree(_): [].

tree_is_goal(10) :
    say('found solution = 10')
    1.

tree_is_goal(n): 0.


other_tree([0, _] ): [  [1, [0]],[2, [0]], [3, [0]],  [4, [0]]   ] .
other_tree([1, r] ): 
    x <- 1
    [  [5, [r]++[x]],[6, [r]++[x]]]. 
    
other_tree([4, r] ): 
    x <- 4
    [  [7, [r]++[x]],[8, [r]++[x]]].
other_tree([7, r] ): 
    x <- 7
    [  [9, [r]++[x]],[10, [r]++[x]]].
other_tree([_,_]): [].   

other_tree_is_goal([10, r]): 
    x <- 10
    say('the end')
    say('r is', r)
    1.
other_tree_is_goal([_,_]): 0.



test_bfs():
      say('=== BFS test tree ===')
      assert(arr_eq(tree(0), [1,2,3,4]), 1)
      assert(arr_eq(tree(1), [5,6]), 1)
      assert(arr_eq(tree(4), [7,8]), 1)
      assert(arr_eq(tree(7), [9,10]), 1)
      
      assert(bfs(tree_is_goal,tree,[0]), 10)
      # look for the path to get to the goal
      sol <- bfs(other_tree_is_goal,other_tree,[ [0, []] ])
      assert(sol[0], 10)
      assert(sol[1], [0,4,7])
      1.
