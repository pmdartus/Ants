%Grille principale: player is 0, X and Y is 36

%Grille de test
case(0, 0, 0, 1).
case(1, 0, 0, 2).
case(2, 0, 0, 3).
case(0, 1, 0, 4).
case(1, 1, 0, 5).
case(2, 1, 0, 6).
case(0, 2, 0, 7).
case(1, 2, 0, 8).
case(2, 2, 0, 9).

disp_case(X, Y) :- case(X, Y, 0, Type), write_term(Type, []).

disp_grid(0, 0).
disp_grid(0, Y) :- nl, disp_case(X, Y), disp_grid(0, X, Yp), Y is Yp+1.
disp_grid(X, Y) :- disp_case(X, Y), disp_grid(0, Xp, Y), X is Xp+1.