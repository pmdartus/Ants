:- module(ai_compare_paths,[play/4, is_shorter/8]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------

play(Board,1,Moves,NewBoard) :-     
									not(carry_resource(Board, 1)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2, Pr \= P2,
    								is_shorter(Board,1,P1,P2,Pr,[PH|PT],Path2,R),R =:= 1,
    								write('Aim for resource '),write(Pr),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 1, PH, NewBoard).

play(Board,1,Moves,NewBoard) :-     
									not(carry_resource(Board, 1)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2, Pr \= P2,
                                    is_shorter(Board,1,P1,P2,Pr,[PH|PT],Path2,R),R =:= 0,
                                    nth0(J,Path2,W),
                                    write('I should put a wall at '),write(W),nl,
                                    place_wall(Board, 1, W, NewBoard).

play(Board,1,Moves,NewBoard) :-     
                                    not(carry_resource(Board, 1)),
                                    pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
                                    board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2, Pr \= P2,
                                    is_shorter(Board,1,P1,P2,Pr,[PH|PT],Path2,R),R =:= 0,
                                    nth0(J,Path2,W),
                                    write('I should put a wall at '),write(W),nl,
                                    not(place_wall(Board, 1, W, NewBoard)),write('But I cannot, so I will move'),nl,
                                    update_user_position(Board, 1, PH, NewBoard).

    						
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
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,Pr \= P1,
    								is_shorter(Board,2,P1,P2,Pr,Path1,[PH|PT],R), R =:= 1,
    								write('Aim for resource '),write(Pr),nl,
    								write('I should move to '), write(PH),nl,
    								update_user_position(Board, 2, PH, NewBoard).

play(Board,2,Moves,NewBoard) :-     
									not(carry_resource(Board, 2)),
									pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
    								board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,Pr \= P1,
    								is_shorter(Board,2,P1,P2,Pr,Path1,[PH|PT],R), R =:= 0,
                                    nth0(J,Path1,W),
    								write('I should put a wall at '),write(W),nl,
								    place_wall(Board, 2, W, NewBoard).

play(Board,2,Moves,NewBoard) :-     
                                    not(carry_resource(Board, 2)),
                                    pos_p1(Board,P1),pos_p2(Board,P2),b_getval(b1,B1),b_getval(b2,B2),
                                    board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2, Pr \= P1,
                                    is_shorter(Board,2,P1,P2,Pr,Path1,[PH|PT],R),R =:= 0,
                                    nth0(J,Path2,W),
                                    write('I should put a wall at '),write(W),nl,
                                    not(place_wall(Board, 2, W, NewBoard)),write('But I cannot, so I will move'),nl,
                                    update_user_position(Board, 2, PH, NewBoard).



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

is_shorter(Board,2,P1,P2,Goal,Path1,Path2,1) :- pathfinding:appel(Board,P2,2,Goal,[],Path2,Length,1),pathfinding:appel(Board,P1,1,Goal,[],Path1,Leng,1),Length =< Leng.
is_shorter(Board,1,P1,P2,Goal,Path1,Path2,1) :- pathfinding:appel(Board,P1,1,Goal,[],Path1,Length,1),pathfinding:appel(Board,P2,2,Goal,[],Path2,Leng,1),Length =< Leng.

is_shorter(Board,2,P1,P2,Goal,Path1,Path2,0) :- pathfinding:appel(Board,P2,2,Goal,[],Path2,Length,1),pathfinding:appel(Board,P1,1,Goal,[],Path1,Leng,1),not(Length =< Leng).
is_shorter(Board,1,P1,P2,Goal,Path1,Path2,0) :- pathfinding:appel(Board,P1,1,Goal,[],Path1,Length,1),pathfinding:appel(Board,P2,2,Goal,[],Path2,Leng,1),not(Length =< Leng).

is_shorter(Board,1,P1,P2,Goal,Path1,Path2,2) :- not(pathfinding:appel(Board,P1,1,Goal,[],Path1,Length,1)).
is_shorter(Board,2,P1,P2,Goal,Path1,Path2,2) :- not(pathfinding:appel(Board,P2,2,Goal,[],Path2,Length,1)).


is_shorter(Board,1,P1,P2,Goal,Path1,Path2,1) :- not(pathfinding:appel(Board,P2,2,Goal,[],Path2,Length,1)).
is_shorter(Board,2,P1,P2,Goal,Path1,Path2,1) :- not(pathfinding:appel(Board,P1,1,Goal,[],Path1,Length,1)).