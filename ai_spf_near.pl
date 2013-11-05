% AI shortest path + resources near

						
						
						
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
						board:board_length(Size),PJ1/Size is Calcul1, PrNew/Size is Calcul2,
						Calcul2-Calcul1 is LongNow, LongNow>=Long,	
							% Iteration
						NewIndex is Index+1, NewIndex<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,1,Long,Pr).

far_resource(Res,PJ1,LongRes,Index,1,Long,Pr) :-  nth0(Index,Res,PrNew),
							% Calcul de la longueur
						board:board_length(Size),PJ1/Size is Calcul1, PrNew/Size is Calcul2,
						Calcul2-Calcul1 is LongNow,LongNow<Long,	
							% Iteration
						NewIndex is Index+1, NewIndex<LongRes, far_resource(Res,PJ1,LongRes,NewIndex,1,LongNow,PrNew).




