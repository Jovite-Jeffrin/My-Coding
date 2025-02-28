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
![image](https://github.com/user-attachments/assets/839ca475-2b40-460d-869f-d8217097bcbc)

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

---

### FAANG Stock Min-Max (Part 1)
[Click here for the problem](https://datalemur.com/questions/sql-bloomberg-stock-min-max-1)

The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

```sql
WITH cte AS(
  SELECT
    ticker, TO_CHAR(date, 'Mon-YYYY') as date, open
  FROM stock_prices)
  
SELECT 
  DISTINCT ticker, 
  FIRST_VALUE(date) OVER(PARTITION BY ticker ORDER BY open desc) as high_mnth,
  FIRST_VALUE(open) OVER(PARTITION BY ticker ORDER BY open desc) as high_open,
  FIRST_VALUE(date) OVER(PARTITION BY ticker ORDER BY open) as low_mnth,
  FIRST_VALUE(open) OVER(PARTITION BY ticker ORDER BY open) as low_open
FROM cte
ORDER BY 1
```

---

### International Call Percentage
A phone call is considered an international call when the person calling is in a different country than the person receiving the call. What percentage of phone calls are international? Round the result to 1 decimal.

Assumption:
* The caller_id in phone_info table refers to both the caller and receiver.

![image](https://github.com/user-attachments/assets/b50fb24a-72c2-4fe3-a850-ed46c55a9680)
![image](https://github.com/user-attachments/assets/f5e1e153-e9d6-49b2-b9f5-7a97b5ac7d66)
```sql
WITH cte AS(
  SELECT
    pc.caller_id, p1.country_id AS caller_country_id, pc.receiver_id, 
    p2.country_id AS receiver_country_id
  FROM phone_calls pc 
  JOIN phone_info p1 ON pc.caller_id = p1.caller_id
  JOIN phone_info p2 ON pc.receiver_id = p2.caller_id),
cte2 AS(
  SELECT
    sum(CASE WHEN caller_country_id != receiver_country_id THEN 1.0 ELSE 0 END) AS foreign_calls,
    count(*) as total_calls
  FROM cte )

SELECT
  round((foreign_calls/total_calls)*100,1) as calls
FROM cte2;
```
