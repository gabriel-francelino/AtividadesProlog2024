% Ordenacao por insercao
insereOrd(Elemento, [], [Elemento]) :- !.
insereOrd(Elemento, [CabecaLista|CaldaLista], [Elemento, CabecaLista|CaldaLista]) :- 
    Elemento =< CabecaLista, !.
insereOrd(Elemento, [CabecaLista|CaldaLista], [CabecaLista|ListaOrdenada]) :-
    Elemento > CabecaLista, !, insereOrd(Elemento, CaldaLista, ListaOrdenada).

ordenacaoPorInsercao([], []) :- !.
ordenacaoPorInsercao([CabecaLista|CaldaLista], ListaOrdenada) :- 
    ordenacaoPorInsercao(CaldaLista, ListaOrdenadaAux), 
    insereOrd(CabecaLista, ListaOrdenadaAux, ListaOrdenada).