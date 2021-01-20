#Lab SQL Queries - Lesson 2.6
#In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link.
#The database is structured as follows: DB schema

#Instructions
######1 Get release years.
SELECT DISTINCT release_year FROM sakila.film;
#2006

######2 Get all films with ARMAGEDDON in the title.
SELECT * FROM sakila.film
where title like '%ARMAGEDDON%';
### OR 
SELECT * FROM sakila.film
where title regexp 'ARMAGEDDON';


######3 Get all films which title ends with APOLLO.
SELECT * FROM sakila.film
where title regexp 'APOLLO$'; 

######4 Get 10 the longest films.
SELECT * FROM sakila.film
ORDER BY length DESC
LIMIT 10;

######5 How many films include Behind the Scenes content?
SELECT * FROM sakila.film
where special_features regexp 'Behind the Scenes';

######6 Drop column picture from staff.
ALTER TABLE staff
DROP picture;

SELECT * FROM sakila.staff;

######7 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
#Update the database accordingly.

SELECT * FROM sakila.customer
WHERE first_name = "Tammy" and last_name = "Sanders";
insert into staff (staff_id, first_name, last_name, email, address_id, active, store_id, username) values (3,'TAMMY','SANDERS', 'TAMMY.SANDERS@sakilacustomer.org', 79, 1, 2, 'Tammy');


######8 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
#You can use current date for the rental_date column in the rental table.
#Hint: Check the columns in the table rental and see what information you would need to add there. 
#You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
#To get that you can use the following query:

select * from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
#Use similar method to get inventory_id, film_id, and staff_id.

select * from sakila.rental
order by rental_id desc
limit 3;

select * from sakila.staff
where first_name = 'MIKE' and last_name = 'HILLYER';
select film_id from sakila.film where title = 'ACADEMY DINOSAUR';

select * from sakila.inventory
where film_id = 1;

insert into rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values(16050, '2021-01-20 16:57:22', 1, 130, NULL, 1, '2021-01-20 21:43:28');
select* from sakila.rental
where rental_id = 16050;


######9 Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
#Follow these steps:


### --- Check if there are any non-active users
SELECT * FROM sakila.customer
WHERE active = 0 or NULL or ' ';

### --- Create a table backup table as suggested

SELECT * FROM sakila.customer;

CREATE TABLE sakila.del_customer (
  customer_id int(11) UNIQUE NOT NULL,
  email char(50) DEFAULT NULL,
  deleted_date int(11) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
);

SELECT * FROM sakila.del_customer;

### --- Insert the non active users in the table backup table
INSERT INTO sakila.del_customer (customer_id, email)
SELECT customer_id, email FROM sakila.customer
WHERE active = 0 or NULL or ' ';

### --- Delete the non active users from the table customer
DELETE FROM sakila.customer
WHERE active IS NULL OR 0;