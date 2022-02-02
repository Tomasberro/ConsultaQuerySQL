-- 1
select * from movies where year = 1991;
-- 2
select count(*) from movies where year = 1982;
-- 3
select * from actors where last_name like '%stack%';
-- 4
select first_name, last_name, count(*) as total
from actors
group by lower(first_name), lower(last_name)
order by total desc
limit 10;
-- 5
select a.first_name, a.last_name, count(*) as total
from actors as a
join roles as r on a.id = r.actor_id
group by a.id
order by total desc
limit 100;
-- 6
select genre, count(*) as total
from movies_genres
group by genre
order by total;
-- 7
select a.first_name, a.last_name, r.role
from movies as m
join roles as r on m.id = r.movie_id
join actors as a on r.actor_id = a.id
where m.name = 'Braveheart' AND m.year = 1995
order by a.last_name;
-- 8
select (d.first_name || " " || d.last_name) as director_name, m.name, m.year
from directors as d
join movies_directors as md on d.id = md.director_id
join movies as m on md.movie_id = m.id
join movies_genres as mg on m.id = mg.movie_id
where mg.genre = 'Film-Noir' and m.year % 4 = 0
order by m.name;
-- 9
select (a.first_name || " " || a.last_name) as name, m.name
from actors as a
join roles as r on a.id = r.actor_id
join movies as m on r.movie_id = m.id
join movies_genres as mg on m.id = mg.movie_id
where mg.genre = 'Drama' and m.id in (
  select r.movie_id
  from roles as r
  join actors as a on r.actor_id = a.id
  where a.first_name = 'Kevin' and a.last_name = 'Bacon'
) and (a.first_name || " " || a.last_name != 'Kevin Bacon')
order by name;
-- 10
select *
from actors
where id in(
  select r.actor_id
  from roles as r
  join movies as m on r.movie_id = m.id
  where m.year < 1900
) and id in (
  select r.actor_id
  from roles as r
  join movies as m on r.movie_id = m.id
  where m.year > 2000
);
-- 11
select a.first_name, a.last_name, m.name, count(distinct role) as total
from actors as a
join roles as r on r.actor_id = a.id
join movies as m on r.movie_id = m.id
where m.year > 1990
group by a.id, m.id
having total > 5;
-- 12
select year, count(distinct id) as total
from movies
where id not in (
  select r.movie_id
  from roles as r
  join actors as a on r.actor_id = a.id
  where a.gender = 'M'
)
group by year
order by year desc;