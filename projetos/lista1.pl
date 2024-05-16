%ex 1
analisa_lista([]) :- write('A lista esta vazia').
analisa_lista([CABECA|CALDA]) :- 
    write('A cabeca da lista eh: '), write(CABECA), nl, 
    write('A calda da lista eh: '), write(CALDA), nl.

%ex2 - reforçar
remove_duplicados([], []).
remove_duplicados([A|B], C) :- member(A, B), remove_duplicados(B, C), !.
remove_duplicados([A|B], [A|C]) :- remove_duplicados(B,C).

%ex3
%troca(Lista, ValorParaTrocar, ElementoDeTroca, Resultado).
troca([], _, _, []).
troca([X], X, Y, [Y]).
troca([X|B], X, Y, [Y|C]) :- troca(B, X, Y, C), !.
troca([A|B], X, Y, [A|C]) :- A\==X, troca(B, X, Y, C). 

%ex4

%ex5
mais_longa([], [_|_]).
mais_longa([_|A], [_|C]) :- mais_longa(A, C).

%ex6
%distancia((0,0), (3,4), X).
raiz_quadrada(X, Y) :- Y is sqrt(X).

potencia(X, 1, X).
potencia(X, N, R) :-
    N>1, N1 is N - 1, 
    potencia(X, N1, R1),
    R is R1*R1, !.

distancia((X1, Y1), (X2, Y2), D) :- 
    potencia((X2-X1), 2, P1), potencia((Y2-Y1), 2, P2),
    SOMA is P1 + P2,
    raiz_quadrada(SOMA, D).


%ex7 - usando metodos callback
escreva_linha(N, S) :- forall(between(1, N, _), (write(S), write(' '))), nl.
quadrado(N, S) :- forall(between(1, N, _), escreva_linha(N, S)), nl.

%ex7 - sem metodos callback
desenha_linha(0, _) :- nl, !.
desenha_linha(N, S) :- 
    (write(S), write(' ')), 
    N1 is N-1, 
    desenha_linha(N1, S).

desenha_quadro(_, _, 0) :- !.
desenha_quadro(N, S, C) :- 
    desenha_linha(N, S), 
    C1 is C-1, 
    desenha_quadro(N, S, C1).

quadrado2(N, S) :- desenha_quadro(N, S, N).

%ex8
elemento_n([A|_], 1, A) :- !.
elemento_n([_|B], N, R) :- N1 is N-1, elemento_n(B, N1, R).

%ex9
soma_lista([X], X) :- !.
soma_lista([X|Y], R) :- soma_lista(Y, R1), R is X + R1.

tamanho_lista([], 0) :- !.
tamanho_lista([_|B], N) :- tamanho_lista(B, N1), N is N1 + 1.

media(L, M) :- soma_lista(L, S), tamanho_lista(L, N), M is S/N, !.

%ex10
minimo([X], X).
minimo([X|Y], X) :- minimo(Y, R), X =< R.
minimo([X|Y], R) :- minimo(Y, R), R =< X.

%ex11
intervalo(A, B, []) :- A > B.
intervalo(A, B, [A|L]) :- C is A+1, intervalo(C, B, L).

%ex13
ocorrencias(_, [], 0).
ocorrencias(A, [A|B], N) :- ocorrencias(A, B, N1), N is N1 + 1.
ocorrencias(A, [B|C], N) :- A \= B, ocorrencias(A, C, N).

%ex14 -
lista_divisores(Number, Number, [Number]).
lista_divisores(Number, Value, [Value|List]) :- 
    Mod is Number mod Value, Mod =:= 0, 
    DecrementedValue is Value+1, lista_divisores(Number, DecrementedValue, List), !.
lista_divisores(Number, Value, List) :- 
    DecrementedValue is Value+1, lista_divisores(Number, DecrementedValue, List).

divisores(Number, List) :- lista_divisores(Number, 1, List).

%ex14 - inverso
% lista_divisores(_, 1, [1]).
% lista_divisores(Number, Value, [Value|List]) :- 
%     Mod is Number mod Value, Mod =:= 0, 
%     DecrementedValue is Value-1, lista_divisores(Number, DecrementedValue, List), !.
% lista_divisores(Number, Value, List) :- 
%     DecrementedValue is Value-1, lista_divisores(Number, DecrementedValue, List).

% divisores(Number, List) :- lista_divisores(Number, Number, List).

