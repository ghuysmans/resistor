%FIXME clpr?
:- use_module(library(clpfd)).

color(black,  n,         d(0), m(1)).
color(brown,  t(0.01),   d(1), m(10)).
color(red,    t(0.02),   d(2), m(100)).
color(orange, n,         d(3), m(1000)).
color(yellow, n,         d(4), m(10000)).
color(green,  t(0.005),  d(5), m(100000)).
color(blue,   t(0.0025), d(6), m(1000000)).
color(violet, t(0.001),  d(7), m(10000000)).
color(grey,   t(0.0005), d(8), m(100000000)).
color(white,  n,         d(9), m(1000000000)).
color(gold,   t(0.05),   n,    m(0.1)).
color(silver, t(0.10),   n,    m(0.01)).
color(none,   t(0.20),   n,    n).

tolerance(C, T) :- color(C, t(T), _, _).
with_tol(val(V)-tol(T), low(L)-high(H)) :- L is V*(1-T), H is V*(1+T).

digit(C, D) :- color(C, _, d(D), _).
multiplier(C, M) :- color(C, _, _, m(M)).

r(A, B, C, D, E, val(V)-tol(T)) :-
    digit(A, X), digit(B, Y), digit(C, Z), multiplier(D, M), tolerance(E, T),
    V #= (X * 100 + Y * 10 + Z) * M.
r(A, B, C, D, val(V)-tol(T)) :-
    digit(A, X), digit(B, Y), multiplier(C, M), tolerance(D, T),
    V #= (X * 10 + Y) * M.
r(A, B, C, R) :- r(A, B, C, none, R).

led(V, DV, R) :- with_tol(R, low(LR)-_), (V - DV) / LR < 0.030.
