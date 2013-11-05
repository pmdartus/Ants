:- module(play_near_basic,[
	play1/2, play2/2
	]).


% ----------------------------------------
%           Public Methods
% ----------------------------------------

% play1(+Board, ?NewBoard).
% Make a turn for the user 1, it returns the new Board with a changes executed during this turn
play1(Board , NewBoard) :- available_moves(Board, 1, Moves), write('Moves available for 1: '), write(Moves), nl, ai_spf_near:play(Board, 1, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.

% play2(+Board, ?NewBoard).
% Make a turn for the user 2, it returns the new Board with a changes executed during this turn
play2(Board , NewBoard) :- available_moves(Board, 2, Moves), write('Moves available for 2: '), write(Moves), nl, ai_basic:play(Board, 2, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.
