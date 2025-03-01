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

