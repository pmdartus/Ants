:-  use_module(ai1).
:-  use_module(ai2).
:- [board].


ants :- default_board(Board), write('Initial board is :     '),nl,display_board(Board, 1),game(Board,1).
ants(Board) :-  write('Initial board is :     '),write(Board),nl,game(Board,1).


%Choose AI
play1(Board , NewBoard) :- ai1:play(Board,NewBoard), write('p1 plays, board is now '),write(NewBoard),nl.
play2(Board , NewBoard) :- ai2:play(Board,NewBoard), write('p2 plays, board is now '),write(NewBoard),nl.


% Define win conditions
win(1,Board) :- pos_p1(Board,P),P=3 .
win(2,Board) :- pos_p2(Board,P),P=3 .

% Stop game if 1 player wins
game(Board , _) :- win(1, Board),write('p1 win!'),nl.
game(Board , _) :- win(2, Board),write('p2 win!'),nl.

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1).

display_board(_, 17) :- nl. 
display_board(Board, Index) :-  pos_p1(Board,Pos), 
                                member(Index, [Pos]), 
                                write('1'), 
                                NewIndex is Index+1, next_display(Index), display_board(Board , NewIndex).
display_board(Board, Index) :-  pos_p2(Board,Pos), 
                                member(Index, [Pos]), 
                                write('2'), 
                                NewIndex is Index+1, next_display(Index), display_board(Board , NewIndex).
display_board(Board, Index) :-  walls(Board,Pos), 
                                member(Index, Pos), 
                                write('M'), 
                                NewIndex is Index+1, next_display(Index), display_board(Board , NewIndex).
display_board(Board, Index) :-  write('_'), 
                                NewIndex is Index+1, next_display(Index), display_board(Board , NewIndex).

next_display(Index) :- Index mod 4 =:= 0, nl. 
next_display(Index) :- write(' '). 