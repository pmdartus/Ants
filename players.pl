:- module(players,[
	available_moves/3,
	update_user_position/4
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% available_moves(+Board, +Player, -Moves)
% Return in Moves the available position arround the selected player 
available_moves(Board,1,Moves) :- 
	pos_p1(Board,Pos),
	findall(Move, get_move(Board, Pos, 1, Move), Moves).
available_moves(Board,2,Moves) :- 
	pos_p2(Board,Pos),
	findall(Move, get_move(Board,Pos, 2,Move), Moves).

% update_user_position(+Board, +Player, +NewPosition, -NewBoard)
% Update the postion of the selected user and return it into NewBoard 
% Not carring resource
update_user_position([Pos1, Pos2, Walls, R], 1, NewPosition, [NewPosition, Pos2, Walls, R]) :- not(carry_resource([Pos1, Pos2, Walls, R],1)),write('Player 1 move to :'), write(NewPosition), nl.
update_user_position([Pos1, Pos2, Walls, R], 2, NewPosition, [Pos1, NewPosition, Walls, R]) :- not(carry_resource([Pos1, Pos2, Walls, R],2)),write('Player 2 move to :'), write(NewPosition), nl.
% Carrying a resource
update_user_position([Pos1, Pos2, Walls, R0], 1, NewPosition, [NewPosition, Pos2, Walls, R]) :- 
	carry_resource([Pos1, Pos2, Walls, R0],1),
	update_resource_position(R0, 1, Pos1, NewPosition, R),
	write('Player 1 move and carry resource to :'), write(NewPosition), nl.

update_user_position([Pos1, Pos2, Walls, R0], 2, NewPosition, [Pos1, NewPosition, Walls, R]) :- 
	carry_resource([Pos1, Pos2, Walls, R0],2), 
	update_resource_position(R0, 2, Pos2, NewPosition, R),
	write('Player 2 move and carry resource to :'), write(NewPosition), nl.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% get_move(+Board, +Position, +Player, -Move)
% Returns the possible moves
% Check for current position if it is available
get_move(Board, Position, 1, Move):-get_surround(Position,Index),Index =\= 0,
		not(carry_resource(Board,1)), 
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p2)), Move=Index.
get_move(Board, Position, 1, Move):-get_surround(Position,Index),Index =\= 0,
		carry_resource(Board,1), Position =\= Index, not(get_element_at_position(Board, Index, resource)),
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p2)), Move=Index.
get_move(Board, Position, 2, Move):-get_surround(Position,Index),Index =\= 0, 
		not(carry_resource(Board,2)),
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p1)), Move=Index.
get_move(Board, Position, 2, Move):-get_surround(Position,Index),Index =\= 0, 
		carry_resource(Board,2), Position =\= Index, not(get_element_at_position(Board, Index, resource)),
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p1)), Move=Index.
        	% special get_move pour les bases joueur 1
get_move(Board, Position, 1, Move):- get_surround(Position,Index),Index =\= 0,
		carry_resource(Board,1), Position =\= Index, b_getval(b1,X), X is Index,
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p2)), Move=Index.
	% special get_move pour les bases joueur 2
get_move(Board, Position, 2, Move):- get_surround(Position,Index),Index =\= 0,
		carry_resource(Board,2), Position =\= Index, b_getval(b2,Y), Y is Index,
        not(get_element_at_position(Board,Index,walls)), 
        not(get_element_at_position(Board,Index,p1)), Move=Index.

		
		
		
% get_surround( +Position, -Index)
% Returns positions of the surroundings for a given cardinal
% Left
get_surround(Position,Index):-board:board_length(Length), Position mod Length =:= 1, Index = 0.
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 1, Index is (Position-1).
% Right
get_surround(Position,Index):-board:board_length(Length), Position mod Length =:= 0, Index = 0.
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 0, Index is (Position+1).
% Top
get_surround(Position,Index):-board:board_length(Length), Position > Length, Index is (Position-Length).
get_surround(Position,Index):-board:board_length(Length), Position =< Length, Index = 0.
% Bottom
get_surround(Position,Index):-board:board_length(Length), Position < Length*Length - Length, Index is (Position+Length).
get_surround(Position,Index):-board:board_length(Length), Position >= Length*Length - Length, Index = 0. 
% Top Left
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 1, Position > Length, Index is Position - Length - 1.
% Top Right
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 0, Position > Length, Index is Position - Length + 1.
% Bottom Left
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 1, Position < Length*Length - Length, Index is Position + Length - 1.
% Bottom Right
get_surround(Position,Index):-board:board_length(Length), Position mod Length =\= 0, Position < Length*Length - Length, Index is Position + Length + 1. 
