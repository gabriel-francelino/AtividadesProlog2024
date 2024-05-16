%	DESCRIÇÃO DA ATIVIDADE
%	NOME: GABRIEL FRANCELINO NASCIMENTO
%	RA: 2021.1.08.030
%	
%	Usando os fatos pai e mãe escreva em PROLOG, conforme exemplificado em aula, 
%	no mínimo, três gerações familiares (bisavós, avós, pais e filhos). 
%	Inclua também regras para as relações tio, primo e neto.
%
%	Enviar uma imagem da árvore genealógica representada e o programa no 
%	arquivo familia.pl num arquivo zipado.
%%

%---------------------------------- FAMILIARES
dad(rickard, eddard).
dad(rickard, benjen).
dad(rickard, brandon).
dad(rickard, lyanna).

dad(eddard, bran).
dad(eddard, arya).
dad(eddard, robb).
dad(eddard, sansa).

dad(rhaegar, jon).

dad(jon, tyrion).

mom(lyarra, eddard).
mom(lyarra, benjen).
mom(lyarra, brandon).
mom(lyarra, lyanna).

mom(catelyn, bran).
mom(catelyn, arya).
mom(catelyn, robb).
mom(catelyn, sansa).

mom(lyanna, jon).

mom(daenerys, tyrion).

%--------------------------------- REGRAS DE PARENTESCO
child(CHILD, X) :- dad(X, CHILD); mom(X, CHILD).

parents(PARENTS, X) :- dad(PARENTS, X); mom(PARENTS, X).

brother_or_sister(X, Y) :- 
    dad(DAD, X), dad(DAD, Y),
    mom(MOM, X), mom(MOM, Y),
    X \== Y.

grandparents(GRANDPARENT, X) :- 
    dad(DAD, X), dad(GRANDPARENT, DAD);
    dad(DAD, X), mom(GRANDPARENT, DAD);
    mom(MOM, X), mom(GRANDPARENT, MOM);
    mom(MOM, X), dad(GRANDPARENT, MOM).

great_grandparents(G_GRANDPARENT, X) :-
    child(Y, G_GRANDPARENT), grandparents(Y, X).

grandchild(GRANDCHILD, GRANDPARENT) :- 
    child(Y, GRANDPARENT), child(GRANDCHILD,Y).

uncles(UNCLE_OR_AUNT, X) :- 
    parents(Y, X), brother_or_sister(Y, UNCLE_OR_AUNT).

cousins(COUSIN, X) :-
    parents(PARENTS, COUSIN), uncles(PARENTS, X),+++ !.
    
%
% cousins(COUSIN, X) :-
%    dad(DAD, COUSIN), mom(MOM, X), brother_or_sister(DAD, MOM);
%    dad(DAD1, COUSIN), dad(DAD2, X), brother_or_sister(DAD1, DAD2);
%    mom(MOM1, COUSIN), mom(MOM2, X), brother_or_sister(MOM1, MOM2).
%







