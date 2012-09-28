select title from danishMovies where imdbVotes>10000;

select * from danishMovies where title like '%man%';

SELECT title, imdbRank as r, imdbVotes as v FROM danishMovies WHERE imdbRank =(SELECT MAX(imdbRank) FROM danishMovies);

select year, count(*) from danishMovies group by year;

select DISTINCT(10*floor(year/10)) as decade, count(*) as c from danishMovies GROUP BY decade;

select director, min(year) as year FROM danishMovies group by director;

select director, max(imdbRank) as r from danishMovies group by director order by r desc;


