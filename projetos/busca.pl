%------------------------------------------
% Busca em largura/profundidade
% Por Luiz Eduardo
%------------------------------------------
ap([],X,X).
ap([A|B],C,[A|D]) :- ap(B,C,D).

in(A,[A|_]) :- !.
in(A,[_|B]) :- in(A,B).

% Implementacao do algoritmo de busca em largura ou profundidade
% 1 = largura
% 2 = profundidade
estrategia(2).

atingemeta([_-E|_]) :- meta(E).

busca([Caminho|_], Solucao) :- atingemeta(Caminho), !, Solucao = Caminho.
busca([Caminho|Lista], Solucao) :- 
   findall(UMAEXT, estende(Caminho,UMAEXT), EXT),
   estrategia(Tipo),
   estrategia(Tipo),
   (Tipo = 1 -> ap(Lista, EXT,  Lista1);
    Tipo = 2 -> ap(EXT, Lista, Lista1)),
   busca(Lista1, Solucao).

naorepete(_-E,C) :- not(in(_-E,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

margem([F,L,C,R], M) :-
   (F = M -> write('F'); write(' ')),
   (L = M -> write('L'); write(' ')),
   (C = M -> write('C'); write(' ')),
   (R = M -> write('R'); write(' ')).

desenha(Estado) :-
     write('    '), margem(Estado, a), write('|    |'), margem(Estado,b).

escreve([_-E]) :- write('Estado Inicial: '), write(E), nl, !.
escreve([O-E|R]) :- 
    escreve(R), 
    write('Executando: '), 
    traduz(O,T),
    write(T), write(' obtemos '), /*desenha(E),*/ write(E), nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

%-----------------------------------
% Especificacao do problema
%-----------------------------------

% JARROS 2 E 3 LITROS -----------------------------------------------------------
% traduz(c1, 'encher o jarro 1  ').
% traduz(c2, 'encher o jarro 2  ').
% traduz(v1, 'esvaziar o jarro 1').
% traduz(v2, 'esvaziar o jarro 2').
% traduz(12, 'despejar 1 em 2   ').
% traduz(21, 'despejar 2 em 1   ').
% inicial([0,0]).
% meta([_,2]).
% oper(c1, [X,Y], [3,Y]) :- X < 3.
% oper(c2, [X,Y], [X,4]) :- Y < 4.
% oper(v1, [X,Y], [0,Y]) :- X > 0.
% oper(v2, [X,Y], [X,0]) :- Y > 0.
% oper(12, [X,Y], [0,Y1]) :- X > 0, Y < 4, Y1 is X + Y, Y1 =< 4.
% oper(12, [X,Y], [X1,4]) :- X > 0, Y < 4, X1 is X + Y - 4, X + Y > 4.
% oper(21, [X,Y], [X1,0]) :- Y > 0, X < 3, X1 is X + Y, X1 =< 3.
% oper(21, [X,Y], [3,Y1]) :- Y > 0, X < 3, Y1 is X + Y - 3, X + Y > 3.

% % Fazendeiro, lobo, cabra e repolho -------------------------------------------
% traduz(fa, 'fazendeiro vai sozinho   ').
% traduz(fb, 'fazendeiro volta sozinho ').
% traduz(la, 'fazendeiro leva o lobo   ').
% traduz(lb, 'fazendeiro traz o lobo   ').
% traduz(ca, 'fazendeiro leva a cabra  ').
% traduz(cb, 'fazendeiro traz a cabra  ').
% traduz(ra, 'fazendeiro leva o repolho').
% traduz(rb, 'fazendeiro traz o repolho').

% oper(fa, [a,L,C,R], [b,L,C,R]) :- L \= C, C \= R.
% oper(fb, [b,L,C,R], [a,L,C,R]) :- L \= C, C \= R.
% oper(la, [a,a,C,R], [b,b,C,R]) :- (C \= R; C = b).
% oper(lb, [b,b,C,R], [a,a,C,R]) :- (C \= R; C = a).
% oper(ca, [a,L,a,R], [b,L,b,R]).
% oper(cb, [b,L,b,R], [a,L,a,R]).
% oper(ra, [a,L,C,a], [b,L,C,b]) :- (L \= C; C = b).
% oper(rb, [b,L,C,b], [a,L,C,a]) :- (L \= C; C = a).

% % [F,L,C,R], margem em que está cada elemento
% inicial([a,a,a,a]).
% meta([b,b,b,b]).

% Problema dos jarros de 8, 5 e 3 litros -------------------------------------------
/*
Há três jarros com capacidades de 8, 5 e 3 litros,
respectivamente. O jarro de 8 litros está cheio de água.
Sabendo-se que podemos transferir o conteúdo de um jarro para
outro, encontre a sequência de operações para deixar os jarros de 8
e 5 litros com exatamente 4 litros de água cada.
*/

% Jarras: 8 -> A, 5 -> B, 3 -> C
traduz(transfere8para5, 'transfere de 8 para 5').
traduz(transfere8para3, 'transfere de 8 para 3').
traduz(transfere5para3, 'transfere de 5 para 3').
traduz(transfere5para8, 'transfere de 5 para 8').
traduz(transfere3para5, 'transfere de 3 para 5').
traduz(transfere3para8, 'transfere de 3 para 8').

inicial([8,0,0]).
meta([4,4,0]).
oper(transfere8para3, [A,_,C], [A1,B1,C1]) :-
    A > 0, C < 3, 
    X is A + C, A1 is X - 3, C1 is X - A1,
    Y is A1 + C1, B1 is 8 - Y. 
oper(transfere8para5, [A,B,_], [A1,B1,C1]) :-
    A > 0, B < 5,
    X is A + B, A1 is X - 5, B1 is X - A1,
    Y is A1 + B1, C1 is 8 - Y.
oper(transfere5para3, [_,B,C], [A1,B1,C1]) :-
    B > 0, C < 3,
    X is B + C, B1 is X - 3, C1 is X - B1,
    Y is B1 + C1, A1 is 8 - Y. 
oper(transfere5para8, [A,B,_], [A1,B1,C1]) :-
    B > 0, A < 8,
    X is B + A, B1 is X - 8, A1 is X - B1,
    Y is B1 + A1, C1 is 8 - Y.
oper(transfere3para5, [_,B,C], [A1,B1,C1]) :-
    C > 0, B < 5,
    X is C + B, C1 is X - 5, B1 is X - C1,
    Y is C1 + B1, A1 is 8 - Y.
oper(transfere3para8, [A,_,C], [A1,B1,C1]) :-
    C > 0, A < 8,
    X is C + A, C1 is X - 8, A1 is X - C1,
    Y is C1 + A1, B1 is 8 - Y.