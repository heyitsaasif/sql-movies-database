# SQL Practice — Movies Database

A structured, hands-on SQL learning project built around a realistic movies database. Progress from basic SELECT queries to advanced window functions across five difficulty levels, with 50 practice questions and a full answer key.

Designed to be **portfolio-ready** — this project demonstrates the SQL skills employers test in data analyst interviews.

---

## Database Schema

```
┌─────────────────────┐         ┌──────────────────────────────────────────┐
│      directors      │         │                  movies                  │
├─────────────────────┤         ├──────────────────────────────────────────┤
│ director_id  INT PK │◄────────│ movie_id   INT PK                        │
│ name         VARCHAR│    ┌───►│ title      VARCHAR                       │
│ country      VARCHAR│    │    │ release_year INT                         │
│ birth_year   INT    │    │    │ genre       VARCHAR                      │
└─────────────────────┘    │    │ rating      DECIMAL(3,1)                 │
                           │    │ box_office_million DECIMAL(10,2)         │
                           │    │ director_id INT FK → directors           │
                           │    └──────────────┬───────────────────────────┘
                           │                   │
                           │      ┌────────────┤
                           │      │            │
              ┌────────────┴──────┴──┐   ┌────┴────────────────┐
              │      movie_cast      │   │       reviews        │
              ├──────────────────────┤   ├──────────────────────┤
              │ cast_id   INT PK     │   │ review_id  INT PK    │
              │ movie_id  INT FK     │   │ movie_id   INT FK    │
              │ actor_id  INT FK     │   │ reviewer_name VARCHAR│
              │ character_name       │   │ rating   DECIMAL(3,1)│
              │ role_type ENUM       │   │ review_text TEXT     │
              └──────────┬───────────┘   │ review_date DATE     │
                         │               └──────────────────────┘
              ┌──────────┴───────────┐
              │        actors        │
              ├──────────────────────┤
              │ actor_id  INT PK     │
              │ name      VARCHAR    │
              │ nationality VARCHAR  │
              │ birth_year INT       │
              └──────────────────────┘
```

### Table Summary

| Table | Records | Description |
|-------|---------|-------------|
| `directors` | 22 | Film directors from 10 countries |
| `movies` | 58 | Films from 1968–2023 across 12 genres |
| `actors` | 52 | Actors from 15 nationalities |
| `movie_cast` | 72 | Actor-movie-character relationships |
| `reviews` | 38 | Audience and critic reviews |

---

## Setup

### Prerequisites

