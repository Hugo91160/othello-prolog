/*
@author : Hexanome 4144
*/

% Condition d'arrêt 
% Condition d'arrêt 
grilleEnLigne([], X, X).

grilleEnLigne([Line|Grille], ActualLine, ResLigne):-
    append(Line,ActualLine,NewActualLine),
    grilleEnLigne(Grille,NewActualLine,ResLigne).

grilleEnLigne(Grille,Resultat) :- grilleEnLigne(Grille, [], Resultat).

nb_elements([], _, NbPions, NbPions).
nb_elements([Pion|ResteLigne], PionJoueur, AccPions, TotalPions) :-
    Pion == PionJoueur,
    NvNbPions is AccPions+1,
    nb_elements(ResteLigne, PionJoueur, NvNbPions, TotalPions).

nb_elements([Pion|ResteLigne], PionJoueur, AccPions, TotalPions) :-
    Pion \== PionJoueur,
    nb_elements(ResteLigne, PionJoueur, AccPions, TotalPions).

nb_elements(L,Joueur,TotalPions) :- nb_elements(L,Joueur,0,TotalPions).


% indexLigneVersAlphaIndex(IndexLigne,Alpha,Index).
indexLigneVersAlphaIndex(1,a,1).
indexLigneVersAlphaIndex(2,a,2).
indexLigneVersAlphaIndex(3,a,3).
indexLigneVersAlphaIndex(4,a,4).
indexLigneVersAlphaIndex(5,a,5).
indexLigneVersAlphaIndex(6,a,6).
indexLigneVersAlphaIndex(7,a,7).
indexLigneVersAlphaIndex(8,a,8).
indexLigneVersAlphaIndex(9,b,1).
indexLigneVersAlphaIndex(10,b,2).
indexLigneVersAlphaIndex(11,b,3).
indexLigneVersAlphaIndex(12,b,4).
indexLigneVersAlphaIndex(13,b,5).
indexLigneVersAlphaIndex(14,b,6).
indexLigneVersAlphaIndex(15,b,7).
indexLigneVersAlphaIndex(16,b,8).
indexLigneVersAlphaIndex(17,c,1).
indexLigneVersAlphaIndex(18,c,2).
indexLigneVersAlphaIndex(19,c,3).
indexLigneVersAlphaIndex(20,c,4).
indexLigneVersAlphaIndex(21,c,5).
indexLigneVersAlphaIndex(22,c,6).
indexLigneVersAlphaIndex(23,c,7).
indexLigneVersAlphaIndex(24,c,8).
indexLigneVersAlphaIndex(25,d,1).
indexLigneVersAlphaIndex(26,d,2).
indexLigneVersAlphaIndex(27,d,3).
indexLigneVersAlphaIndex(28,d,4).
indexLigneVersAlphaIndex(29,d,5).
indexLigneVersAlphaIndex(30,d,6).
indexLigneVersAlphaIndex(31,d,7).
indexLigneVersAlphaIndex(32,d,8).
indexLigneVersAlphaIndex(33,e,1).
indexLigneVersAlphaIndex(34,e,2).
indexLigneVersAlphaIndex(35,e,3).
indexLigneVersAlphaIndex(36,e,4).
indexLigneVersAlphaIndex(37,e,5).
indexLigneVersAlphaIndex(38,e,6).
indexLigneVersAlphaIndex(39,e,7).
indexLigneVersAlphaIndex(40,e,8).
indexLigneVersAlphaIndex(41,f,1).
indexLigneVersAlphaIndex(42,f,2).
indexLigneVersAlphaIndex(43,f,3).
indexLigneVersAlphaIndex(44,f,4).
indexLigneVersAlphaIndex(45,f,5).
indexLigneVersAlphaIndex(46,f,6).
indexLigneVersAlphaIndex(47,f,7).
indexLigneVersAlphaIndex(48,f,8).
indexLigneVersAlphaIndex(49,g,1).
indexLigneVersAlphaIndex(50,g,2).
indexLigneVersAlphaIndex(51,g,3).
indexLigneVersAlphaIndex(52,g,4).
indexLigneVersAlphaIndex(53,g,5).
indexLigneVersAlphaIndex(54,g,6).
indexLigneVersAlphaIndex(55,g,7).
indexLigneVersAlphaIndex(56,g,8).
indexLigneVersAlphaIndex(57,h,1).
indexLigneVersAlphaIndex(58,h,2).
indexLigneVersAlphaIndex(59,h,3).
indexLigneVersAlphaIndex(60,h,4).
indexLigneVersAlphaIndex(61,h,5).
indexLigneVersAlphaIndex(62,h,6).
indexLigneVersAlphaIndex(63,h,7).
indexLigneVersAlphaIndex(64,h,8).

