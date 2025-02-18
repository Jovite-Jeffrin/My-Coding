## Easy SQL practice questions

### Histogram of Tweets
Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket. In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

```sql
with cte as (
    SELECT user_id as users, count(tweet_id) as tweet_id
    FROM tweets
    where EXTRACT(year from tweet_date) = 2022
    group by 1)
select tweet_id, count(users)
from cte 
group by 1
```

### Data Science Skills
Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL. Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.
   
```sql
select c1.candidate_id
from (
    SELECT candidate_id, count(*) as cnt
    FROM candidates
    where skill in ('Python', 'Tableau', 'PostgreSQL')
    group by 1
    having count(*) = 3) as c1
order by c1.candidate_id
```

### Page With No Likes
Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page"). Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.
   
```sql
SELECT p.page_id
from  pages p 
left join page_likes  pl on p.page_id = pl.page_id
where pl.user_id is NULL
order by 1
```

### Unfinished Parts
Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished. Assumptions:
1. parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
2. An unfinished part is one that lacks a finish_date.

```sql
SELECT part, assembly_step
FROM parts_assembly
where finish_date is NULL;
```

### Laptop vs. Mobile Viewership
Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone. Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

```sql
select 
    (SELECT count(user_id)
    FROM viewership
    where device_type = 'laptop') as laptop_views,
    (SELECT count(user_id)
    FROM viewership
    where device_type IN ('tablet','phone')) as mobile_views
```

### Average Post Hiatus (Part 1)
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

```sql
select user_id, max(post_date::Date) - min(post_date::date) as days
from posts
where EXTRACT(year from post_date) = 2021
GROUP by 1
HAVING count(post_id) > 1
```

### Teams Power Users
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages. Assumption: No two users have sent the same number of messages in August 2022.

```sql
SELECT sender_id, count(message_id) as cnt
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = 8 and EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;
```

### Duplicate Job Listings
Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings. Definition: Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.

```sql
WITH cte AS (
    SELECT company_id, title, description, count(job_id) as cnt 
    FROM job_listings
    GROUP BY company_id, title, description)

SELECT count(company_id) as duplicate
FROM cte
where cnt > 1;
```

### Cities With Completed Trades
Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system. Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.

```sql
SELECT
    u.city, count(t.status) as status
FROM trades t
JOIN users u on t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
```

### Average Review Ratings
Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.

```sql
SELECT 
  EXTRACT(MONTH from submit_date) as month_name,
  product_id,  round(avg(stars),2) as avg_stars
FROM reviews
GROUP BY 1,2
ORDER BY 1,2;
```

### Well Paid Employees
Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees earning more than their direct managers. As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.

```sql
SELECT
    e.employee_id, e.name
FROM employee e
INNER JOIN employee m ON m.employee_id = e.manager_id
where e.salary > m.salary;
```

### App Click-through Rate (CTR)
Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places. Definition and note:
* Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
* To avoid integer division, multiply the CTR by 100.0, not 100.

```sql
WITH cte as (
SELECT 
  app_id,
  sum(CASE
    WHEN event_type = 'impression' THEN 1 ELSE 0 END) AS impression,
  sum(CASE
    WHEN event_type = 'click' THEN 1 ELSE 0 END) AS clicks
FROM events
WHERE EXTRACT(YEAR FROM TIMESTAMP) = 2022
GROUP BY 1)

SELECT 
  app_id, round((clicks::NUMERIC/impression::NUMERIC)*100.00 ,2) as ctr
FROM cte;
```

### Second Day Confirmation
Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account. Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day. Definition:
* action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.

#### Using window function:
```sql
WITH cte as (
SELECT 
  e.user_id, e.email_id, t.signup_action, 
  ROW_NUMBER() OVER(PARTITION BY e.email_id ORDER BY t.action_date) as rn 
FROM texts t 
JOIN emails e on t.email_id = e.email_id)

SELECT 
  user_id
FROM cte 
WHERE rn = 2 and signup_action = 'Confirmed'
```

#### Using date function: 
```sql
SELECT 
  e.user_id
FROM emails e 
JOIN texts t on e.email_id = t.email_id
WHERE t.action_date = e.signup_date + INTERVAL '1 day' AND
t.signup_action = 'Confirmed';
```

### Cards Issued Difference
Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity.

```sql
SELECT
  card_name, max(issued_amount) - min(issued_amount) as cnt
FROM monthly_cards_issued
GROUP BY 1
ORDER BY 2 DESC;
```

### Compressed Mean
You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).

```sql
SELECT 
  round(sum(item_count::DECIMAL * order_occurrences) / (sum(order_occurrences)),1) as mean
FROM items_per_order;
```

### Pharmacy Analytics (Part 1)
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

```sql
SELECT
  drug, sum(total_sales - cogs) as profit
FROM pharmacy_sales
GROUP BY 1
ORDER  BY 2 DESC
LIMIT 3;
```

### Pharmacy Analytics (Part 2)
CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively manufactured by a single manufacturer. Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with the highest losses displayed at the top.

```sql
SELECT
  manufacturer, count(drug) as cnt, abs(sum(cogs - total_sales)) as profit
FROM pharmacy_sales
WHERE cogs >  total_sales
GROUP BY 1
ORDER  BY 3 DESC;
```

### Pharmacy Analytics (Part 3)
CVS Health wants to gain a clearer understanding of its pharmacy sales and the performance of various products.

Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and report your results in descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million".

```sql
SELECT
  manufacturer, concat('$',round(sum(total_sales)/1000000),' million') as sale
FROM pharmacy_sales
GROUP BY 1
ORDER BY sum(total_sales) DESC, manufacturer;
```

### Patient Support Analysis (Part 1)
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.

```sql
SELECT count(sq.p_holder) as cnt
FROM (
SELECT 
  policy_holder_id as p_holder, count(case_id) as calls
FROM callers
GROUP BY 1
HAVING count(case_id) >= 3) as sq ;
```

### Patient Support Analysis (Part 2)
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

Calls to the Advocate4Me call centre are classified into various categories, but some calls cannot be neatly categorised. These uncategorised calls are labeled as “n/a”, or are left empty when the support agent does not enter anything into the call category field.

Write a query to calculate the percentage of calls that cannot be categorised. Round your answer to 1 decimal place. For example, 45.0, 48.5, 57.7.

```sql
SELECT
  round(100.0 * sum(CASE WHEN call_category = 'n/a' or call_category IS NULL THEN 1 ELSE 0 END)/count(*),1)
FROM callers
```

### Compressed Mode
You're given a table containing the item count for each order on Alibaba, along with the frequency of orders that have the same item count. Write a query to retrieve the mode of the order occurrences. Additionally, if there are multiple item counts with the same mode, the results should be sorted in ascending order.
Clarifications:
* item_count: Represents the number of items sold in each order.
* order_occurrences: Represents the frequency of orders with the corresponding number of items sold per order.
* For example, if there are 800 orders with 3 items sold in each order, the record would have an item_count of 3 and an order_occurrences of 800.

```sql
SELECT 
  item_count
FROM items_per_order
WHERE order_occurrences = (SELECT max(order_occurrences) FROM items_per_order)
ORDER BY 1;
```

### Card Launch Success
Your team at JPMorgan Chase is soon launching a new credit card. You are asked to estimate how many cards you'll issue in the first month. Before you can answer this question, you want to first get some perspective on how well new credit card launches typically do in their first month.

Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. The launch month is the earliest record in the monthly_cards_issued table for a given card. Order the results starting from the biggest issued amount.

```sql
SELECT
  sq.card_name, sq.issued_amount
FROM (SELECT 
  *,
  ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) as rn
FROM monthly_cards_issued) as sq 
WHERE sq.rn = 1
ORDER BY 2 DESC;
```
