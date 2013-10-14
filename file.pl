:- module(file,[
	save/2, load/1
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



% ---------- Transforming a list of char into a board ----------------
% ASCII Code:
% W :  87, - : 45
% 1 : 49, 2 : 50
% R : 82, S : 83
% B : 66, C : 67
% espace : 32

% create_board(+RawBoard, -Board)
create_board(RawBoard, Board) :- find_indexes(RawBoard, Board), write(Board), update_board(Board).

% Find all the other indexes (not walls) and return the new board
find_indexes(RawBoard, Board) :-
	% Walls
	find_items(Walls, RawBoard, 87),
	% J1, J2
	nth0(IndexJ1,RawBoard,49), nth0(IndexJ2,RawBoard,50),
	% R, S
	find_items(IndexR, RawBoard, 82), find_items(IndexS, RawBoard, 83),
	% B, C
	%	nth0(IndexB,Rawboard,66), nth0(IndexC,Rawboard,67),
	% Call board update
	update_board([IndexJ1, IndexJ2, Walls, IndexR, IndexS]).

% update_board(+RawBoard)
% Update the board predicate with the new one
update_board(Board) :-
	% Update board table
	retractall(board/1), assert(board(Board)),
	% Update board size
	%retractall(board_length/1), length(Board, Board_length), Board_size is Board_length/2, write(Board_size), assert(board_length(Board_size)),
	%Finally display it
	%display_board(Board).


% -------------- Finding a list of char position ----------------------

% find_items(+RawBoard, +ASCICode)
% Find all the items corresponding to the ASCIcode, and return a list of their positions.
% NB 1/ Stored with an assert into tempItems.
% NB 2/ [] if code never found!
% NB 3/ based on find_items_i/4
find_items(Items, RawBoard, ASCICode) :- find_items_i(RawBoard, ASCICode, [], 0), tempsItems(Items), retract(tempsItems(Items)).

% find_items_i(+RawBoard, +ASCICode, -Items, +I)
% see find_items/2
find_items_i(RawBoard, ASCIcode, Items, I) :-
	% Break condition.
	not(nth0(Item_found, RawBoard, ASCIcode)),
	%DEBUG
	write(Items),
	assert(tempsItems(Items)).
% Get the item position and recursive call on the rest of the list.
find_items_i(RawBoard, ASCIcode, Items, I) :-
	nth0(Item_found, RawBoard, ASCIcode), !,
	Item_actual is Item_found+I,
	append([Item_actual], Items, Items_new),
	split(RawBoard, ASCIcode, _, RawBoard_new),
	I_new is Item_actual+1, find_items_i(RawBoard_new, ASCIcode, Items_new, I_new).

% split(+List, +Pivot, -Left, -Right)
% used to split a list on a special char (pivot) and return left and right member
split(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).