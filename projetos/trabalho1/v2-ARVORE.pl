%Trablho1 -  implementar arvore binaria em prolog
% Usando base de fatos dinˆamica e as estrutura de sele¸c˜ao e repeti¸c˜ao
% apresentadas anteriormente, desenvolva um programa prolog para
% inserir fatos que representam os n´os da ´arvore (no(Info,Esq,Dir))
% (conforme o primeiro exemplo de ´arvore bin´aria). O programa dever´a
% ainda ler uma op¸c˜ao (1-inserir, 2-apagar, 3-pre-ordem, 4-em-ordem,
% 5-pos-ordem e 6-fim) e se for necess´ario um valor, para fazer a
% manuten¸c˜ao de uma ´arvore bin´aria de busca.

:- dynamic(no/3).
:- dynamic(raiz/1).

:- assert(no(nada,nada,nada)), assert(raiz(nada)).

mostraRaiz :- 
    raiz(Raiz), 
    write('Raiz da árvore-> '), writeln(Raiz).

arvoreEstaVazia :- no(nada,nada,nada).

inserir(Valor, Valor) :- writeln('Valor ja existe na arvore').
inserir(Valor, nada) :-  
    retract(no(nada,nada,nada)), retract(raiz(nada)), 
    asserta(no(Valor, nada, nada)), asserta(raiz(Valor)), !.
inserir(Valor, SubRaiz) :-
    Valor < SubRaiz,
    no(SubRaiz, nada, Dir),
    retract(no(SubRaiz, nada, Dir)), 
    asserta(no(SubRaiz, Valor, Dir)), asserta(no(Valor, nada, nada)), !.
inserir(Valor, SubRaiz) :-
    Valor > SubRaiz,
    no(SubRaiz, Esq, nada),
    retract(no(SubRaiz, Esq, nada)), 
    asserta(no(SubRaiz, Esq, Valor)), asserta(no(Valor, nada, nada)), !.
inserir(Valor, SubRaiz) :- 
    no(SubRaiz, Esq, Dir),
    (Valor < SubRaiz -> inserir(Valor, Esq) ; inserir(Valor, Dir)).

listaNos :- 
    no(Info, Esq, Dir), 
    write('Raiz-> '), write(Info), 
    write(', Esquerda-> '), write(Esq), 
    write(', Direita-> '), write(Dir), nl, fail.
    
apagar(Raiz) :- retract(no(Raiz, _, _)).

preOrdem(nada) :- !.
preOrdem(Raiz) :- 
    write(Raiz), write(', '), 
    no(Raiz,Esq,Dir), 
    preOrdem(Esq), preOrdem(Dir).

emOrdem(nada) :- !.
emOrdem(Raiz) :- 
    no(Raiz,Esq,Dir), 
    emOrdem(Esq), 
    write(Raiz), write(', '), 
    emOrdem(Dir).

posOrdem(nada) :- !.
posOrdem(Raiz) :- 
    no(Raiz,Esq,Dir), 
    posOrdem(Esq), posOrdem(Dir), 
    write(Raiz), write(', ').

escreveOpcoes :- 
    writeln('======== Opções ========'),
    writeln('1 - Inserir'), 
    writeln('2 - Apagar'), 
    writeln('3 - Pre-ordem'), 
    writeln('4 - Em-ordem'), 
    writeln('5 - Pos-ordem'),
    writeln('6 - Listar todos os nós'),
    writeln('7 - Mostrar raiz'),
    writeln('0 - Fim'), 
    writeln('========================').

executarAcao(Acao) :- 
    raiz(Raiz),
    (Acao == 1 -> 
        writeln('Digite o valor do nó a ser inserido: '), 
        read(Noh),  
        inserir(Noh, Raiz)
    ; Acao == 2 -> 
        writeln('Digite o valor do nó a ser removido: '), 
        read(Noh), 
        apagar(Noh)
    ; Acao == 3 -> 
        writeln('Pre-ordem: '), 
        preOrdem(Raiz), 
        nl
    ; Acao == 4 ->
        writeln('Em-ordem: '), 
        emOrdem(Raiz), 
        nl
    ; Acao == 5 -> 
        writeln('Pos-ordem: '), 
        posOrdem(Raiz), 
        nl
    ; Acao == 6 -> 
        listaNos
    ; Acao == 7 ->
        mostraRaiz
    ; Acao == 0 ->
        writeln('Programa encerrado!'),
        halt(0)        
    ; writeln('Opção inválida!')
    ).

executarPrograma :- 
    repeat,
    escreveOpcoes,
    read(Opcao),
    executarAcao(Opcao),
    fail.

% :- raiz(R), inserir(5,R). 
% :- raiz(R), inserir(3,R).
% :- raiz(R), inserir(7,R).
% :- raiz(R), inserir(1,R).
% :- raiz(R), inserir(2,R).
% :- raiz(R), inserir(6,R).

:- executarPrograma.