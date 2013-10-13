:- module(players,[available_moves/3]).

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

move_right(Board, Pos1, Moves):- Right is Pos1 + 1, get_element_at_position(Board, Right, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, Moves = [Right].
move_right(_, _, _).

move_left(Board, Pos1, Moves, NewMoves):- Left is Pos1 - 1, get_element_at_position(Board, Left, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Left, Temp), flatten(Temp, NewMoves) .
move_left(_, _, Moves, Moves).

move_top(Board, Pos1, Moves, NewMoves):- board_length(Length), Top is Pos1 - Length , get_element_at_position(Board, Top, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Top, Temp), flatten(Temp, NewMoves).
move_top(_, _, Moves, Moves).

move_bottom(Board, Pos1, Moves, NewMoves):- board_length(Length), Bottom is Pos1 + Length , get_element_at_position(Board, Bottom, Elem), Elem \== walls, Elem \== p1, Elem \== p2, !, append(Moves, Bottom, Temp), flatten(Temp, NewMoves).
move_bottom(_, _, Moves, Moves).