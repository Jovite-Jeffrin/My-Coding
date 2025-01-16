## Self Join

1. How many stops are in the database.

```sql
select count(distinct stop)
from route
```

2. Find the id value for the stop 'Craiglockhart'
   
```sql
select id 
from stops
where name = 'craiglockhart'
```

3. Give the id and the name for the stops on the '4' 'LRT' service.
   
```sql
select id, name
from stops s
join route r on s.id = r.stop
where num = 4 and company = 'LRT'
```

4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
   
```sql
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
having count(*) = 2
```

5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
   
```sql
SELECT a.company, a.num, a.stop, b.stop
FROM route a 
JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = (select id from stops where name = 'london road')
```

6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
   
```sql
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'london road'
```

7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
   
```sql
select distinct a.company, a.num
from route a
join route b on a.num = b.num
where a.stop = 115 and b.stop = 137
```
