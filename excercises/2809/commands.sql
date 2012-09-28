select title from danishMovies where imdbVotes>10000;

select * from danishMovies where title like '%man%';

SELECT title, imdbRank as r, imdbVotes as v FROM danishMovies WHERE imdbRank =(SELECT MAX(imdbRank) FROM danishMovies);

select year, count(*) from danishMovies group by year;

select DISTINCT(10*floor(year/10)) as decade, count(*) as c from danishMovies GROUP BY decade;

select director, min(year) as year FROM danishMovies group by director;

select director, max(imdbRank) as r from danishMovies group by director order by r desc;

select * from danishMovies dm1 WHERE 1 = (SELECT count(director) FROM danishMovies dm2 WHERE dm1.director=dm2.director);

select distinct(concat(title, " - ", director)) from danishMovies;

select title, year from danishMovies d1 WHERE 10<(SELECT count(*) FROM danishMovies d2 WHERE d1.year = d2.year);
