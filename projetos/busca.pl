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

oper(transfere8para3, [A,B,C], [A1,B,C1]) :-
    A > 0, C < 3, Soma is A + C, 
    (Soma > 3 -> 
        A1 is Soma - 3, C1 is 3 ;
        A1 is 0, C1 is Soma).
oper(transfere8para5, [A,B,C], [A1,B1,C]) :-
    A > 0, B < 5, Soma is A + B, 
    (Soma > 5 -> 
        A1 is Soma - 5, B1 is 5 ;
        A1 is 0, B1 is Soma).
oper(transfere5para3, [A,B,C], [A,B1,C1]) :-
    B > 0, C < 3, Soma is B + C, 
    (Soma > 3 -> 
        B1 is Soma - 3, C1 is 3 ;
        B1 is 0, C1 is Soma).
oper(transfere5para8, [A,B,C], [A1,0,C]) :- % de 5 para 8 nunca sobra nada em no jarro 5
    B > 0, A < 8, A1 is B + A.
oper(transfere3para5, [A,B,C], [A,B1,C1]) :-
    C > 0, B < 5, Soma is C + B, 
    (Soma > 5 -> 
        C1 is Soma - 5, B1 is 5 ;
        C1 is 0, B1 is Soma).
oper(transfere3para8, [A,B,C], [A1,B,0]) :- % de 3 para 8 nunca sobra nada em no jarro 3
    C > 0, A < 8, A1 is C + A.
 
% inicial([8,0,0]).
% meta([4,4,0]).
% oper(transfere8para3, [A,_,C], [A1,B1,C1]) :-
%     A > 0, C < 3, 
%     X is A + C, 
%     (X > 3 -> 
%         A1 is X - 3, C1 is X - A1;
%         A1 is 0, C1 is X),
%     Y is A1 + C1, B1 is 8 - Y. 
% oper(transfere8para5, [A,B,_], [A1,B1,C1]) :-
%     A > 0, B < 5,
%     X is A + B, 
%     (X > 5 -> 
%         A1 is X - 5, B1 is X - A1;
%         A1 is 0, B1 is X),
%     Y is A1 + B1, C1 is 8 - Y.
% oper(transfere5para3, [_,B,C], [A1,B1,C1]) :-
%     B > 0, C < 3,
%     X is B + C, 
%     (X > 3 ->
%         B1 is X - 3, C1 is X - B1;
%         B1 is 0, C1 is X),
%     Y is B1 + C1, A1 is 8 - Y. 
% oper(transfere5para8, [A,B,_], [A1,B1,C1]) :-
%     B > 0, A < 8,
%     X is B + A, 
%     (X > 8 -> 
%         B1 is X - 8, A1 is X - B1 ;
%         B1 is 0, A1 is X),
%     Y is B1 + A1, C1 is 8 - Y.
% oper(transfere3para5, [_,B,C], [A1,B1,C1]) :-
%     C > 0, B < 5,
%     X is C + B, 
%     (X > 5 -> 
%         C1 is X - 5, B1 is X - C1 ;
%         C1 is 0, B1 is X),
%     Y is C1 + B1, A1 is 8 - Y.
% oper(transfere3para8, [A,_,C], [A1,B1,C1]) :-
%     C > 0, A < 8,
%     X is C + A, 
%     (X > 8 -> 
%         C1 is X - 8, A1 is X - C1 ;
%         C1 is 0, A1 is X),
%     Y is C1 + A1, B1 is 8 - Y.

% Missionarios e canibais --------------------------------------------------------------------
% traduz(vaiM, 'vai um missionario').
% traduz(voltaM, 'volta um missionario').
% traduz(vaiMM, 'vai dois missionarios').
% traduz(voltaMM, 'volta dois missionarios').
% traduz(vaiC, 'vai um canibal').
% traduz(voltaC, 'volta um canibal').
% traduz(vaiCC, 'vai dois canibais').
% traduz(voltaCC, 'volta dois canibais').
% traduz(vaiMC, 'vai um missionario e um canibal').
% traduz(voltaMC, 'volta um missionario e um canibal').

% % [Missionarios1, Canibais1, Missionarios2, Canibais2, LadoDoBarco]
% inicial([3,3,0,0,1]).
% meta([0,0,3,3,2]).

% seguro([M1,C1,M2,C2]) :- (M1 >= C1; M1 =:= 0), (M2 >= C2; M2 =:= 0).

% oper('vaiM', [M1,C1,M2,C2,1], [A,C1,B,C2,2]) :-
%     M1 >= 1, M2 < 3, A is M1 - 1, B is M2 + 1, seguro([A,C1,B,C2]).
% oper('voltaM', [M1,C1,M2,C2,2], [A,C1,B,C2,1]) :-
%     M2 >= 1, M1 < 3, A is M1 + 1, B is M2 - 1, seguro([A,C1,B,C2]).
% oper('vaiMM', [M1,C1,M2,C2,1], [A,C1,B,C2,2]) :-
%     M1 >= 2, M2 < 2, A is M1 - 2, B is M2 + 2, seguro([A,C1,B,C2]).
% oper('voltaMM', [M1,C1,M2,C2,2], [A,C1,B,C2,1]) :-
%     M2 >= 2, M1 < 2, A is M1 + 2, B is M2 - 2, seguro([A,C1,B,C2]).

% oper('vaiC', [M1,C1,M2,C2,1], [M1,X,M2,Y,2]) :-
%     C1 >= 1, C2 < 3, X is C1 - 1, Y is C2 + 1, seguro([M1,X,M2,Y]).
% oper('voltaC', [M1,C1,M2,C2,2], [M1,X,M2,Y,1]) :-
%     C2 >= 1, C1 < 3, X is C1 + 1, Y is C2 - 1, seguro([M1,X,M2,Y]).
% oper('vaiCC', [M1,C1,M2,C2,1], [M1,X,M2,Y,2]) :-
%     C1 >= 2, C2 < 2, X is C1 - 2, Y is C2 + 2, seguro([M1,X,M2,Y]).
% oper('voltaC', [M1,C1,M2,C2,2], [M1,X,M2,Y,1]) :-
%     C2 >= 2, C1 < 2, X is C1 + 2, Y is C2 - 2, seguro([M1,X,M2,Y]).

% oper('vaiMC', [M1,C1,M2,C2,1], [A,X,B,Y,2]) :-
%     M1 >= 1, M2 < 3, C1 >= 1, C2 < 3, 
%     A is M1 - 1, B is M2 + 1, X is C1 - 1, Y is C2 + 1, 
%     seguro([A,X,B,Y]).
% oper('voltaMC', [M1,C1,M2,C2,2], [A,X,B,Y,1]) :-
%     M2 >= 1, M1 < 3, C2 >= 1, C1 < 3, 
%     A is M1 + 1, B is M2 - 1, X is C1 + 1, Y is C2 - 1, 
%     seguro([A,X,B,Y]).