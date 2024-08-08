-- Write a query that returns all of the stores whose average yearly revenue is greater than one million dollars.
-- Output the store ID and average revenue. Round the average to 2 decimal places.
-- Order by store ID.

-- MySQL
SELECT store_id, round(avg(revenue),2) as revenue
FROM stores
GROUP by store_id
having avg(revenue) > 1000000;

-- PostgreSQL
SELECT store_id, round(avg(revenue),2) as revenue
FROM stores
GROUP by store_id
having avg(revenue) > 1000000
order by 1;

-- MSSQL
SELECT store_id, round(avg(CAST(revenue as DECIMAL(10,2))),2) as revenue
FROM stores
GROUP by store_id
having avg(revenue) > 1000000
order by 1;
