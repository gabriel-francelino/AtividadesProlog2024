% Pilha 
empilha(Elemento, Pilha, [Elemento|Pilha]) :- !.
desempilha(Elemento, [Elemento|Pilha], Pilha) :- !.

% Empilha uma lista de elementos em uma pilha de uma só vez
empLista([], Pilha, Pilha) :- !.
empLista([Elemento|CaldaLista], Pilha, NovaPilha) :- 
    empilha(Elemento, Pilha, PilhaAux), !, empLista(CaldaLista, PilhaAux, NovaPilha).

% Fila
insere(Elemento, Fila, NovaFila) :- 
    append(Fila, [Elemento], NovaFila), !.
retira(Elemento, [Elemento|CaldaFila], CaldaFila) :- !.

% Insere uma lista de elementos em uma fila de uma só vez
insLista([], Fila, Fila) :- !.
insLista([Elemento|CaldaFila], Fila, NovaFila) :- 
    insere(Elemento, Fila, FilaAux), !, insLista(CaldaFila, FilaAux, NovaFila).

% Arvore binaria
no(raiz, esq, dir)
no(a,b,c).
no(b,d,[]).
no(d,[],[]).
no(c,e,f).
no(e,[],g).
no(f,[],[]).
no(g,[],[]).

% Percorrendo a arvore
preOrdem([]).
preOrdem(raiz) :- 
    no(raiz, Esq, Dir), 
    write(raiz), write(' '), 
    preOrdem(Esq), 
    preOrdem(Dir), !.

emOrdem([]).
emOrdem(raiz) :-
    no(raiz, Esq, Dir),
    emOrdem(Esq),
    write(raiz), write(' '),
    emOrdem(Dir), !.

posOrdem([]).
posOrdem(raiz) :- 
    no(raiz, Esq, Dir),
    posOrdem(Esq),
    posOrdem(Dir),
    write(raiz), write(' '), !.

% Outra representação de arvore
insereArv(Valor, [], no(Valor, [], [])) :- !.
insereArv(Valor, no(Valor, Esq, Dir), no(Valor, Esq, Dir)) :- !.
insereArv(Valor, no(Raiz, Esq, Dir), no(Raiz, EsqNova, Dir)) :- 
    Valor < Raiz, !, insereArv(Valor, Esq, EsqNova).
insereArv(Valor, no(Raiz, Esq, Dir), no(Raiz, Esq, DirNova)) :- 
    Valor > Raiz, !, insereArv(Valor, Dir, DirNova).

insListaEmArv([], A-A) :- !.
insListaEmArv([Elemento|CaldaLista], X-Z) :- 
    insereArv(Elemento, X, Y), !, insListaEmArv(CaldaLista, Y-Z).

