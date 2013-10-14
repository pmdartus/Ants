# Ants

Two player game's, AI project written in prolog.

## CONCEPT

It a 2 players game where the goal is the take all the ressources hidden in the map and take it back the his base.
The first player who brought all his resources to his base win the round.

## FILE STRUCTURE

```
	main.pl            Generic game comportements
	board.pl           Board initialisation and manipulation
	players.pl         Players status update
	ai_basic.pl        AI playing random moves
```

## API

The board is defined by a table:

```
	Board = [Player1_pos, Player2_pos, Walls, Resources1, Resources2]
```

### Behaviours

When a player gets on one of his resources, he grabs it, which means:

* We start updating the resource's position like the player's position
* The player cannot grab any other resource
* We keep both behaviours until he gets to his base with the resource
* Then the resource is deleted from our board
* We get back to the classic behaviour

Consequences on the old resource's position : it becomes an empty box.

## RUNNING:

The program run on `swi-prolog` [Download](http://www.swi-prolog.org/download/stable).

### Command-line launch

```
	swipl -s main.pl -g "ants, halt." : Launch the program with the default grid and return to terminal at the end
	swipl -s main.pl -g "ants(GRID), halt." : Launch the program with the array passed in parameter and return to terminal
```

### Swi-prolog interface

* Consult the `main.pl` file: `files > consult`
* Run one of the above command in quote the launch the game
