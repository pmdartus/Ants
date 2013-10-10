
% Using Board as the main data structure : 

board_length(X):- X is 4.

ants(Board) :- print_board(
[
e,e,e,w,
w,e,e,w,
e,e,w,e,
w,e,e,w
],1).

print_board([],P).
print_board([T|Q],P) :- board_length(BL),length(Q,L),M is mod(L,BL),M==0, write(T),nl, print_board(Q,P).
print_board([T|Q],P) :- write(T), print_board(Q,P).

% And 2nd parameter represents player who is turn
game(Board , _) :- win(1, Board),write('p1 win!'),nl.
game(Board , _) :- win(2, Board),write('p2 win!'),nl.

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1). 

play1(Board , NewBoard):- Board = NewBoard, write('p1 plays'),nl.
play2(Board , NewBoard):- Board = NewBoard, write('p2 plays'),nl.

win(Player,Board) :- fail.