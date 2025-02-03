![image](https://github.com/user-attachments/assets/3e92a2b9-8805-4997-93ba-bca8c50a8fe3)### Derive Points table for ICC tournament
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

### Find the fraud sellers and buyers
![image](https://github.com/user-attachments/assets/e86a18b2-580f-4565-a23c-0a1a8f5d6588)

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
