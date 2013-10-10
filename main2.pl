:-  use_module(ai1).
:-  use_module(ai2).
:- [initialGrid].

% Using Board as the main data structure : 

board_length(X):- X is 4.
%[
%1,e,e,w,
%w,e,e,w,
%2,e,w,e,
%w,e,e,w
%]


ants(Board) :- game([[4,5,8,11,13,16],1,9],1).

%Get position of a player
pos_player(Board,Player,Position) :- nth0(Player,Board,Position).



% And 2nd parameter represents player who is turn
game(Board , _) :- win(1, Board),write('p1 win!'),nl.
game(Board , _) :- win(2, Board),write('p2 win!'),nl.

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1). 

play1([B,P1,P2] , NewBoard):- 
    NP1 is P1+1,
    NewBoard = [B,NP1,P2],
    write('p1 plays'),nl,
    write(NewBoard),
    get(_).


play2(Board , NewBoard):- Board = NewBoard, write('p2 plays'),nl,write(NewBoard),get(_).

win(Player,[B,P1,P2]) :- P1=3 .
