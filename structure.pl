
% Using Board as the main data structure : 



ants(Board) :- game(Board,1).

% And 2nd parameter represents player who is turn
game(Board , _) :- win(1, Board),write('p1 win!').
game(Board , _) :- win(2, Board),write('p2 win!').

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1). 

play1(Board , NewBoard):- Board = NewBoard.
play2(Board , NewBoard):- Board = NewBoard.

win(Player,Board) :- get_char(Y), Y=:=1.