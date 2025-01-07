## SELECT from Nobel

1. Change the query shown so that it displays Nobel prizes for 1950.

```sql
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950
```

2. Show who won the 1962 prize for literature.

```sql
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'
```

3. Show the year and subject that won 'Albert Einstein' his prize.

```sql

```
