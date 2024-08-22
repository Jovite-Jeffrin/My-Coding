-- Social Media Addiction can be a crippling disease affecting millions every year.
-- We need to identify people who may fall into that category.
-- Write a query to find the people who spent a higher than average amount of time on social media.
-- Provide just their first names alphabetically so we can reach out to them individually.

-- MySQL
SELECT u.first_name
FROM user_time ut
join users u on ut.user_id = u.user_id
where media_time_minutes > (SELECT AVG(media_time_minutes) from user_time)
order by 1;

-- PostgreSQL
SELECT u.first_name
FROM user_time ut
join users u on ut.user_id = u.user_id
where media_time_minutes > (SELECT AVG(media_time_minutes) from user_time)
order by 1;

-- MSSQL
SELECT u.first_name
FROM user_time ut
join users u on ut.user_id = u.user_id
where media_time_minutes > (SELECT AVG(media_time_minutes) from user_time)
order by 1;
