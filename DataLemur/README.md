## LinkedIn Power Creators (Part 1) => https://datalemur.com/questions/linkedin-power-creators
```sql
SELECT
  profile_id
FROM personal_profiles AS pp
LEFT JOIN company_pages AS cp
ON pp.employer_id = cp.company_id
WHERE pp.followers > cp.followers
ORDER BY profile_id;
```

## LinkedIn Power Creators (Part 2) => https://datalemur.com/questions/linkedin-power-creators-part2
```sql
SELECT
  profile_id
FROM personal_profiles AS pp
LEFT JOIN employee_company AS ec
ON pp.profile_id = ec.personal_profile_id
LEFT JOIN company_pages AS cp
ON ec.company_id = cp.company_id
GROUP BY profile_id
HAVING MAX(pp.followers) > SUM(cp.followers)
ORDER BY profile_id;
```
## Photoshop Revenue Analysis ==> https://datalemur.com/questions/photoshop-revenue-analysis
```sql
WITH photoshop_customers_ids AS (
  SELECT 
    DISTINCT customer_id
  FROM adobe_transactions
  GROUP BY customer_id, product
  HAVING product IN ('Photoshop')
)

SELECT
  at.customer_id,
  SUM(at.revenue) AS revenue
FROM adobe_transactions AS at
INNER JOIN photoshop_customers_ids AS pci
ON at.customer_id = pci.customer_id
WHERE product != 'Photoshop'
GROUP BY at.customer_id;
```

## Compensation Outliers ==> https://datalemur.com/questions/compensation-outliers
**Method 1**
```sql
WITH with_average_title_salary AS (
  SELECT
    employee_id,
    salary,
    AVG(salary) OVER(PARTITION BY title) AS avg_title_salary
  FROM employee_pay
), compensation_w_status AS 
(
  SELECT
    employee_id,
    salary,
    CASE
      WHEN salary > (2*avg_title_salary) THEN 'Overpaid'
      WHEN salary < (0.5*avg_title_salary) THEN 'Underpaid'
      ELSE 'Normal'
    END compensation_status
  FROM with_average_title_salary
)

SELECT
  *
FROM compensation_w_status
WHERE compensation_status != 'Normal';
```

**Method 2**
```sql
WITH avg_salaries AS (
  SELECT
    title,
    AVG(salary) AS avg_title_salary
  FROM employee_pay
  GROUP BY title
)

SELECT
  *
FROM
(
  SELECT
    ep.employee_id,
    ep.salary,
    CASE
      WHEN ep.salary > (2*avg_s.avg_title_salary) THEN 'Overpaid'
      WHEN ep.salary < (0.5*avg_s.avg_title_salary) THEN 'Underpaid'
      ELSE 'Normal'
    END status
  FROM employee_pay AS ep
  LEFT JOIN avg_salaries AS avg_s
  ON ep.title = avg_s.title
) AS _
WHERE status != 'Normal';
```

## Highest-Grossing Items ==> https://datalemur.com/questions/sql-highest-grossing
```sql
WITH product_spend_total AS (
  SELECT 
    category,
    product,
    SUM(spend) AS total_spend
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
), product_spend_total_ranked AS (
  SELECT
    *,
    RANK() OVER(PARTITION BY category ORDER BY total_spend DESC) AS rank
  FROM product_spend_total
)

SELECT
  category,
  product,
  total_spend
FROM product_spend_total_ranked
WHERE rank <= 2
ORDER BY category, rank;
```

## Signup Confirmation Rate ==> https://datalemur.com/questions/signup-confirmation-rate
```sql
WITH text_confirmations AS(
  SELECT 
    user_id,
    e.email_id,
    CASE 
      WHEN signup_action = 'Confirmed' THEN 1
      ELSE 0
    END AS confirmed
  FROM emails AS e
  LEFT JOIN texts AS t
  ON e.email_id = t.email_id
), text_confirmations_unique AS (
  SELECT
    user_id,
    SUM(confirmed) AS confirmed
  FROM text_confirmations
  GROUP BY user_id
)

SELECT 
  ROUND(AVG(confirmed), 2) AS confirmation_rate
FROM text_confirmations_unique
```

## Odd and Even Measurements ==> https://datalemur.com/questions/odd-even-measurements
```sql
WITH w_daily_time_rank AS (
  SELECT
    measurement_time::DATE as measurement_day,
    measurement_value,
    ROW_NUMBER() OVER(PARTITION BY measurement_time::DATE ORDER BY measurement_time::TIME) AS daily_time_rank
  FROM measurements
  )
, w_odd_even_cols AS (
  SELECT
    measurement_day,
    CASE
      WHEN (daily_time_rank % 2) != 0 THEN measurement_value
      ELSE 0
    END AS odd,
    CASE
      WHEN (daily_time_rank % 2) = 0 THEN measurement_value
      ELSE 0
    END AS even
  FROM w_daily_time_rank
)

SELECT
  measurement_day,
  SUM(odd) AS odd_sum,
  SUM(even) AS even_sum
FROM w_odd_even_cols
GROUP BY measurement_day
ORDER BY measurement_day;
```

## Histogram of Users and Purchases [Walmart SQL Interview Question] ==> https://datalemur.com/questions/histogram-users-purchases
***Solution 1***
```sql
WITH w_recent_transaction_date AS (
  SELECT 
    user_id,
    transaction_date,
    LAST_VALUE(transaction_date) OVER(PARTITION BY user_id ORDER BY transaction_date::DATE ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS recent_transaction_date
  FROM user_transactions
)

SELECT
  MAX(transaction_date) AS transaction_date,
  user_id,
  COUNT(1) AS purchase_count
FROM w_recent_transaction_date
WHERE transaction_date = recent_transaction_date
GROUP BY user_id
ORDER BY transaction_date;
```

***Solution 2***
```sql
SELECT
  MAX(ut.transaction_date) AS transaction_date,
  ut.user_id,
  COUNT(1) AS purchase_count
FROM user_transactions AS ut
INNER JOIN (
    SELECT 
      user_id,
      MAX(transaction_date) AS recent_transaction_date
    FROM user_transactions
    GROUP BY user_id
  ) AS recent_transactions
ON (ut.user_id = recent_transactions.user_id) AND (ut.transaction_date = recent_transactions.recent_transaction_date)
GROUP BY ut.user_id
ORDER BY transaction_date;
```

## User's Third Transactions [Uber SQL Interview Question] ==> https://datalemur.com/questions/sql-third-transaction
```sql
SELECT
  user_id,
  spend,
  transaction_date
FROM (
  SELECT 
    * ,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date::TIMESTAMP) AS transaction_num
  FROM transactions
) A
WHERE transaction_num = 3;
```

## Compressed Mode [Alibaba SQL interview Question] ==> https://datalemur.com/questions/alibaba-compressed-mode
```sql
SELECT 
  item_count as mode
FROM items_per_order
WHERE order_occurrences = (
  SELECT MAX(order_occurrences) FROM items_per_order
)
ORDER BY item_count ASC;
```
