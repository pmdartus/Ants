:-module(ai1,[]).

play([Player1_pos|T], NewBoard):- 
    NP1 is Player1_pos+1,
    NewBoard = [NP1|T].


