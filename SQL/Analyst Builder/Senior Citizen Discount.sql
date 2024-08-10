-- If a customer is 55 or above they qualify for the senior citizen discount. Check which customers qualify.
-- Assume the current date 1/1/2023.
-- Return all of the Customer IDs who qualify for the senior citizen discount in ascending order.

-- PostgreSQL
SELECT customer_id 
FROM customers
where ((EXTRACT(year from '01-01-2023'::DATE)) - (EXTRACT(YEAR from birth_date))) > 55
order by 1;

-- MySQL
SELECT customer_id 
FROM customers
where ((EXTRACT(year from '2023-01-01')) - (EXTRACT(YEAR from birth_date))) > 55
order by 1;

-- MSSQL
SELECT customer_id 
FROM customers
where (year('2023-01-01') - (YEAR(birth_date))) > 55
order by 1;
