-- ============================================================
-- LEVEL 4 ANSWERS: SUBQUERIES
-- ============================================================

USE movies_db;

-- ----------------------------------------------------------------
-- ANSWER 1
-- Movies with a rating higher than the overall average rating.
-- ----------------------------------------------------------------
SELECT title, rating
FROM movies
WHERE rating > (SELECT AVG(rating) FROM movies)
ORDER BY rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 2
-- Actors who appeared in movies that grossed over $1 billion.
-- ----------------------------------------------------------------
SELECT DISTINCT a.name  AS actor_name,
                m.title AS movie_title,
                m.box_office_million
FROM actors a
JOIN movie_cast mc ON a.actor_id  = mc.actor_id
JOIN movies m      ON mc.movie_id = m.movie_id
WHERE m.movie_id IN (
    SELECT movie_id
    FROM movies
    WHERE box_office_million > 1000
)
ORDER BY m.box_office_million DESC, a.name;

-- ----------------------------------------------------------------
-- ANSWER 3
-- Directors who have directed at least one movie rated 9.0+.
-- ----------------------------------------------------------------
SELECT DISTINCT d.name AS director_name
FROM directors d
WHERE d.director_id IN (
    SELECT director_id
    FROM movies
    WHERE rating >= 9.0
)
ORDER BY d.name;

-- ----------------------------------------------------------------
-- ANSWER 4
-- Movies that received at least one review rated 10.0.
-- ----------------------------------------------------------------
SELECT DISTINCT m.title
FROM movies m
WHERE m.movie_id IN (
    SELECT movie_id
    FROM reviews
    WHERE rating = 10.0
)
ORDER BY m.title;

-- ----------------------------------------------------------------
-- ANSWER 5
-- Actors who have NOT appeared in any movie in our database.
-- ----------------------------------------------------------------
SELECT name, nationality
FROM actors
WHERE actor_id NOT IN (
    SELECT DISTINCT actor_id
    FROM movie_cast
)
ORDER BY name;

-- ----------------------------------------------------------------
-- ANSWER 6
-- Movies in the same genre as 'The Godfather' (Crime),
-- excluding The Godfather itself.
-- ----------------------------------------------------------------
SELECT title, release_year, rating
FROM movies
WHERE genre = (
    SELECT genre
    FROM movies
    WHERE title = 'The Godfather'
)
  AND title <> 'The Godfather'
ORDER BY rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 7
-- The director of the single highest-grossing movie.
-- ----------------------------------------------------------------
SELECT d.name              AS director_name,
       m.title             AS movie_title,
       m.box_office_million
FROM directors d
JOIN movies m ON d.director_id = m.director_id
WHERE m.box_office_million = (
    SELECT MAX(box_office_million)
    FROM movies
);

-- ----------------------------------------------------------------
-- ANSWER 8
-- Movies released after Inception (2010).
-- ----------------------------------------------------------------
SELECT title, release_year
FROM movies
WHERE release_year > (
    SELECT release_year
    FROM movies
    WHERE title = 'Inception'
)
ORDER BY release_year, title;

-- ----------------------------------------------------------------
-- ANSWER 9
-- Actors who appeared in a Christopher Nolan film.
-- ----------------------------------------------------------------
SELECT DISTINCT a.name AS actor_name
FROM actors a
WHERE a.actor_id IN (
    SELECT mc.actor_id
    FROM movie_cast mc
    WHERE mc.movie_id IN (
        SELECT m.movie_id
        FROM movies m
        WHERE m.director_id = (
            SELECT director_id
            FROM directors
            WHERE name = 'Christopher Nolan'
        )
    )
)
ORDER BY a.name;

-- ----------------------------------------------------------------
-- ANSWER 10
-- Movies that earned more than the average for their genre.
-- ----------------------------------------------------------------
SELECT m.title,
       m.genre,
       m.box_office_million,
       ROUND(genre_avg.avg_box_office, 2) AS genre_avg_box_office
FROM movies m
JOIN (
    SELECT genre,
           AVG(box_office_million) AS avg_box_office
    FROM movies
    GROUP BY genre
) AS genre_avg ON m.genre = genre_avg.genre
WHERE m.box_office_million > genre_avg.avg_box_office
ORDER BY m.genre, m.box_office_million DESC;
