Case Study #1: [Click here!](https://8weeksqlchallenge.com/case-study-1/)

### Table creation
```sql
CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

DROP TABLE sales;
CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
SELECT * from sales;

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');

SELECT * from menu;

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

DROP TABLE members;
SELECT * from members;
```

###  Case Study Questions

##### 1. What is the total amount each customer spent at the restaurant?
```sql
SELECT s.customer_id, sum(price) as total_amount_spent
from sales s
JOIN menu m on s.product_id = m.product_id
GROUP BY 1
ORDER by 1;
```

##### 2. How many days has each customer visited the restaurant?
```sql
SELECT customer_id, COUNT(DISTINCT order_date) as customer_visited
FROM sales
GROUP BY 1
ORDER BY 1;
```

##### 3. What was the first item from the menu purchased by each customer?
```sql
with cte as (
SELECT s.customer_id as customer_id, m.product_name as product_name,
RANK() OVER(PARTITION BY s.customer_id order BY s.order_date) as rnk
from menu m
join sales s on m.product_id = s.product_id
)
SELECT DISTINCT customer_id, product_name
from cte
where rnk = 1;
```

##### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
```sql
SELECT product_id, count(*) as purchased
from sales
GROUP by 1;

SELECT customer_id, product_id, COUNT(*) as cnt
from sales
GROUP BY 1,2
order BY 1,2;
```

##### 5. Which item was the most popular for each customer?
```sql
with cte as (
SELECT customer_id, product_id, COUNT(*) as cnt,
  RANK() OVER(PARTITION by customer_id order by count(product_id) DESC) as rnk
from sales
GROUP BY 1,2)
SELECT customer_id, product_id
from cte
where rnk = 1;
```

##### 6. Which item was purchased first by the customer after they became a member?
```sql
with cte as (
  SELECT s.customer_id, s.product_id,
  RANK() OVER(PARTITION by s.customer_id ORDER by s.order_date) as rnk
  FROM sales s 
  JOIN members m on s.customer_id = m.customer_id
  WHERE s.order_date > m.join_date)
SELECT c.customer_id, m.product_name
from cte c
join menu m on c.product_id = m.product_id
where rnk = 1
order by 1;
```

##### 7. Which item was purchased just before the customer became a member?
```sql
with cte as (
  SELECT s.customer_id, s.product_id,
  RANK() OVER(PARTITION by s.customer_id ORDER by s.order_date) as rnk
  FROM sales s 
  JOIN members m on s.customer_id = m.customer_id
  WHERE s.order_date < m.join_date)
SELECT c.customer_id, m.product_name
from cte c
join menu m on c.product_id = m.product_id
where rnk = 1
order by 1;
```

##### 8. What is the total items and amount spent for each member before they became a member?
```sql
SELECT
  s.customer_id, count(s.product_id) as total_items, SUM(mn.price) as amnt_spent
from sales s
join members m on s.customer_id = m.customer_id
join menu mn on s.product_id = mn.product_id
WHERE s.order_date < m.join_date
GROUP by 1
order by 1;
```

##### 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
##### how many points would each customer have?
```sql
SELECT
	s.customer_id,
	sum(CASE 
    	WHEN m.product_name = 'sushi' then m.price*20
        else m.price*10
        end) as points
from sales s 
join menu m on s.product_id = m.product_id
GROUP by 1
order by 1;
```

##### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi 
##### how many points do customer A and B have at the end of January?
```sql
WITH cte AS (
    SELECT 
        s.customer_id, s.order_date, m.price, mem.join_date,
        CASE 
            WHEN s.order_date BETWEEN mem.join_date AND mem.join_date + INTERVAL '6 days' THEN (m.price * 2)  
            ELSE m.price      
        END AS earned_points
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    JOIN members mem ON s.customer_id = mem.customer_id
)

SELECT customer_id, SUM(earned_points) AS total_points
FROM cte
GROUP BY customer_id;
```
