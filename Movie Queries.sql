SELECT * 
FROM movies


SELECT * 
FROM movies
where year not between 2000 and 2010

SELECT title, year FROM movies
WHERE year <= 2003;

--Find all Toy Story movies

SELECT * 
FROM movies
where title like 'Toy%';

--Find all the movies directed by John Lasseter

SELECT * 
FROM movies
where director like 'John%';


--Find all the movies (and director) not directed by John Lasseter

SELECT * 
FROM movies
where director not like 'John%';



--Find all the WALL-* movies

SELECT * 
FROM movies
where title like 'WALL-%';

--List all directors of Pixar movies (alphabetically), without duplicates

SELECT DISTINCT director 
FROM movies
ORDER BY director ASC;

--List the last four Pixar movies released (ordered from most recent to least)
SELECT * 
FROM movies
ORDER BY year desc
limit 4 ;

--List the first five Pixar movies sorted alphabetically
SELECT * 
FROM movies
ORDER BY title asc
limit 5 ;

--List the next five Pixar movies sorted alphabetically

SELECT title FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;




