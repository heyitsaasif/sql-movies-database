-- ============================================================
-- LEVEL 3: JOINS
-- Topics: INNER JOIN, LEFT JOIN, multiple table joins
-- ============================================================
-- Prerequisites: Run setup.sql first
-- USE movies_db;
-- ============================================================

-- ----------------------------------------------------------------
-- QUESTION 1
-- List all movies along with the name of their director
-- and the director's country.
-- Sort alphabetically by movie title.
-- ----------------------------------------------------------------
SELECT m.title, d.name, d.country
FROM movies m
LEFT JOIN directors d
ON m.director_id = d.director_id
ORDER BY m.title;


-- ----------------------------------------------------------------
-- QUESTION 2
-- Find all movies where the director is from Canada.
-- Show the movie title and the director's name.
-- ----------------------------------------------------------------
SELECT
    m.title,
    d.name
FROM movies m
INNER JOIN directors d
ON m.director_id = d.director_id
WHERE d.country = 'Canada';


-- ----------------------------------------------------------------
-- QUESTION 3
-- List every actor alongside the movies they appeared in,
-- their character name, and their role type (lead/supporting).
-- Sort by actor name, then movie title.
-- ----------------------------------------------------------------
SELECT
    a.name,
    m.title,
    mc.character_name,
    mc.role_type
FROM actors a
INNER JOIN movie_cast mc
ON a.actor_id = mc.actor_id
INNER JOIN movies m
ON mc.movie_id = m.movie_id
ORDER BY
    a.name,
    m.title;


-- ----------------------------------------------------------------
-- QUESTION 4
-- Find all actors who played LEAD roles.
-- Show the actor name, movie title, and character name.
-- Sort by actor name.
-- ----------------------------------------------------------------
SELECT
    a.name,
    m.title,
    mc.character_name
FROM actors a
INNER JOIN movie_cast mc
ON a.actor_id = mc.actor_id
INNER JOIN movies m
ON mc.movie_id = m.movie_id
WHERE role_type = 'lead'
ORDER BY a.name ASC;


-- ----------------------------------------------------------------
-- QUESTION 5
-- For each movie, show the movie title, the average reviewer
-- rating from the reviews table (rounded to 2 decimal places),
-- and the total number of reviews it has received.
-- Include movies that have NO reviews (show NULL or 0).
-- Sort by average review rating, highest first.
-- ----------------------------------------------------------------
SELECT
    m.title,
    ROUND(AVG(r.rating), 2) AS avg_review_rating,
    COUNT(r.review_id) AS num_reviews
FROM movies m
LEFT JOIN reviews r
ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY ROUND(AVG(r.rating), 2) DESC;


-- ----------------------------------------------------------------
-- QUESTION 6
-- Find directors who have made movies in MORE than one genre.
-- Show the director's name, how many distinct genres they've
-- worked in, and list the genres.
-- Hint: Use GROUP_CONCAT to list genres.
-- ----------------------------------------------------------------
SELECT
    d.name,
    COUNT(DISTINCT genre) AS num_genre,
    GROUP_CONCAT(DISTINCT genre) AS list
FROM directors d
INNER JOIN movies m
ON d.director_id = m.director_id
GROUP BY d.name
HAVING num_genre > 1;


-- ----------------------------------------------------------------
-- QUESTION 7
-- List all movies directed by directors born before 1950.
-- Show the movie title, release year, director name, and the
-- director's birth year.
-- Sort by director birth year, then movie title.
-- ----------------------------------------------------------------
SELECT
    m.title,
    m.release_year,
    d.name,
    d.birth_year
FROM movies m
LEFT JOIN directors d
ON m.director_id = d.director_id
WHERE d.birth_year < 1950
ORDER BY d.birth_year, m.title;


-- ----------------------------------------------------------------
-- QUESTION 8
-- Find all actors who have appeared in MORE than one movie
-- in our database.
-- Show the actor name and how many movies they've appeared in,
-- sorted from most to fewest.
-- ----------------------------------------------------------------
SELECT
    a.name,
    COUNT(mc.movie_id) AS movie_count
FROM actors a
LEFT JOIN movie_cast mc
ON a.actor_id = mc.actor_id
GROUP BY a.name
HAVING movie_count > 1
ORDER BY movie_count DESC;


-- ----------------------------------------------------------------
-- QUESTION 9
-- List all reviews with the movie title, reviewer name,
-- reviewer's rating, and review date.
-- Sort by review date, most recent first.
-- ----------------------------------------------------------------
SELECT
    m.title,
    r.reviewer_name,
    r.rating,
    r.review_date
FROM reviews r
LEFT JOIN movies m
ON r.movie_id = m.movie_id
ORDER BY r.review_date DESC;


-- ----------------------------------------------------------------
-- QUESTION 10
-- Find all movies that have received NO reviews.
-- Show the movie title, release year, and genre.
-- Sort alphabetically by title.
-- Hint: Use LEFT JOIN and check for NULL.
-- ----------------------------------------------------------------
SELECT
    m.title,
    m.release_year,
    m.genre
FROM movies m
LEFT JOIN reviews r
ON m.movie_id = r.movie_id
WHERE r.movie_id IS NULL;
