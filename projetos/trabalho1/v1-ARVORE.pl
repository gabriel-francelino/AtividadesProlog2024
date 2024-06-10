%Trablho1 -  implementar arvore binaria em prolog
% Usando base de fatos dinˆamica e as estrutura de sele¸c˜ao e repeti¸c˜ao
% apresentadas anteriormente, desenvolva um programa prolog para
% inserir fatos que representam os n´os da ´arvore (no(Info,Esq,Dir))
% (conforme o primeiro exemplo de ´arvore bin´aria). O programa dever´a
% ainda ler uma op¸c˜ao (1-inserir, 2-apagar, 3-pre-ordem, 4-em-ordem,
% 5-pos-ordem e 6-fim) e se for necess´ario um valor, para fazer a
% manuten¸c˜ao de uma ´arvore bin´aria de busca.

:- dynamic(no/3).

inserir(Info, Esq, Dir) :- assert(no(Info, Esq, Dir)).

% listaNos :- 
%     no(Info, Esq, Dir), 
%     write('Raiz: '), write(Info), 
%     write(', Esquerda: '), write(Esq), 
%     write(', Direita: '), write(Dir), nl, fail.

apagar(Info) :- retract(no(Info, _, _)).

preOrdem([]) :- !.
preOrdem(Info) :- 
    write(Info), write(', '), 
    no(Info,Esq,Dir), 
    preOrdem(Esq), preOrdem(Dir).

emOrdem([]) :- !.
emOrdem(Info) :- 
    no(Info,Esq,Dir), 
    emOrdem(Esq), 
    write(Info), write(' '), 
    emOrdem(Dir).

posOrdem([]) :- !.
posOrdem(Info) :- 
    no(Info,Esq,Dir), 
    posOrdem(Esq), posOrdem(Dir), 
    write(Info), write(' ').

escreveOpcoes :- 
    writeln('======== Opções ========'),
    writeln('1 - Inserir'), 
    writeln('2 - Apagar'), 
    writeln('3 - Pre-ordem'), 
    writeln('4 - Em-ordem'), 
    writeln('5 - Pos-ordem'), 
    writeln('6 - Fim'), 
    writeln('========================').

executarAcao(Acao) :- 
    (Acao == 1 -> 
        writeln('Digite o valor do nó raiz: '), 
        read(Info), 
        writeln('Digite o valor do nó esquerdo: '), 
        read(Esq), 
        writeln('Digite o valor do nó direito: '), 
        read(Dir), 
        inserir(Info, Esq, Dir)
    ; Acao == 2 -> 
        writeln('Digite o valor do nó raiz: '), 
        read(Info), 
        apagar(Info)
    ; Acao == 3 -> 
        writeln('Digite o valor do nó raiz: '), 
        read(Info),
        writeln('Pre-ordem: '), 
        preOrdem(Info), 
        nl
    ; Acao == 4 ->
        writeln('Digite o valor do nó raiz: '),
        read(Info), 
        writeln('Em-ordem: '), 
        emOrdem(Info), 
        nl
    ; Acao == 5 -> 
        writeln('Digite o valor do nó raiz: '),
        read(Info),
        writeln('Pos-ordem: '), 
        posOrdem(Info), 
        nl
    ).

executarPrograma :- 
    repeat,
    escreveOpcoes,
    read(Opcao),
    (Opcao == 6 -> ! ; (executarAcao(Opcao), fail)).

:- executarPrograma.