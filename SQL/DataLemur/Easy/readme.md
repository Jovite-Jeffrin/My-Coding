## Easy SQL practice questions

### Histogram of Tweets
1. Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket. In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

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
2. Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL. Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.
   
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

### 
3. 
   
```sql

```
