
/**********************************************************************
 * NAME: Arjuna Herbst
 * CLASS: CPSC321 Database Management
 * DATE: 12/4/2023
 * HOMEWORK: HW 8
 **********************************************************************/


-- Quesiton 1: Write an SQL query to determine the total number of films, their minimum, maximum,
-- and average length, and the number of film special features.


SELECT COUNT(*) as num_films, MIN(length) as min_length, 
        MAX(length) as max_length, AVG(length), COUNT(DISTINCT special_features) 
FROM film;


-- Question 2: Write an SQL query that finds the number of films for each rating along with the
-- corresponding average film length. Your results should be ordered from highest to lowest
-- average length.

SELECT rating, COUNT(*) as num_films, AVG(length) as avg_length
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- Question 3: Find the total number of actors that have acted in a film by film rating. The results
-- should be sorted from highest to lowest total number of actors for each rating value.

SELECT rating, COUNT(actor_id) as num_actors
FROM film JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY rating
ORDER BY num_actors DESC;

-- Question 4: Find the total number of films for each film category, their min, max, and average rental
-- rates, and their min, max, and average replacement costs. The results of your query should
-- be sorted alphabetically by category name.

SELECT category.name, 
        COUNT(film.film_id) as num_films,  
        MIN(rental_rate) as min_rate, 
        MAX(rental_rate) as max_rate, 
        ROUND(AVG(rental_rate), 2) as avg_rate, 
        MIN(replacement_cost) as min_cost, 
        MAX(replacement_cost) as max_cost, 
        ROUND(AVG(replacement_cost), 2) as avg_cost
FROM film JOIN film_category ON film.film_id = film_category.film_id
          JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY category.name;


-- Question 5: Find the number of total rentals of horror films for each rating (G, PG, etc.) that were
-- rented at store 1 (i.e., the store with store_id 1). The query results should be ordered from
-- highest to lowest number of rentals. 

SELECT f.rating, COUNT(r.rental_id) as num_rentals
FROM rental r JOIN inventory i ON r.inventory_id = i.inventory_id
              JOIN film f ON i.film_id = f.film_id
              JOIN film_category fc ON f.film_id = fc.film_id
              JOIN category c ON fc.category_id = c.category_id
              JOIN store s ON i.store_id = s.store_id
WHERE c.name = 'Horror' 
  AND s.store_id = 1
GROUP BY f.rating
ORDER BY num_rentals DESC;

-- Question 6: Find the G-rated action films that have been rented at least 15 times. The query results
-- should be ordered from largest to smallest number of rentals. Note that your query cannot
-- use LIMIT. The result of your query should be the following.

SELECT f.title, COUNT(r.rental_id) as num_rentals
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
            JOIN category c ON fc.category_id = c.category_id
            JOIN inventory i ON f.film_id = i.film_id
            JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.rating = 'G' 
  AND c.name = 'Action'
GROUP BY f.title
HAVING num_rentals >= 15
ORDER BY num_rentals DESC;


-- Question 7: Find the actors that have been in at least 4 horror films. The query results should be
-- ordered from most number of film appearances to least followed by the actor last name and
-- then the first name.

SELECT a.first_name, a.last_name, COUNT(f.film_id) as num_horror_films
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id
             JOIN film f ON fa.film_id = f.film_id
             JOIN film_category fc ON f.film_id = fc.film_id
             JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Horror'
GROUP BY a.first_name, a.last_name
HAVING num_horror_films >= 4
ORDER BY num_horror_films DESC, a.last_name, a.first_name;  

-- Question 8: Find films that are the longest in length. Return each matching film id, film title, and
-- the corresponding film length. As part of your query, you cannot assume you know ahead of
-- time the longest film length

SELECT film_id, title, length
FROM film
WHERE length = (SELECT MAX(length) FROM film);

-- Question 9:Find the longest ‘G’-rated films. Return each matching film id, film title, and the
-- corresponding film length. As part of your query, you cannot assume you know ahead of time
-- the longest film length

SELECT film_id, title, length
FROM film 
WHERE length = (SELECT MAX(length) FROM film) 
    AND rating = 'G';

-- Question 10: Write an SQL query using subqueries to find the actors/actresses that have not acted
-- in an ‘R’ rated film.


SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.rating = 'R'
);

-- Question 11: Find the film category (or categories if there is a tie) with the most number of ‘G’ rated
-- films. Your query cannot use limit and must only return the categories with the most number
-- of films 

SELECT c.name, COUNT(f.film_id) as num_films
FROM category c JOIN film_category fc ON c.category_id = fc.category_id
                JOIN film f ON fc.film_id = f.film_id
WHERE f.rating = 'G'
GROUP BY c.category_id, c.name
HAVING COUNT(f.film_id) = (
    SELECT MAX(num_films)
    FROM (
        SELECT fc.category_id, COUNT(f.film_id) as num_films
        FROM film_category fc JOIN film f ON fc.film_id = f.film_id
        WHERE f.rating = 'G'
        GROUP BY fc.category_id
    ) as category_counts
);

-- Question 12: Find the ‘PG’ rated film (or films if there is a tie) that have been rented more than the
-- average number of times (for ‘PG’ rated movies).

WITH PG_Rentals AS (
    SELECT f.title, COUNT(r.rental_id) AS num_rentals
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE f.rating = 'PG'
    GROUP BY f.title
    HAVING COUNT(r.rental_id) > (
        SELECT AVG(num_rentals)
        FROM (
            SELECT COUNT(r.rental_id) AS num_rentals
            FROM film f
            JOIN inventory i ON f.film_id = i.film_id
            JOIN rental r ON i.inventory_id = r.inventory_id
            WHERE f.rating = 'PG'
            GROUP BY f.title
        ) AS avg_rentals
    )
)

SELECT title, num_rentals
FROM PG_Rentals
ORDER BY num_rentals DESC, title;