% Encapsulate
% Main predicate %
minmax(Grid, Player, Depth, Result) :-
  opposite(Player, Opposite),


  % like in minmax but set the default first Coords that will defined the next move
  allnextGrid(Grid, Player, Grids_out),
  NextDepth is Depth - 1,
  init_value_minOrMax(Depth, Init_minOrMax),
  getScoreMinMax(Grids_out, Player, Opposite, NextDepth, Init_minOrMax, Result),
  !.



% main loop

minmax([Grid_in, FirstMinMaxCoords], MaxPlayer, MinPlayer, Depth, Result) :-
  Depth \= 0,
  allnextGrid_data(Grid_in, MaxPlayer, Grids_out, FirstMinMaxCoords), %get all next grids given a grid
  \+ length(Grids_out, 0),!, % there is still some tree to generate
  % vrai si length de Grids_out != 0

  NextDepth is Depth - 1,
  init_value_minOrMax(Depth, Init_minOrMax), %+inf ou -inf if pair ou impair
  getScoreMinMax(Grids_out, MaxPlayer, MinPlayer, NextDepth, Init_minOrMax, Result).


% no more possibility end of tree or Depth = 0
minmax([Grid_in, [A,I]], MaxPlayer, MinPlayer, _, [Result, [A,I]]) :-
  dynamic_heuristic_evaluation_1st(Grid_in, MaxPlayer, MinPlayer, Result) /* compute the Heuristic every time */
  .
  % ,nl,afficheGrille(Grid_in), write(Result), write('  '),write(A), write(','), write(I),nl.





getScoreMinMax([First_grid]          , MaxPlayer, MinPlayer, Depth, OldRes, Result) :-
  %Si la profondeur est impaire on veut minimiser car c'est le coup de l'adversaire
  even(Depth), !,
  minmax(First_grid, MinPlayer, MaxPlayer, Depth, Result_current),
  my_min(OldRes, Result_current, Result).
  % Result is max(OldRes, Result_current).

getScoreMinMax([First_grid]          , MaxPlayer, MinPlayer, Depth, OldRes, Result) :-
%profondeur est paire on veut donc maximiser le coup car mon coup 
  minmax(First_grid, MinPlayer, MaxPlayer, Depth, Result_current),
  % Result is min(OldRes, Result_current).
  my_max(OldRes, Result_current, Result).


getScoreMinMax([First_grid|Rest_grid], MaxPlayer, MinPlayer, Depth, OldRes, RETURN) :-
  %Si la profondeur est impaire on veut minimiser car coup de l'adversaire
  even(Depth),!,
  minmax(First_grid, MinPlayer, MaxPlayer, Depth, Result_current), 
  /*
  Relance le minmax pour descendre dans l'arbe
  */
  % Result_tmp is max(OldRes, Result_current),
  my_min(OldRes, Result_current, Result_tmp), %get the actual score of the grid
  getScoreMinMax(Rest_grid, MaxPlayer, MinPlayer, Depth, Result_tmp, RETURN).
  /* relance récursion pour calculer le score pour la profondeur pour calculer la min/max 
      de l'étage actuel */

getScoreMinMax([First_grid|Rest_grid], MaxPlayer, MinPlayer, Depth, OldRes, RETURN) :-
%profondeur est paire on veut donc maximiser le coup car mon coup 
  minmax(First_grid, MinPlayer, MaxPlayer, Depth, Result_current),
  % Result_tmp is min(OldRes, Result_current),
  my_max(OldRes, Result_current, Result_tmp),
  getScoreMinMax(Rest_grid, MaxPlayer, MinPlayer, Depth, Result_tmp, RETURN).

      % use_module(library(statistics)).
      % grilleDeDepart(Grid),
      % profile(minmax(Grid, x, 4, R)).

      % use_module(library(statistics)).
      % grilleDeDepart([L1|Rest]), Block = ["-", "-", "-", "-", "-", o, o, x],  GrilleBlock= [L1, L1, L1, L1, L1, Block, Block, Block],
      % afficheGrille(GrilleBlock),
      % (minmax(GrilleBlock, x, 3,  R)).


% vim:set et sw=2 ts=2 ft=prolog:
