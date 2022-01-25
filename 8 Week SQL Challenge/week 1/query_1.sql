-- Total amout each customer spent at restaurant.
USE dannys_diner;

SELECT customer_id, SUM(price) as amount_spent
FROM sales as s
	INNER JOIN menu as m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY customer_id ASC;
