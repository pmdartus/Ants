:-  use_module(ai1).
:-  use_module(ai2).
:- [initialGrid].

% Définition du critère d'arret du jeux :
% Un joueur gagne la partie quand il a ramené toutes les ressources à sa base
% /!\ Necesité de différencier les ressources
win(joueur1) :- case(X,Y,_,base1), case(X,Y,_,rsc1), 
	write('Le joueur 1 a gagne.'), nl
win(joueur2) :- case(X,Y,_,base2), case(X,Y,_,rsc2), 
	write('Le joueur 2 a gagne.'), nl

%%Exemples : 

% Appel au ask_move de l'ai1 : 
% ?-ai1:ask_move(X,Y,Z).
% Appel au ask_move de l'ai2 : 
% ?-ai2:ask_move(X,Y,Z).