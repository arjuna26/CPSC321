-- drop table
DROP TABLE IF EXISTS pet;

-- create pet table
CREATE TABLE pet(
    id INT NOT NULL,
    name VARCHAR(20),
    type VARCHAR(20),
    PRIMARY KEY (id)
);

-- insert data into pet table
INSERT INTO pet VALUES(1, 'one', 'cat'), 
                    (2, 'two', 'dog'),
                    (3, 'three', 'fish'),
                    (4, 'four', 'bird'),
                    (5, 'five', 'chicken'), 
                    (6, 'six', 'pig'), 
                    (7, 'seven', 'duck');

INSERT INTO pet VALUES(8, 'herald', 'cat'), 
                    (9, 'fodo', 'dog'), 
                    (10, 'bubbles', 'fish'), 
                    (11, 'betty', 'bird'), 
                    (12, 'bobo', 'chicken'), 
                    (13, 'char', 'pig'), 
                    (14, 'grape', 'duck');