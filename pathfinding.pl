:- module(pathfinding,[
	paths/5,
        shortest_path/5
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------
% Returns available paths from A to B, considering player J moves
% paths(+Board,+A,+J,+B,-Paths).
paths(Board,A,J,B,Paths) :- findall([Path],path(Board,A,J,B,[],Path,L),Paths).

% Same as above, but return only the shortest ones
% shortest_path(+Board,+A,+J,+B,-Shortest).
shortest_path(Board,A,J,B,Shortest) :- findall([L,Path],path(Board,A,J,B,[],Path,L),Paths),member([Min,Shortest],Paths),findall([L],path(Board,A,J,B,[],Path,L),Poids),min_list(Poids,Min).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

edge(Board,A,J,B) :- players:get_move(Board, A, J, B).

path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,B),not(member(B,Nodes)), Path = [B],L is 1.
path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,C),not(member(C,Nodes)),path(Board,C,J,B,[C|Nodes],PathCB,LCB),Path = [C|PathCB],L is LCB+1.
