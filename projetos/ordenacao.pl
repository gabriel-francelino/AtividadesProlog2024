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

% min([Valor], Valor).
% min([Cabeca|Calda], Cabeca) :- min(Calda, MinimoCalda), Cabeca =< MinimoCalda.
% min([Cabeca|Calda], Minimo) :- min(Calda, Minimo), Cabeca > Minimo.

% Implementacao mais eficiente do min/2
min([X], [X]).
min([X|RestoLista], Menor) :- 
    min(RestoLista, MenorRestoLista),
    (X < MenorRestoLista -> Menor = X; Menor = MenorRestoLista), !.

removeMin(Minimo, Lista, NovaLista) :- 
    min(Lista, Minimo), remove(Minimo, Lista, NovaLista), !.

ordenacaoPorSelecao([], []) :- !.
ordenacaoPorSelecao(Lista, [Minimo|ListaOrdenada]) :- 
    removeMin(Minimo, Lista, ListaAux), ordenacaoPorSelecao(ListaAux, ListaOrdenada), !.

% Ordenacao por troca
ordenacaoPorTroca(Lista, ListaOrdenada) :- 
    append(Antes, [A,B|Depois], Lista), B < A, !,
    append(Antes, [B,A|Depois], ListaAux),
    ordenacaoPorTroca(ListaAux, ListaOrdenada).
ordenacaoPorTroca(Lista, Lista).

% Ordenacao por QuickSort
particao([X|RestoLista], Pivo, [X|Menores], Maiores) :- 
    X < Pivo, !, particao(RestoLista, Pivo, Menores, Maiores).
particao([X|RestoLista], Pivo, Menores, [X|Maiores]) :- 
    X >= Pivo, !, particao(RestoLista, Pivo, Menores, Maiores).
particao([], _, [], []).

quickSort([Pivo|RestoLista], ListaOrdenada) :-
    particao(RestoLista, Pivo, Menores, Maiores),
    quickSort(Menores, MenoresOrd),
    quickSort(Maiores, MaioresOrd),
    append(MenoresOrd, [Pivo|MaioresOrd], ListaOrdenada).
quickSort([],[]).