-- ============================================================
-- LEVEL 2: AGGREGATE FUNCTIONS
-- Topics: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
-- ============================================================
-- Prerequisites: Run setup.sql first, then level 1 exercises
-- USE movies_db;
-- ============================================================

-- ----------------------------------------------------------------
-- QUESTION 1
-- How many movies are in each genre?
-- Show genre and movie_count, sorted by movie_count (highest first).
-- ----------------------------------------------------------------
SELECT genre, COUNT(title) AS movie_count
FROM movies
GROUP BY genre
ORDER BY movie_count DESC;


-- ----------------------------------------------------------------
-- QUESTION 2
-- What is the average rating of all movies in the database?
-- Round the result to 2 decimal places.
-- ----------------------------------------------------------------
SELECT ROUND(AVG(rating), 2) AS avg_rating
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 3
-- What is the total box office revenue for each genre?
-- Show genre and total_box_office (rounded to 2 decimal places),
-- sorted highest first.
-- ----------------------------------------------------------------
SELECT genre, ROUND(SUM(box_office_million), 2) AS total_box_office_earnings
FROM movies
GROUP BY genre
ORDER BY total_box_office_earnings DESC;


-- ----------------------------------------------------------------
-- QUESTION 4
-- Which genres have MORE than 3 movies?
-- Show the genre and movie_count, sorted highest first.
-- Hint: You'll need HAVING for this one.
-- ----------------------------------------------------------------
SELECT genre, COUNT(title) AS movie_count
FROM movies
GROUP BY genre
HAVING movie_count > 3
ORDER BY movie_count DESC;


-- ----------------------------------------------------------------
-- QUESTION 5
-- What is the average rating for movies directed by each director?
-- Show the director's name, their average rating (rounded to 2
-- decimal places), and how many movies they have directed.
-- Sort by average rating, highest first.
-- Hint: You need to JOIN the directors table.
-- ----------------------------------------------------------------
SELECT d.name, ROUND(AVG(m.rating), 2) AS avg_rating, COUNT(m.title) AS movie_count
FROM movies m
LEFT JOIN directors d
ON m.director_id = d.director_id
GROUP BY d.name
ORDER BY avg_rating DESC;


-- ----------------------------------------------------------------
-- QUESTION 6
-- How many actors are from each nationality?
-- Show nationality and actor_count, sorted highest first.
-- ----------------------------------------------------------------
SELECT nationality, COUNT(actor_id) AS actor_count
FROM actors
GROUP BY nationality
ORDER BY actor_count DESC;


-- ----------------------------------------------------------------
-- QUESTION 7
-- For each genre, show the highest and lowest rated movie
-- (the rating values, not the movie names).
-- Show genre, highest_rating, and lowest_rating.
-- ----------------------------------------------------------------
SELECT genre, MAX(rating) AS high_rated, MIN(rating) AS min_rated
FROM movies
GROUP BY genre;


-- ----------------------------------------------------------------
-- QUESTION 8
-- How many movies were released each decade?
-- (1960s, 1970s, 1980s, etc.)
-- Show decade and movie_count, sorted by decade.
-- Hint: FLOOR(release_year / 10) * 10 gives you the decade.
-- ----------------------------------------------------------------
SELECT FLOOR(release_year / 10) * 10 AS decade, COUNT(movie_id) AS movie_count
FROM movies
GROUP BY decade;


-- ----------------------------------------------------------------
-- QUESTION 9
-- Which directors have directed MORE than 3 movies in our database?
-- Show the director's name and how many movies they've directed,
-- sorted from most to fewest.
-- Hint: JOIN + GROUP BY + HAVING.
-- ----------------------------------------------------------------
SELECT d.name, COUNT(m.movie_id) AS movie_count
FROM movies m
INNER JOIN directors d
ON m.director_id = d.director_id
GROUP BY d.name
HAVING movie_count > 3
ORDER BY movie_count DESC;


-- ----------------------------------------------------------------
-- QUESTION 10
-- What is the average box office revenue (in millions) for movies
-- released each decade?
-- Show decade and avg_box_office (rounded to 2 decimal places),
-- sorted by decade.
-- ----------------------------------------------------------------
SELECT FLOOR(release_year / 10) * 10 AS decade, ROUND(AVG(box_office_million), 2) AS avg_revenue
FROM movies
GROUP BY decade
ORDER BY decade;
