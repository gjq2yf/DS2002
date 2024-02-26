# 1 
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'ACADEMY DINOSAUR';

# 2
SELECT category.name AS category_name,
COUNT(film_category.film_id) AS count_of_film
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

# 3
SELECT film.rating, AVG(rental.return_date - rental.rental_date) AS avg_rental_duration
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.rating;

# 4
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_rentals
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

# 5
SELECT store.store_id, COUNT(rental.rental_id) AS total_rentals
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN rental ON staff.staff_id = rental.staff_id
GROUP BY store.store_id
ORDER BY total_rentals DESC
LIMIT 1;

# 6
SELECT category.name AS category_name, COUNT(rental.rental_id) AS rental_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name
ORDER BY rental_count DESC
LIMIT 1;

# 7 
SELECT category.name AS category_name, AVG(film.rental_rate) AS average_rental_rate
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

# 8 
SELECT film.title AS film_title, MAX(rental.rental_date) AS last_rental_date
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date < DATE_SUB(NOW(), INTERVAL 1 MONTH) OR rental.rental_date IS NULL
GROUP BY film.film_id;

# 9
SELECT 
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    SUM(payment.amount) AS total_spending
FROM 
    customer
LEFT JOIN 
    payment ON customer.customer_id = payment.customer_id
GROUP BY 
    Customer.customer_id;

# 10
SELECT language.name AS language, AVG(film.length) AS average_length 
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;