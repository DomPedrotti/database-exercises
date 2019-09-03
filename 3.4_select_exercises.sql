USE `albums_db`;

DESCRIBE albums;

SELECT * FROM albums WHERE artist = "Pink Floyd";
-- returned Dark Side of the Mood & The Wall
SELECT * FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- Release date = 1967
SELECT * FROM albums WHERE NAME = "Nevermind";
-- Genre is Grunge, Alternative rock
Select * FROM albums WHERE release_date BETWEEN 1990 AND 2000;
Select * From albums where sales <= 20;
SELECT * FROM albums WHERE genre like "%rock%"
