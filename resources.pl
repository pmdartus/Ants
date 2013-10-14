:- module(ressources,[
	carry_resource/2,
	has_ressources/2
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% carry_resource(+Board, +Player)
% Return if the selected player is carrying a ressource
carry_resource(Board, 1) :- pos_p1(Board, Pos), resources1(Board, Res), member(Pos, Res).
carry_resource(Board, 2) :- pos_p2(Board, Pos), resources2(Board, Res), member(Pos, Res).

% has_ressources(+Board, +Player)
% Return if the selected user has ressources on the board
has_ressources(Board, 1) :- resources1(Board, Res), length(Res, Length), Length =\= 0.
has_ressources(Board, 2) :- resources2(Board, Res), length(Res, Length), Length =\= 0.

% ----------------------------------------
%           Private Methods
% ----------------------------------------
