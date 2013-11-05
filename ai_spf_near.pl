:- module(ai_spf_near,[
		play/4, far_resource_total/5,
		far_resource/6, max/3, calcul_longueur/3]).

:- dynamic tempsPr/1.

% AI shortest path + resources far away

						
						
						
play(Board, 1, Moves, NewBoard):-
    not(carry_resource(Board, 1)),
    pos_p1(Board,PJ1),b_getval(b1,B1),b_getval(b2,B2),
    board:resources(Board,Resou),
	delete(Resou,B1,Reso),delete(Reso,B2,Res), length(Res,LongRes),
	far_resource_total(Res,PJ1,LongRes,Long,Pr), 
    pathfinding:appel(Board,PJ1,1,Pr,[],[PH|PT],Leng,1),
    write('Aim for resource '),write(Pr),nl,
    write('I should move to '), write(PH),nl,
    update_user_position(Board, 1, PH, NewBoard).

play(Board, 1, Moves, NewBoard):-
    carry_resource(Board, 1),
    pos_p1(Board,PJ1),b_getval(b1,B1),   
    pathfinding:appel(Board,PJ1,1,B1,[],[PH|PT],Leng,1),
    write('Aim for base '),write(B1),nl,
    write('I should move to '), write(PH),nl,
    update_user_position(Board, 1, PH, NewBoard).

play(Board, 1, Moves, NewBoard):-
    pos_p2(Board,PJ2),b_getval(b2,B2),   
    pathfinding:appel(Board,PJ2,1,B2,[],[PH|PT],Leng,1),
    write('I should put a wall @ '),write(PH),nl,
    place_wall(Board, 1, PH, NewBoard).

play(Board,1,Moves,Board) :- write('I pass'),nl.	

% IDEM player 2

% Search for a ressource
play(Board, 2, Moves, NewBoard):-
    not(carry_resource(Board, 2)),
    pos_p2(Board,PJ2),b_getval(b1,B1),b_getval(b2,B2),
	board:resources(Board,Resou),
	delete(Resou,B1,Reso),delete(Reso,B2,Res), length(Res,LongRes),
	far_resource_total(Res,PJ2,LongRes,Long,Pr),
    pathfinding:appel(Board,PJ2,2,Pr,[],[PH|PT],Leng,1),
    write('Aim for resource '),write(Pr),nl,
    write('I should move to '), write(PH),nl,
    update_user_position(Board, 2, PH, NewBoard).

% Going back to base while carrying a ressource
play(Board, 2, Moves, NewBoard):-
    carry_resource(Board, 2),
    pos_p2(Board,PJ2),b_getval(b2,B2),   
    pathfinding:appel(Board,PJ2,2,B1,[],[PH|PT],Leng,1),
    write('Aim for base '),write(B2),nl,
    write('I should move to '), write(PH),nl,
    update_user_position(Board, 2, PH, NewBoard).

% Place a wall
play(Board, 2, Moves, NewBoard):-
    pos_p1(Board,PJ1),b_getval(b1,B1),   
    pathfinding:appel(Board,PJ1,2,B1,[],[PH|PT],Leng,1),
    write('I should put a wall @ '),write(PH),nl,
    place_wall(Board, 2, PH, NewBoard).

% Nothing to do
play(Board,2,Moves,Board) :- write('I pass'),nl.


%main call
far_resource_total(Res,PJ1,LongRes,Long,Pr) :- far_resource(Res,PJ1,LongRes,0,Long,_), tempsPr(Pr), retract(tempsPr(Pr)).

% return the resource nearest from the player
far_resource(Res,PJ1,LongRes,LongRes,Long,Pr) :- assert(tempsPr(Pr)).

far_resource(Res,PJ1,LongRes,0,Long,Pr) :- nth0(0,Res,PrNew),
							calcul_longueur(PJ1,PrNew,LongNow),	
							% Iteration
						NewIndex is 1, NewIndex=<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,LongNow,PrNew).	

far_resource(Res,PJ1,LongRes,Index,Long,Pr) :-  nth0(Index,Res,PrNew),
							calcul_longueur(PJ1,PrNew,LongNow),LongNow>=Long,	
							% Iteration
						NewIndex is Index+1, NewIndex=<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,Long,Pr).						

far_resource(Res,PJ1,LongRes,Index,Long,Pr) :-  nth0(Index,Res,PrNew),
							calcul_longueur(PJ1,PrNew,LongNow),LongNow<Long,	
							% Iteration
						NewIndex is Index+1, NewIndex=<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,LongNow,PrNew).
										

max(LongNow1,LongNow2,LongNow) :- LongNow1>=LongNow2, LongNow is LongNow1.
max(LongNow1,LongNow2,LongNow) :- LongNow1<LongNow2, LongNow is LongNow2.
calcul_longueur(PJ1,PrNew,LongNow) :- board:board_length(Size),DivEnt1 is PJ1//Size,DivEnt2 is PrNew//Size,
						Mod1 is PJ1 mod Size,Mod2 is PrNew mod Size,
						LongNow1 is abs(Mod2-Mod1), LongNow2 is abs(DivEnt2-DivEnt1), 
						max(LongNow1,LongNow2,LongNow).



