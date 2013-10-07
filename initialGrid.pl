% TODO : Modéliser la grille avec des prédicats "case"


%Dimensions de la grille: 36X36


%Position initiale des joueurs:
%-J1 -> 18;2
%-J2 -> 18;33


Case(18,2,0,Joueur1).

Case(18,33,0,Joueur2).

Case(18,2,0,base1).

Case(18,33,0,base2).


%Position des resources: Rsc1 -> ressource joueur1, Rsc2 -> ressource joueur2

Case(1,33,0,Rsc1).

Case(17,19,0,Rsc1).

Case(34,20,0,Rsc1).

Case(1,2,0,Rsc2).

Case(19,16,0,Rsc2).

Case(34,15,0,Rsc2).



%Obstacle droit

Case(6,13,0,obstacle).

Case(6,22,0,obstacle).

Case(7,13,0,obstacle).

Case(7,22,0,obstacle).

Case(8,13,0,obstacle).

Case(8,22,0,obstacle).

Case(9,13,0,obstacle).

Case(9,22,0,obstacle).

Case(10,13,0,obstacle).

Case(10,22,0,obstacle).

Case(25,13,0,obstacle).

Case(26,13,0,obstacle).

Case(27,13,0,obstacle).

Case(28,13,0,obstacle).

Case(29,13,0,obstacle).

Case(25,22,0,obstacle).

Case(26,22,0,obstacle).

Case(27,22,0,obstacle).

Case(28,22,0,obstacle).

Case(29,22,0,obstacle).

%Obstacle du milieu

Case(15,15,0,obstacle).

Case(16,15,0,obstacle).

Case(17,15,0,obstacle).

Case(18,15,0,obstacle).

Case(19,15,0,obstacle).

Case(20,15,0,obstacle).

Case(21,15,0,obstacle).

Case(15,20,0,obstacle).

Case(16,20,0,obstacle).

Case(17,20,0,obstacle).

Case(18,20,0,obstacle).

Case(19,20,0,obstacle).

Case(20,20,0,obstacle).

Case(21,20,0,obstacle).

Case(18,16,0,obstacle).

Case(18,17,0,obstacle).

Case(18,18,0,obstacle).

Case(18,19,0,obstacle).

%Obstacle en U

Case(7,5,0,obstacle).

Case(8,5,0,obstacle).

Case(9,5,0,obstacle).

Case(10,5,0,obstacle).

Case(11,5,0,obstacle).

Case(7,6,0,obstacle).

Case(8,6,0,obstacle).

Case(9,6,0,obstacle).

Case(10,6,0,obstacle).

Case(11,6,0,obstacle).

Case(7,10,0,obstacle).

Case(8,10,0,obstacle).

Case(9,10,0,obstacle).

Case(10,10,0,obstacle).

Case(11,10,0,obstacle).

Case(7,11,0,obstacle).

Case(8,11,0,obstacle).

Case(9,11,0,obstacle).

Case(10,11,0,obstacle).

Case(11,11,0,obstacle).

Case(11,7,0,obstacle).

Case(11,8,0,obstacle).

Case(11,9,0,obstacle).


Case(7,24,0,obstacle).

Case(8,24,0,obstacle).

Case(9,24,0,obstacle).

Case(10,24,0,obstacle).

Case(11,24,0,obstacle).

Case(7,25,0,obstacle).

Case(8,25,0,obstacle).

Case(9,25,0,obstacle).

Case(10,25,0,obstacle).

Case(11,25,0,obstacle).

Case(7,29,0,obstacle).

Case(8,29,0,obstacle).

Case(9,29,0,obstacle).

Case(10,29,0,obstacle).

Case(11,29,0,obstacle).

Case(7,30,0,obstacle).

Case(8,30,0,obstacle).

Case(9,30,0,obstacle).

Case(10,30,0,obstacle).

Case(11,30,0,obstacle).

Case(11,26,0,obstacle).

Case(11,27,0,obstacle).

Case(11,28,0,obstacle).


Case(24,5,0,obstacle).

Case(25,5,0,obstacle).

Case(26,5,0,obstacle).

Case(27,5,0,obstacle).

Case(28,5,0,obstacle).

Case(24,6,0,obstacle).

Case(25,6,0,obstacle).

Case(26,6,0,obstacle).

Case(27,6,0,obstacle).

Case(28,6,0,obstacle).

Case(24,10,0,obstacle).

Case(25,10,0,obstacle).

Case(26,10,0,obstacle).

Case(27,10,0,obstacle).

Case(28,10,0,obstacle).

Case(24,11,0,obstacle).

Case(25,11,0,obstacle).

Case(26,11,0,obstacle).

Case(27,11,0,obstacle).

Case(28,11,0,obstacle).

Case(24,7,0,obstacle).

Case(24,8,0,obstacle).

Case(24,9,0,obstacle).


Case(24,24,0,obstacle).

Case(25,24,0,obstacle).

Case(26,24,0,obstacle).

Case(27,24,0,obstacle).

Case(28,24,0,obstacle).

Case(24,25,0,obstacle).

Case(25,25,0,obstacle).

Case(26,25,0,obstacle).

Case(27,25,0,obstacle).

Case(28,25,0,obstacle).

Case(24,29,0,obstacle).

Case(25,29,0,obstacle).

Case(26,29,0,obstacle).

Case(27,29,0,obstacle).

Case(28,29,0,obstacle).

Case(24,30,0,obstacle).

Case(25,30,0,obstacle).

Case(26,30,0,obstacle).

Case(27,30,0,obstacle).

Case(28,30,0,obstacle).

Case(24,26,0,obstacle).

Case(24,27,0,obstacle).

Case(24,28,0,obstacle).






