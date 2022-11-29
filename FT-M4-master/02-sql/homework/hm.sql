SELECT * FROM movies WHERE year = 1986;

SELECT * FROM actors WHERE LOWER(last_name) LIKE '%stack%';

SELECT first_name, last_name,
COUNT(*) as Total
FROM actors
group by lower(first_name), lower(last_name) order by Total desc
limit 10;

select a.first_name, a.last_name, count (*) as total
from actors as a
join roles as r
on a.id = r.actor_id
group by a.id
order by total desc
limit 100;

select genre,
count(*) as Total 
from movies_genres
group by genre
order by Total;

select a.first_name, a.last_name, m.name
from actors as a
join roles as r on a.id = r.actor_id
join movies as m on r.movie_id = m.id
join movies_genres as mg on m.id = mg.movie_id
where mg.genre = 'Drama' 
and m.id IN (
    select  m.id
    from movies as m
    join roles as r on m.id = r.movie_id
    join actors as a on r.actor_id = a.id
    where a.first_name = 'Kevin' and a.last_name = 'Bacon'
)
and (a.first_name || a.last_name != 'KevinBacon');

SELECT (actors.first_name || " " || actors.last_name) as name, movies.name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
JOIN movies_genres ON movies.id = movies_genres.movie_id
WHERE movies.id IN (
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.first_name = 'Kevin' AND actors.last_name = 'Bacon'
) AND movies_genres.genre = 'Drama' AND (actors.first_name || " " || actors.last_name) != 'Kevin Bacon'
ORDER BY name;

SELECT movies.year, COUNT(*) AS total
FROM movies
WHERE movies.id NOT IN (
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.gender = 'M'

)
GROUP BY movies.year
ORDER BY movies.year DESC;
