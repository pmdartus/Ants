:- module(ai_basic,[play/4]).


% ----------------------------------------
%           Public Methods
% ----------------------------------------

% play(+Board, +Player, +Move, -NewBoard)
% Return in new Board, the next postion of the player
play(Board, Player, Moves, NewBoard):-
	length(Moves, Length),
	Index is random(Length),
	nth0(Index, Moves, NewPosition),
    update_user_position(Board, Player, NewPosition, NewBoard).