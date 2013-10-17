:-  use_module(board).
:-  use_module(players).

%%Ne fonctionne pas pour le moment, il boucle à l'infini, mais renvoie qqmm un chemin 

%TODO : Inverser la récursion de la ligne 10
% Essayé pendant 2 heures, j'en peux plus...

board([8,20,[1,2,3,4,5,6,7,11,12,13,14,17,18,19,22,24,25,26,29,30,31,32,33,34,35,36],[],[]]).

test:- board(Board), path(Board,8,1,25,Nodes).

edge(Board,A,J,B) :- players:get_move(Board, A, J, B).

path(Board,A,J,B,Nodes) :- edge(Board,A,J,B),not(member(B,Nodes)).
path(Board,A,J,B,Nodes) :- edge(Board,A,J,C),not(member(C,Nodes)),path(Board,C,B,[C|Nodes]).
