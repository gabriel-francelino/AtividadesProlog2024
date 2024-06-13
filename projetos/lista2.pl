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

% EX4
potencia(X, Y, Resultado) :- acumulador(X, Y, 1, Resultado).

acumulador(_, 0, Acc, Acc).
acumulador(X, Y, Acc, Resultado) :-
    Y > 0, NewAcc is Acc * X, Y1 is Y - 1,
    acumulador(X, Y1, NewAcc, Resultado).

% EX5
d(0).
d(1).
% ex5 :- findall([A,B],(d(A),d(B)),L).
% Resultado => L = [[0, 0], [0, 1], [1, 0], [1, 1]]

% EX6
concatena([], L, L).
concatena([X|L1], L2, [X|L3]) :- concatena(L1, L2, L3).

inverte([X], [X]).
inverte([X|Y], Z) :- inverte(Y, W), append(W, [X], Z).

comparaLista([A],[A]) :- !.
comparaLista([A|B], [C|D]) :- A == C, comparaLista(B, D).

palindromo(Lista) :- 
    inverte(Lista, ListaInvertida),
    comparaLista(Lista, ListaInvertida).

% EX7
invert([], []) :- !.
invert([Cabeca|Calda], ListaInvertida) :- 
    invert(Calda, ListaAux), 
    append(ListaAux, [Cabeca], ListaInvertida).

metIguais(Lista) :-
    invert(Lista, ListaInvertida),
    (comparaLista(Lista, ListaInvertida) -> 
        writeln('Yes') ; writeln('No')
    ).

% EX8
insereOrd(Elemento, [], [Elemento]) :- !.
insereOrd(Elemento, [Cabeca|Calda], [Elemento,Cabeca|Calda]) :-
    Elemento @=< Cabeca, !.
insereOrd(Elemento, [Cabeca|Calda], [Cabeca|ListaOrd]) :-
    Elemento @> Cabeca, !, insereOrd(Elemento, Calda, ListaOrd).

ordena([],[]) :- !.
ordena([Cabeca|Calda], ListaOrd) :-
    ordena(Calda, ListaAux), insereOrd(Cabeca, ListaAux, ListaOrd).

% EX9
particiona([A,B], [A], [B]) :- !.
particiona([A], [A], []) :- !.
particiona([A,B|L], [A|L1], [B|L2]) :- particiona(L, L1, L2).

% EX10
%juntar as duas listas e ordenadas 
merge(Lista1, Lista2, Resultado) :- 
    append(Lista1, Lista2, ListasJuntas),
    ordena(ListasJuntas, Resultado).

% EX11
/*
O que está errado no programa abaixo? Rode-o com trace, para:
?- max(4,3,M)
?- max(3,4,M)
max(X,Y,M):-!, X>Y, M=X.
max(X,Y,M):-!, X<=Y, M=Y.

Resposta => 
O primeiro erro está na comparação 'X<=Y', em prolog o operador correto seria 'X=<Y'.
O segundo erro é acontece por causa do corte '!', ele não permite que o backtracking aconteca.
*/

% EX12
/*
O que acontece com o predicado p, abaixo, quando o b é executado?
a. b. p:-!,a. p:-b.

Resposta => 
Quando o predicado `b` é executado, ele tem sucesso, e quando o 
predicado `p` é executado, ele também tem sucesso devido à 
primeira cláusula `p :- !, a.`, e a segunda cláusula `p :- b.` 
nunca é considerada por causa do corte (`!`).
*/

% EX13
pred1(Lista, Resultado) :- findall([X], member(X, Lista), Resultado).
pred2(Lista, Resultado) :- findall(pred(X,X), member(X, Lista), Resultado).
pred3(Lista, Resultado) :- findall([element,X], member(X, Lista), Resultado).

% EX14
/*
Considere o seguinte problema: “Há dois jarros com capacidades de 3 e 4 litros,
respectivamente. Nenhum dos jarros contém qualquer medida ou escala, de modo que só
se pode saber o conteúdo exato quando eles estão cheios. Sabendo-se que podemos
encher ou esvaziar um jarro, bem como transferir água de um jarro para outro, encontre
uma sequência de passos que deixe o jarro de 4 litros com exatamente 2 litros de água”.
Considere que o estado inicial pode ser representado pela lista [0,0], indicando que os
jarros de 3 e 4 litros estão vazios inicialmente e a meta é [_,2]. Complete os predicados
transforma abaixo para descrever todas as transformações possíveis de estados desse
problema.
*/
inicial([0,0]).
meta([0,2]).

transforma('encher o jarro 1', [X,Y], [3,Y]) :- X < 3.
transforma('enchar o jarro 2', [X,Y], [X,4]) :- Y < 4.
transforma('esvaziar o jarro 1', [X,Y], [0,Y]) :- X > 0.
transforma('esvaziar o jarro 2', [X,Y], [X,0]) :- Y > 0.
transforma('transferir do jarro 1 para o 2', [X,Y], [0,B]) :- 
    X > 0, Y < 4, B is X + Y, B =< 4.
transforma('transferir do jarro 2 para o 1', [X,Y], [A,0]) :-
    X < 3, Y > 0, A is X + Y, A =< 3.
%--- considerando que ainda restara agua no jarro de origem
transforma('transferir do jarro 1 para o 2', [X,Y], [A,4]) :-
    X > 0, Y < 4, A is X + Y - 4, (X + Y) > 4.
transforma('transferir do jarro 2 para o 1', [X,Y], [3,B]) :- 
    X < 3, Y > 0, B is X + Y - 3, (X + Y) > 3.
