#Statement 1
SELECT 		COUNT(*)
FROM 		hasLanguage, language
WHERE 		hasLanguage.languageId = language.id AND
			language.name = "Danish";
			
	#Indexes:
	#Already indexed on primary key
	#Time:	0.001 s
	
		
#Statement 2
SELECT		YEAR(releaseDate), SUM(votes)
FROM		productions
GROUP BY	YEAR(releaseDate);

	#Indexes:
	#None, as MySQL does not support functional indexing
	#No speed to be gained from releaseDate index
	#Time:	0.057 s
	

#Statement 3
SELECT		productions.title
FROM		productions, positions, persons, posTypes
WHERE		productions.id = positions.prodId AND
			persons.id = positions.persId AND
			persons.name = "John Travolta" AND
			positions.posTypId = posTypes.id AND
			posTypes.name = "actor" AND
			productions.id IN (	SELECT	productions.id
								FROM	productions, positions, persons, posTypes
								WHERE	productions.id = positions.prodId AND
										persons.id = positions.persId AND
										persons.name = "Uma Thurman" AND
										positions.posTypId = posTypes.id AND
										posTypes.name = "actor");
									
	#Indexes:
	#Added index on persons.name
		CREATE INDEX 	nameIndex
		ON				persons (name);
	#Time before:	7.535 s
	#Time after:	0.022 s
									
#Statement 4
SELECT		COUNT(*)
FROM		persons, positions, posTypes
WHERE		persons.name LIKE "Q%" AND
			persons.id = positions.persId AND
			positions.posTypId = posTypes.id AND
			(posTypes.name = "actor" OR posTypes.name = "director");
			
	#Indexes:
	#Added index on persons.name
		CREATE INDEX 	nameIndex
		ON				persons (name);
	#Time before:	0.082 s
	#Time after:	0.006 s
			
		
#Statement 5
SELECT		COUNT(*)
FROM		(	SELECT		COUNT(*)
				FROM 		ratings
				GROUP BY	ratings.user
				HAVING		COUNT(*) > 10) r;
				
	#Indexes:
	#No primary key index existed due to the nature of the data (some users rated the
	#same movie multiple times, with the same rating)
	#Added index on ratings.user, even though it showed no improvement
	#We do, however, believe the index would improve performance when more data is added
		CREATE INDEX 	userIndex
		ON				ratings (user);
	#Time before:	0.002 s
	#Time after:	0.002 s
	

#Statement 6
SELECT		persons.name, YEAR(birthDate) birthYear
FROM		persons, positions, productions, posTypes
WHERE		persons.id = positions.persId AND
			positions.prodId = productions.id AND
			productions.title = "Pulp Fiction" AND
			positions.posTypId = posTypes.id AND
			posTypes.name = "actor"
ORDER BY	birthYear;

	#Indexes:
	#Added index on productions.title
		CREATE INDEX 	titleIndex
		ON				productions (title);
	#Time before:	3.677 s
	#Time after:	0.768 s
	

#Statement 7
SELECT		title, YEAR(releaseDate)
FROM		productions, positions, persons
WHERE		productions.id = positions.prodId AND
			positions.persId = persons.id AND
			persons.name = "John Travolta" AND
			(10 * FLOOR(YEAR(productions.releaseDate) / 10)) = 1980;
			
	#Indexes:
	#Added index on persons.name
		CREATE INDEX 	nameIndex
		ON				persons (name);
	#Time before:	0.078 s
	#Time after:	0.001 s
	
		
#Statement 8
SELECT		*
FROM		productions
WHERE		(10 * FLOOR(YEAR(productions.releaseDate) / 10)) = 1990
ORDER BY	rating DESC
LIMIT		5;

	#Indexes:
	#No indexes are uses, due to MySQL not supporting functional indexing
	#Time:	0.061 s
	

#Statement 9
SELECT		p.id, p.title, AVG(r.rating) averageRating
FROM		productions p, ratings r
WHERE		p.id = r.movieId AND
			(10 * FLOOR(YEAR(p.releaseDate) / 10)) = 1990 AND
			3 < (	SELECT COUNT(*)
					FROM ratings
					WHERE movieId = p.id)
GROUP BY	p.id
ORDER BY	averageRating DESC
LIMIT		5;

	#Indexes:
	#Added index on ratings.movieId
		CREATE INDEX 	movieIdIndex
		ON				ratings (movieId);
	#Time before:	0.048 s
	#Time after:	0.006 s
	

#Statement 10
SELECT		l.name, AVG(p.rating)
FROM		productions p, hasLanguage h, language l
WHERE		p.id = h.prodId AND
			l.id = h.languageId AND
			YEAR(p.releaseDate) = 1994
GROUP BY	l.name;

	#Indexes:
	#Uses mostly primary key indexes
	#Adding an index on language.name did not improve performance
	#Time:	0.191 s
	                                           	
                                                            	
#Statement 12
SELECT		prod.title
FROM		productions prod, positions pos, persons pers, posTypes
WHERE		prod.id = pos.prodId AND
			pos.persId = pers.id AND
			pers.name = "John Travolta" AND
			pos.posTypId = posTypes.id AND
        	posTypes.name = "actor"
ORDER BY	prod.rating DESC
LIMIT		1;					

	#Indexes:
	#Added index on persons.name
		CREATE INDEX 	nameIndex
		ON				persons (name);
	#Time before:	0.077 s
	#Time after:	0.002 s
	
										
#Statement 13
SELECT		COUNT(*)
FROM		persons p
WHERE		p.gender = "f" AND
			(p.deathDate < (	SELECT	birthDate
								FROM	persons
								WHERE	name = "Charles Chaplin") OR
			p.birthDate > (		SELECT	deathDate
								FROM	persons
								WHERE	name = "Charles Chaplin"));
								
	#Indexes:
	#Added index on persons.name
		CREATE INDEX 	nameIndex
		ON				persons (name);
	#Time before:	0.235 s
	#Time after:	0.132 s
	

#Statement 14
SELECT 		AVG(rating), genres.name
FROM 		genres, hasGenres
JOIN		productions on productions.id = hasGenres.prodId
WHERE 		genres.id = hasGenres.genreId
GROUP BY	genres.name
LIMIT 		0, 1000;

	#Indexes:
	#Indexes already exist on primary keys (genres.id and hasGenres.id), so no additional
	#indexes were added.
	#Time:	0,204 s


#Statement 15
SELECT 		COUNT(ratings.rating) AS c, genres.name
FROM 		ratings, hasGenres, genres 
WHERE 		hasGenres.genreId = genres.id AND
			ratings.movieId = hasGenres.prodId
GROUP BY 	genres.name 
HAVING 		c > 10;	

	#Indexes:
	#Added index on ratings.movieId
		CREATE INDEX 	ratingIndex
		ON				ratings (movieId);
	#Time before:	1.548 s
	#Time after:	0.161 s
	

#statement 17
SELECT	 	COUNT(DISTINCT (persons.id))
FROM 		persons, positions, posTypes 
WHERE 		persons.id = positions.persId AND
			positions.posTypId = posTypes.id AND
			posTypes.name = "director" AND
			persons.id IN (	SELECT 	distinct(persons.id) 
							FROM 	persons, positions, posTypes 
							WHERE 	persons.id = positions.persId AND
									positions.posTypId = posTypes.id AND 
									posTypes.name = "actor");
			

	#Indexes:
	#Added index on positions.posTypId
		CREATE INDEX 	posTypIndex
		ON				positions (posTypId);
	#Time before:	3.849 s
	#Time after:	1.918 s