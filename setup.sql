-- ============================================================
-- MOVIES DATABASE - SQL Learning Project
-- Setup Script: Creates database, all tables, and inserts data
-- Run this file first before attempting any exercises.
--
-- Usage: mysql -u root -p < setup.sql
--    or: SOURCE /path/to/setup.sql  (inside mysql shell)
-- ============================================================

DROP DATABASE IF EXISTS movies_db;
CREATE DATABASE movies_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE movies_db;

-- ============================================================
-- TABLE CREATION
-- ============================================================

CREATE TABLE directors (
    director_id INT          PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    country     VARCHAR(50),
    birth_year  INT
);

CREATE TABLE movies (
    movie_id           INT          PRIMARY KEY AUTO_INCREMENT,
    title              VARCHAR(150) NOT NULL,
    release_year       INT,
    genre              VARCHAR(50),
    rating             DECIMAL(3,1),
    box_office_million DECIMAL(10,2),
    director_id        INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

CREATE TABLE actors (
    actor_id    INT          PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year  INT
);

CREATE TABLE movie_cast (
    cast_id        INT          PRIMARY KEY AUTO_INCREMENT,
    movie_id       INT,
    actor_id       INT,
    character_name VARCHAR(100),
    role_type      ENUM('lead', 'supporting'),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

CREATE TABLE reviews (
    review_id     INT          PRIMARY KEY AUTO_INCREMENT,
    movie_id      INT,
    reviewer_name VARCHAR(100),
    rating        DECIMAL(3,1),
    review_text   TEXT,
    review_date   DATE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);


-- ============================================================
-- INSERT DIRECTORS (22 records)
-- ============================================================

INSERT INTO directors (name, country, birth_year) VALUES
('Christopher Nolan',    'United Kingdom', 1970),  -- 1
('Steven Spielberg',     'United States',  1946),  -- 2
('Martin Scorsese',      'United States',  1942),  -- 3
('Quentin Tarantino',    'United States',  1963),  -- 4
('James Cameron',        'Canada',         1954),  -- 5
('Denis Villeneuve',     'Canada',         1967),  -- 6
('Ridley Scott',         'United Kingdom', 1937),  -- 7
('David Fincher',        'United States',  1962),  -- 8
('Francis Ford Coppola', 'United States',  1939),  -- 9
('Stanley Kubrick',      'United States',  1928),  -- 10
('Peter Jackson',        'New Zealand',    1961),  -- 11
('Guillermo del Toro',   'Mexico',         1964),  -- 12
('Wes Anderson',         'United States',  1969),  -- 13
('Sofia Coppola',        'United States',  1971),  -- 14
('Alfonso Cuarón',       'Mexico',         1961),  -- 15
('Bong Joon-ho',         'South Korea',    1969),  -- 16
('Akira Kurosawa',       'Japan',          1910),  -- 17
('Werner Herzog',        'Germany',        1942),  -- 18
('Darren Aronofsky',     'United States',  1969),  -- 19
('Paul Thomas Anderson', 'United States',  1970),  -- 20
('Spike Lee',            'United States',  1957),  -- 21
('Greta Gerwig',         'United States',  1983);  -- 22


-- ============================================================
-- INSERT MOVIES (58 records)
-- ============================================================

INSERT INTO movies (title, release_year, genre, rating, box_office_million, director_id) VALUES
-- Christopher Nolan (director_id = 1)
('The Dark Knight',                                      2008, 'Action',    9.0, 1005.00,  1),  -- 1
('Inception',                                            2010, 'Sci-Fi',    8.8,  836.80,  1),  -- 2
('Interstellar',                                         2014, 'Sci-Fi',    8.6,  701.80,  1),  -- 3
('Memento',                                              2000, 'Thriller',  8.4,   25.54,  1),  -- 4
('Dunkirk',                                              2017, 'War',       7.9,  527.00,  1),  -- 5

-- Steven Spielberg (director_id = 2)
('Schindler''s List',                                    1993, 'Drama',     8.9,  322.16,  2),  -- 6
('Jaws',                                                 1975, 'Thriller',  8.0,  476.00,  2),  -- 7
('E.T. the Extra-Terrestrial',                           1982, 'Sci-Fi',    7.9,  792.91,  2),  -- 8
('Raiders of the Lost Ark',                              1981, 'Adventure', 8.4,  389.93,  2),  -- 9
('Saving Private Ryan',                                  1998, 'War',       8.6,  481.84,  2),  -- 10

-- Martin Scorsese (director_id = 3)
('Goodfellas',                                           1990, 'Crime',     8.7,   46.84,  3),  -- 11
('The Departed',                                         2006, 'Crime',     8.5,  290.54,  3),  -- 12
('Taxi Driver',                                          1976, 'Drama',     8.2,   28.26,  3),  -- 13
('The Wolf of Wall Street',                              2013, 'Comedy',    8.2,  392.01,  3),  -- 14
('Shutter Island',                                       2010, 'Thriller',  8.1,  294.80,  3),  -- 15

-- Quentin Tarantino (director_id = 4)
('Pulp Fiction',                                         1994, 'Crime',     8.9,  214.18,  4),  -- 16
('Django Unchained',                                     2012, 'Western',   8.4,  425.37,  4),  -- 17
('Inglourious Basterds',                                 2009, 'War',       8.3,  321.46,  4),  -- 18
('Kill Bill: Volume 1',                                  2003, 'Action',    8.1,  180.95,  4),  -- 19
('The Hateful Eight',                                    2015, 'Western',   7.8,  155.76,  4),  -- 20

-- James Cameron (director_id = 5)
('Titanic',                                              1997, 'Romance',   7.9, 2201.65,  5),  -- 21
('Avatar',                                               2009, 'Sci-Fi',    7.8, 2923.71,  5),  -- 22
('Terminator 2: Judgment Day',                           1991, 'Action',    8.5,  519.84,  5),  -- 23
('Aliens',                                               1986, 'Sci-Fi',    8.3,  183.00,  5),  -- 24

-- Denis Villeneuve (director_id = 6)
('Arrival',                                              2016, 'Sci-Fi',    7.9,  203.39,  6),  -- 25
('Blade Runner 2049',                                    2017, 'Sci-Fi',    8.0,  260.50,  6),  -- 26
('Dune: Part One',                                       2021, 'Sci-Fi',    8.0,  401.77,  6),  -- 27
('Sicario',                                              2015, 'Thriller',  7.6,   84.90,  6),  -- 28

-- Ridley Scott (director_id = 7)
('Gladiator',                                            2000, 'Action',    8.5,  460.58,  7),  -- 29
('The Martian',                                          2015, 'Sci-Fi',    8.0,  630.16,  7),  -- 30
('Alien',                                                1979, 'Sci-Fi',    8.4,  104.93,  7),  -- 31
('Blade Runner',                                         1982, 'Sci-Fi',    8.1,   41.67,  7),  -- 32

-- David Fincher (director_id = 8)
('Fight Club',                                           1999, 'Thriller',  8.8,  101.21,  8),  -- 33
('Se7en',                                                1995, 'Thriller',  8.6,  327.31,  8),  -- 34
('The Social Network',                                   2010, 'Drama',     7.7,  224.92,  8),  -- 35
('Gone Girl',                                            2014, 'Thriller',  8.1,  369.33,  8),  -- 36

-- Francis Ford Coppola (director_id = 9)
('The Godfather',                                        1972, 'Crime',     9.2,  246.12,  9),  -- 37
('The Godfather Part II',                                1974, 'Crime',     9.0,   93.00,  9),  -- 38
('Apocalypse Now',                                       1979, 'War',       8.4,   83.47,  9),  -- 39

-- Stanley Kubrick (director_id = 10)
('2001: A Space Odyssey',                                1968, 'Sci-Fi',    8.3,   68.74, 10),  -- 40
('A Clockwork Orange',                                   1971, 'Crime',     8.3,   26.59, 10),  -- 41
('The Shining',                                          1980, 'Horror',    8.4,   44.02, 10),  -- 42
('Full Metal Jacket',                                    1987, 'War',       8.3,   46.36, 10),  -- 43

-- Peter Jackson (director_id = 11)
('The Lord of the Rings: The Fellowship of the Ring',    2001, 'Fantasy',   8.8,  898.22, 11),  -- 44
('The Lord of the Rings: The Two Towers',                2002, 'Fantasy',   8.7,  951.22, 11),  -- 45
('The Lord of the Rings: The Return of the King',        2003, 'Fantasy',   8.9, 1146.03, 11),  -- 46

-- Bong Joon-ho (director_id = 16)
('Parasite',                                             2019, 'Thriller',  8.5,  263.10, 16),  -- 47
('Memories of Murder',                                   2003, 'Crime',     8.1,    2.99, 16),  -- 48

-- Alfonso Cuarón (director_id = 15)
('Gravity',                                              2013, 'Sci-Fi',    7.7,  716.39, 15),  -- 49
('Children of Men',                                      2006, 'Sci-Fi',    7.9,   35.60, 15),  -- 50

-- Guillermo del Toro (director_id = 12)
('Pan''s Labyrinth',                                     2006, 'Fantasy',   8.2,   83.26, 12),  -- 51
('The Shape of Water',                                   2017, 'Romance',   7.3,  195.24, 12),  -- 52

-- Wes Anderson (director_id = 13)
('The Grand Budapest Hotel',                             2014, 'Comedy',    8.1,  175.00, 13),  -- 53
('Moonrise Kingdom',                                     2012, 'Comedy',    7.8,   68.26, 13),  -- 54

-- Darren Aronofsky (director_id = 19)
('Black Swan',                                           2010, 'Thriller',  8.0,  329.40, 19),  -- 55
('Requiem for a Dream',                                  2000, 'Drama',     8.3,    7.40, 19),  -- 56

-- Greta Gerwig (director_id = 22)
('Lady Bird',                                            2017, 'Drama',     7.4,   78.98, 22),  -- 57
('Barbie',                                               2023, 'Comedy',    6.9, 1441.71, 22);  -- 58


-- ============================================================
-- INSERT ACTORS (52 records)
-- ============================================================

INSERT INTO actors (name, nationality, birth_year) VALUES
('Leonardo DiCaprio',   'American',         1974),  -- 1
('Tom Hanks',           'American',         1956),  -- 2
('Meryl Streep',        'American',         1949),  -- 3
('Christian Bale',      'British',          1974),  -- 4
('Cate Blanchett',      'Australian',       1969),  -- 5
('Brad Pitt',           'American',         1963),  -- 6
('Scarlett Johansson',  'American',         1984),  -- 7
('Robert De Niro',      'American',         1943),  -- 8
('Natalie Portman',     'Israeli-American', 1981),  -- 9
('Morgan Freeman',      'American',         1937),  -- 10
('Joaquin Phoenix',     'American',         1974),  -- 11
('Emma Stone',          'American',         1988),  -- 12
('Matthew McConaughey', 'American',         1969),  -- 13
('Charlize Theron',     'South African',    1975),  -- 14
('Heath Ledger',        'Australian',       1979),  -- 15
('Kate Winslet',        'British',          1975),  -- 16
('Johnny Depp',         'American',         1963),  -- 17
('Denzel Washington',   'American',         1954),  -- 18
('Ryan Gosling',        'Canadian',         1980),  -- 19
('Amy Adams',           'American',         1974),  -- 20
('Tom Hardy',           'British',          1977),  -- 21
('Jessica Chastain',    'American',         1977),  -- 22
('Sigourney Weaver',    'American',         1949),  -- 23
('Harrison Ford',       'American',         1942),  -- 24
('Al Pacino',           'American',         1940),  -- 25
('Judi Dench',          'British',          1934),  -- 26
('Gary Oldman',         'British',          1958),  -- 27
('Cillian Murphy',      'Irish',            1976),  -- 28
('Florence Pugh',       'British',          1996),  -- 29
('Timothée Chalamet',   'American',         1995),  -- 30
('Zendaya',             'American',         1996),  -- 31
('Ana de Armas',        'Cuban-Spanish',    1988),  -- 32
('Adam Driver',         'American',         1983),  -- 33
('Anthony Hopkins',     'Welsh',            1937),  -- 34
('Frances McDormand',   'American',         1957),  -- 35
('Viola Davis',         'American',         1965),  -- 36
('Samuel L. Jackson',   'American',         1948),  -- 37
('Keanu Reeves',        'Canadian',         1964),  -- 38
('Uma Thurman',         'American',         1970),  -- 39
('John Travolta',       'American',         1954),  -- 40
('Bruce Willis',        'American',         1955),  -- 41
('Jack Nicholson',      'American',         1937),  -- 42
('Marlon Brando',       'American',         1924),  -- 43
('Elijah Wood',         'American',         1981),  -- 44
('Orlando Bloom',       'British',          1977),  -- 45
('Ian McKellen',        'British',          1939),  -- 46
('Viggo Mortensen',     'American',         1958),  -- 47
('Matt Damon',          'American',         1970),  -- 48
('Ben Affleck',         'American',         1972),  -- 49
('Halle Berry',         'American',         1966),  -- 50
('Lupita Nyong''o',     'Kenyan',           1983),  -- 51
('Rosamund Pike',       'British',          1979);  -- 52


-- ============================================================
-- INSERT MOVIE CAST
-- ============================================================

INSERT INTO movie_cast (movie_id, actor_id, character_name, role_type) VALUES
-- The Dark Knight (movie_id = 1)
(1,  4,  'Bruce Wayne / Batman',      'lead'),
(1,  15, 'The Joker',                 'supporting'),
(1,  27, 'Commissioner Gordon',       'supporting'),
(1,  10, 'Lucius Fox',                'supporting'),

-- Inception (movie_id = 2)
(2,  1,  'Dom Cobb',                  'lead'),
(2,  21, 'Eames',                     'supporting'),
(2,  28, 'Robert Fischer',            'supporting'),

-- Interstellar (movie_id = 3)
(3,  13, 'Cooper',                    'lead'),
(3,  22, 'Adult Murph',               'supporting'),
(3,  28, 'Dr. Mann',                  'supporting'),

-- Dunkirk (movie_id = 5)
(5,  21, 'Farrier',                   'lead'),
(5,  28, 'Shivering Soldier',         'supporting'),

-- Saving Private Ryan (movie_id = 10)
(10, 2,  'Capt. John Miller',         'lead'),
(10, 48, 'Private James Ryan',        'supporting'),

-- Goodfellas (movie_id = 11)
(11, 8,  'Jimmy Conway',              'lead'),

-- The Departed (movie_id = 12)
(12, 48, 'Colin Sullivan',            'lead'),
(12, 42, 'Frank Costello',            'supporting'),
(12, 10, 'Capt. Queenan',             'supporting'),

-- Taxi Driver (movie_id = 13)
(13, 8,  'Travis Bickle',             'lead'),

-- The Wolf of Wall Street (movie_id = 14)
(14, 1,  'Jordan Belfort',            'lead'),

-- Shutter Island (movie_id = 15)
(15, 1,  'Teddy Daniels',             'lead'),

-- Pulp Fiction (movie_id = 16)
(16, 40, 'Vincent Vega',              'lead'),
(16, 37, 'Jules Winnfield',           'lead'),
(16, 39, 'Mia Wallace',               'supporting'),
(16, 41, 'Butch Coolidge',            'supporting'),

-- Django Unchained (movie_id = 17)
(17, 1,  'Calvin Candie',             'supporting'),
(17, 37, 'Stephen',                   'supporting'),

-- Inglourious Basterds (movie_id = 18)
(18, 6,  'Lt. Aldo Raine',            'lead'),

-- Kill Bill: Volume 1 (movie_id = 19)
(19, 39, 'The Bride',                 'lead'),

-- The Hateful Eight (movie_id = 20)
(20, 37, 'Major Marquis Warren',      'lead'),

-- Titanic (movie_id = 21)
(21, 1,  'Jack Dawson',               'lead'),
(21, 16, 'Rose DeWitt Bukater',       'lead'),

-- Avatar (movie_id = 22)
(22, 23, 'Dr. Grace Augustine',       'supporting'),

-- Aliens (movie_id = 24)
(24, 23, 'Ellen Ripley',              'lead'),

-- Arrival (movie_id = 25)
(25, 20, 'Louise Banks',              'lead'),

-- Blade Runner 2049 (movie_id = 26)
(26, 19, 'K / Joe',                   'lead'),
(26, 24, 'Rick Deckard',              'supporting'),
(26, 32, 'Joi',                       'supporting'),

-- Dune: Part One (movie_id = 27)
(27, 30, 'Paul Atreides',             'lead'),
(27, 31, 'Chani',                     'supporting'),

-- Gladiator (movie_id = 29)
(29, 11, 'Commodus',                  'supporting'),

-- The Martian (movie_id = 30)
(30, 48, 'Mark Watney',               'lead'),
(30, 22, 'Commander Lewis',           'supporting'),

-- Alien (movie_id = 31)
(31, 23, 'Ellen Ripley',              'lead'),

-- Blade Runner (movie_id = 32)
(32, 24, 'Rick Deckard',              'lead'),

-- Fight Club (movie_id = 33)
(33, 6,  'Tyler Durden',              'lead'),

-- Se7en (movie_id = 34)
(34, 6,  'Detective Mills',           'lead'),
(34, 10, 'Detective Somerset',        'supporting'),

-- Gone Girl (movie_id = 36)
(36, 49, 'Nick Dunne',                'lead'),
(36, 52, 'Amy Dunne',                 'lead'),

-- The Godfather (movie_id = 37)
(37, 43, 'Vito Corleone',             'lead'),
(37, 25, 'Michael Corleone',          'supporting'),

-- The Godfather Part II (movie_id = 38)
(38, 25, 'Michael Corleone',          'lead'),
(38, 8,  'Young Vito Corleone',       'supporting'),

-- Apocalypse Now (movie_id = 39)
(39, 43, 'Colonel Kurtz',             'supporting'),
(39, 24, 'Colonel Lucas',             'supporting'),

-- The Shining (movie_id = 42)
(42, 42, 'Jack Torrance',             'lead'),

-- Lord of the Rings: The Fellowship of the Ring (movie_id = 44)
(44, 44, 'Frodo Baggins',             'lead'),
(44, 46, 'Gandalf',                   'supporting'),
(44, 47, 'Aragorn',                   'supporting'),
(44, 45, 'Legolas',                   'supporting'),

-- Lord of the Rings: The Two Towers (movie_id = 45)
(45, 44, 'Frodo Baggins',             'lead'),
(45, 46, 'Gandalf',                   'supporting'),
(45, 47, 'Aragorn',                   'supporting'),
(45, 45, 'Legolas',                   'supporting'),

-- Lord of the Rings: The Return of the King (movie_id = 46)
(46, 44, 'Frodo Baggins',             'lead'),
(46, 46, 'Gandalf',                   'supporting'),
(46, 47, 'Aragorn',                   'supporting'),
(46, 45, 'Legolas',                   'supporting'),

-- Black Swan (movie_id = 55)
(55, 9,  'Nina Sayers',               'lead'),

-- Barbie (movie_id = 58)
(58, 19, 'Ken',                       'lead');


-- ============================================================
-- INSERT REVIEWS
-- ============================================================

INSERT INTO reviews (movie_id, reviewer_name, rating, review_text, review_date) VALUES
-- The Dark Knight
(1, 'CinematicJourney',   9.5, 'Heath Ledger''s Joker is the most terrifying and captivating villain in cinema history. A masterpiece of superhero storytelling.',                                                        '2008-07-25'),
(1, 'FilmScholarBob',     9.0, 'Nolan elevates the superhero genre to high art. The philosophical depth and practical effects are astounding. Batman Begins was great but this is transcendent.',                       '2008-08-10'),
(1, 'MovieNerd2024',      8.5, 'One of the best action films ever made. The Joker''s hospital scene alone is worth the price of admission.',                                                                           '2009-03-15'),

-- Inception
(2, 'DreamWalker99',      9.0, 'A film that makes you question reality long after the credits roll. DiCaprio delivers one of his finest performances.',                                                                '2010-08-05'),
(2, 'SkepticalViewer',    7.5, 'Visually stunning and technically brilliant, but the emotional core feels somewhat cold. Still, an impressive achievement.',                                                            '2010-09-20'),
(2, 'PhilosophyMajor',    9.5, 'The most intellectually satisfying blockbuster of the decade. Every viewing reveals new layers.',                                                                                      '2011-01-12'),

-- Interstellar
(3, 'SpaceFanatic',       9.0, 'The most emotionally devastating science fiction film since 2001. The docking scene had me gripping my armrest.',                                                                      '2014-11-18'),
(3, 'HardSciFiReader',    7.5, 'The science is surprisingly accurate in places, though the ending strains credibility. Still an ambitious and visually stunning film.',                                                '2015-02-03'),

-- Pulp Fiction
(16, 'TarantinoFan',     10.0, 'A revolution in narrative storytelling. Every scene is quotable, every performance iconic. This film changed cinema forever.',                                                         '1995-01-10'),
(16, 'CasualWatcher',     8.0, 'Not for everyone but undeniably brilliant. Tarantino''s dialogue is razor-sharp and the non-linear structure keeps you engaged throughout.',                                           '2005-06-22'),
(16, 'FilmProfessor',     9.5, 'The gold standard of independent cinema. Tarantino weaves unrelated stories into a cohesive and deeply satisfying whole.',                                                            '2014-07-01'),

-- The Godfather
(37, 'ClassicFilmLover', 10.0, 'The greatest film ever made. Brando and Pacino create characters so real you forget you''re watching fiction. Coppola''s direction is flawless.',                                     '2001-05-14'),
(37, 'NewWaveReviewer',   9.5, 'Nearly 50 years later, The Godfather still sets the standard for dramatic filmmaking. Every frame is perfectly composed.',                                                             '2020-03-28'),

-- The Godfather Part II
(38, 'ClassicFilmLover', 10.0, 'De Niro''s portrayal of young Vito and Pacino''s cold Michael make this sequel arguably better than the original. An extraordinary achievement.',                                     '2001-05-21'),

-- Parasite
(47, 'KoreanCinemaFan',   9.5, 'Bong Joon-ho crafts a perfectly structured thriller that doubles as searing class commentary. The first 30 minutes alone justify the hype.',                                           '2019-10-25'),
(47, 'OscarWatcher',      9.0, 'Historic Best Picture win fully deserved. Parasite is a masterclass in tonal control, shifting seamlessly from dark comedy to genuine horror.',                                        '2020-02-10'),

-- Fight Club
(33, 'AntiConsumerist',   9.5, 'Fincher''s most provocative film. Still as shocking and relevant today as in 1999. Brad Pitt has never been more charismatic.',                                                       '2000-04-15'),
(33, 'MainstreamViewer',  7.0, 'Stylistically impressive but the nihilistic message makes it a challenging watch. The twist works beautifully though.',                                                                '2001-08-12'),

-- Titanic
(21, 'RomanticSoul',      9.0, 'Cameron creates a devastating love story against history''s most famous disaster. DiCaprio and Winslet have undeniable chemistry.',                                                   '1998-01-20'),
(21, 'HistoryBuff',       7.5, 'Remarkable technical achievement with historically accurate set design. The human drama is formulaic but effective.',                                                                  '1998-03-05'),

-- The Shining
(42, 'HorrorAficionado',  9.5, 'Kubrick and Nicholson create the definitive haunted house film. The slow build of dread is masterfully constructed.',                                                                 '1985-11-30'),
(42, 'StephenKingFan',    8.0, 'Despite King''s famous dislike of this adaptation, Kubrick''s version stands as one of cinema''s great horror films.',                                                               '2010-10-31'),

-- Se7en
(34, 'ThrillerJunkie',    9.0, 'The darkest and most satisfying thriller of the 90s. Freeman and Pitt are perfectly paired and the ending is genuinely shocking.',                                                    '1996-04-22'),
(34, 'CrimeDramaFan',     8.5, 'Fincher establishes his visual style with overwhelming confidence. What''s in the box has become one of cinema''s great questions.',                                                  '2005-12-15'),

-- Lord of the Rings: The Return of the King
(46, 'TolkienPurist',     9.5, 'The most satisfying conclusion to a trilogy in cinema history. The Battle of Pelennor Fields remains breathtaking 20 years later.',                                                   '2004-01-15'),
(46, 'EpicFantasyFan',   10.0, 'Jackson''s achievement with this trilogy cannot be overstated. ROTK deserved every one of its 11 Oscars.',                                                                            '2004-02-20'),

-- Lord of the Rings: The Fellowship of the Ring
(44, 'TolkienPurist',     9.0, 'Jackson''s vision is staggeringly faithful and alive. The Shire, Moria, Rivendell — all exactly as I imagined them. A cinematic miracle.',                                           '2002-01-05'),

-- Avatar
(22, 'VisualFXLover',     8.5, 'A visual revolution. Cameron transforms cinema with photorealistic CGI and 3D technology that still holds up years later.',                                                            '2010-01-05'),
(22, 'StorytellerCritic', 6.5, 'The visuals are undeniably spectacular but the script relies too heavily on familiar tropes. Style over substance, but what style.',                                                   '2010-03-15'),

-- Dune: Part One
(27, 'SciFiEnthusiast',   8.5, 'Villeneuve achieves the impossible: a faithful and visually stunning adaptation of an unadaptable novel. Zimmer''s score is extraordinary.',                                          '2021-10-25'),
(27, 'DuneFanatic',       9.0, 'The most anticipated sci-fi film in years delivers on every promise. Timothée Chalamet is born for this role.',                                                                        '2021-11-08'),

-- Blade Runner 2049
(26, 'CyberpunkNoir',     9.0, 'A worthy successor to Ridley Scott''s masterpiece. Gosling''s quiet, melancholy performance anchors a visually overwhelming film.',                                                   '2017-10-15'),
(26, 'BoxOfficeAnalyst',  8.0, 'Criminally underperformed at the box office. This is exactly the kind of thoughtful adult science fiction that Hollywood should make more of.',                                        '2017-12-01'),

-- Goodfellas
(11, 'GangsterFilmFan',   9.5, 'Scorsese''s kinetic energy and Liotta''s narration pull you irresistibly into this world. The Copacabana tracking shot is pure cinema.',                                             '2001-09-10'),

-- Schindler's List
(6,  'HistoryTeacher',   10.0, 'The most important film ever made about the Holocaust. Spielberg''s restraint — shooting in black and white — only amplifies the horror.',                                            '1994-02-15'),
(6,  'FilmStudentMaria',  9.5, 'Liam Neeson''s performance is career-defining. Every frame carries the weight of history.',                                                                                           '2010-06-07'),

-- Gravity
(49, 'AstrophysicsNerd',  8.0, 'Technically flawed in some details but viscerally thrilling. Cuarón''s long takes create suffocating tension that IMAX was made for.',                                               '2013-10-10'),

-- Gladiator
(29, 'ActionMovieFan',    8.5, 'Russell Crowe at his absolute peak. The arena sequences are exhilarating and Hans Zimmer''s score is legendary.',                                                                     '2001-03-20'),

-- Saving Private Ryan
(10, 'WW2Historian',      9.5, 'The first 30 minutes redefine what war cinema can be. Unflinching, terrifying, and deeply respectful of the soldiers it depicts.',                                                   '1999-01-04');


-- ============================================================
-- Verify setup
-- ============================================================

SELECT 'Setup complete!' AS status;
SELECT 'directors' AS table_name, COUNT(*) AS record_count FROM directors
UNION ALL
SELECT 'movies',    COUNT(*) FROM movies
UNION ALL
SELECT 'actors',    COUNT(*) FROM actors
UNION ALL
SELECT 'movie_cast',COUNT(*) FROM movie_cast
UNION ALL
SELECT 'reviews',   COUNT(*) FROM reviews;
