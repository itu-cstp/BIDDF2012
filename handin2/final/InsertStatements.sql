# countries
insert into countries (name) (select distinct country from movie);

# genres
insert into genres (name) (select distinct genre from genre);

# posTypes
insert into posTypes (name) (select distinct role from involved);

# persons
insert into persons (name, birthDate, deathDate, gender, height) 
                    (select name, birthDate, deathDate, gender, height from person);

# language 
insert into languages (name) (select distinct language from movie);

# productions
insert into productions (id, title, releaseDate, rating, votes)
						(select id, title, releaseDate, imdbRank, imdbVotes from movie); 

# positions
insert into positions (persId, prodId, posTypId) 
					  (select personId, movieId, id 
					  		from involved, posTypes 
							where involved.role=posTypes.name);

# hasLanguage
insert into hasLanguage (prodId, languageId) 
						(select m.id, l.id from movie m, languages l
							where l.name=m.language);
                   
# prodHasGenres
insert into hasGenres (prodId, genreId)
						select genre.movieId, genres.id 
						from genre, genres
						where genre.genre = genres.name;

# hasCountry
insert into hasCountry (prodId, countId)
						select movie.id, countries.id
						from movie, countries
						where movie.country=countries.name;

