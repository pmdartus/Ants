:-  use_module(board).
:-  use_module(players).

%%Ne fonctionne pas pour le moment, il boucle à l'infini, mais renvoie qqmm un chemin 

test:- default_board(Board), existeChemin(Board,1,8,10,W,Chemin).

existeChemin(_,_,A,A,W,Chemin):- write(1),W is 0, Chemin = A.
existeChemin(Board,P,A,B,W,Chemin) :- write(2),players:get_move(Board, A, P, B), W is 1, Chemin = [B].
existeChemin(Board,P,A,B,W,Chemin) :- write(3),existeChemin(Board,P,A,C,Wac,CheminAC), players:get_move(Board, C, P, B),not(nth1(_,CheminAC,B)) ,W is Wac + 1, append(CheminAC,[B],Chemin).

