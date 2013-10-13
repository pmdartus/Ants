# Ants

Two player game's, AI project written in prolog.

## CONCEPT

It a 2 players game where the goal is the take all the ressources hidden in the map and take it back the his base.
The first player who brought all his resources to his base win the round.

## RUNNING:

The program run on `swi-prolog` [Download](http://www.swi-prolog.org/download/stable).

### Command-line launch

‘‘‘ 
	swipl -s main.pl -g "ants, halt." : Launch the program with the default grid and return to terminal at the end
	swipl -s main.pl -g "ants(GRID), halt." : Launch the program with the array passed in parameter and return to terminal
‘‘‘

### Swi-prolog interface

* Consult the `main.pl` file: `files > consult`
* Run one of the above command in quote the launch the game