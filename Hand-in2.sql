#Statement 0
insert into hasLanguage select movie.Id, language.Id from movie join language on movie.language = language.name;

#Statement 1

SELECT 		COUNT(*)
FROM 		hasLanguage, language
WHERE 		hasLanguage.languageId = language.id AND
			language.name = "Danish";
		
#Statement 2
SELECT    year(releaseDate), SUM(votes) FROM    productions GROUP BY  year(releaseDate);

# We would liek a function based index for this. No speed to be gained from releaseDate index

#Statement 3
SELECT    productions.title
FROM    productions, positions, persons, posTypes
WHERE   productions.id = positions.prodId AND
      persons.id = positions.persId AND
      persons.name LIKE "John Travolta" AND
      positions.posTypId = posTypes.id AND
      posTypes.name LIKE "actor" AND
      productions.id IN ( SELECT  productions.id
                FROM  productions, positions, persons, posTypes
                WHERE productions.id = positions.prodId AND
                    persons.id = positions.persId AND
                    persons.name LIKE "Uma Thurman" AND
                    positions.posTypId = posTypes.id AND
                    posTypes.name LIKE "actor" AND);

create index nameIndex on persons (name);

# Speed improvement galore (4 - 5 seconds down to almost none)

#Statement 4
SELECT COUNT(*) FROM persons, positions, posTypes
WHERE persons.name LIKE "Q%" AND 
persons.id = positions.persId AND 
positions.posId = positionRoles.posId AND 
(posTypes.name like "Actor" OR posTypes.name like "Director");

SELECT count(distinct(persons.id)) FROM persons, positions, posTypes 
WHERE persons.name LIKE "Q%" AND       
persons.id = positions.persId AND       
positions.posTypId = posTypes.id AND       
(posTypes.name LIKE "actor" OR posTypes.name LIKE "director");


#Statement 5
SELECT		COUNT(*) count
FROM 		userVotes
GROUP BY	userVotes.name
HAVING		COUNT(*) > 10;

#Statement 6
SELECT		name, YEAR(birthDate) birthYear
FROM		persons, positions, productions
WHERE		persons.id = positions.persId AND
			positions.prodId = productions.id AND
			prodictions.title LIKE "Pulp Fiction"
ORDER BY	birthYear

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
SELECT		p.id, p.title, AVG(u.rating) averageRating
FROM		productions p, userVotes u
WHERE		p.id = u.prodId AND
			(10 * FLOOR(YEAR(p.releaseDate) / 10)) = 1990
GROUP BY	p.id
ORDER BY	averageRating DESC
LIMIT		5;

#Statement 10
SELECT		l.name, AVG(p.rating)
FROM		productions p, hasLanguage h, languages l
WHERE		p.id = hasLanguage.prodId AND
			l.id = hasLanguages.languageId AND
			YEAR(p.releaseDate) = 1994
GROUP BY	l.name;

#Statement 11
SELECT  pers.name
FROM    persons pers, positions, productions, positionRoles, roles
WHERE   pers.id = positions.persId AND
        positions.prodId = productions.id AND
        productions.title LIKE "Pulp Fiction" AND
        positionRoles.posId = positions.id AND
        positionRoles.rolId = roles.id AND
        roles.name LIKE "Actor" AND
        0 = (   SELECT  COUNT(*)
                FROM    productions prod, positions, positionRoles, roles
                WHERE   prod.id = positions.prodId AND
                        positions.persId = pers.id AND
                        positionRoles.posId = positions.id AND
                        positionRoles.rolId = roles.id AND
                        roles.name LIKE "Actor" AND
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
FROM		productions prod, positions pos, persons pers, positionRoles, roles
WHERE		prod.id = pos.prodId AND
			pos.persId = pers.id AND
			pers.name LIKE "John Travolta" AND
			positionRoles.posId = pos.id AND
			positionRoles.rolId = roles.id AND
			roles.name LIKE "Actor" AND
			prod.rating > ALL (	SELECT	prod2.rating
								FROM	productions prod2, positions pos2, persons pers2, positionRoles, roles
								WHERE	prod2.id = pos2.prodId AND
										pos2.persId = pers2.id AND
										pers2.name LIKE "John Travolta" AND
										positionRoles.posId = pos2.id AND
										positionRoles.rolId = roles.id AND
										roles.name LIKE "Actor");
										
										
#Statement 13
SELECT		*
FROM		persons p
WHERE		p.gender LIKE "f" AND
			(p.deathDate < (	SELECT	birthDate
								FROM	persons
								WHERE	name LIKE "Charles Chaplin") OR
			p.birthDate > (		SELECT	deathDate
								FROM	persons
								WHERE	name LIKE "Charles Chaplin"));
								
								
#Statement 14
