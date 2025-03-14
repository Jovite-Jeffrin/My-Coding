### Case Study 2 ([Click Here](https://8weeksqlchallenge.com/case-study-2/))

#### Table creation
```sql
CREATE SCHEMA pizza_runner;
SET search_path = pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
```

#### ER Diagram
![image](https://github.com/user-attachments/assets/42eb694a-3e61-4d4a-abc0-b2ab251f798c)

#### Data Cleaning
```sql
UPDATE customer_orders
SET exclusions = NULL WHERE exclusions = '' or exclusions = 'null';

UPDATE customer_orders
SET extras = NULL WHERE extras = '' or extras = 'null';

SELECT * from runner_orders;

UPDATE runner_orders
SET cancellation = NULL WHERE cancellation = '' or cancellation = 'null';

UPDATE runner_orders
SET pickup_time = NULL WHERE pickup_time = 'null';

UPDATE runner_orders
SET distance = NULL WHERE distance = 'null';

UPDATE runner_orders
SET duration = NULL WHERE duration = 'null';
```

#### Pizza Metrics
1. How many pizzas were ordered?
```sql
SELECT COUNT(pizza_id) as no_of_pizza_ordered
FROM customer_orders;
```

2. How many unique customer orders were made?
```sql
SELECT customer_id, count(DISTINCT order_id) as unique_orders
FROM customer_orders
group by 1;
```

###### Data cleaning
```sql
UPDATE runner_orders set distance = 
CASE
	  WHEN distance LIKE 'null' THEN NULL
      WHEN distance LIKE '' THEN NULL
	  WHEN distance LIKE '%km' THEN TRIM('km' from distance)
	  ELSE distance 
    END;
   
UPDATE runner_orders set duration = 
  CASE
	  WHEN duration LIKE 'null' THEN NULL
      WHEN duration LIKE '' THEN NULL
	  WHEN duration LIKE '%mins' THEN TRIM('mins' from duration)
	  WHEN duration LIKE '%minute' THEN TRIM('minute' from duration)
	  WHEN duration LIKE '%minutes' THEN TRIM('minutes' from duration)
	  ELSE duration
	  END;
```

3. How many successful orders were delivered by each runner?
```sql
SELECT count(order_id) as successful_orders
FROM runner_orders
WHERE distance is NOT NULL;
```

4. How many of each type of pizza was delivered?
```sql
SELECT
	co.pizza_id, count(ro.order_id) as orders
FROM customer_orders co 
JOIN runner_orders ro on co.order_id = ro.order_id
where ro.distance is not NULL
GROUP by 1
order BY 1;
```

5. How many Vegetarian and Meatlovers were ordered by each customer?
```sql
SELECT
	co.pizza_id, pn.pizza_name, COUNT(order_id) as ordered
FROM customer_orders co 
JOIN pizza_names pn on co.pizza_id = pn.pizza_id
GROUP by 1,2
order BY 1,2;
```

6. What was the maximum number of pizzas delivered in a single order?
```sql
SELECT
	co.pizza_id, pn.pizza_name, COUNT(order_id) as ordered
FROM customer_orders co 
JOIN pizza_names pn on co.pizza_id = pn.pizza_id
GROUP by 1,2
order BY 1,2;
```

7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
```sql
SELECT
	customer_id, 
    sum(CASE 
    when exclusions <> '' or extras <> '' then 1 else 0 end) as "Atleast a change",
    sum(CASE 
    when exclusions is null and extras is null then 1 else 0 end) "No change"
FROM customer_orders
GROUP by 1;
```

8. How many pizzas were delivered that had both exclusions and extras?
```sql
SELECT pizza_id, COUNT(*) as count 
FROM customer_orders co 
JOIN runner_orders ro on co.order_id = ro.order_id
WHERE duration is not NULL and exclusions is not NULL and extras is not NULL
GROUP BY 1;
```

9. What was the total volume of pizzas ordered for each hour of the day?
```sql
SELECT
	order_time::DATE as order_time,
    EXTRACT(HOUR FROM order_time) as hour,
    COUNT(*) as orders
FROM customer_orders
GROUP by 1,2
ORDER BY 1,2;
```
![image](https://github.com/user-attachments/assets/8c645682-c0ea-4cc9-93ba-39d8660c6404)

10. What was the volume of orders for each day of the week?
```sql
SELECT
	TO_CHAR(order_time + INTERVAL '2 days', 'Day') as day,
    COUNT(*) as orders
FROM customer_orders
GROUP by 1;
```
