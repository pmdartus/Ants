:- module(file,[
	save/2, load/2
	]).

% temp memory between find_items/3 and find_items/4 made by an assert into tempsItems.
:- dynamic tempsItems/1.


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

% Load(+Path, +Size)
load(Path, Size) :- open(Path,read,Stream),
	update_board_size(Size),
	read_element(Stream, _),
  close(Stream),
  write('Done'), nl.





% ----------------------------------------
%           Private Methods
% ----------------------------------------

% ----------------------------------------
%           Save subfunctions

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
save_element(Board, Index, Stream) :- get_element_at_position(Board, Index, resource), 
                                write(Stream, 'R'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).
save_element(Board, Index, Stream) :-  write(Stream, '_'), 
                                NewIndex is Index+1, next_display(Index, Stream), save_element(Board , NewIndex, Stream).

% next_display(+Index)
% Select if the at this index it should break or not
next_display(Index, Stream) :- board_length(Length), Index mod Length =:= 0, write(Stream, '\n'). 
next_display(_, Stream) :- write(Stream, ' ').



% ----------------------------------------
%           Load subfunctions 

% read_element(+Stream, -RawBoard)
% Read a line into the file
read_element(Stream, RawBoard) :-
	at_end_of_stream(Stream),
	find_indexes(RawBoard),
	board:board(Board),
	%DEBUG
	%write(Board),
	display_board(Board).
read_element(Stream, RawBoard) :- read_line_to_codes(Stream,RawBoard_loaded), append(RawBoard, RawBoard_loaded, RawBoard_new), !, read_element(Stream, RawBoard_new).


% ASCII Code:
% W :  87, - : 45
% 1 : 49, 2 : 50
% R : 82
% B : 66, C : 67
%slash : 47, espace : 32
% 0 : 48 -> 9 : 57

% ---------- Transforming a list of char into a board ----------------

% find_indexes(+RawBoard)
% Find all the other indexes (not walls) and update the new board
find_indexes(RawBoard) :-
	% Walls
	find_items(Walls, RawBoard, 87),
	% J1, J2

	nth1(IndexJ1,RawBoard,49), nth1(IndexJ2,RawBoard,50),
	% R, S
	find_items(IndexR, RawBoard, 82), find_items(IndexS, RawBoard, 83),
	% B, C
	%	nth0(IndexB,Rawboard,66), nth0(IndexC,Rawboard,67),
	% Call board update
	update_board([IndexJ1, IndexJ2, Walls, IndexR]).

% update_board(+RawBoard)
% Update the board predicate with the new one
update_board(NewBoard) :-
	% Update board table
	retractall(board:board(_)), assert(board:board(NewBoard)),
	%DEBUG
	board:board(Board),
	write(Board).

% update_board_size(+RawBoard)
% Update the board size predicate
update_board_size(Size) :-
	% Update board size
	retractall(board:board_length(_)), assert(board:board_length(Size)).


% -------------- Finding a list of char position ----------------------

% find_items(+RawBoard, +ASCICode)
% Find all the items corresponding to the ASCIcode, and return a list of their positions.
% NB 1/ Stored with an assert into tempItems.
% NB 2/ [] if code never found!
% NB 3/ based on find_items_i/4
find_items(Items, RawBoard, ASCICode) :- find_items_i(RawBoard, ASCICode, [], 1), tempsItems(Items), retract(tempsItems(Items)).

% find_items_i(+RawBoard, +ASCICode, -Items, +I)
% see find_items/2
find_items_i(RawBoard, ASCIcode, Items, _) :-
	% Break condition.
	not(nth0(_, RawBoard, ASCIcode)),
	%DEBUG
	%write(Items),
	assert(tempsItems(Items)).
% Get the item position and recursive call on the rest of the list.
find_items_i(RawBoard, ASCIcode, Items, I) :-
	%Find an element
	nth0(Item_found, RawBoard, ASCIcode), !,
	%Update Items by adding the new index.
	Item_actual is Item_found+I,
	append([Item_actual], Items, Items_new),
	%Split the RawBoard to get only the right part after the founded item
	split(RawBoard, ASCIcode, _, RawBoard_new),
	%Recursive call
	I_new is Item_actual+1, find_items_i(RawBoard_new, ASCIcode, Items_new, I_new).

% split(+List, +Pivot, -Left, -Right)
% used to split a list on a special char (pivot) and return left and right member
split(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).

% ---------- Get the board size ----------------

% get_size(+RawBoard_full, -RawBoard, -Size)
% Get the size from the readed board
%get_size(RawBoard_full, RawBoard, Size) :- split(RawBoard_full, 47, RawBoard, Size_raw), length(Size_raw, SizeLength), real_size(Size_raw, Size, SizeLength).

% TO BE DONE
% Return the real size in decimal
%real_size([F | Size_raw], Size, 1) :-
%	Size_new is Size_raw + Size.
