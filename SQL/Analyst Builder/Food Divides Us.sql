-- In the United States, fast food is the cornerstone of it's very society. Without it, it would cease to exist.
-- But which region spends the most money on fast food?
-- Write a query to determine which region spends the most amount of money on fast food.

-- MySQL
SELECT region 
FROM food_regions 
group by region
order by sum(fast_food_millions) DESC
limit 1;

-- PostgreSQL
SELECT region 
FROM food_regions 
group by region
order by sum(fast_food_millions) DESC
limit 1;

-- MSSQL
SELECT Top 1 region 
FROM food_regions 
group by region
order by sum(fast_food_millions) DESC;
