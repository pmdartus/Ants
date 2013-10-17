:-  use_module(ai_basic).
:-  use_module(board).
:-  use_module(players).
:-  use_module(file).
:-  use_module(resources).
:-  use_module(pathfinding).

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
board([8,20,[1,2,3,4,5,6,7,11,12,13,14,17,18,19,22,24,25,26,29,30,31,32,33,34,35,36],[],[]]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ants.
% Launch the game with the default map
ants :- board(Board), write('Initial board is :     '),display_board(Board),game(Board,1).

% ants(+Board).
% Launch the game with a custom Board
ants(Board) :- write('Initial board is :     '),display_board(Board),nl,game(Board,1).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% win(+Player, +Board).
% Is true when a player win

% Official !!!
% win(1,Board) :- not(has_ressource(Board,1)).
% win(2,Board) :- not(has_ressource(Board,2)).
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


