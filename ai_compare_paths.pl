:- module(ai_compare_paths,[]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

play(Board,1,Moves,NewBoard) :-     
									not(carry_resource(Board, 1)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,
    								is_my_path_shorter(Board,1,P1,P2,Pr,[PH|PT]),
    								write('Aim for resource '),write(Pr),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 1, PH, NewBoard).

play(Board,1,Moves,NewBoard) :-     
									not(carry_resource(Board, 1)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,
    								not(is_my_path_shorter(Board,1,P1,P2,Pr,[PH|PT])),
    								write('I should put a wall @ '),write(PH),nl,
								    place_wall(Board, 1, PH, NewBoard).

play(Board,1,Moves,NewBoard) :-     
									carry_resource(Board, 1),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								pathfinding:appel(Board,P1,1,B1,[],[PH|PT],Leng,1),
    								write('Aim for base '),write(B1),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 1, PH, NewBoard).


play(Board,2,Moves,NewBoard) :-     
									not(carry_resource(Board, 2)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,
    								is_my_path_shorter(Board,2,P1,P2,Pr,[PH|PT]),
    								write('Aim for resource '),write(Pr),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 2, PH, NewBoard).

play(Board,2,Moves,NewBoard) :-     
									not(carry_resource(Board, 2)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,
    								not(is_my_path_shorter(Board,2,P1,P2,Pr,[PH|PT])),
    								write('I should put a wall @ '),write(PH),nl,
								    place_wall(Board, 2, PH, NewBoard).

play(Board,2,Moves,NewBoard) :-     
									carry_resource(Board, 2),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								pathfinding:appel(Board,P2,2,B2,[],[PH|PT],Leng,1),
    								write('Aim for base '),write(B1),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 1, PH, NewBoard).



% ----------------------------------------
%           Private Methods
% ----------------------------------------

is_my_path_shorter(Board,2,P1,P2,Goal,Path1) :- pathfinding:appel(Board,P2,2,Goal,[],Path1,Length,1),pathfinding:appel(Board,P1,1,Goal,[],P,Leng,1),Length <= Leng,!, write('My path is shorter!'),write(Path1).
is_my_path_shorter(Board,1,P1,P2,Goal,Path2) :- pathfinding:appel(Board,P1,1,Goal,[],Path2,Length,1),pathfinding:appel(Board,P2,2,Goal,[],P,Leng,1),Length < Leng,!, write('My path is shorter!'),write(Path2).

