% TODO : Modéliser la grille avec des prédicats "case"

%Dimensions de la grille: 36X36
%Ligne à TESTER!!! puis reproduire pour générer les bordures
Case(X,Y,0,bord):-X==-1,Y<36.

%Position initiale des joueurs:
%-J1 -> 18;2
%-J2 -> 18;33

case(18,2,0,joueur1).
case(18,33,0,joueur2).
case(18,2,0,base1).
case(18,33,0,base2).

%Position des resources: Rsc1 -> ressource joueur1, Rsc2 -> ressource joueur2
case(1,33,0,rsc1).
case(17,19,0,rsc1).
case(34,20,0,rsc1).
case(1,2,0,rsc2).
case(19,16,0,rsc2).
case(34,15,0,rsc2).

%Obstacle droit
case(6,13,0,obstacle).
case(6,22,0,obstacle).
case(7,13,0,obstacle).
case(7,22,0,obstacle).
case(8,13,0,obstacle).
case(8,22,0,obstacle).
case(9,13,0,obstacle).
case(9,22,0,obstacle).
case(10,13,0,obstacle).
case(10,22,0,obstacle).
case(25,13,0,obstacle).
case(26,13,0,obstacle).
case(27,13,0,obstacle).
case(28,13,0,obstacle).
case(29,13,0,obstacle).
case(25,22,0,obstacle).
case(26,22,0,obstacle).
case(27,22,0,obstacle).
case(28,22,0,obstacle).
case(29,22,0,obstacle).
%Obstacle du milieu
case(15,15,0,obstacle).
case(16,15,0,obstacle).
case(17,15,0,obstacle).
case(18,15,0,obstacle).
case(19,15,0,obstacle).
case(20,15,0,obstacle).
case(21,15,0,obstacle).
case(15,20,0,obstacle).
case(16,20,0,obstacle).
case(17,20,0,obstacle).
case(18,20,0,obstacle).
case(19,20,0,obstacle).
case(20,20,0,obstacle).
case(21,20,0,obstacle).
case(18,16,0,obstacle).
case(18,17,0,obstacle).
case(18,18,0,obstacle).
case(18,19,0,obstacle).
%Obstacle en U
case(7,5,0,obstacle).
case(8,5,0,obstacle).
case(9,5,0,obstacle).
case(10,5,0,obstacle).
case(11,5,0,obstacle).
case(7,6,0,obstacle).
case(8,6,0,obstacle).
case(9,6,0,obstacle).
case(10,6,0,obstacle).
case(11,6,0,obstacle).
case(7,10,0,obstacle).
case(8,10,0,obstacle).
case(9,10,0,obstacle).
case(10,10,0,obstacle).
case(11,10,0,obstacle).
case(7,11,0,obstacle).
case(8,11,0,obstacle).
case(9,11,0,obstacle).
case(10,11,0,obstacle).
case(11,11,0,obstacle).
case(11,7,0,obstacle).
case(11,8,0,obstacle).
case(11,9,0,obstacle).

case(7,24,0,obstacle).
case(8,24,0,obstacle).
case(9,24,0,obstacle).
case(10,24,0,obstacle).
case(11,24,0,obstacle).
case(7,25,0,obstacle).
case(8,25,0,obstacle).
case(9,25,0,obstacle).
case(10,25,0,obstacle).
case(11,25,0,obstacle).
case(7,29,0,obstacle).
case(8,29,0,obstacle).
case(9,29,0,obstacle).
case(10,29,0,obstacle).
case(11,29,0,obstacle).
case(7,30,0,obstacle).
case(8,30,0,obstacle).
case(9,30,0,obstacle).
case(10,30,0,obstacle).
case(11,30,0,obstacle).
case(11,26,0,obstacle).
case(11,27,0,obstacle).
case(11,28,0,obstacle).

case(24,5,0,obstacle).
case(25,5,0,obstacle).
case(26,5,0,obstacle).
case(27,5,0,obstacle).
case(28,5,0,obstacle).
case(24,6,0,obstacle).
case(25,6,0,obstacle).
case(26,6,0,obstacle).
case(27,6,0,obstacle).
case(28,6,0,obstacle).
case(24,10,0,obstacle).
case(25,10,0,obstacle).
case(26,10,0,obstacle).
case(27,10,0,obstacle).
case(28,10,0,obstacle).
case(24,11,0,obstacle).
case(25,11,0,obstacle).
case(26,11,0,obstacle).
case(27,11,0,obstacle).
case(28,11,0,obstacle).
case(24,7,0,obstacle).
case(24,8,0,obstacle).
case(24,9,0,obstacle).

case(24,24,0,obstacle).
case(25,24,0,obstacle).
case(26,24,0,obstacle).
case(27,24,0,obstacle).
case(28,24,0,obstacle).
case(24,25,0,obstacle).
case(25,25,0,obstacle).
case(26,25,0,obstacle).
case(27,25,0,obstacle).
case(28,25,0,obstacle).
case(24,29,0,obstacle).
case(25,29,0,obstacle).
case(26,29,0,obstacle).
case(27,29,0,obstacle).
case(28,29,0,obstacle).
case(24,30,0,obstacle).
case(25,30,0,obstacle).
case(26,30,0,obstacle).
case(27,30,0,obstacle).
case(28,30,0,obstacle).
case(24,26,0,obstacle).
case(24,27,0,obstacle).
case(24,28,0,obstacle).



