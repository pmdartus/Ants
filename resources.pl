:- module(ressources,[
	carry_resource/2,
	update_resource_position/4,
	not_resources/3
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

% update_resource_position(+Ressources, +ActPosition, +NewPos, -NewRessource)
% Return new array of ressources, with the selected ressource postion update
update_resource_position(R0, OldPos, _, R0) :- b_getval(b1,X), X == OldPos, !.
update_resource_position(R0, OldPos, _, R0) :- b_getval(b2,X), X == OldPos, !.
update_resource_position(R0, OldPos, NewPos, [NewPos|R]) :- delete(R0, OldPos, R).

% Prise de la ressource




% Voyage avec la ressource
% carry_resource(+Board, +Player)
% Return if the selected player is carrying a ressource
carry_resource(Board, 1) :- pos_p1(Board, Pos), resources(Board, Res), member(Pos, Res).
carry_resource(Board, 2) :- pos_p2(Board, Pos), resources(Board, Res), member(Pos, Res).

% Pose de la ressource



% Général ressource
% not_ressources(+Board)
% Return true if ressources are not anymore on the board (there're in the basis)
not_resources(Board,B1,B2) :- board:resources(Board, Res), delete(Res,B1,T), delete(T,B2,[]).

 
% ----------------------------------------
%           Private Methods
% ----------------------------------------
