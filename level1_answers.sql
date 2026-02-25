-- ============================================================
-- LEVEL 1 ANSWERS: SQL BASICS
-- ============================================================

USE movies_db;

-- ----------------------------------------------------------------
-- ANSWER 1
-- List the title and release year of every movie in the database.
-- ----------------------------------------------------------------
SELECT title, release_year
FROM movies;

-- ----------------------------------------------------------------
-- ANSWER 2
-- Find all movies with a rating above 8.5.
-- ----------------------------------------------------------------
SELECT title, rating
FROM movies
WHERE rating > 8.5
ORDER BY rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 3
-- List all directors who are from the United States.
-- ----------------------------------------------------------------
SELECT name, country
FROM directors
WHERE country = 'United States';

-- ----------------------------------------------------------------
-- ANSWER 4
-- Find all movies released between 2000 and 2009 (inclusive).
-- ----------------------------------------------------------------
SELECT title, release_year
FROM movies
WHERE release_year BETWEEN 2000 AND 2009
ORDER BY release_year;

-- ----------------------------------------------------------------
-- ANSWER 5
-- Show the top 10 highest-grossing movies of all time.
-- ----------------------------------------------------------------
SELECT title, box_office_million
FROM movies
ORDER BY box_office_million DESC
LIMIT 10;

-- ----------------------------------------------------------------
-- ANSWER 6
-- List all Sci-Fi movies.
-- ----------------------------------------------------------------
SELECT title, release_year, rating
FROM movies
WHERE genre = 'Sci-Fi'
ORDER BY rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 7
-- Find all actors born after 1980.
-- ----------------------------------------------------------------
SELECT name, nationality, birth_year
FROM actors
WHERE birth_year > 1980
ORDER BY birth_year;

-- ----------------------------------------------------------------
-- ANSWER 8
-- Find all movies that have earned more than $500 million.
-- ----------------------------------------------------------------
SELECT title, box_office_million
FROM movies
WHERE box_office_million > 500
ORDER BY box_office_million DESC;

-- ----------------------------------------------------------------
-- ANSWER 9
-- List every movie in alphabetical order.
-- ----------------------------------------------------------------
SELECT title, genre, release_year
FROM movies
ORDER BY title ASC;

-- ----------------------------------------------------------------
-- ANSWER 10
-- Find all movies from the 1990s, sorted by rating highest first.
-- ----------------------------------------------------------------
SELECT title, release_year, rating
FROM movies
WHERE release_year BETWEEN 1990 AND 1999
ORDER BY rating DESC;
