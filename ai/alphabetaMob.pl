% Main predicate %
% Encapsulate
alphabetaMob(Grid, Player, Depth, Result) :-
  opposite(Player, Opposite),


  % like in alphabetaMob but set the default first Coords that will defined the next move
  allnextGrid(Grid, Player, Grids_out),
  NextDepth is Depth - 1,
  init_value_minOrMax(Depth, Init_minOrMax),
  getScorealphabetaMob(Grids_out, Player, Opposite, NextDepth, Init_minOrMax, Result, -inf, +inf),
  !.



% main loop
alphabetaMob([Grid_in, FirstMinMaxCoords], MaxPlayer, MinPlayer, Depth, Result, Alpha, Beta) :-
  Depth \= 0,
  allnextGrid_data(Grid_in, MaxPlayer, Grids_out, FirstMinMaxCoords),
  \+ length(Grids_out, 0),!, % there is still some tree to generate

  NextDepth is Depth - 1,
  init_value_minOrMax(Depth, Init_minOrMax),
  getScorealphabetaMob(Grids_out, MaxPlayer, MinPlayer, NextDepth, Init_minOrMax, Result, Alpha, Beta).


% no more possibility end of tree or Depth = 0
alphabetaMob([Grid_in, [A,I]], MaxPlayer, MinPlayer, _, [Result, [A,I]], _, _) :-
  dynamic_heuristic_evaluation_mobility(Grid_in, MaxPlayer, MinPlayer, Result) /* compute the Heuristic every time */
  .
  % ,nl,afficheGrille(Grid_in), write(Result), write('  '),write(A), write(','), write(I),nl.





getScorealphabetaMob([First_grid]          , MaxPlayer, MinPlayer, Depth, OldRes, Result, Alpha, Beta) :-
  even(Depth), !,
  alphabetaMob(First_grid, MinPlayer, MaxPlayer, Depth, Result_current, Alpha, Beta),
  my_min(OldRes, Result_current, Result).
  % Result is max(OldRes, Result_current).

getScorealphabetaMob([First_grid]          , MaxPlayer, MinPlayer, Depth, OldRes, Result, Alpha, Beta) :-
  alphabetaMob(First_grid, MinPlayer, MaxPlayer, Depth, Result_current, Alpha, Beta),
  % Result is min(OldRes, Result_current).
  my_max(OldRes, Result_current, Result).


getScorealphabetaMob([First_grid|Rest_grid], MaxPlayer, MinPlayer, Depth, OldRes, RETURN, Alpha, Beta) :-
  even(Depth),!,
  alphabetaMob(First_grid, MinPlayer, MaxPlayer, Depth, Result_current, Alpha, Beta),
  my_min(OldRes, Result_current, Result_tmp),
  [Val , _] = Result_tmp,
  ( Val >  Alpha ->
     getScorealphabetaMob(Rest_grid, MaxPlayer, MinPlayer, Depth, Result_tmp, RETURN, Alpha, Val)
    ; RETURN = Result_tmp
  ).


getScorealphabetaMob([First_grid|Rest_grid], MaxPlayer, MinPlayer, Depth, OldRes, RETURN, Alpha, Beta) :-
  alphabetaMob(First_grid, MinPlayer, MaxPlayer, Depth, Result_current, Alpha, Beta),
  my_max(OldRes, Result_current, Result_tmp),
  [Val , _] = Result_tmp,
  ( Val <  Beta ->
    getScorealphabetaMob(Rest_grid, MaxPlayer, MinPlayer, Depth, Result_tmp, RETURN, Val, Beta)
    ; RETURN = Result_tmp
  ).


      % grilleDeDepart(Grid),
      % alphabetaMob(Grid, x, 4, R).

% vim:set et sw=2 ts=2 ft=prolog:
