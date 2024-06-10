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

% Ordenacao por selecao
remove(_, [], []).
remove(Valor, [Valor|CaldaLista], CaldaLista) :- !.
remove(Valor, [CabecaLista|CaldaLista], [CabecaLista|ListaResultante]) :-
    remove(Valor, CaldaLista, ListaResultante).

min([Valor], Valor).
min([Cabeca|Calda], Cabeca) :- min(Calda, MinimoCalda), Cabeca =< MinimoCalda.
min([Cabeca|Calda], Minimo) :- min(Calda, Minimo), Cabeca > Minimo.

removeMin(Minimo, Lista, NovaLista) :- 
    min(Lista, Minimo), remove(Minimo, Lista, NovaLista), !.

ordenacaoPorSelecao([], []) :- !.
ordenacaoPorSelecao(Lista, [Minimo|ListaOrdenada]) :- 
    removeMin(Minimo, Lista, ListaAux), ordenacaoPorSelecao(ListaAux, ListaOrdenada), !.

% Ordenacao por troca
ordenacaoPorTroca(Lista, ListaOrdenada) :- 
    append(Ord, [A,B|L], Lista), B < A, !,
    append(Ord, [B,A|L], ListaAux),
    ordenacaoPorTroca(ListaAux, ListaOrdenada).
ordenacaoPorTroca(Lista, Lista).