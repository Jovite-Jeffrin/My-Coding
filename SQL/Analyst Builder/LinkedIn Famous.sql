-- Write a query to determine the popularity of a post on LinkedIn
-- Popularity is defined by number of actions (likes, comments, shares, etc.) divided by the number impressions the post received * 100.
-- If the post receives a score higher than 1 it was very popular.
-- Return all the post IDs and their popularity where the score is 1 or greater.
-- Order popularity from highest to lowest.

-- MySQL
SELECT post_id, (actions/impressions)*100 as popularity
FROM linkedin_posts
where (actions/impressions)*100 > 1
order by 2 desc;

-- PostgreSQL
with cte as (
  SELECT post_id, (actions :: NUMERIC/impressions)*100 as popularity
  FROM linkedin_posts
)
select *
from cte 
where popularity > 1
order by popularity DESC;

-- MSSQL
SELECT post_id, (CAST(actions as DECIMAL)/impressions)*100 as popularity
FROM linkedin_posts
where (CAST(actions as DECIMAL)/impressions)*100 > 1
order by 2 desc;
