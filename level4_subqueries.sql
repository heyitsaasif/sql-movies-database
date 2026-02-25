-- ============================================================
-- LEVEL 4: SUBQUERIES
-- Topics: Nested queries, IN, NOT IN, EXISTS, correlated subqueries
-- ============================================================
-- Prerequisites: Run setup.sql first
-- USE movies_db;
-- ============================================================

-- ----------------------------------------------------------------
-- QUESTION 1
-- Find all movies with a rating HIGHER than the average
-- rating of all movies.
-- Show the title and rating, sorted highest rating first.
-- ----------------------------------------------------------------
SELECT
    title,
    rating
FROM movies
WHERE rating >
(SELECT AVG(rating)
FROM movies)
ORDER BY rating DESC;


-- ----------------------------------------------------------------
-- QUESTION 2
-- Find all actors who appeared in movies that grossed MORE
-- than $1 billion at the box office.
-- Show each actor's name and the movie title.
-- Use a subquery with IN.
-- ----------------------------------------------------------------
SELECT
    a.name,
    m.title
FROM actors a
INNER JOIN movie_cast mc
ON a.actor_id = mc.actor_id
INNER JOIN movies m
ON mc.movie_id = m.movie_id
WHERE m.movie_id IN (SELECT movie_id
FROM movies
WHERE box_office_million > 1000);


-- ----------------------------------------------------------------
-- QUESTION 3
-- Find all directors who have directed at least one movie
-- rated 9.0 or above.
-- Show only the director's name.
-- Use a subquery with IN.
-- ----------------------------------------------------------------
SELECT DISTINCT d.name
FROM directors d
INNER JOIN movies m
ON d.director_id = m.director_id
WHERE d.director_id IN (SELECT director_id
FROM movies
WHERE rating >= 9);


-- ----------------------------------------------------------------
-- QUESTION 4
-- Find all movies that have received at least one review with
-- a perfect rating of 10.0.
-- Show the movie title.
-- ----------------------------------------------------------------
SELECT title
FROM movies
WHERE movie_id IN (SELECT movie_id
FROM reviews
WHERE rating = 10);


-- ----------------------------------------------------------------
-- QUESTION 5
-- Find all actors in our actors table who have NOT appeared
-- in any movie in the movie_cast table.
-- Show the actor name and nationality.
-- Use NOT IN or NOT EXISTS.
-- ----------------------------------------------------------------
SELECT
    name,
    nationality
FROM actors
WHERE actor_id NOT IN (SELECT DISTINCT actor_id
FROM movie_cast);


-- ----------------------------------------------------------------
-- QUESTION 6
-- Find all movies that are in the SAME genre as 'The Godfather',
-- but are NOT 'The Godfather' itself.
-- Show the title, release year, and rating, sorted by rating desc.
-- ----------------------------------------------------------------
SELECT
    title,
    release_year,
    rating
FROM movies
WHERE genre =
     (SELECT genre
FROM movies
WHERE title = 'The Godfather')
AND title != 'The Godfather'
ORDER BY rating DESC;


-- ----------------------------------------------------------------
-- QUESTION 7
-- Find the director of the single highest-grossing movie
-- in the database. Show the director's name, the movie title,
-- and the box office revenue.
-- ----------------------------------------------------------------
SELECT
    d.name,
    m.title,
    m.box_office_million
FROM directors d
INNER JOIN movies m
ON d.director_id = m.director_id
WHERE m.box_office_million =
(SELECT
    MAX(box_office_million) AS highest_grossing_film
FROM movies);


-- ----------------------------------------------------------------
-- QUESTION 8
-- Find all movies released AFTER 'Inception' (2010).
-- Show the title and release year, sorted by release year.
-- Use a subquery to find Inception's release year.
-- ----------------------------------------------------------------
SELECT
    title,
    release_year
FROM movies
WHERE release_year > (SELECT release_year
FROM movies
WHERE title = 'Inception')
ORDER BY release_year DESC;


-- ----------------------------------------------------------------
-- QUESTION 9
-- Find all actors who have appeared in a movie directed by
-- Christopher Nolan. Show the actor name.
-- Use subqueries (no explicit JOIN required, but it's fine if you do).
-- ----------------------------------------------------------------
SELECT name
FROM actors
WHERE actor_id IN (SELECT actor_id
FROM movie_cast
WHERE movie_id IN (SELECT movie_id
FROM movies
WHERE director_id IN (SELECT director_id
FROM directors
WHERE name = 'Christopher Nolan')));


-- ----------------------------------------------------------------
-- QUESTION 10
-- Find movies that earned MORE than the average box office
-- revenue FOR THEIR GENRE.
-- Show the title, genre, box_office_million, and the genre's
-- average box office (rounded to 2 decimal places).
-- Sort by genre, then box office descending.
-- Hint: Use a subquery in the FROM clause (a derived table).
-- ----------------------------------------------------------------
SELECT
    m.title,
    m.genre,
    m.box_office_million,
    ga.avg_box_office_million
FROM movies m
INNER JOIN (SELECT genre, ROUND(AVG(box_office_million), 2) AS avg_box_office_million
FROM movies
GROUP BY genre) AS ga
ON m.genre = ga.genre
WHERE m.box_office_million > ga.avg_box_office_million
ORDER BY m.box_office_million DESC;
