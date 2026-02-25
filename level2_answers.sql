-- ============================================================
-- LEVEL 2 ANSWERS: AGGREGATE FUNCTIONS
-- ============================================================

USE movies_db;

-- ----------------------------------------------------------------
-- ANSWER 1
-- How many movies are in each genre?
-- ----------------------------------------------------------------
SELECT genre, COUNT(*) AS movie_count
FROM movies
GROUP BY genre
ORDER BY movie_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 2
-- What is the average rating of all movies?
-- ----------------------------------------------------------------
SELECT ROUND(AVG(rating), 2) AS average_rating
FROM movies;

-- ----------------------------------------------------------------
-- ANSWER 3
-- What is the total box office revenue for each genre?
-- ----------------------------------------------------------------
SELECT genre,
       ROUND(SUM(box_office_million), 2) AS total_box_office
FROM movies
GROUP BY genre
ORDER BY total_box_office DESC;

-- ----------------------------------------------------------------
-- ANSWER 4
-- Which genres have more than 3 movies?
-- ----------------------------------------------------------------
SELECT genre, COUNT(*) AS movie_count
FROM movies
GROUP BY genre
HAVING COUNT(*) > 3
ORDER BY movie_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 5
-- Average rating per director (with movie count).
-- ----------------------------------------------------------------
SELECT d.name                      AS director_name,
       ROUND(AVG(m.rating), 2)     AS avg_rating,
       COUNT(m.movie_id)           AS movies_directed
FROM movies m
JOIN directors d ON m.director_id = d.director_id
GROUP BY d.director_id, d.name
ORDER BY avg_rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 6
-- How many actors are from each nationality?
-- ----------------------------------------------------------------
SELECT nationality, COUNT(*) AS actor_count
FROM actors
GROUP BY nationality
ORDER BY actor_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 7
-- For each genre, the highest and lowest rated movie (the ratings).
-- ----------------------------------------------------------------
SELECT genre,
       MAX(rating) AS highest_rating,
       MIN(rating) AS lowest_rating
FROM movies
GROUP BY genre
ORDER BY genre;

-- ----------------------------------------------------------------
-- ANSWER 8
-- How many movies were released each decade?
-- ----------------------------------------------------------------
SELECT FLOOR(release_year / 10) * 10 AS decade,
       COUNT(*)                        AS movie_count
FROM movies
GROUP BY decade
ORDER BY decade;

-- ----------------------------------------------------------------
-- ANSWER 9
-- Directors who have directed more than 3 movies.
-- ----------------------------------------------------------------
SELECT d.name          AS director_name,
       COUNT(m.movie_id) AS movies_count
FROM movies m
JOIN directors d ON m.director_id = d.director_id
GROUP BY d.director_id, d.name
HAVING COUNT(m.movie_id) > 3
ORDER BY movies_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 10
-- Average box office revenue per decade.
-- ----------------------------------------------------------------
SELECT FLOOR(release_year / 10) * 10  AS decade,
       ROUND(AVG(box_office_million), 2) AS avg_box_office_million
FROM movies
GROUP BY decade
ORDER BY decade;
