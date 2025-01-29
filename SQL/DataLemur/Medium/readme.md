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

### Sending vs. Opening Snaps
Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output. Notes:
##### Calculate the following percentages:
* time spent sending / (Time spent sending + Time spent opening)
* Time spent opening / (Time spent sending + Time spent opening)
* To avoid integer division in percentages, multiply by 100.0 and not 100.

```sql
SELECT
  ab.age_bucket, 
  round((send/(open+send))*100.0,2) as send_perc,
  round((open/(open+send))*100.0,2) as open_perc
FROM age_breakdown ab
JOIN 
(SELECT
  user_id, 
  sum(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) as open,
  sum(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) as send 
FROM activities
GROUP BY 1) as sq ON  ab.user_id = sq.user_id
ORDER BY 1;
```

### Tweets' Rolling Averages
Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places. 
##### Notes:
* A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
* In this case, we want to determine how the tweet count for each user changes over a 3-day period.

```sql
SELECT 
  user_id, tweet_date,
  round(avg(tweet_count) OVER(PARTITION BY user_id ORDER  BY tweet_date
                            ROWS BETWEEN 2 PRECEDING AND CURRENT row),2) as av  
FROM tweets;
```

### Highest-Grossing Items
Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

```sql
SELECT
  sq.category, sq.product, sq.sm 
FROM (
SELECT 
  category, product, sum(spend) as sm,
  ROW_NUMBER() OVER(PARTITION BY category order by sum(spend) desc) as rn
FROM product_spend
WHERE EXTRACT(YEAR from transaction_date) = 2022
GROUP BY 1,2) as sq 
WHERE sq.rn <3
ORDER BY 1, 3 DESC;
```

### Top Three Salaries
As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying high earners in each department. A 'high earner' within a department is defined as an employee with a salary ranking among the top three salaries within that department.

You're tasked with identifying these high earners across all departments. Write a query to display the employee's name along with their department name and salary. In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. If multiple employees have the same salary, then order them alphabetically.

```sql
WITH cte as (
SELECT
  employee_id, name, department_id, salary,
  DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rnk
FROM employee) 

SELECT
  d.department_name, c.name, c.salary
FROM cte c 
JOIN department d on c.department_id = d.department_id
WHERE rnk <= 3
ORDER BY d.department_name ASC, c.salary DESC, c.name ASC;
```

### IBM db2 Product Analytics (Histogram)
IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.

##### Using Right Join
```sql
WITH cte as (
SELECT
  e.employee_id, 
  COALESCE(count(DISTINCT q.query_id),0) as cnt 
FROM queries q 
RIGHT JOIN employees e ON q.employee_id = e.employee_id
AND q.query_starttime >= '2023-07-01T00:00:00Z' AND q.query_starttime  < '2023-10-01T00:00:00Z'
GROUP BY 1)

SELECT
  cnt, count(employee_id) as  cont 
FROM cte 
GROUP BY 1
ORDER BY 1;
```

##### Using Left Join
```sql
WITH cte as(
SELECT
  e.employee_id, COALESCE(count(DISTINCT q.query_id),0) as cnt 
FROM employees e 
LEFT JOIN queries q ON e.employee_id = q.employee_id
AND q.query_starttime >= '2023-07-01T00:00:00Z' AND q.query_starttime  < '2023-10-01T00:00:00Z'
GROUP BY 1)

SELECT 
  cnt, count(employee_id)
FROM cte 
GROUP BY 1
ORDER BY 1;
```
