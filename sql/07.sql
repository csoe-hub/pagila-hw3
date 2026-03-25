/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IN (
    SELECT fa2.film_id
    FROM film_actor fa2
    WHERE fa2.actor_id IN (
        SELECT DISTINCT a1.actor_id
        FROM actor a1
        JOIN film_actor f1 ON a1.actor_id = f1.actor_id
        WHERE f1.film_id IN (
            SELECT f2.film_id
            FROM film_actor f2
            JOIN actor a2 ON f2.actor_id = a2.actor_id
            WHERE a2.first_name = 'RUSSELL'
              AND a2.last_name = 'BACALL'
        )
        AND NOT (a1.first_name = 'RUSSELL' AND a1.last_name = 'BACALL')
    )
)
AND a.actor_id NOT IN (
    SELECT a0.actor_id
    FROM actor a0
    WHERE a0.first_name = 'RUSSELL'
      AND a0.last_name = 'BACALL'
)
AND a.actor_id NOT IN (
    SELECT DISTINCT a1.actor_id
    FROM actor a1
    JOIN film_actor f1 ON a1.actor_id = f1.actor_id
    WHERE f1.film_id IN (
        SELECT f2.film_id
        FROM film_actor f2
        JOIN actor a2 ON f2.actor_id = a2.actor_id
        WHERE a2.first_name = 'RUSSELL'
          AND a2.last_name = 'BACALL'
    )
)
ORDER BY "Actor Name";
