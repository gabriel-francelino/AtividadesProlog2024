% EX1
% forall(member(X,[1,2,3]),write(X)). => 123.
% forall(between(1,5,I),(write(I*I),write(' '))). => 1*1 2*2 3*3 4*4 5*5.
% forall(between(10,20,I),write(I:' ')). => 10: 11: 12: 13: 14: 15: 16: 17: 18: 19: 20:.

% EX2
a:-a(0).
a(X):- X>10,!.
a(X):- write(X),write(' '), X1 is X+1,a(X1).
% Resultado => 0 1 2 3 4 5 6 7 8 9 10

% EX3
wN(0):-write(0),!.
wN(N):-write(N),N1 is N-1, wN(N1),write(N).

drawSpaces(N) :- forall(between(1,N,_), write(' ')).

xxx(N) :- forall(between(0,N,X), (S is N-X, drawSpaces(S), wN(X), nl)).

% EX5
d(0).
d(1).
% ex5 :- findall([A,B],(d(A),d(B)),L).
% Resultado => L = [[0, 0], [0, 1], [1, 0], [1, 1]]

% EX6
inverte([X], [X]).
inverte([X|Y], Z) :- inverte(Y, W), append(W, [X], Z).

comparaLista([A],[A]).
comparaLista([A|B], [C|D]) :- A == C, comparaLista(B, D).

palindromo(Lista) :- 
    inverte(Lista, ListaInvertida),
    comparaLista(Lista, ListaInvertida).
