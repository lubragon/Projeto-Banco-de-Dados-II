/* 
	Questão 1:
	Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
	da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).
 */

SELECT 
	o.fname    	AS nome,
        o.lname     	AS sobrenome,
        b.name 		AS negocio,
        c.city 		AS cidade
FROM business b
INNER JOIN officer o ON (o.cust_id = b.cust_id)
INNER JOIN customer c ON (c.cust_id = b.cust_id);

/* 
	Questão 2:
	Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome
	das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento.
*/

SELECT 
	CONCAT(e.fname, ' ', e.lname) 	AS Name,
	COUNT(t.txn_id) 				AS qtTrans
FROM account a
RIGHT OUTER JOIN employee e ON(e.emp_id = a.open_emp_id)
LEFT JOIN transaction t ON(a.account_id = t.account_id)
GROUP BY Name
ORDER BY Name ASC, t.txn_date;




/*
	Questão 3:
	Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso, os números de
	transações por ano envolvendo as contas que eles abriram (usando open_emp_id). Ordene os resultados
	por ordem alfabética, e depois por ano (do mais antigo para o mais recente)

*/

SELECT DISTINCT
	CONCAT(e.fname, ' ', e.lname) 	AS Name,
	COUNT(a.open_date) 		AS qtTrans
FROM employee e
LEFT OUTER JOIN account a ON (e.emp_id = a.open_emp_id)
GROUP BY Name
ORDER BY Name ASC;



SELECT DISTINCT
	CONCAT(e.fname, ' ', e.lname) 	AS Name,
	COUNT(t.txn_date) 		AS qtTrans
FROM account a
RIGHT OUTER JOIN employee e ON(e.emp_id = a.open_emp_id)
INNER JOIN transaction t ON(a.account_id = t.account_id)
GROUP BY Name;




/*
	Questão 4:
	Escreva uma consulta que retorne os identificadores de contas com maior saldo de dinheiro por agência,
	juntamente com os nomes dos titulares (nome da empresa ou nome e sobrenome da pessoa física) e os
	nomes dessas agências.

*/
/*
	Questão 5:
	Escreva de novo as consultas 2. e 4. utilizando uma visualização (CREATE VIEW).
*/
