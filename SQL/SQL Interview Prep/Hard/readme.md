### Derive Points table for ICC tournament
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
