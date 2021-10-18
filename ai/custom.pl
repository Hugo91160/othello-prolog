inputPickCustomCoord(Grid, Alpha, Index, Player) :-
  allValidMove(Player, Grid, [[Alpha, Index]|_]).

% vim:set et sw=2 ts=2 ft=prolog:
