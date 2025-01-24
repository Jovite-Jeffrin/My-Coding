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
