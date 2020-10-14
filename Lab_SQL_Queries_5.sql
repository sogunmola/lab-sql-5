USE sakila;
/* 1) Drop column picture from staff
*/
ALTER TABLE staff
DROP COLUMN picture;
SELECT * FROM staff;

/* 2) A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
*/
SELECT * FROM staff;

SELECT first_name, last_name, address_id, email, store_id FROM customer
WHERE last_name = 'SANDERS';

INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
SELECT 3, first_name, last_name, address_id, email, store_id, active, LEFT(first_name,3), 'password' , last_update FROM customer
WHERE last_name = 'SANDERS' AND first_name = 'TAMMY';

UPDATE staff
SET username = 'tam'
WHERE last_name = 'SANDERS';

SELECT * FROM staff;

/* 3) Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1 today.
*/
SELECT customer_id, store_id FROM customer
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';

SELECT staff_id, first_name FROM staff
WHERE first_name = 'Mike';

SELECT title, film_id FROM film
WHERE title = 'Academy Dinosaur';

SELECT inventory_id, film_id, store_id FROM inventory
WHERE film_id = 1 AND store_id = 1;

SELECT max(rental_date) FROM rental;

INSERT INTO rental
values (16050, 20060216, 1, 130, NULL, 1, 20060216);

SELECT * FROM rental
WHERE customer_id = 130 AND rental_id = 16050;

/* 4) Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date the user was deleted
*/
 CREATE TABLE deleted_users (
customer_id INT(3) UNIQUE NOT NULL,
email VARCHAR(45) NOT NULL,
date INT(12) DEFAULT NULL,
CONSTRAINT PRIMARY KEY (customer_id)
);

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email 
FROM customer 
WHERE active = 0;

UPDATE deleted_users
set date = curdate();

DELETE FROM customer
WHERE active = 0;

SELECT * FROM deleted_users;
SELECT * FROM customer
WHERE active = 0;
