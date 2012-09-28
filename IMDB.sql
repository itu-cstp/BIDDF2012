CREATE TABLE persons (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(256) NOT NULL,
  birthDate DATE,
  deathDate DATE,
  description TEXT  
)

CREATE TABLE genres (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
)

CREATE TABLE posTypes (
  id INT PRIMARY KEY AUTO_INCREMENT,  
  name VARCHAR(50)
)

CREATE TABLE prodTypes (
  id INT PRIMARY KEY AUTO_INCREMENt,
  name VARCHAR(256)
)

CREATE TABLE productions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(256),
  typeId INT REFERENCES prodTypes(id),
  childOf INT REFERENCES productions(id)
)

CREATE TABLE productionHasGenres
(
  production_id int,
  genres_id int,
  primary key (production_id, genres_id),
  production_id references production(id),
  genres_id references genres(id)
)

CREATE TABLE roles(
  id INT PRIMARY KEY,
  name VARCHAR(256)
)

CREATE TABLE positionRoles(
  posId INT REFERENCES positions(id),
  rolId INT REFERENCES roles(id)
  PRIMARY KEY(posId, rolId)
)

CREATE TABLE positions(
  startDate DATE,
  endDate DATE,
  persId int REFERENCES persons(id),
  prodId int REFERENCES productions(id),
  posTypId int REFERENCES posTypes(id)
)


CREATE TABLE releases(
  prodId INT NOT NULL REFERENCES productions(id),
  country VARCHAR(256),
  releaseDate DATE
)
