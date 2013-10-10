:-  use_module(ai1).
:-  use_module(ai2).
:- [board].


ants :- default_board(Board), write('Initial board is :     '),write(Board),nl,game(Board,1).
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

