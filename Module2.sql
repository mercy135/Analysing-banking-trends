/* Task 1  Write an SQL query to solve the given problem statement.
 List all regions along with the number of users assigned to each region.*/

SELECT b.region_name as RegionName, COUNT(DISTINCT(a.consumer_id)) as NumUsers
FROM `user_nodes`a
RIGHT JOIN world_regions b ON a.region_id = b.region_id 
GROUP BY b.region_name
ORDER BY b.region_name;



/* Task 2 Write an SQL query to solve the given problem statement.
Find the user who made the largest deposit amount and the transaction type for that deposit.*/

SELECT consumer_id, transaction_type, transaction_amount AS largest_deposit 
FROM user_transaction 
WHERE transaction_amount = (SELECT MAX (transaction_amount) 
FROM user_transaction);


/* Task 3 Write an SQL query to solve the given problem statement.
Calculate the total amount deposited for each user in the "Europe" region.*/

SELECT a.consumer_id, SUM(a.transaction_amount) TotalDeposited 
FROM user_transaction a 
INNER JOIN user_nodes b ON a.consumer_id=b.consumer_id 
INNER JOIN world_regions c ON b.region_id = c.region_id 
WHERE c.region_name = 'Europe' and a.transaction_type='deposit'
GROUP BY a.consumer_id, c.region_name;


/* Task 4 Write an SQL query to solve the given problem statement.
Calculate the total number of transactions made by each user in the "United States" region*/

SELECT a.consumer_id, Count(a.consumer_id) Totaltransactions 
FROM user_transaction a 
INNER JOIN user_nodes b ON a.consumer_id=b.consumer_id 
INNER JOIN world_regions c ON b.region_id = c.region_id 
WHERE c.region_name = 'United States' 
GROUP BY a.consumer_id;


/* Task 5 Write an SQL query to solve the given problem statement
Calculate the total number of users who made more than 5 transactions*/

SELECT consumer_id AS user_id, COUNT(*) AS num_transactions
FROM user_transaction
GROUP BY consumer_id
HAVING
COUNT(*) > 5;



/* Task 6 Write an SQL query to solve the given problem statement.
Find the user who made the largest deposit amount in the "Australia" region*/

WITH 
AustraliaDeposits 
AS 
(SELECT un.consumer_id, un.region_id, ut.transaction_amount 
FROM user_nodes un 
JOIN world_regions wr ON un.region_id = wr.region_id 
JOIN user_transaction ut ON un.consumer_id = ut.consumer_id 
WHERE wr.region_name = "Australia" AND ut.transaction_type = "deposit") 
SELECT DISTINCT(ad.consumer_id), ad.transaction_amount as largest_deposit 
FROM AustraliaDeposits ad 
WHERE ad.transaction_amount IN (SELECT MAX(ad.transaction_amount) FROM AustraliaDeposits ad);

  
/* Task 7 Write an SQL query to solve the given problem statement.
Calculate the total amount deposited by each user in each region*/

SELECT a.consumer_id,c.region_name, SUM(a.transaction_amount) TotalDeposited 
FROM user_transaction a 
INNER JOIN user_nodes b ON a.consumer_id=b.consumer_id 
INNER JOIN world_regions c ON b.region_id = c.region_id 
WHERE a.transaction_type='deposit'
GROUP BY a.consumer_id, c.region_name;

  
/* Task 8 Write an SQL query to solve the given problem statement.
Retrieve the total number of transactions for each region*/

SELECT c.region_name, COUNT(*) AS total_transactions
FROM user_nodes a
JOIN
user_transaction b
ON a.consumer_id = b.consumer_id
JOIN 
world_regions c
ON c.region_id = a.region_id
GROUP BY c.region_name;

/* Task 9 Write an SQL query to solve the given problem statement.
Write a query to find the total deposit amount for each region (region_name) in the user_transaction table. 
Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table*/
  
SELECT c.region_name, SUM(a.transaction_amount) TotalDeposited 
FROM user_transaction a 
INNER JOIN user_nodes b ON a.consumer_id=b.consumer_id 
INNER JOIN world_regions c ON b.region_id = c.region_id 
WHERE a.transaction_type='deposit'
GROUP BY  c.region_name;


/* Task 10 Write an SQL query to solve the given problem statement.
Write a query to find the top 5 consumers who have made the highest total transaction amount (sum of all their deposit transactions) in the user_transaction table.*/

SELECT consumer_id, SUM(transaction_amount) AS total_transaction_amount 
FROM user_transaction 
WHERE transaction_type = "Deposit" 
GROUP BY consumer_id
ORDER BY total_transaction_amount DESC
LIMIT 5;

/* Task 11 Write an SQL query to solve the given problem statement.
How many consumers are allocated to each region? */
SELECT a.region_id, b.region_name,
    COUNT(DISTINCT a.consumer_id) AS num_of_consumers
FROM user_nodes a
JOIN world_regions b
ON a.region_id = b.region_id
GROUP BY a.region_id, b.region_name;


/* Task 12 Write an SQL query to solve the given problem statement.
What is the unique count and total amount for each transaction type? */
  
SELECT transaction_type, COUNT(DISTINCT(consumer_id)) Numtrans, SUM(transaction_amount) TotalAmount 
FROM user_transaction
GROUP BY transaction_type;

/* Task 13 Write an SQL query to solve the given problem statement.
What are the average deposit counts and amounts for each transaction type ('deposit') across all customers, grouped by transaction type?*/
  
WITH cte_deposit AS (
	SELECT 
		transaction_type,
		COUNT(transaction_type) AS deposit_count,
		SUM(transaction_amount) AS deposit_amount
	FROM user_transaction
	WHERE transaction_type = 'deposit'
	GROUP BY consumer_id;
)
SELECT 
	transaction_type,
    ROUND(AVG(deposit_count),0) AS avg_deposit_count,
	ROUND(AVG(deposit_amount),0) AS avg_deposit_amount
FROM cte_deposit;