caseStable(Grille, a, 1, Player, _) :- donneValeurDeCase(Grille, a, 1, Player).
caseStable(Grille, a, 8, Player, _) :- donneValeurDeCase(Grille, a, 8, Player).
caseStable(Grille, h, 1, Player, _) :- donneValeurDeCase(Grille, h, 1, Player).
caseStable(Grille, h, 8, Player, _) :- donneValeurDeCase(Grille, h, 8, Player).
caseStable(Grille, a, X, Player, o) :- succNum(X, Y), donneValeurDeCase(Grille, a, X, Player), caseStable(Grille, a, Y, Player, s).
caseStable(Grille, a, X, Player, o) :- succNum(Y, X), donneValeurDeCase(Grille, a, X, Player), caseStable(Grille, a, Y, Player, p).
caseStable(Grille, a, X, Player, s) :- succNum(X, Y), donneValeurDeCase(Grille, a, X, Player), caseStable(Grille, a, Y, Player, s).
caseStable(Grille, a, X, Player, p) :- succNum(Y, X), donneValeurDeCase(Grille, a, X, Player), caseStable(Grille, a, Y, Player, p).

caseStable(Grille, X, 1, Player, o) :- succAlpha(X, Y), donneValeurDeCase(Grille, X, 1, Player), caseStable(Grille, Y, 1, Player, s).
caseStable(Grille, X, 1, Player, o) :- succAlpha(Y, X), donneValeurDeCase(Grille, X, 1, Player), caseStable(Grille, Y, 1, Player, p).
caseStable(Grille, X, 1, Player, s) :- succAlpha(X, Y), donneValeurDeCase(Grille, X, 1, Player), caseStable(Grille, Y, 1, Player, s).
caseStable(Grille, X, 1, Player, p) :- succAlpha(Y, X), donneValeurDeCase(Grille, X, 1, Player), caseStable(Grille, Y, 1, Player, p).

caseStable(Grille, X, 8, Player, o) :- succAlpha(Y, X), donneValeurDeCase(Grille, X, 8, Player), caseStable(Grille, Y, 8, Player, s).
caseStable(Grille, X, 8, Player, o) :- succAlpha(X, Y), donneValeurDeCase(Grille, X, 8, Player), caseStable(Grille, Y, 8, Player, p).
caseStable(Grille, X, 8, Player, s) :- succAlpha(Y, X), donneValeurDeCase(Grille, X, 8, Player), caseStable(Grille, Y, 8, Player, s).
caseStable(Grille, X, 8, Player, p) :- succAlpha(X, Y), donneValeurDeCase(Grille, X, 8, Player), caseStable(Grille, Y, 8, Player, p).

caseStable(Grille, h, X, Player, o) :- succNum(Y, X), donneValeurDeCase(Grille, h, X, Player), caseStable(Grille, h, Y, Player, s).
caseStable(Grille, h, X, Player, o) :- succNum(X, Y), donneValeurDeCase(Grille, h, X, Player), caseStable(Grille, h, Y, Player, p).
caseStable(Grille, h, X, Player, s) :- succNum(Y, X), donneValeurDeCase(Grille, h, X, Player), caseStable(Grille, h, Y, Player, s).
caseStable(Grille, h, X, Player, p) :- succNum(X, Y), donneValeurDeCase(Grille, h, X, Player), caseStable(Grille, h, Y, Player, p).

nbCaseInstable(_,_,0).

% nbCaseStable(_,_,65,X,X).
% nbCaseStable(Grille,Player,I,Acc,Res) :- indexLigneVersAlphaIndex(I,Alpha,Index), caseStable(Grille, Alpha, Index, Player), !, NextI is I+1, NvAcc is Acc+1, nbCaseStable(Grille,Player,NextI,NvAcc,Res).
% nbCaseStable(Grille,Player,I,Acc,Res) :- NextI is I+1, nbCaseStable(Grille,Player,NextI,Acc,Res).

nbCaseStable(Grille,Player,Res) :- setof([Alpha,Index],caseStable(Grille, Alpha, Index, Player, o), L), !, length(L, Res).
nbCaseStable(Grille,Player,Res) :- Res is 0.