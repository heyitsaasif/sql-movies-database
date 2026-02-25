-- ============================================================
-- LEVEL 1: SQL BASICS
-- Topics: SELECT, WHERE, ORDER BY, LIMIT
-- ============================================================
-- Prerequisites: Run setup.sql first
-- USE movies_db;
-- ============================================================

-- ----------------------------------------------------------------
-- QUESTION 1
-- List the title and release year of every movie in the database.
-- ----------------------------------------------------------------
SELECT title, release_year
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 2
-- Find all movies with a rating above 8.5.
-- Show the title and rating.
-- ----------------------------------------------------------------
SELECT title, rating
FROM movies
WHERE rating > 8.5;


-- ----------------------------------------------------------------
-- QUESTION 3
-- List all directors who are from the United States.
-- Show their name and country.
-- ----------------------------------------------------------------
SELECT name, country
FROM directors
WHERE country = "United States";


-- ----------------------------------------------------------------
-- QUESTION 4
-- Find all movies released between the years 2000 and 2009 (inclusive).
-- Show the title and release year.
-- ----------------------------------------------------------------
SELECT title, release_year
FROM movies
WHERE release_year BETWEEN 2000 AND 2009;


-- ----------------------------------------------------------------
-- QUESTION 5
-- Show the top 10 highest-grossing movies of all time.
-- Show the title and box_office_million, sorted highest first.
-- ----------------------------------------------------------------
SELECT title, box_office_million
FROM movies
ORDER BY box_office_million DESC
LIMIT 10;


-- ----------------------------------------------------------------
-- QUESTION 6
-- List all Sci-Fi movies.
-- Show the title, release year, and rating.
-- ----------------------------------------------------------------
SELECT title, release_year, rating
FROM movies
WHERE genre = 'Sci-fi';


-- ----------------------------------------------------------------
-- QUESTION 7
-- Find all actors born after 1980.
-- Show their name, nationality, and birth year.
-- ----------------------------------------------------------------
SELECT name, nationality, birth_year
FROM actors
WHERE birth_year > 1980;


-- ----------------------------------------------------------------
-- QUESTION 8
-- Find all movies that have earned more than $500 million at
-- the box office. Show the title and box_office_million,
-- sorted from highest to lowest.
-- ----------------------------------------------------------------
SELECT title, box_office_million
FROM movies
WHERE box_office_million > 500
ORDER BY box_office_million DESC;


-- ----------------------------------------------------------------
-- QUESTION 9
-- List every movie in alphabetical order (A to Z).
-- Show the title, genre, and release year.
-- ----------------------------------------------------------------
SELECT title, genre, release_year
FROM movies
ORDER BY title ASC;


-- ----------------------------------------------------------------
-- QUESTION 10
-- Find all movies from the 1990s (1990-1999).
-- Show the title, release year, and rating.
-- Sort by rating from highest to lowest.
-- ----------------------------------------------------------------
SELECT title, release_year, rating
FROM movies
WHERE release_year BETWEEN 1990 AND 1999
ORDER BY rating DESC;
