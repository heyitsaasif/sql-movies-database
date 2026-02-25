-- ============================================================
-- LEVEL 5: WINDOW FUNCTIONS
-- Topics: RANK, DENSE_RANK, ROW_NUMBER, LAG, LEAD,
--         FIRST_VALUE, SUM OVER, AVG OVER
-- ============================================================
-- Prerequisites: Run setup.sql first | MySQL 8.0+ required
-- USE movies_db;
-- ============================================================

-- ----------------------------------------------------------------
-- QUESTION 1
-- Rank ALL movies by box office revenue, highest first.
-- Show the title, box_office_million, and the rank.
-- (Movies with the same revenue should share a rank.)
-- ----------------------------------------------------------------
SELECT
    title,
    box_office_million,
    RANK() OVER (ORDER BY box_office_million DESC) AS ranks
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 2
-- For each genre, rank movies by their rating (highest first).
-- Show the genre, title, rating, and the rank within the genre.
-- (Each genre restarts at rank 1.)
-- ----------------------------------------------------------------
SELECT
    genre,
    title,
    rating,
    RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS ranks
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 3
-- Show each movie's title, release_year, and box_office_million,
-- along with a RUNNING TOTAL of box office revenue ordered by
-- release year (then movie_id as a tiebreaker).
-- ----------------------------------------------------------------
SELECT
    title,
    release_year,
    box_office_million,
    SUM(box_office_million) OVER (ORDER BY release_year, movie_id) AS running_total
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 4
-- For each movie, show the title, genre, rating, the AVERAGE
-- rating of all movies in the same genre, and the difference
-- between this movie's rating and its genre average.
-- Round all averages and differences to 2 decimal places.
-- Sort by genre, then by rating descending.
-- ----------------------------------------------------------------
SELECT
    title,
    genre,
    rating,
    ROUND(AVG(rating) OVER (PARTITION BY genre), 2) AS genre_avg,
    ROUND(rating - AVG(rating) OVER (PARTITION BY genre), 2) AS difference
FROM movies
ORDER BY genre, rating DESC;


-- ----------------------------------------------------------------
-- QUESTION 5
-- Rank DIRECTORS by their total box office revenue
-- (sum of all their movies' revenues), highest first.
-- Show the director name, total_box_office, and revenue_rank.
-- ----------------------------------------------------------------
SELECT
    d.name,
    SUM(m.box_office_million) AS total_box_office,
    RANK() OVER (ORDER BY SUM(box_office_million) DESC) AS revenue_rank
FROM movies m
INNER JOIN directors d
ON m.director_id = d.director_id
GROUP BY d.name;


-- ----------------------------------------------------------------
-- QUESTION 6
-- For each movie, show the previous movie released in the SAME
-- genre (ordered by release year).
-- Show the title, genre, release_year, and previous_movie_in_genre.
-- (If there's no previous movie, show NULL.)
-- Hint: Use LAG().
-- ----------------------------------------------------------------
SELECT
    title,
    genre,
    release_year,
    LAG(title) OVER (PARTITION BY genre ORDER BY release_year ASC) AS previous_movie_in_genre
FROM movies;


-- ----------------------------------------------------------------
-- QUESTION 7
-- Show only the TOP 3 rated movies per genre.
-- Show the title, genre, rating, and rank within the genre.
-- If two movies are tied, they share the same rank (use RANK()).
-- ----------------------------------------------------------------
SELECT
    title,
    genre,
    rating,
    rank_in_genre
FROM (SELECT
    title,
    genre,
    rating,
    RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS rank_in_genre
FROM movies) AS ranked_movies
WHERE rank_in_genre <= 3;


-- ----------------------------------------------------------------
-- QUESTION 8
-- For each genre, calculate:
--   1. The total box office revenue for that genre
--   2. What PERCENTAGE of the overall total box office that genre
--      represents (rounded to 2 decimal places)
-- Show genre, genre_total, and pct_of_total.
-- Sort by genre_total descending.
-- Hint: SUM() OVER () with no PARTITION gives the grand total.
-- ----------------------------------------------------------------
SELECT
    genre,
    SUM(box_office_million) AS genre_total,
    SUM(SUM(box_office_million)) OVER () AS grand_total,
    ROUND((SUM(box_office_million) / SUM(SUM(box_office_million)) OVER ()) * 100, 2) AS pct_of_total
FROM movies
GROUP BY genre
ORDER BY genre_total DESC;


-- ----------------------------------------------------------------
-- QUESTION 9
-- For each movie, use FIRST_VALUE to show the title and box
-- office revenue of the HIGHEST-GROSSING movie in the same genre.
-- Show movie title, genre, box_office_million, top_movie_in_genre,
-- and top_genre_box_office.
-- Sort by genre, then box_office_million descending.
-- ----------------------------------------------------------------
SELECT
    title,
    genre,
    box_office_million,
    FIRST_VALUE(title) OVER (PARTITION BY genre ORDER BY box_office_million DESC) AS top_movie_in_genre,
    FIRST_VALUE(box_office_million) OVER (PARTITION BY genre ORDER BY box_office_million DESC) AS top_genre_box_office
FROM movies
ORDER BY genre, box_office_million DESC;


-- ----------------------------------------------------------------
-- QUESTION 10
-- For each movie (ordered by release year within genre), show:
--   - title, genre, release_year, rating
--   - The PREVIOUS movie's rating in the same genre
--   - The CHANGE in rating compared to the previous movie
--     (positive = improved, negative = declined)
-- Round the change to 1 decimal place.
-- Sort by genre, then release_year.
-- ----------------------------------------------------------------
SELECT
    title,
    genre,
    release_year,
    rating,
    LAG(rating) OVER (PARTITION BY genre ORDER BY release_year) AS prev_rating,
    ROUND(rating - LAG(rating) OVER (PARTITION BY genre ORDER BY release_year), 1) AS compared_rating
FROM movies;
