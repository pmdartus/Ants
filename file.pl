:- module(file,[
	save/2
	]).


% ----------------------------------------
%           Public Methods
% ----------------------------------------

% ----------------------------------------
%           Saving into a file

% save(+Board, +Path)
% Save the actual game state into a file, located in path
save(Board, Path) :- open(Path,write,Stream), write(Stream,display_board(Board)), nl(Stream), close(Stream).

% ----------------------------------------
%           Loading from a file

% Load(+Board, +Path)




% ----------------------------------------
%           Private Methods
% ----------------------------------------

% save_element(+Board, +Index)
% Save the element at the selected index ( begin at 1 ) into file
save_element(_, Index) :- board_length(Length), Index > Length * Length, nl. 
save_element(Board, Index) :- get_element_at_position(Board, Index, p1), 
                                write('1'), 
                                NewIndex is Index+1, next_display(Index), save_element(Board , NewIndex).
save_element(Board, Index) :- get_element_at_position(Board, Index, p2),  
                                write('2'), 
                                NewIndex is Index+1, next_display(Index), save_element(Board , NewIndex).
save_element(Board, Index) :- get_element_at_position(Board, Index, walls), 
                                write('M'), 
                                NewIndex is Index+1, next_display(Index), save_element(Board , NewIndex).
save_element(Board, Index) :-  write('_'), 
                                NewIndex is Index+1, next_display(Index), save_element(Board , NewIndex).