- MySQL 8.0 or higher (window functions require 8.0+)
- A MySQL client: [MySQL Workbench](https://www.mysql.com/products/workbench/), [DBeaver](https://dbeaver.io/), [TablePlus](https://tableplus.com/), or the `mysql` command line

### Installation

**Option A — Command line:**
```bash
mysql -u root -p < setup.sql
```

**Option B — MySQL shell:**
```sql
SOURCE /path/to/sql-practice/setup.sql;
```

**Option C — GUI tool:**
Open `setup.sql` in MySQL Workbench or your preferred client and run the entire script.

### Verify the Setup

After running setup.sql you should see:

```
+------------+--------------+
| table_name | record_count |
+------------+--------------+
| directors  |           22 |
| movies     |           58 |
| actors     |           52 |
| movie_cast |           72 |
| reviews    |           38 |
+------------+--------------+
```

---

## Project Structure

```
sql-practice/
├── setup.sql                 # Database + all data (run this first)
│
├── level1_basics.sql         # Exercise questions — Level 1
├── level2_aggregates.sql     # Exercise questions — Level 2
├── level3_joins.sql          # Exercise questions — Level 3
├── level4_subqueries.sql     # Exercise questions — Level 4
├── level5_window_functions.sql  # Exercise questions — Level 5
│
├── level1_answers.sql        # Answer key — Level 1
├── level2_answers.sql        # Answer key — Level 2
├── level3_answers.sql        # Answer key — Level 3
├── level4_answers.sql        # Answer key — Level 4
├── level5_answers.sql        # Answer key — Level 5
│
├── CONCEPTS.md               # Beginner SQL concepts + keyword glossary
└── README.md                 # This file
```

---

## Exercise Levels

### Level 1 — Basics (`level1_basics.sql`)
**Concepts:** `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`

10 questions covering fundamental data retrieval:
- Selecting specific columns from a table
- Filtering rows with WHERE conditions
- Sorting results with ORDER BY (ASC/DESC)
- Limiting output with LIMIT
- Using BETWEEN for range filters

*Example:* Find all movies released in the 2000s. Find the top 10 highest-grossing films. List all Sci-Fi movies sorted by rating.

---

### Level 2 — Aggregates (`level2_aggregates.sql`)
**Concepts:** `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`

10 questions covering data summarization and grouping:
- Counting rows per category
- Calculating totals and averages
- Grouping data with GROUP BY
- Filtering groups with HAVING
- Combining JOINs with aggregates

*Example:* Count movies per genre. Find directors with more than 3 films. Calculate average box office revenue per decade.

---

### Level 3 — Joins (`level3_joins.sql`)
**Concepts:** `INNER JOIN`, `LEFT JOIN`, multi-table joins

10 questions covering relational data retrieval:
- Joining two tables on a foreign key
- Three-table joins (movies + actors + movie_cast)
- LEFT JOIN to include rows with no match
- Combining GROUP BY with JOINs
- Finding rows that have no related records

*Example:* List all movies with their director's name. Find actors who played lead roles. Find movies that have received no reviews.

---

### Level 4 — Subqueries (`level4_subqueries.sql`)
**Concepts:** Nested queries, `IN`, `NOT IN`, `EXISTS`, derived tables

10 questions covering advanced filtering with subqueries:
- Scalar subqueries (return a single value)
- IN / NOT IN with subquery lists
- Correlated subqueries
- Derived tables in the FROM clause
- Multi-level nested queries

*Example:* Find movies rated above average. Find actors who haven't appeared in any films. Find movies that out-earned their genre's average.

---

### Level 5 — Window Functions (`level5_window_functions.sql`)
**Concepts:** `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`, `FIRST_VALUE()`, `SUM OVER`, `AVG OVER`

10 questions covering analytic/window functions (MySQL 8.0+):
- Ranking rows within partitions
- Running totals with SUM OVER
- Comparing to previous/next rows with LAG/LEAD
- Genre-level averages alongside individual rows
- Calculating percentage of totals

*Example:* Rank directors by total box office. Show each movie's rating vs. its genre average. Find the top 3 movies per genre.

---

## Sample Data

The database features 58 iconic films from directors including:

| Director | Country | Notable Films in DB |
|----------|---------|---------------------|
| Christopher Nolan | UK | The Dark Knight, Inception, Interstellar |
| Steven Spielberg | USA | Schindler's List, Saving Private Ryan |
| Martin Scorsese | USA | Goodfellas, The Departed |
| Quentin Tarantino | USA | Pulp Fiction, Django Unchained |
| James Cameron | Canada | Titanic, Avatar |
| Denis Villeneuve | Canada | Dune, Blade Runner 2049, Arrival |
| Ridley Scott | UK | Gladiator, Alien, The Martian |
| David Fincher | USA | Fight Club, Se7en, Gone Girl |
| Francis Ford Coppola | USA | The Godfather (I & II) |
| Peter Jackson | NZ | The Lord of the Rings trilogy |
| Bong Joon-ho | South Korea | Parasite |
| Stanley Kubrick | USA | 2001, The Shining, Full Metal Jacket |

**Genres covered:** Action, Adventure, Comedy, Crime, Drama, Fantasy, Horror, Romance, Sci-Fi, Thriller, War, Western

---

## Skills Demonstrated

This project showcases the following data skills — relevant for **Data Analyst**, **Business Analyst**, and **Data Scientist** roles:

| Skill | Demonstrated In |
|-------|----------------|
| Database design & normalization | `setup.sql` — 5-table relational schema |
| Primary & foreign key constraints | All tables in `setup.sql` |
| Basic data retrieval | Level 1 |
| Filtering and sorting | Level 1 |
| Aggregate functions | Level 2 |
| Grouping and having clauses | Level 2 |
| Multi-table joins (INNER, LEFT) | Level 3 |
| Subqueries and nested logic | Level 4 |
| Window / analytic functions | Level 5 |
| Running totals | Level 5 |
| Ranking within partitions | Level 5 |
| Lag/lead for time-series comparison | Level 5 |
| Percentage-of-total calculations | Level 5 |

---

## Tips for Learners

1. **Work the levels in order** — each builds on the previous
2. **Try each question yourself before checking the answer** — struggle is how learning happens
3. **Modify the answers** — change a WHERE condition, add a column, or switch ASC to DESC to see what changes
4. **Read CONCEPTS.md** if you're stuck on a keyword — it explains every SQL concept used
5. **Re-do questions after a few days** — spaced repetition is the most effective way to memorize SQL syntax

---

## License

MIT — use freely for learning, portfolio projects, or teaching others.
