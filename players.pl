:- module(players,[
	available_moves/3,
	update_user_position/4
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% available_moves(+Board, +Player, ?Moves)
% Return in Moves the available position arround the selected player 
available_moves(Board,1,Moves) :- 
	pos_p1(Board,Pos1),
	move_right(Board, Pos1, M0),
	move_left(Board, Pos1, M0, M1),
	move_top(Board, Pos1, M1, M2),
	move_bottom(Board, Pos1, M2, M3),
	Moves = M3.
available_moves(Board,2,Moves) :- 
	pos_p2(Board,Pos1),
	move_right(Board, Pos1, M0),
	move_left(Board, Pos1, M0, M1),
	move_top(Board, Pos1, M1, M2),
	move_bottom(Board, Pos1, M2, M3),
	Moves = M3.

% get_moves(+Board, +Position, Move)
% Returns the possible moves

get_moves(Board, Position, Move):-get_surround(Board,Position,Cardinal,Index),Index =\= 0, 
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p1)), 
        not(get_element_at_position(Board,Index,p2)), Move=Cardinal.

% update_user_position(+Board, +Player, +NewPosition, -NewBoard)
% Update the postion of the selected user and return it into NewBoard 
update_user_position([_, Pos2, Walls, R1, R2], 1, NewPosition, [NewPosition, Pos2, Walls, R1, R2]) :- write('Player 1 move to :'), write(NewPosition), nl.
update_user_position([Pos1, _, Walls, R1, R2], 2, NewPosition, [Pos1, NewPosition, Walls, R1, R2]) :- write('Player 2 move to :'), write(NewPosition), nl.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% move_right(+Board, +ActualPos, ?Moves)
% Add in Moves the right position if the move if possible
move_right(Board, Pos1, Moves):- Right is Pos1 + 1, get_element_at_position(Board, Right, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, Moves = [Pos1, Right].
move_right(_, _, _).

% move_left(+Board, +ActualPos, +Possible_moves, ?NewMoves)
% Add in NewMoves the left position if the move if possible
move_left(Board, Pos1, Moves, NewMoves):- Left is Pos1 - 1, get_element_at_position(Board, Left, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Left, Temp), flatten(Temp, NewMoves) .
move_left(_, _, Moves, Moves).

% move_top(+Board, +ActualPos, +Possible_moves, ?NewMoves)
% Add in NewMoves the top position if the move if possible
move_top(Board, Pos1, Moves, NewMoves):- board_length(Length), Top is Pos1 - Length , get_element_at_position(Board, Top, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Top, Temp), flatten(Temp, NewMoves).
move_top(_, _, Moves, Moves).

% move_bottom(+Board, +ActualPos, +Possible_moves, ?NewMoves)
% Add in NewMoves the bottom position if the move if possible
move_bottom(Board, Pos1, Moves, NewMoves):- board_length(Length), Bottom is Pos1 + Length , get_element_at_position(Board, Bottom, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Bottom, Temp), flatten(Temp, NewMoves).
move_bottom(_, _, Moves, Moves).



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