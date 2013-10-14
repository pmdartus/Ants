:- module(file,[
	save/2, load/1
	]).


% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ----------------------------------------
%           Saving into a file

% save(+Board, +Path)
% Save the actual game state into a file, located in path
% WARNING: the saving path will be relative from the actual one (i.e the one from which you lunch swipl)
save(Board, Path) :- open(Path,write,Stream), save_board(Board, Stream), nl(Stream), close(Stream).

% ----------------------------------------
%           Loading from a file

% Load(+Path)
load(Path) :- open(Path,read,Stream), 
	read_element(RawBoard, Stream),
  close(Stream),
  write('Done'), nl.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

% ----------------------------------------
%           Saving subfunctions

% save_board(+Board)
% Save the board passed in argument into a stream
save_board(Board, Stream) :- write(Stream, '\n'), save_element(Board, 1, Stream).

% save_element(+Board, +Index, +Stream)
% Save the element at the selected index ( begin at 1 ) into a stream
save_element(_, Index, Stream) :- board_length(Length), Index > Length * Length, write(Stream, '\n'). 
save_element(Board, Index, Stream) :- get_element_at_position(Board, Index, p1), 
                                write(Stream, '1'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).
save_element(Board, Index, Stream) :- get_element_at_position(Board, Index, p2),  
                                write(Stream, '2'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).
save_element(Board, Index, Stream) :- get_element_at_position(Board, Index, walls), 
                                write(Stream, 'W'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).
save_element(Board, Index, Stream) :-  write(Stream, '_'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).

% next_display(+Index)
% Select if the at this index it should break or not
next_display(Index, Stream) :- board_length(Length), Index mod Length =:= 0, write(Stream, '\n'). 
next_display(_, Stream) :- write(Stream, ' ').

% ----------------------------------------
%           Loading subfunctions 

% read_element(-RawBoard, +Stream)
% Read a line into the file
read_element(RawBoard, Stream) :- at_end_of_stream(Stream), update_board(RawBoard).
read_element(RawBoard, Stream) :- read_line_to_codes(Stream,RawBoard_loaded), append(RawBoard, RawBoard_loaded, RawBoard_new), !, read_element(RawBoard_new, Stream).


% update_board(+RawBoard)
% Update the board predicate with the new one
update_board(RawBoard) :- create_board(RawBoard, Board), display_board(Board).

%create_board(+RawBoard, -Board)
create_board(RawBoard, Board) :- write(RawBoard).
%find_allindexes(RawbBard,Indexj1,Indexj2,Walls,IndexR,IndexS,IndexB,IndexC,Board).
%retract(board), assert(board(Board)).
% with Board = [Indexj1,Indexj2,Walls,IndexR,IndexS,IndexB,IndexC]


% ASCII Code:
% W :  87, _ : 95
% 1 : 49, 2 : 50
% R : 82, S : 83
% B : 66, C : 67
% espace : 32 

%Find all the walls

%find_allindexes(RawBoard,Indexj1+1,Indexj2+1,Walls,IndexR,IndexS,IndexB+1,IndexC+1) :- nth0(Indexj1,Rawboard,49),nth0(Indexj2,Rawboard,50), find_Walls(Rawboard,Walls),find_indexR(Rawboard,IndexR),find_indexS(Rawboard,IndexS), nth0(IndexB,Rawboard,66),nth0(IndexC,Rawboard,67).

find_walls(RawBoard, Walls, I) :- length(RawBoard,0), write(Walls).
find_walls(RawBoard, Walls, I) :-
	nth0(Wall_found,RawBoard,87), !, I1 is I+1,
	Wall_actual is Wall_found+I1, append([Wall_actual], Walls, Walls_new),
	split(RawBoard, 87, _, RawBoard_new),
	find_walls(RawBoard_new, Walls_new, I1).

split(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).


%find_Indexes(RawBoard, I, Board) :- nth0(I,RawBoard,87), !, walls(%Board, Walls), find_next().
%
%find_next() :- find_Indexes(RawBoard_min, I1), I is I1-1.
%
%get_element_at_position(Board, Position, Type):- resources1(Board,%R1), memberType=walls(Position,R1), Type=resource1.
%get_element_at_position(Board, Position, Type):- resources2(Board,%R2), member(Position,R2), Type=resource2.
%get_element_at_position(Board, Position, Type):- pos_p1(Board, %Position), Type=p1.
%get_element_at_position(Board, Position, Type):- pos_p2(Board, %Position), Type=p2.
%get_element_at_position(_, _, Type):- Type=empty.
%
%









