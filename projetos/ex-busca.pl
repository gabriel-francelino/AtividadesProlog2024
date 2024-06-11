% Problema dos jarros de 8, 5 e 3 litros
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

