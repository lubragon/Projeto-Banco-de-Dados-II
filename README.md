# Projeto-Banco-de-Dados-II
O arquivo contém as Querys necessárias para concluir as atividades propostas no primeiro semestre da disciplina Design e Desenvolvimento de Banco de Dados 2.
Durante o semestre e no trabalho em questão, utilizamos o banco de dados "bank" fornecido pelo professor.
A primeira questão pedia para projetar informações de diferentes tabelas e foi solocuinada apenas utilizando joins.
Para resolver a segunda questão, além das joins foi necessário também utilizar o Union para conseguirmos apresentar tanto as informações dos indivíduos como dos negócios.
A terceira questão pedia para retornar o nome de todos os funcionários e a quantidade de transações envolvendo contas que eles abriram. 
	Para resolver a questão utilizei Count e Coalesce, além de algumas joins, finalizando pelo agrupamento e ordenamento.
A quarta questão foi a mais difícil. Pedia para retornar ID, nome do titular(físico ou jurídico) e o nome da agência apenas da conta com o maior saldo disponível
	Para resolver a questão, além de joins e union, foi preciso utilizar uma join em uma subconsulta que retornava apenas a conta com o maior saldo ( MAX(avail_balance) ).
A quinta questão pedia para refazer as questões 2 e 4 utilizando visualizações.



Lucas Brangança Gonçalves
