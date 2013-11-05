:-  use_module(ai_basic).
:-  use_module(ai_spf).
:-  use_module(ai_compare_paths).
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
ants(Board, Size) :- load(Board, Size),log_board_name(Board) ,ants.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% win(+Player, +Board).
% Is true when a player win

% Official !!! Déjà Testé et CA MARCHE !
win(1,Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y), board:resources(Board,Res), length(Res,LongR), delete(Res,Y,T), length(T,Long1), Long1>(LongR/2),Points1 is Long1,Points2 is LongR-Long1, log_points(Points1,Points2).
win(2,Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y), board:resources(Board,Res), length(Res,LongR), delete(Res,X,T), length(T,Long2), Long2>(LongR/2),Points2 is Long2,Points1 is LongR-Long2, log_points(Points1,Points2).
%TODO : on y est presque
%win(2,Board) :- b_getval(b1,X),pos_p1(Board,P1),P1 \= X,not(pathfinding:accessible(Board,X,1,P1)),!,write('bloc'),nl.
%win(1,Board) :- b_getval(b2,Y),pos_p2(Board,P2),P2 \= Y,not(pathfinding:accessible(Board,Y,1,P2)),!,write('bloc'),nl.

win(null,Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y), board:resources(Board,Res), length(Res,LongR), delete(Res,X,T), length(T,Long2), LongR =:= (Long2*2), log_points(0,0).

% TODO : Add : win when there no longer exist a path between all remaining resources and a base
% ie : the remaining resources are impossible to bring to a base


% play1(+Board, ?NewBoard).
% Make a turn for the user 1, it returns the new Board with a changes executed during this turn
%play1(Board , NewBoard) :- available_moves(Board, 1, Moves), write('Moves available for 1: '), write(Moves), nl, ai_basic:play(Board, 1, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.
%play1(Board , NewBoard) :- available_moves(Board, 1, Moves), write('Moves available for 1: '), write(Moves), nl, ai_spf:play(Board, 1, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.
play1(Board , NewBoard) :- available_moves(Board, 1, Moves), write('Moves available for 1: '), write(Moves), nl, ai_compare_paths:play(Board, 1, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.


% play2(+Board, ?NewBoard).
% Make a turn for the user 2, it returns the new Board with a changes executed during this turn
play2(Board , NewBoard) :- available_moves(Board, 2, Moves), write('Moves available for 2: '), write(Moves), nl, ai_basic:play(Board, 2, Moves, NewBoard), write('The new board is :'), write(NewBoard), display_board(NewBoard), nl.

% game(+Board, +Player).
% Change the player turn and verify first if a player won the game during the last turn
game(Board , _) :- win(1, Board),write('//////  P1 win! /////////'), display_board(Board).
game(Board , _) :- win(2, Board),write('//////  P2 win! /////////'), display_board(Board).
game(Board , _) :- win(null, Board),write('//////  Match null /////////'), display_board(Board).
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1).


% Format of log files : 
% 1 line per game
% name of board, points for player 1, points for player 2
log_board_name(Board) :- open('results.csv', append, Handle), write(Handle, Board),write(Handle, ','), close(Handle).
log_points(Points1,Points2) :- open('results.csv', append, Handle), write(Handle, Points1),write(Handle, ','), write(Handle, Points2),write(Handle, '\n'), close(Handle).