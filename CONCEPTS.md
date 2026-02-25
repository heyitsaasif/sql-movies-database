# SQL Concepts Guide
### A Beginner-Friendly Reference for the Movies Database Project

---

## Table of Contents
1. [What is a Database?](#1-what-is-a-database)
2. [What is a Table?](#2-what-is-a-table)
3. [What is SQL?](#3-what-is-sql)
4. [How Multiple Tables Connect](#4-how-multiple-tables-connect)
5. [SQL Keyword Glossary](#5-sql-keyword-glossary)

---

## 1. What is a Database?

A **database** is an organized collection of information stored on a computer so it can be accessed, managed, and updated easily.

Think of it like a very advanced filing cabinet. Instead of paper folders, you have structured digital storage that can hold millions of records and retrieve any one of them in milliseconds.

### Why Do Companies Use Databases?

Every major company you can think of runs on databases:

- **Netflix** stores every user account, every movie title, every watch history record, and every subscription in a database. When you click play, SQL queries figure out which video to stream to your account.
- **Amazon** stores billions of products, millions of customer orders, and real-time inventory levels in databases.
- **Spotify** uses databases to store 100 million+ songs, user playlists, and listening history to power recommendations.
- **Banks** record every single transaction — every deposit, withdrawal, and transfer — in highly secure databases.

**Without databases, none of these services could function.** A database makes it possible to:
- Store huge amounts of data reliably (it won't disappear when you close the app)
- Find specific information instantly (search for one customer out of 50 million)
- Update records accurately (change a price without breaking anything else)
- Keep data consistent and secure

---

## 2. What is a Table?

A **table** is how data is actually stored inside a database. If a database is a filing cabinet, a table is one drawer in that cabinet — dedicated to one specific type of information.

### Tables Are Like Spreadsheets

You can think of a database table exactly like an Excel spreadsheet:

| **Spreadsheet concept** | **Database concept** |
|------------------------|----------------------|
| Worksheet              | Table                |
| Column header          | Column (field)       |
| Row of data            | Record (row)         |
| Cell                   | A single data value  |

Here is what our `movies` table looks like:

| movie_id | title            | release_year | genre  | rating | box_office_million |
|----------|------------------|--------------|--------|--------|--------------------|
| 1        | The Dark Knight  | 2008         | Action | 9.0    | 1005.00            |
| 2        | Inception        | 2010         | Sci-Fi | 8.8    | 836.80             |
| 3        | Interstellar     | 2014         | Sci-Fi | 8.6    | 701.80             |

Each **row** is one movie. Each **column** is one piece of information about that movie.

### Key Difference from Excel

In Excel, you might put everything on one giant sheet. In a database, you split related data into **separate tables** and link them together. This prevents repetition and keeps data organized. (More on this in Section 4.)

---

## 3. What is SQL?

**SQL** stands for **Structured Query Language**. It is the language you use to talk to a database — to ask questions, add data, update records, and more.

SQL is pronounced either "S-Q-L" (saying each letter) or "sequel" — both are acceptable.

### Why SQL Matters for Your Career

SQL is one of the most in-demand skills in the job market. According to job data, SQL appears in:
- **90%+ of Data Analyst job postings**
- Nearly all Data Scientist roles
- Business Intelligence (BI) Analyst roles
- Product Manager and Marketing Analyst roles
- Backend Developer roles

**It is typically the #1 skill employers test in data interviews.**

The reason is simple: data lives in databases. If you want to work with data professionally, you need to know how to get it out and analyze it. SQL is how you do that.

### What SQL Looks Like

SQL reads almost like plain English:

```sql
SELECT title, rating
FROM movies
WHERE genre = 'Action'
ORDER BY rating DESC;
```

Reading this out loud: *"Select the title and rating from the movies table, but only where the genre is Action, and sort them with the highest rating first."*

That's it. SQL tells the database *what* you want — the database figures out *how* to get it.

---

## 4. How Multiple Tables Connect

Our movies database has **5 tables** that are connected to each other. This is called a **relational database**.

```
directors ──────────── movies ──────────── movie_cast ──────────── actors
                          │
                       reviews
```

Instead of putting all information in one giant table, we split it up. Here is why:

### The Problem with One Big Table

Imagine if we had one massive table like this:

| title           | director_name       | director_country | actor_name      | character  |
|-----------------|---------------------|-----------------|-----------------|------------|
| The Dark Knight | Christopher Nolan   | United Kingdom  | Christian Bale  | Batman     |
| The Dark Knight | Christopher Nolan   | United Kingdom  | Heath Ledger    | The Joker  |
| The Dark Knight | Christopher Nolan   | United Kingdom  | Gary Oldman     | Gordon     |
| Inception       | Christopher Nolan   | United Kingdom  | Leonardo DiCaprio | Cobb     |

Notice how "Christopher Nolan" and "United Kingdom" appear over and over? This is called **data redundancy**, and it causes problems:
- It wastes storage space
- If you need to update Christopher Nolan's country, you'd have to change it in 100 rows
- Easy to make mistakes — one typo and your data is inconsistent

### The Solution: Multiple Tables with Foreign Keys

Instead, we store each type of information once:

**`directors` table** — stores Christopher Nolan's info once, with a unique ID:
```
director_id = 1, name = 'Christopher Nolan', country = 'United Kingdom'
```

**`movies` table** — instead of repeating director info, just stores the ID:
```
movie_id = 1, title = 'The Dark Knight', director_id = 1
movie_id = 2, title = 'Inception', director_id = 1
```

The `director_id` in the `movies` table is called a **Foreign Key** — it's a reference (like a hyperlink) to a row in another table.

When you want to see the movie WITH the director's name, you use a **JOIN** to connect the tables:

```sql
SELECT movies.title, directors.name
FROM movies
JOIN directors ON movies.director_id = directors.director_id;
```

### Our Database Schema

```
┌─────────────────┐         ┌─────────────────────────────────────┐
│   directors     │         │              movies                  │
├─────────────────┤         ├─────────────────────────────────────┤
│ director_id  PK │◄────────│ movie_id   PK                       │
│ name            │         │ title                               │
│ country         │         │ release_year                        │
│ birth_year      │         │ genre                               │
└─────────────────┘         │ rating                              │
                            │ box_office_million                  │
                            │ director_id  FK → directors         │
                            └──────────────┬──────────────────────┘
                                           │
               ┌───────────────────────────┼───────────────────────┐
               │                           │                       │
    ┌──────────┴──────────┐     ┌──────────┴──────────┐
    │     movie_cast      │     │       reviews       │
    ├─────────────────────┤     ├─────────────────────┤
    │ cast_id  PK         │     │ review_id  PK       │
    │ movie_id FK → movies│     │ movie_id FK → movies│
    │ actor_id FK → actors│     │ reviewer_name       │
    │ character_name      │     │ rating              │
    │ role_type           │     │ review_text         │
    └──────────┬──────────┘     │ review_date         │
               │                └─────────────────────┘
    ┌──────────┴──────────┐
    │       actors        │
    ├─────────────────────┤
    │ actor_id  PK        │
    │ name                │
    │ nationality         │
    │ birth_year          │
    └─────────────────────┘

PK = Primary Key (unique identifier for each row)
FK = Foreign Key (links to another table's primary key)
```

---

## 5. SQL Keyword Glossary

Every keyword used in these exercises, explained in plain English.

---

### SELECT
**What it does:** Chooses which columns to display in your results.

```sql
SELECT title, rating FROM movies;
```
*"Show me the title and rating columns."*

Use `SELECT *` to get all columns (the `*` means "everything").

---

### FROM
**What it does:** Tells SQL which table to look in.

```sql
SELECT title FROM movies;
--                ^^^^^^ this is the FROM clause
```

Every query needs a FROM. It's telling SQL: *"Go look in this table."*

---

### WHERE
**What it does:** Filters rows. Only rows that match the condition are included.

```sql
SELECT title FROM movies WHERE rating > 8.5;
```
*"Only show movies where the rating is greater than 8.5."*

Common operators: `=`, `>`, `<`, `>=`, `<=`, `<>` (not equal), `BETWEEN`, `LIKE`, `IN`

---

### ORDER BY
**What it does:** Sorts the results.

```sql
SELECT title, rating FROM movies ORDER BY rating DESC;
```

- `ASC` = ascending order (A→Z, lowest to highest) — this is the default
- `DESC` = descending order (Z→A, highest to lowest)

---

### LIMIT
**What it does:** Caps the number of rows returned.

```sql
SELECT title FROM movies ORDER BY rating DESC LIMIT 5;
```
*"Show only the top 5 movies."*

Very useful in real work — you often don't need all 1 million rows, just the top 10.

---

### COUNT
**What it does:** Counts the number of rows (or non-null values in a column).

```sql
SELECT COUNT(*) FROM movies;              -- total number of movies
SELECT COUNT(*) FROM movies WHERE genre = 'Crime';  -- only Crime movies
```

`COUNT(*)` counts all rows. `COUNT(column_name)` counts rows where that column is not NULL.

---

### SUM
**What it does:** Adds up all the values in a numeric column.

```sql
SELECT SUM(box_office_million) FROM movies;
```
*"What is the total box office revenue of all movies combined?"*

---

### AVG
**What it does:** Calculates the average (mean) of a numeric column.

```sql
SELECT AVG(rating) FROM movies;
```
*"What is the average rating across all movies?"*

Use `ROUND(AVG(rating), 2)` to round to 2 decimal places.

---

### MIN / MAX
**What it does:** Finds the smallest (MIN) or largest (MAX) value in a column.

```sql
SELECT MIN(release_year), MAX(release_year) FROM movies;
```
*"What is the oldest and newest movie year?"*

---

### GROUP BY
**What it does:** Groups rows that share the same value in a column so you can calculate aggregates (COUNT, SUM, AVG) for each group.

```sql
SELECT genre, COUNT(*) AS movie_count
FROM movies
GROUP BY genre;
```
*"Count the movies in each genre separately."*

Without `GROUP BY`, `COUNT(*)` would just give you one total number.

---

### HAVING
**What it does:** Filters groups (like WHERE, but for aggregate results).

```sql
SELECT genre, COUNT(*) AS movie_count
FROM movies
GROUP BY genre
HAVING COUNT(*) > 3;
```
*"Only show genres that have more than 3 movies."*

**Key rule:** Use `WHERE` to filter individual rows *before* grouping. Use `HAVING` to filter groups *after* grouping.

---

### JOIN (INNER JOIN)
**What it does:** Combines rows from two tables where a matching value exists in both.

```sql
SELECT movies.title, directors.name
FROM movies
INNER JOIN directors ON movies.director_id = directors.director_id;
```

The `ON` clause specifies how to match rows: *"Connect each movie to its director using the director_id."*

If a movie has no matching director (or vice versa), that row is excluded from the results.

---

### LEFT JOIN
**What it does:** Like INNER JOIN, but also includes rows from the LEFT table even if there's no match in the right table. Missing values from the right table show as NULL.

```sql
SELECT movies.title, reviews.rating
FROM movies
LEFT JOIN reviews ON movies.movie_id = reviews.movie_id;
```

*"Show all movies — and if they have reviews, show the rating. If no reviews exist, show NULL."*

Use LEFT JOIN when you want to include rows that might not have a match (like finding movies with no reviews).

---

### Subqueries
**What it does:** A query nested inside another query. The inner query runs first and its result is used by the outer query.

```sql
-- Find movies rated above average
SELECT title, rating
FROM movies
WHERE rating > (SELECT AVG(rating) FROM movies);
--              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ this is the subquery
```

**Common patterns:**
- `WHERE column IN (SELECT ...)` — check if a value is in a list
- `WHERE column NOT IN (SELECT ...)` — check if a value is NOT in a list
- `WHERE EXISTS (SELECT ...)` — check if any matching row exists
- `FROM (SELECT ...) AS alias` — use a query result as a temporary table

---

### Window Functions
**What they do:** Perform calculations across a set of rows that are related to the current row, WITHOUT collapsing the results into groups.

The key syntax is `OVER()` — this is what makes it a window function.

```sql
SELECT title, rating,
       RANK() OVER (ORDER BY rating DESC) AS rank
FROM movies;
```

This shows EVERY movie AND its rank — unlike `GROUP BY`, which collapses rows.

**Common window functions:**

| Function | What it does |
|----------|-------------|
| `RANK()` | Assigns a rank. Ties get the same rank; next rank skips (1,1,3) |
| `DENSE_RANK()` | Like RANK but no gaps (1,1,2) |
| `ROW_NUMBER()` | Assigns a unique sequential number, no ties |
| `LAG(col)` | Gets the value from the PREVIOUS row |
| `LEAD(col)` | Gets the value from the NEXT row |
| `FIRST_VALUE(col)` | Gets the value from the first row in the window |
| `SUM(col) OVER(...)` | Running total or group total |
| `AVG(col) OVER(...)` | Running average or group average |

**PARTITION BY** — splits the window into groups (like GROUP BY, but doesn't collapse):
```sql
RANK() OVER (PARTITION BY genre ORDER BY rating DESC)
-- "Rank within each genre separately"
```

**ORDER BY inside OVER()** — defines which direction the window "looks":
```sql
SUM(box_office_million) OVER (ORDER BY release_year)
-- "Running total, increasing as years go forward"
```

---

### Other Important Keywords

| Keyword | Meaning |
|---------|---------|
| `DISTINCT` | Remove duplicate rows from results |
| `AS` | Give a column or table an alias (nickname) |
| `BETWEEN x AND y` | Range filter (inclusive on both ends) |
| `IN (a, b, c)` | Match any value in a list |
| `NOT IN (...)` | Exclude any value in a list |
| `IS NULL` | Check if a value is missing/empty |
| `IS NOT NULL` | Check if a value exists |
| `LIKE 'pat%'` | Pattern matching (`%` = any characters) |
| `ROUND(x, n)` | Round to n decimal places |
| `FLOOR(x)` | Round down to nearest integer |
| `GROUP_CONCAT(col)` | Concatenate values from grouped rows into one string |

---

*Good luck with the exercises! Remember: the best way to learn SQL is to actually run the queries and experiment with changing them.*
