:- module(ai_spf,[play/4]).


% ----------------------------------------
%           Public Methods
% ----------------------------------------

% play(+Board, +Player, +Move, -NewBoard)
% Return in new Board, the next position of the player
play(Board, Player, Moves, Board):- 
    length(Moves, N),
    N == 0,
    write('pass').

play(Board, 1, Moves, NewBoard):-
    not(carry_resource(Board, 1)),
    pos_p1(Board,PJ1),b_getval(b1,B1),b_getval(b2,B2),
    board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1,Pr \=B2,
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

play(Board,1,Moves,Board) :- write('I pass'),nl.


%play(Board, 1, Moves, Board):-
%    pos_p1(Board,PJ1),,b_getval(b1,B1),b_getval(b2,B2)
%    board:resources(Board,Res),nth0(I,Res,Pr), Pr \=B1, Pr \=B2,
%    pathfinding:appel(Board,PJ1,1,Pr,[],[PH|PT],Leng,1),!,
%    write('Aim for resource '),write(Pr),nl,
%    write('I should move to '), write(PH),nl,fail.