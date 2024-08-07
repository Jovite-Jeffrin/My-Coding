-- Tesla just provided their quarterly sales for their major vehicles.
-- Determine which Tesla Model has made the most profit.
-- Include all columns with the "profit" column at the end.

-- MySQL
SELECT *, 
  ((car_price - production_cost)*cars_sold) as profit
FROM tesla_models
order by ((car_price - production_cost)*cars_sold) desc
limit 1;

-- PostgreSQL
SELECT *, 
  ((car_price - production_cost)*cars_sold) as profit
FROM tesla_models
order by ((car_price - production_cost)*cars_sold) desc
limit 1;

--MSSQL
SELECT TOP 1 *,
       (CAST([car_price] AS BIGINT) - CAST([production_cost] AS BIGINT)) * CAST([cars_sold] AS BIGINT) AS [profit]
FROM [tesla_models]
ORDER BY [profit] DESC;
