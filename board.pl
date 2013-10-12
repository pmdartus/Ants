:- module(board,[
	board_length/1, default_board/1, 
	resources1/2, resources2/2, pos_p1/2, pos_p2/2, walls/2, 
	display_board/1,get_element_at_position/3
	]).
% ----------------------------------------
%             Constantes
% ----------------------------------------

% Default board structure (4x4 size)
%	1 _ _ w
%	w _ _ w
%	2 _ w _
%	w _ _ w

board_length(X):- X is 4.
default_board(Board):- Board = [1,9,[4,5,8,11,13,16],[],[]].

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% Acessor(+Board, -Item)
% Return into the seccond argument the selected item

resources1([_,_,_,Resources1,_],Resources1).
resources2([_,_,_,_,Resources2],Resources2).
pos_p1([Player1_pos,_,_,_,_],Player1_pos).
pos_p2([_,Player2_pos,_,_,_],Player2_pos).
walls([_,_,Walls,_,_],Walls).

% get_element_at_position(+Board, +Position, -Type)
% Retun the type of the element in position Position

get_element_at_position(Board, Position, Type):- walls(Board,Walls), member(Position, Walls), Type=walls.
get_element_at_position(Board, Position, Type):- resources1(Board,R1), member(Position,R1), Type=resource1.
get_element_at_position(Board, Position, Type):- resources2(Board,R2), member(Position,R2), Type=resource2.
get_element_at_position(Board, Position, Type):- pos_p1(Board, Position), Type=p1.
get_element_at_position(Board, Position, Type):- pos_p2(Board, Position), Type=p2.
get_element_at_position(Board, Position, Type):- Type=empty.


% display_board(+Board)
% Display the board passed in argument
display_board(Board) :- nl, display_element(Board, 1).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% display_element(+Board, +Index)
% Display the element at the selected index ( begin at 1 )
display_element(_, Index) :- board_length(Length), Index > Length * Length, nl. 
display_element(Board, Index) :-  pos_p1(Board,Pos), 
                                member(Index, [Pos]), 
                                write('1'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :-  pos_p2(Board,Pos), 
                                member(Index, [Pos]), 
                                write('2'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :-  walls(Board,Pos), 
                                member(Index, Pos), 
                                write('M'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :-  write('_'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).

% next_display(+Index)
% Select if the at this index it should break or not
next_display(Index) :- board_length(Length), Index mod Length =:= 0, nl. 
next_display(Index) :- write(' '). 