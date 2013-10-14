:-  use_module(ai_basic).
:-  use_module(ai2).
:-  use_module(board).
:-  use_module(players).
:-  use_module(file).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ants.
% Launch the game with the default map
ants :- default_board(Board), write('Initial board is :     '),display_board(Board),game(Board,1).

% ants(+Board).
% Launch the game with a custom Board
ants(Board) :- write('Initial board is :     '),display_board(Board),nl,game(Board,1).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% win(+Player, +Board).
% Is true when a player win
win(1,Board) :- pos_p1(Board,P),P=10 .
win(2,Board) :- pos_p2(Board,P),P=10 .

% play1(+Board, ?NewBoard).
% Make a turn for the user 1, it returns the new Board with a changes executed during this turn
play1(Board , NewBoard) :- available_moves(Board, 1, Moves), write('Moves available for 1: '), write(Moves), nl, ai_basic:play(Board, 1, Moves, NewBoard),display_board(Board),nl.

% play2(+Board, ?NewBoard).
% Make a turn for the user 2, it returns the new Board with a changes executed during this turn
play2(Board , NewBoard) :- available_moves(Board, 2, Moves), write('Moves available for 2: '), write(Moves), nl, ai_basic:play(Board, 2, Moves, NewBoard),display_board(Board),nl.

% game(+Board, +Player).
% Change the player turn and verify first if a player won the game during the last turn
game(Board , _) :- win(1, Board),write('//////  P1 win! /////////'), display_board(Board).
game(Board , _) :- win(2, Board),write('//////  P2 win! /////////'), display_board(Board).
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1).