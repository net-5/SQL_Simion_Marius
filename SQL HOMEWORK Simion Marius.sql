--1 Create a database
--CREATE DATABASE SQL_Homework_Simion_Marius;

--2 Create a table called Director with following columns: FirstName, LastName, Nationality and Birth date. Insert 5 rows into it.
--CREATE TABLE Director(DirectorId int IDENTITY(1,1) PRIMARY KEY, FirstName nvarchar(MAX), LastName varchar(MAX),Nationality varchar(MAX), BirthDate date);
--INSERT INTO Director VALUES('Liviu','Ciulei', 'Romanian', '1923-07-07');
--INSERT INTO Director VALUES('Sergiu','Nicolaescu', 'Romanian', '1930-04-13');
--INSERT INTO Director VALUES('Cristian','Mungiu', 'Romanian', '1968-04-27');
--INSERT INTO Director VALUES('Corneliu','Porumboiu', 'Romanian', '1975-09-14');
--INSERT INTO Director VALUES('Cristian','Nemescu', 'Romanian', '1979-03-31');
--SELECT * FROM Director

--3 Delete the director with id = 3
--DELETE FROM Director WHERE DirectorId=3;
--SELECT * FROM Director


--4 Create a table called Movie with following columns: DirectorId, Title, ReleaseDate, Rating and Duration. Each movie has a director. Insert some rows into it
--CREATE TABLE Movie(
--Id int IDENTITY(1,1) PRIMARY KEY,
--DirectorId int CONSTRAINT fk_DirectorId REFERENCES Director(DirectorId),
--Title varchar(MAX),
--ReleaseDate date,
--Rating int CHECK(Rating>=0 AND Rating<=10),
--Duration int
--);
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--2,'Nea Mãrin Miliardar', '1979-06-26',9,88);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--2,'Nemuritorii', '1974-08-26',8,101);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--1,'Padurea Spanzuratilor', '1965-04-26',9,158);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--1,'Dimitrie Cantemir', '1973-09-16',8,73);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--4,'Film 1', '2007-09-14',8,110);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--4,'Film 2', '2016-05-20',8,113);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--4,'Film 3', '2016-05-26',9,100);
--
--INSERT INTO Movie (DirectorId, Title, ReleaseDate, Rating, Duration) VALUES (
--4,'Film 4', '2016-05-21',8,90);
--SELECT * FROM Movie

--5 Update all movies that have a rating lower than 10.
--UPDATE Movie SET Title='UpdatedTitle' WHERE Rating<10;
--SELECT *  FROM Movie;

--6 Create a table called Actor with following columns: FirstName, LastName, Nationality, Birth date and PopularityRating. Insert some rows into it.
--CREATE TABLE Actor(
--ActorID int Identity(1,1) PRIMARY KEY,
--FirstName varchar(MAX) NOT NULL,
--LastName varchar(MAX) NOT NULL,
--Nationality varchar(MAX),
--BirthDate date,
--PopularityRating int
--);
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'Amza', 'Pellea', 'romanian', '1931-04-07', 8);
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'Jean', 'Constantin', 'romanian', '1927-08-21', 9);
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'Toma', 'Caragiu', 'romanian', '1925-08-21', 9);	
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'Ion', 'Caramitru', 'romanian', '1942-03-09', 8);	
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'George', 'Dinica', 'romanian', '1934-01-01', 9);	
--INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating) VALUES(
--	'Mircea', 'Albulescu', 'romanian', '1934-10-04', 9);	
--SELECT *  FROM Actor;


--7 Which is the movie with the lowest rating?
--SELECT CONCAT('Id=',DirectorId, 'Title=', Title, 'Rating=', Rating ) AS MovieInfo FROM Movie WHERE Rating=(SELECT MIN(Rating) FROM Movie);

--8 Which director has the most movies directed?
--SELECT DirectorId, COUNT (DirectorId) AS DirectedMovies FROM Movie 
--	GROUP BY DirectorId HAVING COUNT(DirectorId)>=ALL(SELECT COUNT (DirectorId) FROM Movie GROUP BY DirectorId);

--9 Display all movies ordered by director's LastName inascending order, then by birth date descending. 
--SELECT * FROM Movie m INNER JOIN Director d ON m.DirectorId=d.DirectorId
--	ORDER BY d.LastName ASC, d.BirthDate DESC

--12 Create a stored procedure that will increment the rating by 1 for a given movie id.
--CREATE PROCEDURE [dbo.spIncrementMovieRating]
--@Id int AS
--BEGIN TRANSACTION
--UPDATE Movie SET Rating=Rating+1 WHERE MovieId=@Id
--COMMIT TRANSACTION
--
--
--EXEC[dbo.spIncrementMovieRating] @Id=1
--SELECT * FROM Movie WHERE MovieId=1


--15 Implement many to many relationship between Movie and Actor
--CREATE TABLE MovieActor (
--MovieId int CONSTRAINT fk_movie REFERENCES Movie(MovieId),
--ActorID int CONSTRAINT fk_actor REFERENCES Actor(ActorId)
--);
--INSERT INTO MovieActor(MovieId, ActorId) VALUES (1,5);
--INSERT INTO MovieActor(MovieId, ActorId) VALUES (2,4);
--INSERT INTO MovieActor(MovieId, ActorId) VALUES (4,4);
--INSERT INTO MovieActor(MovieId, ActorId) VALUES (5,4);
--SELECT * FROM MovieActor

--16 Implement many to many relationship between Movie and Genre
--CREATE TABLE Genre (
--Id int IDENTITY (1,1) PRIMARY KEY, 
--Name varchar(MAX) NOT NULL
--);
--
--CREATE TABLE MovieGenre (
--MovieId int CONSTRAINT fk_movieId REFERENCES Movie(MovieId),
--GenreId int CONSTRAINT fk_genreId REFERENCES Genre(Id)
--);
--
--INSERT INTO Genre(Name) VALUES('Comedy');
--INSERT INTO Genre(Name) VALUES('Drama');
--SELECT * FROM Genre;
--
--INSERT INTO MovieGenre(MovieId, GenreId) VALUES(1,1)
--INSERT INTO MovieGenre(MovieId, GenreId) VALUES(2,2)
--INSERT INTO MovieGenre(MovieId, GenreId) VALUES(3,2)
--INSERT INTO MovieGenre(MovieId, GenreId) VALUES(4,1)
--SELECT * FROM MovieGenre;


--17 Which actor has worked with the most distinct movie directors?
--SELECT a.ActorID, COUNT(d.DirectorId) AS DirNumber 
--FROM Actor a 
--INNER JOIN MovieActor ma ON  a.ActorID=ma.ActorID
--INNER JOIN Movie m ON ma.MovieId=m.MovieId
--INNER JOIN Director d ON m.DirectorId=d.DirectorId
--GROUP BY a.ActorID HAVING MAX(d.DirectorId)>=(SELECT COUNT(d.DirectorId) AS DirNumber
--FROM Actor a
--INNER JOIN MovieActor ma ON  a.ActorID=ma.ActorID
--INNER JOIN Movie m ON ma.MovieId=m.MovieId
--INNER JOIN Director d ON m.DirectorId=d.DirectorId);

--18 Which is the preferred genre of each actor?
--SELECT a.FirstName, a.LastName,g.Name
--FROM Actor a 
--INNER JOIN MovieActor ma ON a.ActorID=ma.ActorId 
--INNER JOIN Movie m ON ma.MovieId =m.MovieId 
--INNER JOIN MovieGenre mg ON m.MovieId=mg.MovieId 
--INNER JOIN Genre g ON mg.GenreId=g.Id;



