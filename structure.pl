
% Using Board as the main data structure : 

ants(Board) :- game(
[
e,e,e,
w,e,e,
e,e,w
],1).

% And 2nd parameter represents player who is turn
game(Board , _) :- win(1, Board),write('p1 win!'),nl.
game(Board , _) :- win(2, Board),write('p2 win!'),nl.

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1). 

play1(Board , NewBoard):- Board = NewBoard, write('p1 plays'),nl.
play2(Board , NewBoard):- Board = NewBoard, write('p2 plays'),nl.

win(Player,Board) :- fail.