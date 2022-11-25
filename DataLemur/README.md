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
