### Scenario based on join, group by and having clauses ([Problem link](https://youtu.be/SfzbR69LquU?list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb))
![image](https://github.com/user-attachments/assets/1997c166-5264-4a01-bf55-88d6eeccb6b9)

```sql
WITH cte as(
  SELECT f.pid as pid, count(f.fid) as friends_count , SUM(p.score) as score 
  FROM person p 
  JOIN friend f ON p.personid =f.fid
  GROUP BY 1
  HAVING sum(p.score) > 100)
  
SELECT 
	c.pid, p.name,c.friends_count, c.score
FROM cte c 
JOIN person p on c.pid = p.personid;
```

- - - - 

### Scenario Based SQL Question ([Problem link](https://youtu.be/51ryMCf-fvU?si=DWDPligf7fjwiuOm))
<img width="1052" height="589" alt="image" src="https://github.com/user-attachments/assets/974f3cb9-7f4f-4f0e-892e-28ee0e21be87" />

```sql
with cte as 
(SELECT
*, LEAD(bill_date ,1,'2000-01-01') over(PARTITION BY emp_name ORDER BY bill_date) - INTERVAL '1 DAY' as last_date
from billings)

SELECT
	c.emp_name, sum(bill_rate*bill_hrs)
from cte c 
join hoursworked h on c.emp_name = h.emp_name and h.work_date BETWEEN c.bill_date and c.last_date
group by 1
```
<img width="696" height="138" alt="image" src="https://github.com/user-attachments/assets/b8c237ad-c6cc-4242-824d-11a0ad98e6c2" />

- - - -

### Consecutive Empty Seats ([Problem link](https://youtu.be/F9Otofceer0?list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb))
<img width="1421" height="578" alt="image" src="https://github.com/user-attachments/assets/5cbf2a9b-f71c-456a-a188-3259f185372a" />

#### Using LEAD AND LAG Function
```sql
SELECT * 
from 
  (
  SELECT *,
    lead(is_empty,1) over(order by seat_no) as next_1,
    lead(is_empty,2) over(order by seat_no) as next_2,
    LAG(is_empty,1) over(order by seat_no) as prev_1,
    LAG(is_empty,2) over(order by seat_no) as prev_2
  from bms
  ) as sq 
where (is_empty = 'Y' and next_1 = 'Y' and next_2 = 'Y')
	or (is_empty = 'Y' and prev_1 = 'Y' and next_1 = 'Y')	
	or (is_empty = 'Y' and prev_1 = 'Y' and prev_2 = 'Y');
```
<img width="1109" height="658" alt="image" src="https://github.com/user-attachments/assets/300ca7d3-8e69-4992-96c9-ca699565fef5" />

<img width="1088" height="351" alt="image" src="https://github.com/user-attachments/assets/23c5b634-761b-4a88-8bd5-aac50fe9d95a" />

#### Using Advance Function
```sql
SELECT
	*
from 
  (
    SELECT *,
      sum(case when is_empty = 'Y' then 1 else 0 END) over(order by seat_no ROWS BETWEEN 2 PRECEDING and CURRENT ROW) as prev_2,
      sum(case when is_empty = 'Y' then 1 else 0 END) over(order by seat_no ROWS BETWEEN 1 PRECEDING and 1 FOLLOWING) as prev_next_1,
      sum(case when is_empty = 'Y' then 1 else 0 END) over(order by seat_no ROWS BETWEEN CURRENT row and 2 FOLLOWING) as next_2
      from bms
  ) as sq 
WHERE prev_2 = 3 or prev_next_1 = 3 or next_2 = 3;
```
<img width="1078" height="352" alt="image" src="https://github.com/user-attachments/assets/3840b1b3-f803-467c-a0db-6f103ce278fb" />

- - - -
