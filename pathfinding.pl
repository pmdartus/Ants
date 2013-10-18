:- module(pathfinding,[
	path/6,
        shortest_path/6
	]).

% ----------------------------------------
%           Public Methods
% ----------------------------------------
% Returns available paths from A to B, considering player J moves
% path(+Board,+A,+J,+B,-Path,?Length).
% Example usage from main : board:board(Board),path(Board,8,1,23,Path,Length).
path(Board,A,J,B,Path,Length) :- path(Board,A,J,B,[],Path,Length).

% Same as above, but return only the shortest ones
% shortest_path(+Board,+A,+J,+B,-Path,?Length).
% Example usage from main :  board:board(Board),shortest_path(Board,8,1,23,Path,Length).
shortest_path(Board,A,J,B,Path,Length) :- findall([L],path(Board,A,J,B,[],_,L),Poids),min_list(Poids,Length), !, path(Board,A,J,B,[],Path,Length).


% ----------------------------------------
%           Private Methods
% ----------------------------------------

edge(Board,A,J,B) :- players:get_move(Board, A, J, B).

path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,B),not(member(B,Nodes)), Path = [B],L is 1.
path(Board,A,J,B,Nodes,Path,L) :- edge(Board,A,J,C),not(member(C,Nodes)),path(Board,C,J,B,[C|Nodes],PathCB,LCB),Path = [C|PathCB],L is LCB+1.
