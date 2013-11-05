:- module(board,[
	resources/2, pos_p1/2, pos_p2/2, walls/2, 
	display_board/1,get_element_at_position/3
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
board:board_length(6).
board:board([8,20,[1,2,3,4,5,6,7,11,12,13,14,17,18,19,22,24,25,26,29,30,31,32,33,34,35,36],[9,27, 15, 23]]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% Acessor(+Board, -Item)
% Return into the seccond argument the selected item

resources([_,_,_,Resources],Resources).
pos_p1([Player1_pos,_,_,_],Player1_pos).
pos_p2([_,Player2_pos,_,_],Player2_pos).
walls([_,_,Walls,_],Walls).

% get_element_at_position(+Board, +Position, -Type)
% Retun the type of the element in position Position

get_element_at_position(Board, Position, Type):- walls(Board,Walls), member(Position, Walls), !, Type=walls.
get_element_at_position(Board, Position, Type):- resources(Board,R), member(Position,R), Type=resource.
get_element_at_position(Board, Position, Type):- pos_p1(Board, Position), Type=p1.
get_element_at_position(Board, Position, Type):- pos_p2(Board, Position), Type=p2.
get_element_at_position(_, _, Type):- Type=empty.


% display_board(+Board)
% Display the board passed in argument
display_board(Board) :- nl, display_element(Board, 1).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% display_element(+Board, +Index)
% Display the element at the selected index ( begin at 1 )
display_element(_, Index) :- board:board_length(Length), Index > Length * Length, nl. 
display_element(Board, Index) :- get_element_at_position(Board, Index, p1), 
                                display_if_carrying(Board, 1),
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :- get_element_at_position(Board, Index, p2),  
                                ansi_format([fg(red)], '2', []), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :- get_element_at_position(Board, Index, walls), 
                                ansi_format([bg(cyan)], ' ', []), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :- get_element_at_position(Board, Index, resource), 
                                ansi_format([fg(blue)], '*', []),  
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).
display_element(Board, Index) :-  write(' '), 
                                NewIndex is Index+1, next_display(Index), display_element(Board , NewIndex).

% next_display(+Index)
% Select if the at this index it should break or not
next_display(Index) :- board:board_length(Length), Index mod Length =:= 0, nl. 
next_display(_) :- write(''). 

% display_if_carrying(+Player)
display_if_carrying(Board, 1) :- carry_resource(Board, 1), ansi_format([underline, fg(green)], '1', []).
display_if_carrying(Board, 1) :- not(carry_resource(Board, 1)), ansi_format([fg(green)], '1', []).

display_if_carrying(Board, 2) :- carry_resource(Board, 1), ansi_format([underline, fg(red)], '2', []).
display_if_carrying(Board, 2) :- not(carry_resource(Board, 1)), ansi_format([fg(red)], '2', []).
