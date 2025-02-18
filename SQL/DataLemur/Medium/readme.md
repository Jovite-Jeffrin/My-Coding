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

### Signup Activation Rate
New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

A senior analyst is interested to know the activation rate of specified users in the emails table. Write a query to find the activation rate. Round the percentage to 2 decimal places.

Definitions:
* emails table contain the information of user signup details.
* texts table contains the users' activation information.
Assumptions:
* The analyst is interested in the activation rate of specific users in the emails table, which may not include all users that could potentially be found in the texts table. For example, user 123 in the emails table may not be in the texts table and vice versa.

```sql
SELECT
  round(count(t.email_id)::DECIMAL/count(e.email_id),2)
FROM emails e 
LEFT JOIN texts t ON e.email_id = t.email_id
AND t.signup_action = 'Confirmed'
```

### Top 5 Artists
Assume there are three Spotify tables: artists, songs, and global_song_rank, which contain information about the artists, songs, and music charts, respectively.

Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. Display the top 5 artist names in ascending order, along with their song appearance ranking.

If two or more artists have the same number of song appearances, they should be assigned the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).

```sql
WITH cte AS(
  SELECT
    a.artist_name,
    dense_rank() OVER(ORDER BY count(s.song_id) DESC) as rnk
  FROM artists a 
  JOIN songs s ON a.artist_id = s.artist_id
  JOIN global_song_rank g ON s.song_id = g.song_id
  WHERE g.rank <= 10
  GROUP BY 1)

SELECT 
  artist_name,rnk
FROM cte 
WHERE rnk <= 5;
```

### Supercloud Customer
A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table. Write a query that identifies the customer IDs of these Supercloud customers.

```sql
SELECT
  cc.customer_id
FROM customer_contracts cc 
JOIN products p ON cc.product_id = p.product_id
GROUP BY 1
HAVING count(DISTINCT p.product_category) = (SELECT count(DISTINCT product_category) FROM products)
```

### Odd and Even Measurements
Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.
Definition:
* Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.

```sql
WITH cte AS(
SELECT 
  *,
  row_number() OVER(PARTITION BY measurement_time::DATE ORDER BY measurement_time) as rnk
FROM measurements)

SELECT
  measurement_time::DATE,
  sum(CASE WHEN rnk%2 <> 0 THEN measurement_value ELSE 0 END) as odd_sum,
  sum(CASE WHEN rnk%2 = 0 THEN measurement_value ELSE 0 END) as even_sum
FROM cte
GROUP BY 1
ORDER BY 1;
```

### Swapped Food Delivery
Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data. In the results, return the correct pairs of order IDs and items.

```sql
WITH cte AS(
SELECT
  count(*) as total_orders
FROM orders),
correct_orders AS(
SELECT
  order_id, item,
  CASE 
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id 
    ELSE order_id - 1
  END as correct_orders
FROM orders 
CROSS JOIN cte )

SELECT 
  correct_orders, item
FROM correct_orders
ORDER BY 1;
```

### User Shopping Sprees
In an effort to identify high-value customers, Amazon asked for your help to obtain data about users who go on shopping sprees. A shopping spree occurs when a user makes purchases on 3 or more consecutive days. List the user IDs who have gone on at least 1 shopping spree in ascending order.
> By using LEAD funtion and setting the value to 2 results in getting the third date if available. Thus the absence of such value means we didn't meet the '3 day spree' requirement. But the presence of a value means we did for that user. we then select user_id which met the criteria of having at least one entry in the lead column.

```sql
SELECT
  sq.user_id
FROM
(SELECT
  *,
  lead(transaction_date,2) OVER(PARTITION BY user_id ORDER BY user_id, transaction_date) as ld 
FROM transactions) as sq 
GROUP BY sq.user_id
HAVING count(ld) >= 1;
```

### Histogram of Users and Purchases
Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, write a query that retrieve the users along with the number of products they bought.
Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

```sql
WITH cte AS(
SELECT 
  transaction_date, user_id, product_id,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as rn 
FROM user_transactions)

SELECT
  transaction_date, user_id, count(product_id)
FROM cte 
WHERE rn = 1
GROUP BY 1,2
ORDER BY 1;
```

### FAANG Stock Min-Max (Part 1)
The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

```sql
WITH cte AS(
  SELECT
    ticker, TO_CHAR(date, 'Mon-YYYY') as date, open
  FROM stock_prices)
  
SELECT 
  DISTINCT ticker, 
  FIRST_VALUE(date) OVER(PARTITION BY ticker ORDER BY open desc) as high_mnth,
  FIRST_VALUE(open) OVER(PARTITION BY ticker ORDER BY open desc) as high_open,
  FIRST_VALUE(date) OVER(PARTITION BY ticker ORDER BY open) as low_mnth,
  FIRST_VALUE(open) OVER(PARTITION BY ticker ORDER BY open) as low_open
FROM cte
ORDER BY 1
```
