
/**********************************************************************
 * NAME: Arjuna Herbst
 * CLASS: CPSC321   
 * DATE: 12/10
 * HOMEWORK: Extra Credit SQL
 **********************************************************************/

-- Quesiton 1: 

SELECT f.title
FROM film f
WHERE NOT EXISTS (
    SELECT s.store_id
    FROM store s
    WHERE NOT EXISTS (
        SELECT 1
        FROM inventory i
        WHERE i.store_id = s.store_id
        AND i.film_id = f.film_id
    )
)
ORDER BY f.title;

-- Question 2:

WITH film_update AS (

    -- Updates for actors
    SELECT fa.film_id, f.title, 'actor' AS type, fa.last_update
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    
    UNION
    
    -- Updates for categories
    SELECT fc.film_id, f.title, 'category' AS type, fc.last_update
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
    
    UNION
    
    -- Updates for inventories
    SELECT i.film_id, f.title, 'inventory' AS type, i.last_update
    FROM inventory i
    JOIN film f ON i.film_id = f.film_id
)
-- Final query
SELECT fu.film_id, fu.title, fu.type, fu.last_update
FROM film_update fu
JOIN film_category fc ON fu.film_id = fc.film_id
WHERE fc.category_id = (SELECT category_id FROM category WHERE name = 'Action')
ORDER BY fu.film_id, fu.last_update;


-- Question 3:

SELECT
    film_id,
    title,
    rating,
    length,
    CASE
        WHEN length <= 50 THEN 'short'
        WHEN length > 50 AND length < 80 THEN 'featurette'
        WHEN length >= 80 THEN 'feature'
    END AS type
FROM film
ORDER BY film_id;

-- Question 4:

SELECT
    film_id,
    title,
    rating,
    length,
    (
        SELECT COUNT(*) + 1
        FROM film f2
        WHERE f2.rating = f.rating AND f2.length < f.length
    ) AS rank
FROM film f
ORDER BY rating, rank, title;

-- Question 5:

WITH ranked_films AS (
    SELECT
        film_id,
        title,
        rating,
        length,
        (
            SELECT COUNT(DISTINCT length) + 1
            FROM film f2
            WHERE f2.rating = f1.rating AND f2.length < f1.length
        ) AS film_rank
    FROM film f1
)
SELECT
    film_id,
    title,
    rating,
    length
FROM ranked_films
WHERE film_rank <= 5
ORDER BY rating, film_rank, film_id;

-- Question 6:

SELECT
    film.film_id,
    COUNT(film_actor.actor_id) AS actors
FROM
    film
LEFT JOIN
    film_actor ON film.film_id = film_actor.film_id
GROUP BY
    film.film_id
ORDER BY
    film.film_id;


-- Question 7:

SELECT
    r.recipe_id,
    r.title,
    COUNT(rev.review_id) AS num_reviews
FROM
    recipes r
LEFT JOIN
    reviews rev ON r.recipe_id = rev.recipe_id
GROUP BY
    r.recipe_id, r.title
ORDER BY
    num_reviews DESC;

-- Question 8:

SELECT
    r.recipe_id,
    r.title,
    AVG(rev.rating) AS average_rating,
    CASE
        WHEN AVG(rev.rating) >= 4.5 THEN 'Excellent'
        WHEN AVG(rev.rating) >= 3.5 THEN 'Good'
        WHEN AVG(rev.rating) >= 2.5 THEN 'Average'
        WHEN AVG(rev.rating) >= 1.5 THEN 'Poor'
        ELSE 'Very Poor'
    END AS rating_category
FROM
    recipes r
LEFT JOIN
    reviews rev ON r.recipe_id = rev.recipe_id
GROUP BY
    r.recipe_id, r.title
ORDER BY
    average_rating DESC;

-- Question 9:

SELECT
    recipe_id,
    title,
    AVG(COUNT(ingredient_id)) OVER () AS avg_ingredients_per_recipe
FROM
    recipes r
JOIN
    recipe_ingredients ri ON r.recipe_id = ri.recipe_id
GROUP BY
    recipe_id, title
ORDER BY
    recipe_id;