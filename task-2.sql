--1.1
SELECT f.title AS film_title, f.length AS duration, c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY f.title;
--1.2
SELECT f.title AS film_title, r.rental_date
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'John' AND c.last_name = 'Doe'
ORDER BY r.rental_date DESC;
--1.3
SELECT f.title AS film_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;
--2.1
INSERT INTO customer (store_id, first_name, last_name, email, address_id)
VALUES (
    1,
    'Alice',
    'Cooper',
    'alice.cooper@example.com',
    (SELECT address_id FROM address WHERE address = '123 Main St' AND city_id = (SELECT city_id FROM city WHERE city = 'San Francisco'))
);
--2.2
UPDATE customer
SET address_id = (
    SELECT address_id 
    FROM address 
    WHERE address = '456 Elm St'
)
WHERE first_name = 'Alice' AND last_name = 'Cooper';
--2.3
DELETE FROM customer
WHERE first_name = 'Alice' AND last_name = 'Cooper';