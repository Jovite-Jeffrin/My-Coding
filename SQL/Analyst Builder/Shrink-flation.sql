-- Write a query to identify products that have undergone shrink-flation over the last year. Shrink-flation is defined as a reduction in product size while maintaining or increasing the price.
-- Include a flag for Shrinkflation. This should be a boolean value (True or False) indicating whether the product has undergone shrink-flation
-- The output should have the columns Product_Name, Size_Change_Percentage, Price_Change_Percentage, and Shrinkflation_Flag.
-- Round percentages to the nearest whole number and order the output on the product names alphabetically.

-- MySQL
SELECT 
  product_name, 
  round(((new_size - original_size)/original_size)*100,2) as size_percentage,
  round(((new_price - original_price)/original_price)*100,2) as price_change,
  CASE
    when new_size < original_size or new_price > original_price then 'True'
    else 'False'
  END as shrinkflation_flag
FROM products 
order by 1;

-- PostgreSQL
SELECT 
  product_name, 
  round(((new_size::NUMERIC - original_size::NUMERIC)/original_size::NUMERIC)*100,2) as size_percentage,
  round(((new_price::NUMERIC - original_price::NUMERIC)/original_price::NUMERIC)*100,2) as price_change,
  CASE
    when new_size < original_size or new_price > original_price then 'True'
    else 'False'
  END as shrinkflation_flag
FROM products 
order by 1;

-- MSSQL
SELECT 
  product_name, 
  round(((new_size - original_size)/original_size)*100,2) as size_percentage,
  round(((new_price - original_price)/original_price)*100,2) as price_change,
  CASE
    when new_size < original_size or new_price > original_price then 'True'
    else 'False'
  END as shrinkflation_flag
FROM products 
order by 1;
