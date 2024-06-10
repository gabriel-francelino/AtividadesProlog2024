/*+=============================================================
2 | UNIFAL = Universidade Federal de Alfenas.
3 | BACHARELADO EM CIENCIA DA COMPUTACAO.
4 | Trabalho . . : Árvore binária em prolog
5 | Disciplina . : Progrmação Lógica
6 | Professor. . : Luiz Eduardo da Silva
7 | Aluno . . . .: Gabriel Francelino Nascimento
8 | Data . . . . : 20/05/2024
9 +=============================================================*/

% OPERAÇÃO PARA CRIAR DINÂMICAMENTO OS FATOS no/3 E raiz/1
:- dynamic(no/3).
:- dynamic(raiz/1).

% INICA ÁRVORE COM no(nada,nada,nada) E raiz(nada)
:- asserta(no(nada,nada,nada)), asserta(raiz(nada)).

% OPERAÇÕES DE LISTAGEM 
mostraRaiz :- 
    raiz(Raiz), 
    write('Raiz da árvore-> '), writeln(Raiz).

listaNos :- 
    no(Info, Esq, Dir), 
    write('Raiz-> '), write(Info), 
    write(', Esquerda-> '), write(Esq), 
    write(', Direita-> '), write(Dir), nl, fail.

% OPERAÇÕES DE INSERÇÃO
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

% OPERAÇÕES DE REMOÇÃO
apagarArvore :- 
    retractall(no(_,_,_)), 
    retractall(raiz(_)), 
    asserta(no(nada,nada,nada)), 
    asserta(raiz(nada)).
    
apagarNohFolha(Raiz) :- 
    no(Raiz, nada, nada),
    no(Pai, Raiz, Dir),
    retract(no(Raiz, nada, nada)),
    retract(no(Pai,Raiz,Dir)),
    assertz(no(Pai, nada, Dir)), !.
apagarNohFolha(Raiz) :- 
    no(Raiz, nada, nada),
    no(Pai, Esq, Raiz),
    retract(no(Raiz, nada, nada)),
    retract(no(Pai,Esq,Raiz)),
    assertz(no(Pai, Esq, Raiz)), !.
apagarNohFolha(_) :- writeln('No momento só é permitido remover nós que são folhas.').

% OPERAÇÕES DE PERCURSO NA ÁRVORE
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

% MENU PRINCIPAL
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

% EXECUTA AS OPÇÕES
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

% PREDICADOS PARA TESTES
:- raiz(R), inserir(5,R). 
:- raiz(R), inserir(3,R).
:- raiz(R), inserir(7,R).
:- raiz(R), inserir(1,R).
:- raiz(R), inserir(2,R).
:- raiz(R), inserir(6,R).

% EXECUTA O PROGRAMA AO CARREGAR O ARQUIVO
:- executarPrograma.