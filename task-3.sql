-- 1. Загальна кількість фільмів у кожній категорії
SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY film_count DESC;

-- 2. Середня тривалість фільмів у кожній категорії
SELECT c.name AS category_name, AVG(f.length) AS avg_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_duration DESC;

-- 3. Мінімальна та максимальна тривалість фільмів
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 4. Загальна кількість клієнтів
SELECT COUNT(*) AS total_customers
FROM customer;

-- 5. Сума платежів по кожному клієнту
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_payments DESC;

-- 6. П'ять клієнтів з найбільшою сумою платежів
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_payments DESC
LIMIT 5;

-- 7. Загальна кількість орендованих фільмів кожним клієнтом
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_rentals DESC;

-- 8. Середній вік фільмів у базі даних
SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - release_year) AS avg_film_age
FROM film;

-- 9. Кількість фільмів, орендованих за певний період
SELECT COUNT(*) AS rentals_count
FROM rental
WHERE rental_date BETWEEN '2005-07-01' AND '2005-08-01';

-- 10. Сума платежів по кожному місяцю
SELECT 
    DATE_TRUNC('month', payment_date) AS payment_month,
    SUM(amount) AS total_amount
FROM payment
GROUP BY payment_month
ORDER BY payment_month;

-- 11. Максимальна сума платежу для кожного клієнта
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    MAX(p.amount) AS max_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY max_payment DESC;

-- 12. Середня сума платежів для кожного клієнта
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    AVG(p.amount) AS avg_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY avg_payment DESC;

-- 13. Кількість фільмів у кожному рейтингу
SELECT 
    rating,
    COUNT(*) AS films_count
FROM film
GROUP BY rating
ORDER BY films_count DESC;

-- 14. Середня сума платежів по кожному магазину
SELECT 
    s.store_id,
    AVG(p.amount) AS avg_payment
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY avg_payment DESC;
