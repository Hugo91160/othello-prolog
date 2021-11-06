% FROM :
% https://courses.cs.washington.edu/courses/cse573/04au/Project/mini1/RUSSIA/Final_Paper.pdf


% This heuristic function is actually a collection of several heuristics
% and calculates the utility value of a board position by assigning
% different weights to those heuristics. These heuristics take into account:
    % - the mobility,
    % - coin parity,
    % - stability,
    % - corners-captured,
% aspects of a board configuration.

% Each heuristic scales its return value from -100 to 100.
% These values are weighed appropriately to play an optimal game.

% The various heuristics include:

  % !! use of if else to reduce processing (and it's more readable)


  %% 1. Coin Parity %%
  % This component of the utility function captures the difference in coins
  % between the max player and the min player.
  % The return value is determined as follows :

coinParityHeuristic(Grille, MaxPlayer, MinPlayer, Res) :-
  grilleEnLigne(Grille, GrilleLigne),
  nb_elements(GrilleLigne, MaxPlayer, NbCoinMaxPlayer),
  nb_elements(GrilleLigne, MinPlayer, NbCoinMinPlayer),
  Res is 100 * (NbCoinMaxPlayer - NbCoinMinPlayer) / (NbCoinMaxPlayer + NbCoinMinPlayer).


      % grilleDeDepart(Grille), coinParityHeuristic(Grille, x, o, 0). % test Match (start of game == even == 0)


  %% 2. Mobility %%
  % It attempts to capture the relative difference between
  % the number of possible moves for the max and the min players,
  % with the intent of restricting the opponent’s mobility
  % and increasing one’s own mobility.
  % This value is calculated as follows :

mobilityHeuristic(Grille, MaxPlayer, MinPlayer, Mobility) :-
  
      % grilleDeDepart(Grille), mobilityHeuristic(Grille, x, o, 0). % test Match

      % grilleDeDepart([L1|Rest]), Block = ["-", "-", "-", "-", "-", o, o, x],  GrilleBlock= [L1, L1, L1, L1, L1, Block, Block, Block],
      % afficheGrille(GrilleBlock),
      % mobilityHeuristic(GrilleBlock, x, o, X),!. %test Trun Blocked heuristic
    allValidMove(MaxPlayer, Grille, AllMovesMaxPlayer), 
    length(AllMovesMaxPlayer, Nb_MaxMoves),
    allValidMove(MinPlayer, Grille, AllMovesMinPlayer), 
    length(AllMovesMinPlayer, Nb_MinMoves),

    /*Formula for the mobility heuristic : 
    if((Max Player Actual Mobility Value + Min Player Actual Mobility 
        Value) !=0) 
        Actual Mobility Heuristic Value =   100* (Max Player Actual Mobility Value –Min Player Actual 
        Mobility Value)/ (Max Player Actual Mobility Value + Min Player Actual Mobility Value)  
    else 
        Actual Mobility Heuristic Value = 0
*/
    Sum is Nb_MaxMoves + Nb_MinMoves,
    ( Sum \= 0 -> %if
        Mobility is 100 * (Nb_MaxMoves - Nb_MinMoves) / (Nb_MaxMoves + Nb_MinMoves) ; %then
        Mobility is 0 %else
    ).





  %% 3. Corners Captured %%
  % Corners hold special importance because once captured,
  % they cannot be flanked by the opponent.
  % They also allow a player to build coins around them
  % and provide stability to the player’s coins.
  % This value is captured as follows :

cornersCapturedHeuristic(Grid, MaxPlayer, MinPlayer, Res) :-
/*Formula : 
if((Max Player Corner Value + Min Player Corner Value) !=0) 
  Corner Heuristic Value =  
  100* (Max Player Corner Heurisitc Value –Min Player Corner 
  Heuristic Value)/ 
  (Max Player Corner Heuristic Value + Min Player Corner Heurisitc Value)  
else 
  Corner Heuristic Value = 0 
*/
  getAllCorners(Grid, AsLine),
  nb_elements(AsLine, MaxPlayer, Nb_MaxCoins),
  nb_elements(AsLine, MinPlayer, Nb_MinCoins),
  Nb_AllCorners is Nb_MaxCoins + Nb_MinCoins,
    ( /* If */  Nb_AllCorners \= 0
      /* Then */ ->  Res is 100 * (Nb_MaxCoins - Nb_MinCoins) / (Nb_MaxCoins + Nb_MinCoins)
      /* Else */ ; Res is 0
     ).

     % grilleDeDepart(Grille), cornersCapturedHeuristic(Grille, x, o, 0). % test Match




  %% 4. Stability %%
  % The stability measure of a coin is a quantitative representation
  % of how vulnerable it is to being flanked.
  % Coins can be classified as belonging to one of three categories:
  % (i) stable, (ii) semi-stable and (iii) unstable.

  % Stable coins are coins which cannot be flanked at
  % any point of time in the game from the given state.
  % Unstable coins are those that could be flanked in the very next move.
  % Semi-stable coins are those that could potentially be flanked at some point in the future,
  % but they do not face the danger of being flanked immediately in the next move.
  % Corners are always stable in nature, and by building upon corners,
  % more coins become stable in the region.

  % Tab which classify the coins :
  /*
  1 : stable
  0 : semi-stable 
  -1 : unstable
  */
stabilityHeuristic(Grid, MaxPlayer, MinPlayer, Res_stability) :- 
  nbCaseStable(Grid, MaxPlayer, StableMaxPlayer),
  nbCaseStable(Grid, MinPlayer, StableMinPlayer),

  nbCaseInstable(Grid, MaxPlayer, InstableMaxPlayer),
  nbCaseInstable(Grid, MinPlayer, InstableMinPlayer),
  StabilityMaxPlayer is StableMaxPlayer - InstableMaxPlayer,
  StabilityMinPlayer is StableMinPlayer - InstableMinPlayer,

  Sum is StabilityMaxPlayer + StabilityMinPlayer,
  (
    Sum \= 0 
    -> Res_stability is 100 * (StabilityMaxPlayer - StabilityMinPlayer) / (StabilityMaxPlayer + StabilityMinPlayer)
    ; Res_stability is 0
  ).












%% Static evaluation
static_weights_heuristic_function([4,  -3,  2,  2,  2,  2, -3,  4,
                                  -3, -4, -1, -1, -1, -1, -4, -3,
                                  2,  -1,  1,  0,  0,  1, -1,  2,
                                  2,  -1,  0,  1,  1,  0, -1,  2,
                                  2,  -1,  0,  1,  1,  0, -1,  2,
                                  2,  -1,  1,  0,  0,  1, -1,  2,
                                  -3, -4, -1, -1, -1, -1, -4, -3,
                                  4,  -3,  2,  2,  2,  2, -3,  4]).

% encapsulate
static_heuristic_evaluation(Grid, MaxPlayer, MinPlayer, Res) :-
  grilleEnLigne(Grid, AsLine),
  static_weights_heuristic_function(Stability_line),
  static_heuristic_evaluation_CB(AsLine, Stability_line,
                        MaxPlayer, MinPlayer,
                        Res_PlayerMax, Res_PlayerMin),

  Res is Res_PlayerMax - Res_PlayerMin.

static_heuristic_evaluation_CB([], [], _, _, 0, 0).

static_heuristic_evaluation_CB([Head_grid|Tail_grid], [Head_weights|Tail_weights],
                      /* MaxPlayer = */ Head_grid, MinPlayer,
                      Res_PlayerMax, Res_PlayerMin) :-

  static_heuristic_evaluation_CB(Tail_grid, Tail_weights,
                     Head_grid, MinPlayer,
                     Tmp_ResPlayerMax, Res_PlayerMin),!,

  Res_PlayerMax is Tmp_ResPlayerMax + Head_weights.

static_heuristic_evaluation_CB([Head_grid|Tail_grid], [Head_weights|Tail_weights],
                      MaxPlayer, /* MinPlayer = */ Head_grid,
                      Res_PlayerMax, Res_PlayerMin) :-

  static_heuristic_evaluation_CB(Tail_grid, Tail_weights,
                     MaxPlayer, Head_grid,
                     Res_PlayerMax, Tmp_ResPlayerMin),!,

  Res_PlayerMin is Tmp_ResPlayerMin + Head_weights.

static_heuristic_evaluation_CB([_|TG], [_|TW], MaxPlayer, MinPlayer, ResMax, ResMin) :-
  static_heuristic_evaluation_CB(TG, TW, MaxPlayer, MinPlayer, ResMax, ResMin).

      % grilleDeDepart(Grid),
      % static_heuristic_evaluation(Grid, x, o, 0). % test Match



  %% Sum of all previous heuristic with their respective weights %%



getWeight(Grid, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res) :- 
  count_xo_grid(Count, Grid),
  Count =< 20,
  Res is 100 * Res_corners + 10 * Res_mobility + 5 * Res_coinParity + 50 * Res_stability.

getWeight(Grid, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res) :- 
  count_xo_grid(Count, Grid),
  Count > 20,
  Count =< 50,
  Res is 100 * Res_corners + 50 * Res_mobility + 10 * Res_coinParity + 25 * Res_stability.

getWeight(Grid, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res) :- 
  count_xo_grid(Count, Grid),
  Count > 50,
  Res is 100 * Res_corners + 25 * Res_mobility + 50 * Res_coinParity + 10 * Res_stability.







%% Dynamic evaluation
dynamic_heuristic_evaluation_1st(Grid, MaxPlayer, MinPlayer, Res) :-
  stabilityHeuristic(Grid, MaxPlayer, MinPlayer, Res_stability),
  %coinParityHeuristic(Grid, MaxPlayer, MinPlayer, Res_coinParity),
  %cornersCapturedHeuristic(Grid, MaxPlayer, MinPlayer, Res_corners),

  %mobilityHeuristic(Grid, MaxPlayer, MinPlayer, Res_mobility),
  %Res_stability is 0,
  Res_coinParity is 0,
  Res_corners is 0,
  Res_mobility is 0,

  getWeight(Grid, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res).

dynamic_heuristic_evaluation_2nd(Grid, MaxPlayer, MinPlayer, Res) :-
  stabilityHeuristic(Grid, MaxPlayer, MinPlayer, Res_stability),
  coinParityHeuristic(Grid, MaxPlayer, MinPlayer, Res_coinParity),
  cornersCapturedHeuristic(Grid, MaxPlayer, MinPlayer, Res_corners),

  mobilityHeuristic(Grid, MaxPlayer, MinPlayer, Res_mobility),
  getWeight2(Grid, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res).

getWeight2(_, Res_corners, Res_mobility, Res_coinParity, Res_stability, Res) :- 
  Res is 100 * Res_corners + 5 * Res_mobility + 25 * Res_coinParity + 25 * Res_stability.
% Res is 100 * Res_corners + 5 * Res_coinParity + 25 * Res_stability.

      % grilleDeDepart(Grid),
      % dynamic_heuristic_evaluation(Grid, x, o, 0). % test Match

      % use_module(library(statistics)).
      % grilleDeDepart([L1|Rest]), Block = ["-", "-", "-", "-", "-", o, o, x],  GrilleBlock= [L1, L1, L1, L1, L1, Block, Block, Block],
      % profile(dynamic_heuristic_evaluation(GrilleBlock, x, o, R)).

% vim:set et sw=2 ts=2 ft=prolog:
