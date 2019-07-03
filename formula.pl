%pas utile mais plus facile pour comprendre
%cas de base
has(X, X) :- atomic(X).
%cas inductifs
has(A + B, X) :- has(A, X); has(B, X).
has(A - B, X) :- has(A, X); has(B, X).
has(A * B, X) :- has(A, X); has(B, X).
has(A / B, X) :- has(A, X); has(B, X).

%isoler x dans y = x, donne y
isolate(X,     Y,  X,       Y) :- atomic(X).
%isoler x dans y = a + (...x...=b) nous fait isoler x dans y - a = b
isolate(X,     Y,  A + B,              Z) :- isolate(X, Y - A, B, Z).
%même principe...
isolate(X,     Y,  A + B,              Z) :- isolate(X, Y - B, A, Z).
isolate(X,     Y,  A - B,              Z) :- isolate(X, Y + A, B, Z).
isolate(X,     Y,  A - B,              Z) :- isolate(X, Y + B, A, Z).
isolate(X,     Y,  A * B,              Z) :- isolate(X, Y / A, B, Z).
isolate(X,     Y,  A * B,              Z) :- isolate(X, Y / B, A, Z).
isolate(X,     Y,  A / B,              Z) :- isolate(X, Y * A, B, Z).
isolate(X,     Y,  A / B,              Z) :- isolate(X, Y * B, A, Z).

subst(X, Y, X, Y) :- atomic(X).
subst(X, Y, X + B, Y + B).
subst(X, Y, A + X, A + Y).
subst(X, Y, X - B, Y - B).
subst(X, Y, A - X, A - Y).
subst(X, Y, X * B, Y * B).
subst(X, Y, A * X, A * Y).
subst(X, Y, X / B, Y / B).
subst(X, Y, A / X, A / Y).

vars(X, L, [X|L]) :- atom(X).
vars(X, L, L) :- number(X).
vars(A + B, L, N) :- vars(A, L, M), vars(B, M, N).
vars(A - B, L, N) :- vars(A, L, M), vars(B, M, N).
vars(A * B, L, N) :- vars(A, L, M), vars(B, M, N).
vars(A / B, L, N) :- vars(A, L, M), vars(B, M, N).

law(ohm, u, r*i).
unit(u, volt).
unit(r, ohm).
unit(i, amp).
