:-  use_module(ai_basic).
:-  use_module(board).
:-  use_module(players).
:-  use_module(file).
:-  use_module(resources).
:-  use_module(pathfinding).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ants.
% Launch the game with the default map
ants :- board:board(Board), write('Initial board is :     '),pos_p1(Board,J1),b_setval(b1, J1),pos_p2(Board,J2),b_setval(b2, J2),display_board(Board),game(Board,1).

% ants(+Board).
% Launch the game with a custom Board loaded from a file
ants(Board, Size) :- load(Board, Size),ants.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% win(+Player, +Board).
% Is true when a player win

% Official !!! Déjà Testé et CA MARCHE !
win(1,Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y), board:resources(Board,Res), length(Res,LongR), delete(Res,Y,T), length(T,Long1), Long1>(LongR/2).
win(2,Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y), board:resources(Board,Res), length(Res,LongR), delete(Res,X,T), length(T,Long2), Long2>(LongR/2).
%win(1,Board) :- pos_p1(Board,P),P=10 .
%win(2,Board) :- pos_p2(Board,P),P=10 .

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


