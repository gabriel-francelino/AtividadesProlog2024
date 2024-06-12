% Exercício 1
p(10).
p(-20).
p(30).

ex1 :- findall(X,(p(X), X>0), L), writeln(L).

% Exercício 2
pto(1,3).
pto(-1,5).
pto(-1,-2).
pto(3,-1).
pto(2,4).
pto(4,-5).

quadrante(1, L) :- findall((X,Y), (pto(X,Y), X>=0, Y>=0), L).
quadrante(2, L) :- findall((X,Y), (pto(X,Y), X=<0, Y>=0), L).
quadrante(3, L) :- findall((X,Y), (pto(X,Y), X=<0, Y=<0), L).
quadrante(4, L) :- findall((X,Y), (pto(X,Y), X>=0, Y=<0), L).

ex2 :- 
    write('Quadrante 1:'), quadrante(1, L1), writeln(L1),
    write('Quadrante 2:'), quadrante(2, L2), writeln(L2),
    write('Quadrante 3:'), quadrante(3, L3), writeln(L3),
    write('Quadrante 4:'), quadrante(4, L4), writeln(L4).

% Exercício 3
inverte([X], [X]).
inverte([X|Lista], ListaInvertida) :- 
    inverte(Lista, ListaAux), 
    append(ListaAux, [X], ListaInvertida).

comparaLista([X], [X]).
comparaLista([X|Y], [X|B]) :- comparaLista(Y, B).

palindromo(Lista) :- 
    inverte(Lista, ListaInvertida), 
    (comparaLista(Lista, ListaInvertida == true) ->
        write(Lista), write(' é palíndromo'), nl;
        write(Lista), write(' não é palíndromo'), nl
    ).

ex3 :- palindromo([a,b,c,d,c,b,a]).

% Exercício 4
insOrd(Elem, [], [Elem]).
insOrd(Elem, [CabecaLista|CaldaLista], [Elem, CabecaLista|CaldaLista]) :- Elem =< CabecaLista, !.
insOrd(Elem, [CabecaLista|CaldaLista], [CabecaLista|ListaOrdenada]) :- 
    Elem > CabecaLista, insOrd(Elem, CaldaLista, ListaOrdenada).

ex4 :- insOrd(4, [2,3,5,7], L), writeln(L).

% Exercício 5
inicial([8,0,0]).
meta([4,4,0]).
oper(transfere8para3, [A,_,C], [A1,B1,C1]) :-
    A > 0, C < 3, 
    X is A + C, 
    (X > 3 -> 
        A1 is X - 3, C1 is X - A1;
        A1 is 0, C1 is X),
    Y is A1 + C1, B1 is 8 - Y. 
oper(transfere8para5, [A,B,_], [A1,B1,C1]) :-
    A > 0, B < 5,
    X is A + B, 
    (X > 5 -> 
        A1 is X - 5, B1 is X - A1;
        A1 is 0, B1 is X),
    Y is A1 + B1, C1 is 8 - Y.
oper(transfere5para3, [_,B,C], [A1,B1,C1]) :-
    B > 0, C < 3,
    X is B + C, 
    (X > 3 ->
        B1 is X - 3, C1 is X - B1;
        B1 is 0, C1 is X),
    Y is B1 + C1, A1 is 8 - Y. 
oper(transfere5para8, [A,B,_], [A1,B1,C1]) :-
    B > 0, A < 8,
    X is B + A, 
    (X > 8 -> 
        B1 is X - 8, A1 is X - B1 ;
        B1 is 0, A1 is X),
    Y is B1 + A1, C1 is 8 - Y.
oper(transfere3para5, [_,B,C], [A1,B1,C1]) :-
    C > 0, B < 5,
    X is C + B, 
    (X > 5 -> 
        C1 is X - 5, B1 is X - C1 ;
        C1 is 0, B1 is X),
    Y is C1 + B1, A1 is 8 - Y.
oper(transfere3para8, [A,_,C], [A1,B1,C1]) :-
    C > 0, A < 8,
    X is C + A, 
    (X > 8 -> 
        C1 is X - 8, A1 is X - C1 ;
        C1 is 0, A1 is X),
    Y is C1 + A1, B1 is 8 - Y.

% Gabarito
gabarito :- 
    writeln('Exercício 1:'), ex1,
    writeln('Exercício 2:'), ex2,
    writeln('Exercício 3:'), ex3,
    writeln('Exercício 4:'), ex4.
