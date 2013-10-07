:-module(ai1,[ask_move_ai1/3]).

ask_move_ai1(xMove,yMove,layObstacle).
ask_move_ai1(1,1,true). % Lay obstacle at current position, then, move x+1 and y+1
