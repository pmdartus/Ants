:-  use_module(ai_basic).
:-  use_module(ai_spf).
:-  use_module(ai_spf_near).
:-  use_module(ai_compare_paths).
:-  use_module(board).
:-  use_module(players).
:-  use_module(file).
:-  use_module(resources).
:-  use_module(pathfinding).

%Choose IA for player 1 & 2.
:-  use_module(play_spf_near).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ants.
% Launch the game with the default map
ants :- board:board(Board), write('Initial board is :     '),pos_p1(Board,J1),b_setval(b1, J1),pos_p2(Board,J2),b_setval(b2, J2),display_board(Board),game(Board,1).

% ants(+Board).
% Launch the game with a custom Board loaded from a file
ants(Board, Size) :- load(Board, Size),log_board_name(Board),ants.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% blocked_state(+Board)
% Check if the board is in a stuck state
% No more resources
blocked_state(Board) :- b_getval(b1,X), b_getval(b2,Y), resources:not_resources(Board,X,Y). 
% Player 1 blocked
blocked_state(Board) :- 
	b_getval(b1,X),pos_p1(Board,P1),P1 \= X, pos_p2(Board,P2),P2 \= X, 
	not(pathfinding:accessible(Board,P1,1,X)),!,write('Joueur 1 ne peut pas retourner à sa base'),nl.
% Player 2 blocked
blocked_state(Board) :- 
	b_getval(b2,Y),pos_p2(Board,P2),P2 \= Y, pos_p1(Board,P1),P1 \= Y, 
	not(pathfinding:accessible(Board,P2,2,Y)),!,write('Joueur 2 ne peut pas retourner a sa base'),nl.

% get_winner(+Board, -Winner)
% return by the Winner the player which win
get_winner(Board, 1) :- 
	b_getval(b1,X), b_getval(b2,Y), board:resources(Board,Res), 
	length(Res,LongR), delete(Res,Y,T), length(T,Long1), Long1>(LongR/2),Points1 is Long1,Points2 is LongR-Long1,
	log_points(Points1,Points2).
get_winner(Board, 2) :- 
	b_getval(b1,X), b_getval(b2,Y), board:resources(Board,Res), 
	length(Res,LongR), delete(Res,X,T), length(T,Long2), Long2>(LongR/2),Points2 is Long2,Points1 is LongR-Long2, 
	log_points(Points1,Points2).
get_winner(Board, null) :-
	b_getval(b1,X), b_getval(b2,Y), board:resources(Board,Res), 
	length(Res,LongR), delete(Res,X,T), length(T,Long2), LongR =:= (Long2*2), 
	log_points(0,0).

display_winner(1) :- write('/////// Player 1 win /////////').
display_winner(2) :- write('/////// Player 2 win /////////').
display_winner(null) :- write('/////// Match null /////////').

% game(+Board, +Player).
% Change the player turn and verify first if a player won the game during the last turn
game(Board , _) :- blocked_state(Board), get_winner(Board, X), display_winner(X), display_board(Board).
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1).


% Format of log files : 
% 1 line per game
% name of board, points for player 1, points for player 2
log_board_name(Board) :- open('games/results.csv', append, Handle), write(Handle, Board),write(Handle, ','), close(Handle).
log_points(Points1,Points2) :- open('games/results.csv', append, Handle), write(Handle, Points1),write(Handle, ','), write(Handle, Points2),write(Handle, '\n'), close(Handle).
