
arr_eq([],[]): 1.
arr_eq(A,B | len(A) != len(B)): 0.
arr_eq(a <~ [A] , b <~ [B] | a != b): 0.
arr_eq(a <~ [A] , b <~ [B]): arr_eq(A,B).

