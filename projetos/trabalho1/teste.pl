%UMA REPRESENTAÇÃO DE ÁRVORE EM PROLOG
%arvore de teste
% no(5,3,8).
% no(3,1,4).
% no(1,[],2).
% no(2,[],[]).
% no(4,[],[]).
% no(8,7,9).
% no(7,6,[]).
% no(6,[],[]).
% no(9,[],[]).

% preOrdem([]) :- !.
% preOrdem(Raiz) :- 
%     write(Raiz), write(' '), 
%     no(Raiz,Esquerda,Direita), 
%     preOrdem(Esquerda), preOrdem(Direita).

% emOrdem([]) :- !.
% emOrdem(Raiz) :- 
%     no(Raiz,Esquerda,Direita), 
%     emOrdem(Esquerda), 
%     write(Raiz), write(' '), 
%     emOrdem(Direita).

% posOrdem([]) :- !.
% posOrdem(Raiz) :- 
%     no(Raiz,Esquerda,Direita), 
%     posOrdem(Esquerda), posOrdem(Direita), 
%     write(Raiz), write(' ').

%preOrdem(5), nl, emOrdem(5), nl, posOrdem(5).


% :- dynamic(fato/1).
% cadastra([]).
% cadastra([A|B]) :- assert(fato(A)), cadastra(B).

% apaga(A) :- retract(fato(A)).

% listafatos :-
%     fato(X),
%     writeln(X),
%     fail.
% listafatos.

% limpa :- abolish(fato/1).

%Trablho1 -  implementar arvore binaria em prolog
% Usando base de fatos dinˆamica e as estrutura de sele¸c˜ao e repeti¸c˜ao
% apresentadas anteriormente, desenvolva um programa prolog para
% inserir fatos que representam os n´os da ´arvore (no(Info,Esq,Dir))
% (conforme o primeiro exemplo de ´arvore bin´aria). O programa dever´a
% ainda ler uma op¸c˜ao (1-inserir, 2-apagar, 3-pre-ordem, 4-em-ordem,
% 5-pos-ordem e 6-fim) e se for necess´ario um valor, para fazer a
% manuten¸c˜ao de uma ´arvore bin´aria de busca.

:- dynamic(no/3).
:- dynamic(opcao/1).

inserir(Info, Esq, Dir) :- assert(no(Info, Esq, Dir)).
apagar(Info) :- retract(no(Info, _, _)).
preOrdem(Info) :- no(Info, Esq, Dir), write(Info), write(' '), preOrdem(Esq), preOrdem(Dir).
emOrdem(Info) :- no(Info, Esq, Dir), emOrdem(Esq), write(Info), write(' '), emOrdem(Dir).
posOrdem(Info) :- no(Info, Esq, Dir), posOrdem(Esq), posOrdem(Dir), write(Info), write(' ').

menu :- writeln('1 - Inserir'), writeln('2 - Apagar'), writeln('3 - Pre-ordem'), writeln('4 - Em-ordem'), writeln('5 - Pos-ordem'), writeln('6 - Fim'), read(Opcao), assert(opcao(Opcao)), executa(Opcao).

executa(1) :- writeln('Digite o valor do nó: '), read(Info), writeln('Digite o valor do nó esquerdo: '), read(Esq), writeln('Digite o valor do nó direito: '), read(Dir), inserir(Info, Esq, Dir), menu.

executa(2) :- writeln('Digite o valor do nó: '), read(Info), apagar(Info), menu.

executa(3) :- writeln('Pre-ordem: '), preOrdem(5), nl, menu.

executa(4) :- writeln('Em-ordem: '), emOrdem(5), nl, menu.

executa(5) :- writeln('Pos-ordem: '), posOrdem(5), nl, menu.

executa(6) :- halt.

% :- menu.

% Exemplo de uso:
% 1 - Inserir
% 2 - Apagar
% 3 - Pre-ordem
% 4 - Em-ordem
% 5 - Pos-ordem
% 6 - Fim
% 1.
% Digite o valor do nó:
% 10.
% Digite o valor do nó esquerdo:
% 5.
% Digite o valor do nó direito:
% 15.
% 1 - Inserir
% 2 - Apagar
% 3 - Pre-ordem
% 4 - Em-ordem
% 5 - Pos-ordem
% 6 - Fim
% 3.
% Pre-ordem: 10 5 15