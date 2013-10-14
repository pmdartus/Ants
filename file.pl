:- module(file,[
	save/2, load/2
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

% Load(+Board, +Path)
load(Path, Board) :- open(Path,read,Stream), 
	read_element(RawBoard, Stream),
  close(Stream),
  write(RawBoard), nl.


% ----------------------------------------
%           Private Methods
% ----------------------------------------

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

% read_element(-RawBoard, +Stream)
% REad a line into the file
read_element(RawBoard, Stream) :- at_end_of_stream(Stream), write(RawBoard).
read_element(RawBoard, Stream) :- read_line_to_codes(Stream,RawBoard_loaded), append(RawBoard, RawBoard_loaded, RawBoard_new), !, read_element(RawBoard_new, Stream).
