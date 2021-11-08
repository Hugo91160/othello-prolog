/*
@author : Hexanome 4144
*/

/*
This predicats allows to adapt the depth (for minmax or alphabeta) in terms of the board
Start of the game : depth is 5 because there are few plays
Middle of the game : depth is 3 because too many plays.
End of the game : Depth is 5 because there are few plays
*/

count_xo(Count,[]) :- Count = 0.
count_xo(Count2,[x|Q]) :- count_xo(Count,Q), Count2 is Count+1.
count_xo(Count2,[o|Q]) :- count_xo(Count,Q), Count2 is Count+1.
count_xo(Count,["-"|Q]) :- count_xo(Count,Q).

count_xo_grid(Count, Grid) :- gridToLine(Grid, Line), count_xo(Count, Line).

getDepth(Grid, Depth) :- count_xo_grid(Count, Grid),
  Count < 10,
  Depth=5.

getDepth(Grid, Depth) :- count_xo_grid(Count, Grid),
  Count >= 10,
  Count < 55,
  Depth=3.

getDepth(Grid, Depth) :- count_xo_grid(Count, Grid),
  Count >= 55,
  Depth=5.

getDepth2(_, Depth) :-
  Depth=3.
