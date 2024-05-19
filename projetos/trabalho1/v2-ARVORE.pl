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

:- asserta(no(nada,nada,nada)), asserta(raiz(nada)).

mostraRaiz :- 
    raiz(Raiz), 
    write('Raiz da árvore-> '), writeln(Raiz).

arvoreEstaVazia :- no(nada,nada,nada).

inserir(Valor, Valor) :- writeln('Valor ja existe na arvore').
inserir(Valor, nada) :-  
    retract(no(nada,nada,nada)), retract(raiz(nada)), 
    assertz(no(Valor, nada, nada)), assertz(raiz(Valor)), !.
inserir(Valor, SubRaiz) :-
    Valor < SubRaiz,
    no(SubRaiz, nada, Dir),
    retract(no(SubRaiz, nada, Dir)), 
    assertz(no(SubRaiz, Valor, Dir)), assertz(no(Valor, nada, nada)), !.
inserir(Valor, SubRaiz) :-
    Valor > SubRaiz,
    no(SubRaiz, Esq, nada),
    retract(no(SubRaiz, Esq, nada)), 
    assertz(no(SubRaiz, Esq, Valor)), assertz(no(Valor, nada, nada)), !.
inserir(Valor, SubRaiz) :- 
    no(SubRaiz, Esq, Dir),
    (Valor < SubRaiz -> inserir(Valor, Esq) ; inserir(Valor, Dir)).

listaNos :- 
    no(Info, Esq, Dir), 
    write('Raiz-> '), write(Info), 
    write(', Esquerda-> '), write(Esq), 
    write(', Direita-> '), write(Dir), nl, fail.

apagarArvore :- 
    retractall(no(_,_,_)), 
    retractall(raiz(_)), 
    asserta(no(nada,nada,nada)), 
    asserta(raiz(nada)).
    
apagarNohFolha(Raiz) :- 
    (no(Raiz, nada, nada) -> 
        retract(no(Raiz, nada, nada)) ; 
        writeln('No momento só é permitido remover nós que são folhas.')
    ).

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
    writeln('2 - Apagar Árvore'), 
    writeln('3 - Apagar Nó Folha'),
    writeln('4 - Pre-ordem'), 
    writeln('5 - Em-ordem'), 
    writeln('6 - Pos-ordem'),
    writeln('7 - Listar todos os nós'),
    writeln('8 - Mostrar raiz'),
    writeln('0 - Fim'), 
    writeln('========================').

executarAcao(Acao) :- 
    raiz(Raiz),
    (Acao == 1 -> 
        writeln('Digite o valor do nó a ser inserido: '), 
        read(Noh),  
        inserir(Noh, Raiz)
    ; Acao == 2 ->
        apagarArvore
    ; Acao == 3 -> 
        writeln('Digite o valor do nó a ser removido: '), 
        read(Noh), 
        apagarNohFolha(Noh)
    ; Acao == 4 -> 
        writeln('Pre-ordem: '), 
        preOrdem(Raiz), 
        nl
    ; Acao == 5 ->
        writeln('Em-ordem: '), 
        emOrdem(Raiz), 
        nl
    ; Acao == 6 -> 
        writeln('Pos-ordem: '), 
        posOrdem(Raiz), 
        nl
    ; Acao == 7 -> 
        listaNos
    ; Acao == 8 ->
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

:- raiz(R), inserir(5,R). 
:- raiz(R), inserir(3,R).
:- raiz(R), inserir(7,R).
:- raiz(R), inserir(1,R).
:- raiz(R), inserir(2,R).
:- raiz(R), inserir(6,R).

:- executarPrograma.