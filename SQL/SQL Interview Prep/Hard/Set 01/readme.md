### Derive Points table for ICC tournament ([Problem link](https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=1&pp=iAQB))
![image](https://github.com/user-attachments/assets/33f2b9eb-af12-4ca4-a7e8-eddad2b4e87f)

```sql
SELECT
	sq.team_name, count(1) as matches_played, sum(sq.winner) as no_of_wins, count(1) - sum(sq.winner) as no_of_loses
FROM
(select 
	team_1 as team_name, winner as winning_team, 
	case 
    	when team_1 = winner then 1 else 0 end as winner
from icc_world_cup

union ALL

select 
	team_2 as team_name, winner, 
	case 
    	when team_2 = winner then 1 else 0 end as winning_team
from icc_world_cup) as sq 
GROUP by 1
order by 1, 2 DESC
```

- - - - 

### Find the fraud sellers and buyers (asked @Google ([Link](https://youtu.be/2wN3D0jsj9k?si=CTiAPTfdMtx1IHQ6)) ⭐
![image](https://github.com/user-attachments/assets/e86a18b2-580f-4565-a23c-0a1a8f5d6588))

```sql
WITH cte as (
	SELECT 
		transaction_id, customer_id as sellers, 
		LEAD(customer_id,1) OVER(ORDER BY transaction_id) as buyers,
	  	amount, tran_date
	FROM transactions),
cte2 as(
	SELECT  
	  	sellers, buyers, COUNT(amount) as cnt
	FROM cte
	WHERE transaction_id % 2 = 1
	GROUP BY 1,2),
frauds as (
	SELECT sellers as frauds FROM cte2
	INTERSECT
	SELECT buyers FROM cte2)

SELECT
	*
FROM cte2 
WHERE sellers NOT IN (SELECT frauds FROM frauds) 
AND buyers NOT IN (SELECT frauds FROM frauds)
```

----

### Find the number new and repeat customers on day-wise ([Link](https://www.youtube.com/watch?v=MpAMjtvarrc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2&pp=iAQB))
![image](https://github.com/user-attachments/assets/a2fb228b-397c-4c35-bfe7-43d2cbfee7ea)

From the above table 
* Find the number of new and repeat customers per day.
* How much they spent

##### Task 01:
By comparing the order_date with the joined_date i.e first transation happend. Joined_date can be found by taking min(order_date) using aggregate function.

```sql
with cte as (
	SELECT
		customer_id, MIN(order_date) as joined_date
	FROM customer_orders
	GROUP BY 1),
cte2 as (
	SELECT 
		co.*, c.joined_date
	FROM customer_orders co 
	JOIN cte c ON co.customer_id = c.customer_id)

SELECT
	order_date,
    sum(CASE WHEN order_date = joined_date THEN  1 ELSE 0 end) as new_customer,
    sum(CASE WHEN order_date != joined_date THEN  1 ELSE 0 end)  as old_customer
FROM cte2
GROUP BY 1
order by 1;
```
![image](https://github.com/user-attachments/assets/ada6f06f-042b-45ab-8a8a-1a565fdd3886)

##### Task 02:
Finding the amount spent

```sql
with cte as (
	SELECT
		customer_id, MIN(order_date) as joined_date
	FROM customer_orders
	GROUP BY 1),
cte2 as (
	SELECT 
		co.*, c.joined_date
	FROM customer_orders co 
	JOIN cte c ON co.customer_id = c.customer_id)

SELECT
	order_date,
    sum(CASE WHEN order_date = joined_date THEN  1 ELSE 0 end) as new_customer,
    sum(CASE WHEN order_date != joined_date THEN  1 ELSE 0 end)  as old_customer,
    sum(CASE WHEN order_date = joined_date THEN  order_amount ELSE 0 end) as new_customer_spent,
    sum(CASE WHEN order_date != joined_date THEN  order_amount ELSE 0 end) as new_customer_spent
FROM cte2
GROUP BY 1
order by 1;
```
![image](https://github.com/user-attachments/assets/ac7c6417-2429-4323-8a74-7a70df1ccd00)

---


### Trips and Users [Link](https://youtu.be/EjzhMv0E_FE?si=yKVzgxS9FutTtpLE)
![image](https://github.com/user-attachments/assets/74c5000c-9023-4172-ab6c-9c2a820c0da1)

##### Task 01:
Joining the master table with client and driver

```sql
SELECT
	*
FROM trips t 
JOIN users u1 ON t.client_id = u1.users_id -- with client 
JOIN users u2 ON t.driver_id = u2.users_id -- with driver
```
![image](https://github.com/user-attachments/assets/2c656ce3-1fdb-45df-b1b7-29a01833cdc0)

##### Task 02:
Finding thecancellation rates

```sql
SELECT
	request_at, 
    SUM(CASE WHEN status IN ('cancelled_by_driver','cancelled_by_client') THEN 1 ELSE 0 END) as cancelled_trips,
    count(1) as no_of_rides,
    round(SUM(CASE WHEN status IN ('cancelled_by_driver','cancelled_by_client') THEN 1.0 ELSE 0 END) /
    count(1.0) * 100.0,2) as cancellation_rates
FROM trips t 
JOIN users u1 ON t.client_id = u1.users_id
JOIN users u2 ON t.driver_id = u2.users_id
WHERE u1.banned = 'No' AND u2.banned = 'No'
GROUP BY 1;
```
![image](https://github.com/user-attachments/assets/68510d9f-f0c9-4fee-abad-6bf04126aa93)

---

### Tournament Winners [Link](https://youtu.be/IQ4n4n-Y9z8?si=5fqLVxfYGVYem7Tr)
![image](https://github.com/user-attachments/assets/a201084c-e125-405f-b94d-b9345cdd7bbd)

From the above table find the maximum scores scored by the players in each group.

```sql
with cte as (
SELECT first_player as players, first_score as score FROM matches
UNION all
SELECT second_player as players, second_score as score FROM matches)
, cte2 as(
SELECT
	p.group_id, c.players, sum(score) as scores,
    RANK() OVER(PARTITION BY p.group_id ORDER BY sum(score) DESC, players asc) as rnk
FROM cte as c
JOIN players p ON c.players = p.player_id
group by 1,2)

SELECT
	group_id, players, scores
from cte2
WHERE rnk = 1;
```
![image](https://github.com/user-attachments/assets/9bea51a5-d286-4405-aad0-de00e58495b3)
