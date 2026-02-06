use astar, assert, arr_eq

# comparator by cost (lower cost first)
astar_test_by_cost(a, b | a[1] < b[1]): 1.
astar_test_by_cost(_, _): 0.

astar_test_by_cost_rev(a, b | a[1] > b[1]): 1.
astar_test_by_cost_rev(_, _): 0.

# goal is state 3
astar_test_is_goal(n | n[0] = 3): 1.
astar_test_is_goal(_): 0.

# small acyclic graph with two paths to goal
append1([], v): [v].
append1(x <~ [xs], v): x ~> [append1(xs, v)].

astar_test_next_nodes([0, _, _]):
    [ [1, 1, [0,1]], [2, 5, [0,2]] ].
astar_test_next_nodes([1, _, path]):
    [ [3, 2, append1(path, 3)] ].
astar_test_next_nodes([2, _, path]):
    [ [3, 6, append1(path, 3)] ].
astar_test_next_nodes(_): [].

# graph with no goal reachable
astar_test_next_nodes_dead([0, _, _]): [ [1, 1, [0,1]] ].
astar_test_next_nodes_dead([1, _, path]): [ [2, 2, append1(path, 2)] ].
astar_test_next_nodes_dead(_): [].

mk_list(0, _): [].
mk_list(n, v): v ~> [mk_list(n-1, v)].

prepend(x, xs): x ~> [xs].

test_astar():
    say('===== astar tests =====')

    # empty frontier returns []
    assert(astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost, []), [])

    # start already at goal
    goal_start <- astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost, [[3, 0, [3]]])
    assert(goal_start[0], 3)

    # finds lowest-cost solution
    start <- [0, 0, [0]]
    sol <- astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost, [start])
    assert(sol[0], 3)
    assert(sol[1], 2)
    assert(arr_eq(sol[2], [0,1,3]), 1)

    # higher-cost comparator picks the worse path
    sol_hi <- astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost_rev, [start])
    assert(sol_hi[0], 3)
    assert(sol_hi[1], 6)

    # no solution returns []
    dead <- astar(astar_test_is_goal, astar_test_next_nodes_dead, astar_test_by_cost, [[0,0,[0]]])
    assert(dead, [])

    # respects MAX_EXPLORE_LEN limit
    many <- mk_list(200, [99, 0, []])
    over <- astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost, many)
    assert(over, [])

    # goal is returned even if explore length exceeds MAX_EXPLORE_LEN
    over_goal <- prepend([3, 2, [3]], many)
    over_goal_sol <- astar(astar_test_is_goal, astar_test_next_nodes, astar_test_by_cost, over_goal)
    assert(over_goal_sol[0], 3)

    1.
