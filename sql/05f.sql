/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT title
FROM (
    SELECT f.title
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN film_category fc2 ON fc.category_id = fc2.category_id
    JOIN film f2 ON fc2.film_id = f2.film_id
    WHERE f2.title = 'AMERICAN CIRCUS'
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fc.category_id) >= 2

    INTERSECT

    SELECT f.title
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    WHERE fa.actor_id IN (
        SELECT fa2.actor_id
        FROM film_actor fa2
        JOIN film f2 ON fa2.film_id = f2.film_id
        WHERE f2.title = 'AMERICAN CIRCUS'
    )
) AS t
ORDER BY title;
