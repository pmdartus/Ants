% AI shortest path + resources far away

						
						
						
play(Board, 1, Moves, NewBoard):-
    not(carry_resource(Board, 1)),
    pos_p1(Board,PJ1),b_getval(b1,B1),b_getval(b2,B2),
    board:resources(Board,Res),length(Res,Long)
	far_ressource(Res,PJ1,LongRes,0,1,0,Pr), Pr \=B1,Pr \=B2,
    pathfinding:appel(Board,PJ1,1,Pr,[],[PH|PT],Leng,1),
    write('Aim for resource '),write(Pr),nl,
    write('I should move to '), write(PH),nl,
    update_user_position(Board, 1, PH, NewBoard).						



% return the resource farest from the player
far_resource(Res,PJ1,LongRes,Index,1,Long,Pr) :-  nth0(Index,Res,PrNew),
							% Calcul de la longueur
						board:board_length(Size),DivEnt1 is PJ1//Size,DivEnt2 is PrNew//Size,
						Mod1 is PJ1 mod Size,Mod2 is PrNew mod Size,
						thales(DivEnt1,DivEnt2,Mod1,Mod2,LongNow), LongNow>=Long,	
							% Iteration
						NewIndex is Index+1, NewIndex<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,1,Long,Pr).

far_resource(Res,PJ1,LongRes,Index,1,Long,Pr) :-  nth0(Index,Res,PrNew),
							% Calcul de la longueur
						board:board_length(Size),DivEnt1 is PJ1//Size,DivEnt2 is PrNew//Size,
						Mod1 is PJ1 mod Size,Mod2 is PrNew mod Size,
						thales(DivEnt1,DivEnt2,Mod1,Mod2,LongNow),LongNow<Long,	
							% Iteration
						NewIndex is Index+1, NewIndex<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,1,LongNow,PrNew).


thales(DivEnt1,DivEnt2,Mod1,Mod2,LongNow) :- LongNow1 is (DivEnt1-DivEnt2)*(DivEnt1-DivEnt2),
									LongNow2 is (Mod1-Mod2)*(Mod1-Mod2),
									LongNow is LongNow1+LongNow2.


