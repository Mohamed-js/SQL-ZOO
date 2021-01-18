-- 0 - basics
SELECT population
FROM world
WHERE name = 'Germany'


SELECT name,
  population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');


SELECT name,
  area
FROM world
WHERE area BETWEEN 200000 AND 250000 

-- ------------------------------------------
  -- 1- select name :like:
SELECT name
FROM world
WHERE name LIKE 'Y%'


SELECT name
FROM world
WHERE name LIKE '%y'


SELECT name
FROM world
WHERE name LIKE '%x%'


SELECT name
FROM world
WHERE name LIKE '%land'


SELECT name
FROM world
WHERE name LIKE 'C%ia'


SELECT name
FROM world
WHERE name LIKE '%oo%'


SELECT name
FROM world
WHERE name LIKE '%a%a%a%'


SELECT name
FROM world
WHERE name LIKE '_t%'
ORDER BY name


SELECT name
FROM world
WHERE name LIKE '%o__o%'


SELECT name
FROM world
WHERE name LIKE '__'


SELECT name
FROM world
WHERE name = capital


SELECT name
FROM world
WHERE capital LIKE concat(name, ' city')


SELECT capital,
  name
FROM world
WHERE capital LIKE concat('%', name, '%')


SELECT capital,
  name
FROM world
WHERE capital LIKE concat(name, '%')
  And capital <> name


SELECT name,
  replace (capital, name, '') as ext
FROM world
WHERE capital LIKE concat(name, '%')
  And capital <> name
  
  -- ------------------------------------------------------------
  -- 2 - select from world

SELECT name,
continent,
population
FROM world


SELECT name
FROM world
WHERE population > 200000000


SELECT name,
GDP / population
FROM world
Where population > 200000000


SELECT name,
population / 1000000
FROM world
WHERE continent = 'South America'


SELECT name,
population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')


SELECT name
From world
Where name like 'United%'


Select name,
population,
area
From world
Where area > 3000000
Or population > 250000000


Select name,
population,
area
From world
Where area > 3000000
xor population > 250000000


Select name,
round(population / 1000000, 2),
round (GDP / 1000000000, 2)
From world
Where continent = 'South America'


Select name,
round (GDP / population, -3)
From world
Where round(GDP / 1000000000000, 3) > 1


SELECT name,
capital
FROM world
WHERE length (name) = length (capital)


SELECT name,
capital
FROM world
Where LEFT(name, 1) = LEFT(capital, 1)
And name <> capital


SELECT name
FROM world
WHERE name LIKE '%a%'
  And name LIKE '%e%'
  And name LIKE '%i%'
  And name LIKE '%o%'
  And name LIKE '%u%'
  AND name NOT LIKE '% %' 
  
-- -----------------------------------------------------------------
-- 3- Select from Nobel
SELECT yr,
subject,
winner
FROM nobel
WHERE yr = 1950


SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'


select yr,
subject
from nobel
where winner = 'Albert Einstein'


select winner
from nobel
where subject = 'Peace'
and yr >= 2000


select *
from nobel
where yr >= 1980
and yr <= 1989
and subject = 'Literature'


SELECT *
FROM nobel
WHERE winner IN (
    'Theodore Roosevelt',
    'Woodrow Wilson',
    'Jimmy Carter',
    'Barack Obama'
  )

  
select winner
from nobel
where winner like 'John%'


select yr,
subject,
winner
from nobel
where subject = 'Physics'
and yr = 1980
or subject = 'Chemistry'
and yr = 1984


select yr,
subject,
winner
from nobel
where subject != 'Chemistry'
and subject != 'Medicine'
and yr = 1980


select yr,
subject,
winner
from nobel
where subject = 'Medicine'
and yr < 1910
or subject = 'Literature'
and yr >= 2004


select *
from nobel
where winner = 'PETER GRÜNBERG'


select *
from nobel
where winner = 'EUGENE O''NEILL'


select winner,
yr,
subject
from nobel
where winner like 'sir%'


SELECT winner,
  subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Physics', 'Chemistry'),
  subject,
  winner 
  
--  ----------------------------------------------------------------------
-- 4- Select in Select
SELECT name
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name = 'Russia'
  )


SELECT name
FROM world
WHERE GDP / population > (
    SELECT GDP / population
    FROM world
    WHERE name = 'United Kingdom'
  )
  and continent = 'Europe'


SELECT name,
continent
from world
where continent = (
    select continent
    from world
    where name = 'Argentina'
  )
  or continent = (
    select continent
    from world
    where name = 'Australia'
  )
order by name


SELECT name,
  population
from world
where population > (
    select population
    from world
    where name = 'Canada'
  )
  and population < (
    select population
    from world
    where name = 'Poland'
  )
order by name 


-- fantastic !
select name,
  concat(
    round(
      population /(
        Select population
        from world
        where name = 'Germany'
      ) * 100,
      0
    ),
    '%'
  ) as percentage
from world
where continent = 'Europe'


SELECT name
FROM world
WHERE population >= ALL(
    SELECT population
    FROM world
    WHERE continent = 'Europe'
      and population > 0
  ) 
  
  
  -- same
SELECT name
FROM world
WHERE GDP >= ALL(
    SELECT GDP
    FROM world
    WHERE continent = 'Europe'
      and GDP > 0
  )
  and name != 'Germany'


SELECT continent,
  name,
  area
