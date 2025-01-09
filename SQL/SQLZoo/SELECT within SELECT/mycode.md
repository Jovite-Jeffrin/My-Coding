## SELECT within SELECT

1.
List each country name where the population is larger than that of 'Russia'.

```sql
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
```

2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

```sql
select name
from world
where continent = 'Europe' and gdp/population > 
  (select gdp/population 
  from world 
  where name = 'United Kingdom')
```

3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
   
```sql
select name, continent
from world
where continent in 
    (select continent 
    from world 
    where name in ('Argentina','Australia')) 
order by name
```

4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

```sql
select name, population
from world
where population > 
    (select population
    from world
    where name = 'United Kingdom') and 
population < 
    (select population
    from world
    where name = 'Germany')
```

5. Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.

```sql

```

6. Show all details of the presidential winners:
Theodore Roosevelt
Thomas Woodrow Wilson
Jimmy Carter
Barack Obama

```sql

```

7. Show the winners with first name John

```sql

```

8. Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.

```sql

```

9. Show the year, subject, and name of winners for 1980 excluding chemistry and medicine

```sql

```

10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

```sql

```

11. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

```sql

```

12. The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.

```sql

```
