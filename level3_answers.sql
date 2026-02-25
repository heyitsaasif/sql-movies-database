-- ============================================================
-- LEVEL 3 ANSWERS: JOINS
-- ============================================================

USE movies_db;

-- ----------------------------------------------------------------
-- ANSWER 1
-- All movies with their director name and country.
-- ----------------------------------------------------------------
SELECT m.title,
       d.name    AS director_name,
       d.country
FROM movies m
INNER JOIN directors d ON m.director_id = d.director_id
ORDER BY m.title;

-- ----------------------------------------------------------------
-- ANSWER 2
-- Movies where the director is from Canada.
-- ----------------------------------------------------------------
SELECT m.title,
       d.name AS director_name
FROM movies m
INNER JOIN directors d ON m.director_id = d.director_id
WHERE d.country = 'Canada'
ORDER BY m.title;

-- ----------------------------------------------------------------
-- ANSWER 3
-- Every actor alongside the movies they appeared in.
-- ----------------------------------------------------------------
SELECT a.name            AS actor_name,
       m.title           AS movie_title,
       mc.character_name,
       mc.role_type
FROM actors a
INNER JOIN movie_cast mc ON a.actor_id  = mc.actor_id
INNER JOIN movies m      ON mc.movie_id = m.movie_id
ORDER BY a.name, m.title;

-- ----------------------------------------------------------------
-- ANSWER 4
-- Actors who played LEAD roles.
-- ----------------------------------------------------------------
SELECT a.name            AS actor_name,
       m.title           AS movie_title,
       mc.character_name
FROM actors a
INNER JOIN movie_cast mc ON a.actor_id  = mc.actor_id
INNER JOIN movies m      ON mc.movie_id = m.movie_id
WHERE mc.role_type = 'lead'
ORDER BY a.name;

-- ----------------------------------------------------------------
-- ANSWER 5
-- Each movie with its average review rating and review count.
-- Includes movies with no reviews (LEFT JOIN).
-- ----------------------------------------------------------------
SELECT m.title,
       ROUND(AVG(r.rating), 2) AS avg_review_rating,
       COUNT(r.review_id)      AS review_count
FROM movies m
LEFT JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY avg_review_rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 6
-- Directors who have worked in more than one genre.
-- ----------------------------------------------------------------
SELECT d.name                                                AS director_name,
       COUNT(DISTINCT m.genre)                              AS genre_count,
       GROUP_CONCAT(DISTINCT m.genre ORDER BY m.genre)      AS genres
FROM directors d
INNER JOIN movies m ON d.director_id = m.director_id
GROUP BY d.director_id, d.name
HAVING COUNT(DISTINCT m.genre) > 1
ORDER BY genre_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 7
-- Movies directed by directors born before 1950.
-- ----------------------------------------------------------------
SELECT m.title,
       m.release_year,
       d.name       AS director_name,
       d.birth_year AS director_birth_year
FROM movies m
INNER JOIN directors d ON m.director_id = d.director_id
WHERE d.birth_year < 1950
ORDER BY d.birth_year, m.title;

-- ----------------------------------------------------------------
-- ANSWER 8
-- Actors who have appeared in more than one movie.
-- ----------------------------------------------------------------
SELECT a.name            AS actor_name,
       COUNT(mc.movie_id) AS movie_count
FROM actors a
INNER JOIN movie_cast mc ON a.actor_id = mc.actor_id
GROUP BY a.actor_id, a.name
HAVING COUNT(mc.movie_id) > 1
ORDER BY movie_count DESC;

-- ----------------------------------------------------------------
-- ANSWER 9
-- All reviews with movie title, reviewer name, rating, and date.
-- ----------------------------------------------------------------
SELECT r.reviewer_name,
       m.title       AS movie_title,
       r.rating      AS review_rating,
       r.review_date
FROM reviews r
INNER JOIN movies m ON r.movie_id = m.movie_id
ORDER BY r.review_date DESC;

-- ----------------------------------------------------------------
-- ANSWER 10
-- Movies that have received NO reviews.
-- ----------------------------------------------------------------
SELECT m.title, m.release_year, m.genre
FROM movies m
LEFT JOIN reviews r ON m.movie_id = r.movie_id
WHERE r.review_id IS NULL
ORDER BY m.title;