FROM world x
WHERE area >= ALL (
    SELECT area
    FROM world y
    WHERE y.continent = x.continent
    AND population > 0
  )


SELECT continent,
  name
FROM world a
WHERE name = (
    SELECT name
    FROM world b
    Where a.continent = b.continent
    limit 1
  )



SELECT name,
  continent,
  population
FROM world w
WHERE NOT EXISTS (
    SELECT *
    FROM world y
    WHERE y.continent = w.continent
    AND y.population > 25000000
  );


--  ----------------------------------------------------------------------
-- 5- SUM && COUNT
SELECT SUM(population)
FROM world

SELECT DISTINCT continent
FROM world

SELECT SUM(gdp)
FROM world
where continent = 'Africa'

SELECT COUNT(name)
FROM world
where area >= 1000000

SELECT SUM(population)
FROM world
where name IN ('Estonia', 'Latvia', 'Lithuania')

SELECT continent, COUNT(name)
FROM world
GROUP BY continent

SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000


--  ----------------------------------------------------------------------
-- 6- Join

SELECT matchid, player FROM goal 
WHERE teamid ='GER'

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012


SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game JOIN goal ON (id=matchid) where teamid = 'GER'


SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid) where player like 'Mario%'


SELECT player, teamid, coach, gtime
FROM goal join eteam on teamid=id
WHERE gtime<=10


SELECT mdate, teamname
From game join eteam on eteam.id=team1 
where eteam.coach = 'Fernando Santos'


Select player 
From goal join game on id=matchid
where stadium =  'National Stadium, Warsaw'


Select goal.player 
From goal join game on id=matchid
where game.stadium =  'National Stadium, Warsaw'


SELECT DISTINCT goal.player
FROM game JOIN goal ON matchid = id 
WHERE teamid!='GER' AND (team1 = 'GER' or team2 = 'GER')


SELECT teamname, COUNT(goal.player)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname


SeLECT stadium, count(goal.player)
From goal join game on id=matchid
group by stadium


SELECT game.id, game.mdate, COUNT(*)
FROM game
JOIN goal
ON id = matchid
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY game.id, game.mdate


SELECT game.id, mdate, COUNT(*)
FROM game
JOIN goal
ON goal.matchid = game.id
WHERE teamid = 'GER'

----------------------------
-- 7- More join

SELECT id, title
FROM movie
WHERE yr=1962

SELECT yr 
FROM movie
WHERE title=  'Citizen Kane'

SELECT id, title, yr
FROM movie
WHERE title like '%Star Trek%'
ORDER BY yr ASC

SELECT id 
FROM actor
WHERE name =  'Glenn Close'

SELECT id 
FROM movie
WHERE title=   'Casablanca'

SELECT name FROM actor
JOIN casting ON id = actorid
WHERE movieid=11768

SELECT name FROM (actor
JOIN casting ON actor.id = actorid) 
JOIN movie ON movie.id = movieid
WHERE movie.title ='Alien'

SELECT title FROM (actor
JOIN casting ON actor.id = actorid) 
JOIN movie ON movie.id = movieid
WHERE actor.name ='Harrison Ford'

SELECT title FROM (actor
JOIN casting ON actor.id = actorid) 
JOIN movie ON movie.id = movieid
WHERE actor.name ='Harrison Ford'
AND casting.ord != 1

SELECT title, actor.name 
FROM (actor JOIN casting ON actor.id = actorid) 
JOIN movie ON movie.id = movieid
WHERE yr = '1962'
AND ord = 1


SELECT yr, COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

SELECT title, actor.name
FROM movie JOIN casting ON (movie.id=movieid AND ord=1)
           JOIN actor ON actorid=actor.id
WHERE movie.id IN (SELECT movieid from casting
WHERE actorid IN (SELECT id FROM actor WHERE name='Julie Andrews'))

SELECT title, COUNT(actorid) FROM movie
  JOIN casting ON movieid = movie.id
 WHERE yr=1978
 GROUP BY title
 ORDER BY COUNT(actorid) DESC, title

SELECT name FROM actor
JOIN casting ON actorid = actor.id
WHERE movieid IN (SELECT movie.id FROM movie
                    JOIN casting ON movieid = movie.id
                    JOIN actor ON actorid = actor.id
                    WHERE name = 'Art Garfunkel')
 AND name != 'Art Garfunkel'


 ---------------------------
 -- 8- Using NULL


SELECT name
 FROM teacher
WHERE dept IS NULL

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher left JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher right JOIN dept
           ON (teacher.dept=dept.id)

SELECT name, COALESCE(mobile,'07986 444 2266')
  FROM teacher 

SELECT teacher.name, COALESCE(dept.name,'None') 
  FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

SELECT COUNT(name), COUNT(mobile)
FROM teacher

SELECT dept.name, COUNT(teacher.name)
FROM  teacher RIGHT JOIN dept ON (dept.id=teacher.dept)
GROUP BY dept.name

SELECT name, CASE WHEN dept= 1
                  THEN 'Sci'
                  WHEN dept= 2
                  THEN 'Sci'
                  ELSE 'Art'
END AS department
FROM teacher

SELECT name, CASE WHEN dept= 1
                  THEN 'Sci'
                  WHEN dept= 2
                  THEN 'Sci'
                  WHEN dept= 3
                  THEN 'Art'
                  ELSE 'None'
END AS department                    
FROM teacher
