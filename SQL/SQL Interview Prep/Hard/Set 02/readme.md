### Second Most Recent Activity | SQL Window Analytical Functions ([Problem link](https://youtu.be/RljzVfz8vjk?si=XCDlALJmLEWl5-Ub))
<img width="694" height="259" alt="image" src="https://github.com/user-attachments/assets/73f05dfe-6c43-4800-9cc5-9f2fd5172ff6" />

Step 01:
``` sql
SELECT *,
COUNT(1) OVER(PARTITION BY username) AS CNN,
RANK() over(partition by username order by startdate) as rnk
from useractivity;
```
<img width="1058" height="210" alt="image" src="https://github.com/user-attachments/assets/914f02d6-e4a4-4393-80c2-4b5c8ef7b2d5" />


Step 02:
```sql
with cte as 
(SELECT *,
COUNT(1) OVER(PARTITION BY username) AS CNN,
RANK() over(partition by username order by startdate) as rnk
from useractivity) 

select 
	username, activity, startdate, enddate
from cte 
where cnn = 1 or rnk = 2;
```
<img width="1060" height="133" alt="image" src="https://github.com/user-attachments/assets/04ba184c-3a72-4a0a-9c8e-731dcd715f0b" />
