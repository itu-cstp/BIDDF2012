#Statement 1 √
SELECT 		COUNT(*)
FROM 		hasLanguage, language
WHERE 		hasLanguage.languageId = language.id AND
			language.name = "Danish";
			
	#Indexes: √
	#Already indexed on primary key
	
		
#Statement 2 √
SELECT		YEAR(releaseDate), SUM(votes)
FROM		productions
GROUP BY	YEAR(releaseDate);

	#Indexes: √
	#None, as MySQL does not support functional indexing
	#No speed to be gained from releaseDate index
	

#Statement 3
SELECT		productions.title
FROM		productions, positions, persons, posTypes
WHERE		productions.id = positions.prodId AND
			persons.id = positions.persId AND
			persons.name LIKE "John Travolta" AND
			positions.posTypId = posTypes.id AND
			posTypes.name LIKE "actor" AND
			productions.id IN (	SELECT	productions.id
								FROM	productions, positions, persons, posTypes
								WHERE	productions.id = positions.prodId AND
										persons.id = positions.persId AND
										persons.name LIKE "Uma Thurman" AND
										positions.posTypId = posTypes.id AND
										posTypes.name LIKE "actor" AND);
									
	#Indexes: √
	#Already indexed on primary key
									
#Statement 4
SELECT		COUNT(*)
FROM		persons, positions, posTypes
WHERE		persons.name LIKE "Q%" AND
			persons.id = positions.persId AND
			positions.posTypId = posTypes.id AND
			(posTypes.name LIKE "actor" OR posTypes.name LIKE "director");
		
#Statement 5
SELECT		COUNT(*)
FROM		(	SELECT		COUNT(*)
				FROM 		ratings
				GROUP BY	ratings.user
				HAVING		COUNT(*) > 10) r;

#Statement 6
SELECT		persons.name, YEAR(birthDate) birthYear
FROM		persons, positions, productions, posTypes
WHERE		persons.id = positions.persId AND
			positions.prodId = productions.id AND
			productions.title LIKE "Pulp Fiction" AND
			positions.posTypId = posTypes.id AND
			posTypes.name LIKE "actor"
ORDER BY	birthYear;

#Statement 7
SELECT		title, YEAR(releaseDate)
FROM		productions, positions, persons
WHERE		productions.id = positions.prodId AND
			positions.persId = persons.id AND
			persons.name LIKE "John Travolta" AND
			(10 * FLOOR(YEAR(productions.releaseDate) / 10)) = 1980;
		
#Statement 8
SELECT		*
FROM		productions
WHERE		(10 * FLOOR(YEAR(productions.releaseDate) / 10)) = 1990
ORDER BY	rating DESC
LIMIT		5;

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

#Statement 10
SELECT		l.name, AVG(p.rating)
FROM		productions p, hasLanguage h, language l
WHERE		p.id = h.prodId AND
			l.id = h.languageId AND
			YEAR(p.releaseDate) = 1994
GROUP BY	l.name;

#Statement 11
SELECT  pers.name
FROM    persons pers, positions, productions, posTypes
WHERE   pers.id = positions.persId AND
        positions.prodId = productions.id AND
        productions.title LIKE "Pulp Fiction" AND
        positions.posTypId = posTypes.id AND
        posTypes.name LIKE "actor" AND
        0 = (   SELECT  COUNT(*)
                FROM    productions prod, positions, posTypes
                WHERE   prod.id = positions.prodId AND
                        positions.persId = pers.id AND
                        positions.posTypId = posTypes.id AND
        				posTypes.name LIKE "actor" AND
                        1 < (   SELECT  COUNT(*)
                                FROM    positions, persons
                                WHERE   positions.persId = persons.id AND
                                        positions.prodId = prod.id AND
                                        persons.id IN ( SELECT  persons.id
                                                        FROM    persons, positions, productions
                                                        WHERE   persons.id = positions.persId AND
                                                                productions.id = positions.prodId AND
                                                                productions.title LIKE "Pulp Fiction")));
                                                            	
                                                            	
#Statement 12
SELECT		prod.title
FROM		productions prod, positions pos, persons pers, posTypes
WHERE		prod.id = pos.prodId AND
			pos.persId = pers.id AND
			pers.name LIKE "John Travolta" AND
			pos.posTypId = posTypes.id AND
        	posTypes.name LIKE "actor"
ORDER BY	prod.rating DESC
LIMIT		1;					
	
										
#Statement 13
SELECT		COUNT(*)
FROM		persons p
WHERE		p.gender LIKE "f" AND
			(p.deathDate < (	SELECT	birthDate
								FROM	persons
								WHERE	name LIKE "Charles Chaplin") OR
			p.birthDate > (		SELECT	deathDate
								FROM	persons
								WHERE	name LIKE "Charles Chaplin"));