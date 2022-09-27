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
