-- ============================================================
-- LEVEL 5 ANSWERS: WINDOW FUNCTIONS
-- Requires MySQL 8.0+
-- ============================================================

USE movies_db;

-- ----------------------------------------------------------------
-- ANSWER 1
-- Rank all movies by box office revenue (highest first).
-- Ties share the same rank.
-- ----------------------------------------------------------------
SELECT title,
       box_office_million,
       RANK() OVER (ORDER BY box_office_million DESC) AS box_office_rank
FROM movies
ORDER BY box_office_rank;

-- ----------------------------------------------------------------
-- ANSWER 2
-- For each genre, rank movies by their rating (highest first).
-- Each genre restarts at rank 1.
-- ----------------------------------------------------------------
SELECT genre,
       title,
       rating,
       RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS genre_rank
FROM movies
ORDER BY genre, genre_rank;

-- ----------------------------------------------------------------
-- ANSWER 3
-- Running total of box office revenue, ordered by release year.
-- ----------------------------------------------------------------
SELECT title,
       release_year,
       box_office_million,
       ROUND(
           SUM(box_office_million) OVER (
               ORDER BY release_year, movie_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ), 2
       ) AS running_total
FROM movies
ORDER BY release_year, movie_id;

-- ----------------------------------------------------------------
-- ANSWER 4
-- Each movie's rating vs. the average rating for its genre,
-- plus the difference.
-- ----------------------------------------------------------------
SELECT title,
       genre,
       rating,
       ROUND(AVG(rating) OVER (PARTITION BY genre), 2)              AS genre_avg_rating,
       ROUND(rating - AVG(rating) OVER (PARTITION BY genre), 2)     AS diff_from_genre_avg
FROM movies
ORDER BY genre, rating DESC;

-- ----------------------------------------------------------------
-- ANSWER 5
-- Rank directors by total box office revenue.
-- ----------------------------------------------------------------
SELECT d.name                              AS director_name,
       ROUND(SUM(m.box_office_million), 2) AS total_box_office,
       RANK() OVER (ORDER BY SUM(m.box_office_million) DESC) AS revenue_rank
FROM directors d
JOIN movies m ON d.director_id = m.director_id
GROUP BY d.director_id, d.name
ORDER BY total_box_office DESC;

-- ----------------------------------------------------------------
-- ANSWER 6
-- For each movie, show the previous movie released in the same
-- genre using LAG().
-- ----------------------------------------------------------------
SELECT title,
       genre,
       release_year,
       box_office_million,
       LAG(title) OVER (
           PARTITION BY genre
           ORDER BY release_year, movie_id
       ) AS previous_movie_in_genre
FROM movies
ORDER BY genre, release_year;

-- ----------------------------------------------------------------
-- ANSWER 7
-- Top 3 rated movies per genre (ties share the same rank).
-- ----------------------------------------------------------------
SELECT title, genre, rating, genre_rank
FROM (
    SELECT title,
           genre,
           rating,
           RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS genre_rank
    FROM movies
) ranked
WHERE genre_rank <= 3
ORDER BY genre, genre_rank;

-- ----------------------------------------------------------------
-- ANSWER 8
-- Genre total box office and percentage of overall total.
-- ----------------------------------------------------------------
SELECT genre,
       ROUND(SUM(box_office_million), 2)                               AS genre_total,
       ROUND(
           SUM(box_office_million) * 100.0
           / SUM(SUM(box_office_million)) OVER (),
           2
       )                                                               AS pct_of_total
FROM movies
GROUP BY genre
ORDER BY genre_total DESC;

-- ----------------------------------------------------------------
-- ANSWER 9
-- For each movie, the title and box office of the highest-grossing
-- movie in the same genre using FIRST_VALUE().
-- ----------------------------------------------------------------
SELECT DISTINCT
       genre,
       title,
       box_office_million,
       FIRST_VALUE(title) OVER (
           PARTITION BY genre
           ORDER BY box_office_million DESC
       ) AS top_movie_in_genre,
       FIRST_VALUE(box_office_million) OVER (
           PARTITION BY genre
           ORDER BY box_office_million DESC
       ) AS top_genre_box_office
FROM movies
ORDER BY genre, box_office_million DESC;

-- ----------------------------------------------------------------
-- ANSWER 10
-- Previous movie's rating and rating change within each genre
-- (ordered by release year), using LAG().
-- ----------------------------------------------------------------
SELECT title,
       genre,
       release_year,
       rating,
       LAG(rating) OVER (
           PARTITION BY genre
           ORDER BY release_year, movie_id
       )                                                               AS prev_movie_rating,
       ROUND(
           rating - LAG(rating) OVER (
               PARTITION BY genre
               ORDER BY release_year, movie_id
           ),
           1
       )                                                               AS rating_change
FROM movies
ORDER BY genre, release_year;
