1. subsequence(S,L) : 
Logic Used:
    The predicate has three clauses. The first one is the base case: an empty list is a subsequence of any list. 
    The second clause checks if the head of the first list matches the head of the second list, and recursively checks if the tail of the first list is a subsequence of the tail of the second list.
    The third clause skips the head of the second list and checks if the first list is a subsequence of the tail of the second list.
Input: S: A list of elements that needs to be checked if it's a subsequence of L.
       L: A list of elements where S needs to be checked if it's a subsequence.
Output : true: If S is a subsequence of L, i.e., all the elements in S are present in L in the same order, but not necessarily successively.
         false: If S is not a subsequence of L.
Corner Cases: 
    If S is an empty list, the predicate returns true as an empty list is always a subsequence of any list.
    If L is an empty list and S is not an empty list, the predicate returns false as L doesn't have any elements to compare with S.
    If S and L are both empty lists, the predicate returns true as an empty list is always a subsequence of any list, including another empty list.
    If S and L both contain the same elements in the same order, the predicate returns true.
    If L contains all the elements of S in the same order, but there are additional elements in L, the predicate returns true.
    If S contains an element that is not present in L, the predicate returns false.
    If S contains elements that are present in L but not in the same order, the predicate returns false.

2. has_no_triplicates(L):
Logic Used:
     The list is sorted using the mergesort algorithm. If the sorted list contains three or more occurrences of an element, the predicate has_triplicates([X,X,X|_]) returns true. If the sorted list does not contain three or more occurrences of an element, the not(has_triplicates(X)) predicate returns true, and the has_no_triplicates(L) predicate returns true.
Input: A list L of elements.
Output: A boolean value true if L does not contain three (or more) copies of an element, and false otherwise.

3. arith(L):
Logic Used:
    The logic of the function is to generate all possible operator combinations that can be applied to the elements of L using the create_op predicate. It is also ensured that the operator list contains only one equality operator. These combinations are then combined with the elements of L using the combine predicate to generate a list of operands and operators in the correct order. The break_list predicate is then used to split the list of operands and operators into two lists, one for the left-hand side of the equation and one for the right-hand side. The evaluate predicate is used to compute the value of each side of the equation, and valid_eq is used to check if the equation is valid. Finally, tostring is used to convert the lists of operands and operators into a string representation of the equation.
Input: A list of integers L
Output: A string X that represents a valid arithmetic equation using the elements of L and the operators +, -, and =.As it was specified in the assignment , to print a correct equation, code results in single equation by default. However,the code can give all possible correct equations as output, if ! operator inserted at the end of the arith function is removed. 
Corner Cases: 
    The function handles corner cases such as an empty input list gives message 'Empty List' as output. It also checks for the presence of multiple equality operators and ensures that the operator list contains only one equality operator.This code also may return equation containing a minus sign in front of a negative integer which in turn gives equation containing two consecutive minus signs or a plus sign followed by a minus sign.

4. abcd():
Logic Used:
    The problem requires finding all possible valid routes for the four paddlers to cross the river, with only one/two people on the canoe at a time, and satisfying the given constraints. The program uses a recursive depth-first search approach to explore all possible paths starting from the initial state of the problem (where all paddlers are on the left bank and the canoe is on the left bank as well).
    For each state of the problem, the program constructs the canoe based on the previous direction of travel and the available paddlers, and checks whether the canoe satisfies the constraints given in the problem statement. If the canoe is correct, the program simulates the crossing and generates the next state of the problem. If the next state has not been previously visited, the program adds it to the list of visited states and continues the search recursively from that state. If the current state is a valid end state (i.e., all paddlers have crossed the river to the right bank), the program prints out the route and identifies the paddler who has paddled twice.
    To check whether a route is valid i.e. all the people have paddled atleast once, the program keeps track of the number of crossings made by each paddler in the route. If a paddler has crossed the river twice, the program identifies that paddler as the one who has peddled twice in the given route.
    Overall, the program implements a backtracking algorithm to systematically explore all possible paths and find all valid solutions to the problem.
Input: No input is required for this program.
Output: 
The program outputs all possible valid combinations for the four paddlers to cross the river in the given scenario. It also identifies the paddler who has peddled twice in each valid route.
The program outputs a list of moves(canoes) required to get all four people across the river. Each move is represented as a two-element list, where the  first element is the list of people in the canoe during that move and the second element is the direction of the move (left_to_right or right_to_left) and the. The first member of the persons list in a canoe represents the paddler for that move.
For example: 
[[[alice,bob],left_to_right]], [[[alice],right_to_left]], [[[carol,davis],left_to_right]], [[[bob],right_to_left]], [[[bob,carol],left_to_right,]] represents the solution where Alice and Bob cross together first from left_to_right with Alice as paddler, followed by Alice crossing alone, then Carol and Davis crossing together from left_to_right with carol as paddler, then Bob crossing alone, and finally Bob and Carol crossing together from left_to_right with Bob as paddler. The person firstly mentioned in this list is the paddler.
