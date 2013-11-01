:- module(ressources,[
	carry_resource/2,
	not_resources/3,
	wintest/2,
	init/2
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------



% Prise de la ressource




% Voyage avec la ressource
% carry_resource(+Board, +Player)
% Return if the selected player is carrying a ressource
carry_resource(Board, 1) :- pos_p1(Board, Pos), resources(Board, Res), member(Pos, Res).
carry_resource(Board, 2) :- pos_p2(Board, Pos), resources(Board, Res), member(Pos, Res).

% Pose de la ressource



% Général ressource
% board_ressources(+Board)
% Return true if ressources are not anymore on the board (there're in the basis)
not_resources(Board,B1,B2) :- board:resources(Board, Res), delete(Res,B1,T), delete(T,B2,[]).

 
% ----------------------------------------
%           Private Methods
% ----------------------------------------
