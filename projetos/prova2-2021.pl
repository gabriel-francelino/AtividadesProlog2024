% Exercício 1

% produto(nome, codigo)
produto(prego, 12).
produto(lixa, 20).
produto(cola, 25).
produto(papel, 15).
% preco(codigo, valor)
preco(10, 1).
preco(12, 2).
preco(15, 3).
preco(20, 4).
preco(22, 5).
preco(25, 6).
preco(30, 7).

ex1 :- findall((P,V), (produto(P, ID), preco(ID, V)), L), writeln(L).

% Exercício 2

criaLista(1, X, [X]).
criaLista(N, X, [X|L]) :- N1 is N-1, criaLista(N1, X, L).

ex2 :- criaLista(5, a, L), writeln(L).

% Exercício 3

apagaPar([], []).
apagaPar([X|Y], [X|Z]) :- X mod 2 =\= 0, apagaPar(Y, Z).
apagaPar([_|Y], Z) :- apagaPar(Y, Z).

ex3 :- apagaPar([1,2,4,5,6,7,8,10], L), writeln(L).

% Exercício 4

selecaoparcial([], [], _).
selecaoparcial(_, [], 0).
selecaoparcial(L, [M|S], N) :- N1 is N-1, removeMin(M, L, L1), selecaoparcial(L1, S, N1), !.

seleciona(X,[X|Y], Y).
seleciona(X,[Y|Z],[Y|W]) :- seleciona(X,Z,W).

min([X],X).
min([X|Xs],M) :-
min(Xs,M1),(X < M1 -> M = X ; M = M1), !.

removeMin(M,L,Lo) :- min(L,M), seleciona(M,L,Lo).

ex4 :- selecaoparcial([40,10,60,50,20,80], L, 3), writeln(L).

% Gabarito

gabarito :- 
    writeln('Exercício 1:'), ex1,
    writeln('Exercício 2:'), ex2,
    writeln('Exercício 3:'), ex3,
    writeln('Exercício 4:'), ex4.
