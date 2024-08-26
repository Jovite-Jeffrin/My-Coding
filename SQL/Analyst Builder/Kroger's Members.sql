-- Kroger's is a very popular grocery chain in the US. They offer a membership card in exchange for a discount on select items. Customers can still shop at Krogers without the card.
-- Write a query to find the percentage of customers who shop at Kroger's who also have a Kroger's membership card. Round to 2 decimal places.

-- MySQL
SELECT 
  round(((select count(*) from customers where has_member_card = 'Y')/(select count(*) from customers)*100),2) as percent;

-- PostgreSQL
SELECT 
    ROUND(COUNT(CASE WHEN "has_member_card" = 'Y' THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct
FROM customers
WHERE "kroger_id" IS NOT NULL;

-- MSSQL
SELECT 
  ROUND(CAST((SELECT COUNT(*) FROM customers WHERE has_member_card = 'Y') AS FLOAT) 
        / CAST((SELECT COUNT(*) FROM customers) AS FLOAT) * 100, 2) AS percent;
