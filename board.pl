:- module(board,[
	resources1/2, resources2/2, pos_p1/2, pos_p2/2, walls/2, 
	display_board/1,get_element_at_position/3,get_moves/3
	]).

% ----------------------------------------
%             Dynamic
% ----------------------------------------

%Define the board function as dynamic -> can be edited by assert & retract
:- dynamic([
    board/1, board_length/1
    ]).

% Default board structure (4x4 size)
%  1/  w w w w w w
%  7/  w 1 _ _ w w
% 13/  w w _ _ w w
% 19/  w 2 _ w _ w
% 25/  w w _ _ w w
% 31/  w w w w w w

%Define the default board
board_length(6).
assert(board([8,20,[1,2,3,4,5,6,7,11,12,13,14,17,18,19,22,24,25,26,29,30,31,32,33,34,35,36],[],[]])).



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

get_element_at_position(Board, Position, Type):- walls(Board,Walls), member(Position, Walls), !, Type=walls.
get_element_at_position(Board, Position, Type):- resources1(Board,R1), member(Position,R1), Type=resource1.
get_element_at_position(Board, Position, Type):- resources2(Board,R2), member(Position,R2), Type=resource2.
get_element_at_position(Board, Position, Type):- pos_p1(Board, Position), Type=p1.
get_element_at_position(Board, Position, Type):- pos_p2(Board, Position), Type=p2.
get_element_at_position(_, _, Type):- Type=empty.

% get_moves(+Board, +Position, Move)
% Returns the possible moves

get_moves(Board, Position, Move):-get_surround(Board,Position,Cardinal,Index),Index =\= 0, 
                                  not(get_element_at_position(Board,Index,walls)), 
				  not(get_element_at_position(Board,Index,p1)), 
				  not(get_element_at_position(Board,Index,p2)), Move=Cardinal.


% display_board(+Board)
% Display the board passed in argument
display_board(Board) :- nl, display_element(Board, 1).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% display_element(+Board, +Index)
% Display the element at the selected index ( begin at 1 )
display_element(_, Index) :- board_length(Length), Index > Length * Length, nl. 
display_element(Board, Index) :- get_element_at_position(Board, Index, p1), 
                                write('1'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :- get_element_at_position(Board, Index, p2),  
                                write('2'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :- get_element_at_position(Board, Index, walls), 
                                write('M'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :-  write('_'), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).

% next_display(+Index)
% Select if the at this index it should break or not
next_display(Index) :- board_length(Length), Index mod Length =:= 0, nl. 
next_display(_) :- write(' '). 


% get_surround(+Board, +Position, -Cardinal, -Index)
% Returns positions of the surroundings for a given cardinal

get_surround(Board,Position,left,Index):-board_length(Length), Position mod Length =:= 1, Index = 0.
get_surround(Board,Position,left,Index):-board_length(Length), Position mod Length =\= 1, Index is (Position-1).

get_surround(Board,Position,right,Index):-board_length(Length), Position mod Length =:= 0, Index = 0.
get_surround(Board,Position,right,Index):-board_length(Length), Position mod Length =\= 0, Index is (Position+1).

get_surround(Board,Position,top,Index):-board_length(Length), Position > Length, Index is (Position-Length).
get_surround(Board,Position,top,Index):-board_length(Length), Position =< Length, Index = 0.

get_surround(Board,Position,bottom,Index):-board_length(Length), Position < Length*Length - Length, Index is (Position+Length).
get_surround(Board,Position,bottom,Index):-board_length(Length), Position >= Length*Length - Length, Index = 0. 
