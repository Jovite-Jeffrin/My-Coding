### Swapped Food Delivery
[Click here for the problem](https://datalemur.com/questions/sql-swapped-food-delivery)

Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data. In the results, return the correct pairs of order IDs and items.

##### Step 01
Finding the total orders 

```sql
SELECT
  count(*) as total_orders
FROM orders
```

##### Step 02
Using Cross Join to match the total_orders with items

```sql
WITH cte AS(
  SELECT
    count(*) as total_orders
  FROM orders)

SELECT
  *
FROM orders 
CROSS JOIN cte
```
![image](https://github.com/user-attachments/assets/fc2a0962-b3f3-4e16-8dc3-4f186593a319)

##### Step 03
Using CASE statement, finding and swapping the correct order_id

```sql
WITH cte AS(
SELECT
  count(*) as total_orders
FROM orders)

SELECT
    order_id, item,
  CASE 
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id 
    ELSE order_id - 1
  END as correct_orders
FROM orders 
CROSS JOIN cte
```
![image](https://github.com/user-attachments/assets/780d3c81-95f0-4637-b923-919a423ec071)

##### Step 04
Keeping the values in the cte then printng the  values

```sql
WITH cte AS(
SELECT
  count(*) as total_orders
FROM orders),
correct_orders AS(
SELECT
  order_id, item,
  CASE 
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id 
    ELSE order_id - 1
  END as correct_orders
FROM orders 
CROSS JOIN cte )

SELECT 
  correct_orders, item
FROM correct_orders
ORDER BY 1;
```
![image](https://github.com/user-attachments/assets/02c527be-b7bb-44b8-86ed-146dfd734bb1)
