-- How many days has each customer visited the restaurant?
USE dannys_diner;

-- use the order date to calculate the number of days each customer has visited the restaurant.
SELECT customer_id, COUNT(DISTINCT order_date) as num_vist_dates
FROM sales as s
GROUP BY customer_id;