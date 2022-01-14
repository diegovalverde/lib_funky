use assert, rroll, croll, roll

test_roll():
  say('====== test roll =======')
  A <- [[1,0,0],[0,0,0],[0,0,0]]

  M <- [[1,2,3],[4,5,6],[7,8,9]]

  assert( rroll(M,0), M) 
  assert( croll(M,0), M) 
  assert( croll(rroll(M,0),0), M)

  # roll 1D
  assert( rroll([1,2,3,4],0), [1,2,3,4]) 
  assert( rroll([1,2,3,4],1), [4,1,2,3]) 
  assert( rroll([1,2,3,4],2), [3,4,1,2]) 
  assert( rroll([1,2,3,4],3), [2,3,4,1]) 
  assert( rroll([1,2,3,4],4), [1,2,3,4]) 

  assert( rroll([1,2,3,4],-1), [2,3,4,1]) 
  assert( rroll([1,2,3,4],-2), [3,4,1,2]) 
  assert( rroll([1,2,3,4],-3), [4,1,2,3])
  assert( rroll([1,2,3,4],-4), [1,2,3,4])  

  # roll 2D down/up
  assert(rroll(M,1), [[7,8,9],[1,2,3],[4,5,6]])
  assert(rroll(M,2), [[4,5,6],[7,8,9],[1,2,3]])
  assert(rroll(M,3), M)

  assert(rroll(M,-1), [[4,5,6],[7,8,9],[1,2,3]])
  assert(rroll(M,-2), [[7,8,9],[1,2,3],[4,5,6]])
  assert(rroll(M,-3), M)

  # roll 2D left/right
  assert(croll(M,1), [[3,1,2],[6,4,5],[9,7,8]])
  assert(croll(M,2), [[2,3,1],[5,6,4],[8,9,7]])
  assert(croll(M,3), M)

  assert(croll(M,-1), [[2,3,1],[5,6,4],[8,9,7]])
  assert(croll(M,-2), [[3,1,2],[6,4,5],[9,7,8]])
  assert(croll(M,-3), M)

  #assert(roll(A,0,0),A)
  #assert(roll(A,-3,-3),A)
  # assert(roll(A,0,1),[[0,1,0],[0,0,0],[0,0,0]])
  # assert(roll(A,1,0),[[0,0,0],[1,0,0],[0,0,0]])
  # assert(roll(A,1,1),[[0,0,0],[0,1,0],[0,0,0]])
  # assert(roll(A,0,-1),[[0,0,1],[0,0,0],[0,0,0]])
  # assert(roll(A,-1,0),[[0,0,0],[0,0,0],[1,0,0]])
  # assert(roll(A,-1,-1),[[0,0,0],[0,0,0],[0,0,1]])
  # assert(roll(A,-2,-2),[[0,0,0],[0,1,0],[0,0,0]])
  1.
