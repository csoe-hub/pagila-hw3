/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN LATERAL (
    SELECT is_action
    FROM (
        SELECT r.rental_id,
               r.rental_date,
               MAX(CASE WHEN cat.name = 'Action' THEN 1 ELSE 0 END) AS is_action
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film_category fc ON i.film_id = fc.film_id
        JOIN category cat ON fc.category_id = cat.category_id
        WHERE r.customer_id = c.customer_id
        GROUP BY r.rental_id, r.rental_date
        ORDER BY r.rental_date DESC
        LIMIT 5
    ) AS x
) AS recent ON TRUE
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(recent.is_action) >= 4
ORDER BY c.customer_id;
