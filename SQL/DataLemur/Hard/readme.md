### Server Utilization Time

Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage. Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

Assumptions:
* Each server might start and stop several times.
* The total time in which the server fleet is running can be calculated as the sum of each server's uptime.

```sql
WITH cte AS(
SELECT 
  *,
  lead(status_time,1) OVER(PARTITION BY server_id ORDER BY status_time) as ld
FROM server_utilization)

SELECT
  sum(EXTRACT(DAY FROM ld) - EXTRACT(DAY FROM status_time)) as runtime
FROM cte 
WHERE session_status = 'start';
```
