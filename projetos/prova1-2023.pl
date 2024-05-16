%ex5
escreve_linha(N, E) :- forall(between(1,N,_),(write(E))), nl.

triangulo(N, E) :- forall(between(1,N,R), (escreve_linha(R, E))).

%ex5
write_line(1, Symbol) :- write(Symbol), nl, !.
write_line(Number, Symbol) :- write(Symbol), N1 is Number-1, write_line(N1,Symbol). 

draw_triangle(Number, Symbol, Number) :- write_line(Number, Symbol).
draw_triangle(Number, Symbol, Count) :- 
    Count =< Number, write_line(Count, Symbol), 
    Count1 is Count+1, draw_triangle(Number, Symbol, Count1). 

triangle(Number, Symbol) :- draw_triangle(Number, Symbol, 1), !.


%ex4
contazero([], 0).
contazero([Zero|Lista], Resultado) :- Zero =:= 0, contazero(Lista, Numero), Resultado is Numero + 1, !.
contazero([_|Lista], Resultado) :- contazero(Lista, Resultado).