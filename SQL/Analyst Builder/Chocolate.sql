-- I love chocolate and only want delicious baked goods that have chocolate in them!
-- Write a Query to return bakery items that contain the word "Chocolate".

-- MySQL
SELECT * FROM 
bakery_items
where product_name like '%chocolate%';

-- PostgreSQL
SELECT * FROM 
bakery_items
where product_name like '%Chocolate%';

-- MSSQL
SELECT * FROM 
bakery_items
where product_name like '%chocolate%';
