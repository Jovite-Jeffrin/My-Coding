## Using NULL

1. List the teachers who have NULL for their department.

```sql
select name
from teacher
where dept is null
```

2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

```sql
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
```

3. Use a different JOIN so that all teachers are listed.
   
```sql
select t.name, d.name
from teacher t
left join dept d on t.dept= d.id
```

4. Use a different JOIN so that all departments are listed.
   
```sql
select t.name, d.name
from teacher t
right join dept d on t.dept= d.id
```

5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
   
```sql
select t.name, coalesce(t.mobile, '07986 444 2266') as phone
from teacher t 
left join dept d on t.dept = d.id
```

6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
   
```sql
select t.name, coalesce(d.name,'None')
from teacher t
left join dept d on t.dept= d.id
```

7. Use COUNT to show the number of teachers and the number of mobile phones.

```sql
select count(t.id), count(mobile)
from teacher t
left join dept d on t.dept= d.id
```

8. Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
   
```sql
select d.name, count(t.id)
from teacher t
right join dept d on t.dept = d.id
group by 1
```

9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
   
```sql
select
  t.name, 
  case 
      when t.dept = 1  or t.dept = 2 then 'Sci'
      else 'Art'
  End as name
from teacher t
left join dept d on t.dept = d.id
```

10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
   
```sql
select
  t.name, 
  case 
      when t.dept = 1  or t.dept = 2 then 'Sci'
      when t.dept = 3 then 'Art'
      else 'None'
  End as name
from teacher t
left join dept d on t.dept = d.id
```
