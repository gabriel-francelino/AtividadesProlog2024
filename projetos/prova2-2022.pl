%Exercício 1
carro(fusca, branco, 1974).
carro(gol, vermelho, 1980).
carro(voyage, preto, 1978).
carro(gol, branco, 2001).
carro(uno, branco, 2004).

ex1 :- findall(Marca-Ano, carro(Marca, branco, Ano), L), writeln(L).

%Exercício 2
paresComFindall(Lista, Resultado) :- findall(X, (member(X, Lista), X mod 2 =:= 0), Resultado).

pares([], []).
pares([CabecaLista|RestoLista], [CabecaLista|Z]) :- CabecaLista mod 2 =:= 0, pares(RestoLista, Z).
pares([_|RestoLista], Z) :- pares(RestoLista, Z).

ex2 :- 
    writeln('Exemplo com findall:'), 
    paresComFindall([1,2,3,4,5,6,7,8,9,10], R1), writeln(R1), 
    writeln('Exemplo sem findall:'), 
    pares([1,2,3,4,5,6,7,8,9,10], R2), writeln(R2).

%Exercício 3
trunca([_|_], 0, []).
trunca([CabecaLista|RestoLista], Valor, [CabecaLista|ListaTruncada]) :- 
    ValorAux is Valor - 1, trunca(RestoLista, ValorAux, ListaTruncada).

ex3 :- trunca([1,2,3,4,5,6,7,8,9,10], 5, R), writeln(R).

%Exercício 4
d(0).
d(1).

ex4 :- findall([A,B],(d(A),d(B)),L), writeln(L).

%Exercício 5
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

% Gabarito com as respostas
gabarito :- 
    writeln('Exercício 1:'), ex1,
    writeln('Exercício 2:'), ex2,
    writeln('Exercício 3:'), ex3,
    writeln('Exercício 4:'), ex4.