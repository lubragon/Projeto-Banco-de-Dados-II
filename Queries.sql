/* 
	Questão 1:
	Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
	da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).
 */

SELECT 
	o.fname    			AS nome,
        o.lname     			AS sobrenome,
        b.name 				AS negocio,
        c.city 				AS cidade
FROM business b
INNER JOIN officer o ON (o.cust_id = b.cust_id)
INNER JOIN customer c ON (c.cust_id = b.cust_id);

/* 
	Questão 2:
	Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome
	das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento.
*/

SELECT DISTINCT
	'FIS' 				AS Type,
	CONCAT(i.fname, ' ', i.lname) 	AS Name
FROM customer c
INNER JOIN individual i ON(c.cust_id = i.cust_id)
INNER JOIN account a ON(c.cust_id = a.cust_id)
INNER JOIN branch bra ON(a.open_branch_id = bra.branch_id)
WHERE bra.city != c.city
UNION
SELECT
		'JUR',
        	b.name 
FROM business b
INNER JOIN customer c ON(c.cust_id = b.cust_id )
INNER JOIN account a ON(c.cust_id = a.cust_id)
INNER JOIN branch bra ON(a.open_branch_id = bra.branch_id)
WHERE bra.city != c.city;




/*
	Questão 3:
	Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso, os números de
	transações por ano envolvendo as contas que eles abriram (usando open_emp_id). Ordene os resultados
	por ordem alfabética, e depois por ano (do mais antigo para o mais recente)
*/

SELECT 	
	CONCAT(e.fname, ' ', e.lname) 		AS Nome,
	COUNT(t.txn_id) 			AS qtTrans,
	COALESCE(YEAR(t.txn_date))	 	AS Ano
FROM employee e
LEFT JOIN account a ON(e.emp_id = a.open_emp_id)
LEFT JOIN transaction t ON(a.account_id = t.account_id)
GROUP BY Nome, Ano
ORDER BY Nome ASC, Ano DESC;


/*
	Questão 4:
	Escreva uma consulta que retorne os identificadores de contas com maior saldo de dinheiro por agência,
	juntamente com os nomes dos titulares (nome da empresa ou nome e sobrenome da pessoa física) e os
	nomes dessas agências.
*/
SELECT
	'FIS'                    	AS Type,
	account_id 	        	AS ID,
	CONCAT(fname,' ', lname) 	AS Name,
	bra.name 	       	 	AS BranchName,		
	a.avail_balance 	 	AS Balance                   
FROM account a	 
INNER JOIN individual USING (cust_id)
INNER JOIN branch bra ON (open_branch_id = branch_id)
INNER JOIN (
		SELECT 
		  	branch_id	     AS branchId,
             	  	MAX(avail_balance)   AS maxBalance
		FROM account
		INNER JOIN branch b ON (open_branch_id = branch_id)
		GROUP BY open_branch_id
	   ) maxAvail ON a.open_branch_id = branchId AND a.avail_balance = maxBalance
UNION
SELECT
	'JUR'			, 
	account_id		, 	       		
	bu.name			, 			
	bra.name		, 	       		 		
	a.avail_balance 	 	                  
FROM account a	 
INNER JOIN business bu ON (a.cust_id = bu.cust_id)
INNER JOIN branch bra  ON (open_branch_id = branch_id)
INNER JOIN (
		SELECT 
		  	branch_id	     AS branchId,
             	  	MAX(avail_balance)   AS maxBalance
		FROM account
		INNER JOIN branch b ON (open_branch_id = branch_id)
		GROUP BY open_branch_id
	   ) maxAvail ON a.open_branch_id = branchId AND a.avail_balance = maxBalance;
/*
	Questão 5:
	Escreva de novo as consultas 2. e 4. utilizando uma visualização (CREATE VIEW).
*/

// 2
CREATE VIEW ClientType 	AS
SELECT DISTINCT
		'FIS' 				AS Type,
		CONCAT(i.fname, ' ', i.lname) 	AS Name
FROM customer c
INNER JOIN individual i ON(c.cust_id = i.cust_id)
INNER JOIN account a ON(c.cust_id = a.cust_id)
INNER JOIN branch bra ON(a.open_branch_id = bra.branch_id)
WHERE bra.city != c.city
UNION
SELECT
		'JUR',
        	b.name 
FROM business b
INNER JOIN customer c ON(c.cust_id = b.cust_id )
INNER JOIN account a ON(c.cust_id = a.cust_id)
INNER JOIN branch bra ON(a.open_branch_id = bra.branch_id)
WHERE bra.city != c.city;



//4
CREATE VIEW maxAvail AS
SELECT
	'FIS'                    AS Type,
	account_id 	         AS ID,
	CONCAT(fname,' ', lname) AS Name,
	bra.name 	       	 AS BranchName,		
	a.avail_balance 	 AS Balance                   
FROM account a	 
INNER JOIN individual USING (cust_id)
INNER JOIN branch bra ON (open_branch_id = branch_id)
INNER JOIN (
		SELECT 
		  	branch_id	     AS branchId,
             	  	MAX(avail_balance)   AS maxBalance
		FROM account
		INNER JOIN branch b ON (open_branch_id = branch_id)
		GROUP BY open_branch_id
	   ) maxAvail ON a.open_branch_id = branchId AND a.avail_balance = maxBalance
UNION
SELECT
	'JUR'			, 
	account_id		, 	       		
	bu.name			, 			
	bra.name		, 	       		 		
	a.avail_balance 	 	                  
FROM account a	 
INNER JOIN business bu ON (a.cust_id = bu.cust_id)
INNER JOIN branch bra  ON (open_branch_id = branch_id)
INNER JOIN (
		SELECT 
		  	branch_id	     AS branchId,
             	  	MAX(avail_balance)   AS maxBalance
		FROM account
		INNER JOIN branch b ON (open_branch_id = branch_id)
		GROUP BY open_branch_id
	   ) maxAvail ON a.open_branch_id = branchId AND a.avail_balance = maxBalance;
