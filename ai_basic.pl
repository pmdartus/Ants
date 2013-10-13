:- module(ai_basic,[play/3]).

play([_|T], Moves, NewBoard):-
	length(Moves, Length),
	Index is random(Length),
	nth0(Index, Moves, NP1),
    NewBoard = [NP1|T].


