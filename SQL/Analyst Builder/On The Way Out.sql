-- Herschel's Manufacturing Plant has hit some hard times with the economy and unfortunately they need to let some people go.
-- They figure the younger employees need their jobs more as they are growing families so they decide to let go of their 3 oldest employees. They have more experience and will be able to land on their feet easier (and they had to pay them more).
-- Write a query to identify the ids of the three oldest employees.
-- Order output from oldest to youngest.

-- MySQL
with cte as (
  SELECT *,
  Rank() over(order by now() - birth_date desc) as rnk
FROM employees
)
select employee_id
from cte 
where rnk in (1,2,3);

-- PostgreSQL
with cte as (
  SELECT *,
  Rank() over(order by now() - birth_date desc) as rnk
FROM employees
)
select employee_id
from cte 
where rnk in (1,2,3);

-- MSSQL
select Top 3 employee_id
from employees
order by birth_date asc
