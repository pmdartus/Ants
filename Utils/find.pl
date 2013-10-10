:-module(find,
	[
		get_board/3
	]).

% get_player_board(+Player, +Board, -PlayerBoard)
%
% Return  the general board for Player = 0 
% or the selected player board Player = 1 or 2
get_board(Player,Board,PlayerBoard) :- nth0(Player,Board,PlayerBoard).