
-- 1. -	A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
SELECT 
  COUNT(title) 
FROM 
  film 
WHERE 
  description LIKE ('%Astronaut%');

 
-- 2. How many films have a rating of “R” and a replacement cost between $5 and $15?
SELECT 
  COUNT (*) 
FROM 
  film 
WHERE 
  rating = 'R' 
  AND replacement_cost BETWEEN 5 
  AND 15;
  
 
-- 3. We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.How many payments did each staff member handle? And how much was the total amount processed by each staff member?
SELECT 
  staff_id, 
  COUNT (staff_id) AS total_payment, 
  SUM(amount) AS total_amount 
FROM 
  payment 
GROUP BY 
  staff_id;
  
 
 
-- 4. Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
SELECT 
  rating, 
  ROUND(
    AVG(replacement_cost), 
    2
  ) AS average_replacement_cost 
FROM 
  film 
GROUP BY 
  rating;
  
 
 
  -- 5.  We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
SELECT 
  CONCAT (
    customer.first_name, ' ', customer.last_name
  ) AS name, 
  customer.email, 
  SUM(payment.amount) AS total_amount 
FROM 
  customer 
  JOIN payment ON customer.customer_id = payment.customer_id 
GROUP BY 
  CONCAT (
    customer.first_name, ' ', customer.last_name
  ), 
  customer.email 
ORDER BY 
  SUM(payment.amount) DESC 
LIMIT 
  5;

 
 
-- We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
SELECT 
  film.title, 
  SUM(
    CASE WHEN inventory.store_id = 1 THEN 1 ELSE 0 END
  ) AS store_1, 
  SUM(
    CASE WHEN inventory.store_id = 2 THEN 1 ELSE 0 END
  ) AS store_2 
FROM 
  inventory 
  JOIN film ON film.film_id = inventory.film_id 
GROUP BY 
  film.title 
ORDER BY 
  film.title ASC;
  
 
 
-- 7. We want to know what customers are eligible for our platinum credit card. 
-- The requirements are that the customer has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card!
SELECT 
  CONCAT (
    customer.first_name, ' ', customer.last_name
  ) AS name, 
  customer.email
FROM 
  customer 
  JOIN payment ON customer.customer_id = payment.customer_id 
GROUP BY 
  CONCAT (
    customer.first_name, ' ', customer.last_name
  ), 
  customer.email 
HAVING COUNT(payment.customer_id) >= 40

