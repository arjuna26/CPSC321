
/**********************************************************************
 * NAME: Arjuna Herbst
 * CLASS: CPSC321  
 * DATE: 9/29/2023
 * HOMEWORK: HW3
 * DESCRIPTION: simple SQL script to insert some tables and populate them with data,
 *              executeable on MariaDB
 **********************************************************************/

-- drop table statements

DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS music_group;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS group_genre;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS group_membership;
DROP TABLE IF EXISTS track;
DROP TABLE IF EXISTS track_artists;

-- create table statements

CREATE TABLE album(

    title CHAR(50),
    year_recorded YEAR,
    record_label CHAR(50),
    group_id SMALLINT,
    PRIMARY KEY(title, year_recorded, record_label)

);

CREATE TABLE music_group(

    group_id INT,
    group_name CHAR(30),
    year_created YEAR,
    PRIMARY KEY(group_id)

);

CREATE TABLE genre(
    
    genre_label CHAR(40),
    genre_descrip TEXT(250),
    PRIMARY KEY(genre_label)

);

CREATE TABLE group_genre(

    group_id INT, 
    genre_label CHAR(40),
    PRIMARY KEY(group_id, genre_label),
    FOREIGN KEY(group_id) REFERENCES music_group(group_id),
    FOREIGN KEY(genre_label) REFERENCES genre(genre_label)  

);


CREATE TABLE artist(

    artist_id INT,
    artist_name CHAR(20),
    birth_year YEAR,
    PRIMARY KEY(artist_id)

);

CREATE TABLE group_membership(

    artist_id INT,
    group_id INT,
    start_year YEAR,
    end_year YEAR,
    PRIMARY KEY(artist_id, group_id, start_year),
    FOREIGN KEY(artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY(group_id) REFERENCES music_group(group_id)

);


-- added FK to link tracks to albums
CREATE TABLE track(

    track_id INT,
    track_name CHAR(40),
    year_rec YEAR,
    album_title CHAR(50),
    PRIMARY KEY(track_id),
    FOREIGN KEY(album_title) REFERENCES album(title) 

);

CREATE TABLE track_artists(

    track_id INT,
    artist_id INT,
    PRIMARY KEY(track_id, artist_id),
    FOREIGN KEY(track_id) REFERENCES track(track_id),
    FOREIGN KEY(artist_id) REFERENCES artist(artist_id)   

);

-- insert statements

INSERT INTO album VALUES

    ('blue', 2016, 'cheese', 24),('red', 1998, 'lemon', 13),('green', 1807, 'old cheese', 1);

INSERT INTO music_group VALUES

    (1, 'old', 1799),(13, 'medium', 1990),(24, 'why', 2011);


INSERT INTO genre VALUES

    ('rock', 'music with rocks it go boooooom'),('edm', 'loud laser and robot sounds'),('pop', 'soda (pop)');

INSERT INTO group_genre VALUES

    (24, 'edm'),(1, 'rock'),(13, 'pop');

INSERT INTO artist VALUES

    (3, 'doubleword', 1996),(6, 'python3', 1990),(27, 'C++', 1234);

INSERT INTO group_membership VALUES

    (3, 24, 2011, 2015),(6, 24, 2012, 2015),(27, 13, 1992, 2002);

INSERT INTO track VALUES

    (1, 'orange', 2016, 'blue'),(24, 'rocks', 1807, 'green'),(123, 'cat', 2016, 'blue');

INSERT INTO track_artists VALUES

    (1, 3),(24, 6),(1, 3);