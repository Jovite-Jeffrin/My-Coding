## SUM and COUNT

1. Show the total population of the world.

```sql
SELECT SUM(population)
FROM world
```

2. List all the continents - just once each.

```sql
select distinct continent
from world
```

3. Give the total GDP of Africa

```sql
select sum(gdp)
from world
where continent = 'Africa'
```

4. How many countries have an area of at least 1000000

```sql
select count(name)
from world
where area >= 1000000
```

5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
   
```sql
select sum(population)
from world
where name in ('Estonia', 'Latvia', 'Lithuania')
```

### Using GROUP BY and HAVING

6. For each continent show the continent and number of countries.
   
```sql
select continent, count(name) as countries
from world
group by continent
```

7. For each continent show the continent and number of countries with populations of at least 10 million.

```sql
select continent, count(name) as countries
from world
where population >= 10000000
group by continent
```

8. List the continents that have a total population of at least 100 million.
   
```sql
select continent
from world
group by continent
having sum(population) >= 100000000
```
