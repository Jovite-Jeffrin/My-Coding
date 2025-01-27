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
Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places. Notes:
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
