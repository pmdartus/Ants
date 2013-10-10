resources1([_,_,_,Resources1,_],Resources1).
resources2([_,_,_,_,Resources2],Resources2).
pos_p1([Player1_pos,_,_,_,_],Player1_pos).
pos_p2([_,Player2_pos,_,_,_],Player2_pos).
walls([_,_,Walls,_,_],Walls).

% Using Board as the main data structure : 

board_length(X):- X is 4.

% Default board structure (invocation of ants w/o arguments)
%[
%1,e,e,w,
%w,e,e,w,
%2,e,w,e,
%w,e,e,w
%]

default_board(Board):- Board = [1,9,[4,5,8,11,13,16],[],[]].