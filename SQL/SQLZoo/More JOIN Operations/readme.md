## More JOIN  Operations

1. List the films where the yr is 1962 [Show id, title]

```sql
SELECT id, title
 FROM movie
 WHERE yr=1962
```

2. Give year of 'Citizen Kane'.

```sql
select yr
from movie
where title = 'citizen kane'
```

3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

```sql
select id, title, yr
from movie
where title like '%star trek%'
order by yr
```

4. What id number does the actor 'Glenn Close' have?

```sql
select id 
from actor
where name = 'glenn close'
```

5. What is the id of the film 'Casablanca'

```sql
select id
from movie
where title = 'casablanca'
```

6. Obtain the cast list for 'Casablanca'. Use movieid=11768, (or whatever value you got from the previous question)

```sql
select a.name
from movie m
join casting c on m.id = c.movieid
join actor a on a.id = c.actorid
-- where m.title = 'casablanca'
where m.id = (select id from movie where title = 'casablanca')
```

7. Obtain the cast list for the film 'Alien'

```sql
select distinct a.name
from movie m
join casting c on m.id = c.movieid
join actor a on a.id = c.actorid
where m.title = 'alien'
```

8. List the films in which 'Harrison Ford' has appeared
   
```sql
select m.title
from movie m
join casting c on m.id = c.movieid
join actor a on a.id = c.actorid
where a.name = 'harrison ford'
```

9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
    
```sql
select m.title
from movie m
join casting c on m.id = c.movieid
join actor a on a.id = c.actorid
where a.name = 'harrison ford' and c.ord <> 1
```

10. List the films together with the leading star for all 1962 films.
    
```sql
select m.title, a.name
from movie m
join casting c on m.id = c.movieid
join actor a on a.id = c.actorid
where c.ord = 1 and m.yr = 1962
```

11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

```sql
SELECT yr,COUNT(movie.id) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='rock hudson'
GROUP BY yr
HAVING COUNT(title) > 2
```

12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
    
```sql
select m.title, a.name
from movie m
join casting c on m.id = c.movieid
join actor a on c.actorid = a.id
where m.id in
   (select c.movieid
   from casting c
   join actor a on c.actorid = a.id
   where a.name = 'Julie Andrews') and c.ord = 1
```

13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
    
```sql
select m.name
from (
   select a.name as name, count(m.id) as roles
   from movie m
   join casting c on m.id = c.movieid
   join actor a on c.actorid = a.id
   where c.ord = 1
   group by 1
   having count(m.id) >= 15) m
order by m.name
```

14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
    
```sql
select m.title, count(a.id) as actors
from movie m
join casting c on m.id = c.movieid
join actor a on c.actorid = a.id
where m.yr = 1978
group by 1
order by 2 desc, 1
```

15. List all the people who have worked with 'Art Garfunkel'.
    
```sql
select a.name
from movie m
join casting c on m.id = c.movieid
join actor a on c.actorid = a.id
where m.id in
    (select c.movieid
    from casting c
    join actor a on c.actorid = a.id
    where a.name = 'art garfunkel') and a.name <> 'art garfunkel'
```
