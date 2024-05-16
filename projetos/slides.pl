%pertence
pertence(X, [X|_]).
pertence(X, [_|Resto]) :- pertence(X, Resto).

%apaga
apaga(X, [X|L], L).
apaga(X, [Y|L1], [Y, L2]) :- apaga(X, L1, L2).

%ex1
maximo(X,[X]).
maximo(X, [X|B]) :- maximo(Y,B), X > Y.
maximo(X, [A|B]) :- maximo(X, B), X > A.

%ex2
comprimento(0, []).
comprimento(X, [_|B]) :- comprimento(X1, B), X is X1 + 1.

%ex3
nesimo(1, [A|_], A).
nesimo(N, [_|B], X) :- N1 is N - 1, nesimo(N1, B, X).

%ex4
total([X], X).
total([A|B], X) :- total(B, X1), X is A + X1.

%remove
rem_elemento(A, [A], []).
rem_elemento(A, [A|X], X).
rem_elemento(A, [B|X], [B|Y]) :- rem_elemento(A, X, Y).

%concatena
concat([], L, L).
concat([A|B], L2, [A|L3]) :- concat(B, L2, L3).

%reverso
reverso([], []).
reverso([A|B], X) :- reverso(B, C), concat(C, [A], X).


%add
add(X, L, L) :- in(X, L), !.
add(X, L, [X|L]) :- !.

% in
in(X, [X|_]) :- !.
in(X, [_|L]) :- in(X,L).

%implementando metodos a partir do metodo concat()
membro(X, L) :- concat(_, [X|_], L).
ultimo(U, L) :- concat(_, [U], L).
prefixo(P,L) :- concat(P,_,L).
sufixo(S,L) :- concat(_,S,L).
sublista(S,L) :- prefixo(P,L), sufixo(S,P).
permuta([], []).
permuta(B, [A|C]) :- apaga(A, B, D), permuta(D, C).

%programação procedural
quadrado :-
	ledado(D),
	calcula(D, R),
	escreve(R).

ledado(X) :-
	write('Digite um valor '),
	read(X) .

calcula(D, R) :- R is D*D.

escreve(X) :- 
	write("O quadrado eh "),
	write(X), nl.