:-  use_module(ai1).
:-  use_module(ai2).
:- [initialGrid].


resources1([_,_,_,Resources1,_],Resources1).
resources2([_,_,_,_,Resources2],Resources2).
pos_p1([Player1_pos,_,_,_,_],Player1_pos).
pos_p2([_,Player2_pos,_,_,_],Player2_pos).
walls([_,_,Walls,_,_],Walls).

% Using Board as the main data structure : 

board_length(X):- X is 4.
%[
%1,e,e,w,
%w,e,e,w,
%2,e,w,e,
%w,e,e,w
%]


ants() :- game([1,9,[4,5,8,11,13,16],[],[]],1).

%Get position of a player
pos_player(Board,Player,Position) :- nth0(Player,Board,Position).



% And 2nd parameter represents player who is turn
game(Board , _) :- win(1, Board),write('p1 win!'),nl.
game(Board , _) :- win(2, Board),write('p2 win!'),nl.

% Play and switch turns
game(Board , 1) :- play1(Board , NewBoard), game(NewBoard , 2). 
game(Board , 2) :- play2(Board , NewBoard), game(NewBoard , 1). 

play1([Player1_pos|T], NewBoard):- 
    NP1 is Player1_pos+1,
    NewBoard = [NP1|T],
    write('p1 plays'),nl,
    write(NewBoard),
    get(_).


play2(Board , NewBoard):- Board = NewBoard, write('p2 plays'),nl,write(NewBoard),get(_).

win(1,Board) :- pos_p1(Board,P),P=3 .
win(2,Board) :- pos_p2(Board,P),P=3 .