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

