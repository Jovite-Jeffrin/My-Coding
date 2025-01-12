## The JOIN Operation

1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

```sql
SELECT matchid, player
FROM goal 
WHERE teamid = 'ger'
```

2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
Show id, stadium, team1, team2 for just game 1012

```sql
SELECT id,stadium,team1,team2
  FROM game
where id   = 1012
```

3. You can combine the two steps into a single query with a JOIN.
The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
ON (game.id=goal.matchid).
The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate for every German goal.

```sql
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
where teamid = 'ger'
```

4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

```sql
select gm.team1,gm.team2, gl.player
from game gm
join goal gl on gm.id = gl.matchid
where gl.player like 'mario%'
```

5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

```sql
SELECT player, teamid, coach, gtime
FROM goal g
join eteam e on g.teamid = e.id
WHERE gtime<=10
```

6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

```sql
select g.mdate, e.teamname
from game g
join eteam e on g.team1 = e.id 
where e.coach = 'Fernando Santos'
```

7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' 

```sql
select gl.player
from goal gl
join game gm on gl.matchid = gm.id
where gm.stadium = 'National Stadium, Warsaw'
```

8. The example query shows all goals scored in the Germany-Greece quarterfinal. Instead show the name of all players who scored a goal against Germany. 

```sql
SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' or team2='ger') and teamid <>  'ger'
```

9. Show teamname and the total number of goals scored. 

```sql
SELECT teamname, count(*) as goals
  FROM eteam JOIN goal ON id=teamid
group by teamname
 ORDER BY teamname
```

10. Show the stadium and the number of goals scored in each stadium. 

```sql
select stadium, count(*) as goals
from game gm
join goal gl on gm.id = gl.matchid
group by stadium
```
11. For every match involving 'POL', show the matchid, date and the number of goals scored. 

```sql
SELECT matchid,mdate, count(*) as goals
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by 1,2
```

12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' 

```sql
select id, mdate, count(*) as goals
from goal gl
join game gm on gl.matchid = gm.id
where teamid = 'ger'
group by 1,2
```

13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises. Sort your result by mdate, matchid, team1 and team2.

```sql
SELECT mdate,
  team1,
  sum(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
team2,
sum(case when teamid = team2 then 1 else 0 end) score2
  FROM game left JOIN goal ON matchid = id
group by 1,2,4
order by mdate,matchid,team1,team2
```
