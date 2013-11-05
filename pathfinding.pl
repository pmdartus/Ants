:- module(pathfinding,[
	path/6,
        shortest_p/8
	]).

% TODO : use new accessible prediacte in order to find shortest paths : 
%	1 - Test if a path exists
%	2 - If one exists, find for one path 1-step long, if this fails, find for one 1 step longer and so on
% TODO : Wrap this in a function


% ----------------------------------------
%           Public Methods
% ----------------------------------------
% Returns available paths from A to B, considering player J moves
% path(+Board,+A,+J,+B,-Path,?Length).
% Example usage from main : board:board(Board),path(Board,8,1,23,Path,Length).
path(Board,A,J,B,Path,Length) :- path(Board,A,J,B,[],Path,Length).


% checks for accessible before launching one of both shortest_p methods.
% example: board:board(Board),appel(Board,21,1,26,[],Path,Length,1).
appel(Board,A,J,B,Nodes,Path,Length,Max) :- accessible(Board,A,J,B),first_shortest_p(Board,A,J,B,Nodes,Path,Length,Max).


% returns shortest paths from A to B, considering player J moves
shortest_p(Board,A,J,B,Nodes,Path,Length,Max) :- spf(Board,A,J,B,Nodes,Path,Length,Max).
shortest_p(Board,A,J,B,Nodes,Path,Length,Max) :- not(spf(Board,A,J,B,Nodes,Path,Length,Max)),NMax is Max+1,shortest_p(Board,A,J,B,Nodes,Path,Length,NMax).

% returns first shortest path found from A to B, considering player J moves
first_shortest_p(Board,A,J,B,Nodes,Path,Length,Max) :- spf(Board,A,J,B,Nodes,Path,Length,Max),!.
first_shortest_p(Board,A,J,B,Nodes,Path,Length,Max) :- not(spf(Board,A,J,B,Nodes,Path,Length,Max)),NMax is Max+1,first_shortest_p(Board,A,J,B,Nodes,Path,Length,NMax).

% ----------------------------------------
%           Private Methods
% ----------------------------------------

edge(Board,A,J,B) :- players:get_move(Board, A, J, B).

path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,B),not(member(B,Nodes)), Path = [B],L is 1.
path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,C),not(member(C,Nodes)),path(Board,C,J,B,[C|Nodes],PathCB,LCB),Path = [C|PathCB],L is LCB+1.


spf(Board,A,J,B,Nodes,Path,L,Max) :- Max > 0,edge(Board,A,J,B),not(member(B,Nodes)), Path = [B],L is 1.
spf(Board,A,J,B,Nodes,Path,L,Max) :- Max > 0,edge(Board,A,J,C),not(member(C,Nodes)),NMax is Max-1,spf(Board,C,J,B,[C|Nodes],PathCB,LCB,NMax),Path = [C|PathCB],L is LCB+1.

start_accessible(Board,A,J) :- players:get_move(Board, A, J, C), assert(acc(C)).
step_accessible(Board,J) :- acc(A),players:get_move(Board, A, J, C),not(acc(C)), assert(acc(C)),step_accessible(Board,J).
clean_accessible :- retractall(acc(X)).


% checks if there is a path between A and B for player J
% based on start_accessible, step_accessible and clean_accessible using assert method
accessible(Board,A,J,B) :- start_accessible(Board,A,J),step_accessible(Board,J).
accessible(Board,A,J,B) :- acc(B),clean_accessible.
accessible(Board,A,J,B) :- clean_accessible,fail.
