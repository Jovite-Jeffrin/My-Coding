### User's Third Transaction
Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

```sql
WITH cte AS(
SELECT 
  user_id, spend, transaction_date,
  ROW_NUMBER() OVER(PARTITION BY user_id order by transaction_date) as rn
FROM transactions)

SELECT 
  user_id, spend, transaction_date
FROM cte 
WHERE rn = 3;
```

### Second Highest Salary
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

```sql
SELECT 
  sq.salary
FROM 
(SELECT 
  salary,
  ROW_NUMBER() OVER(ORDER BY salary DESC) as rn
FROM employee) as sq
WHERE sq.rn = 2;
```
