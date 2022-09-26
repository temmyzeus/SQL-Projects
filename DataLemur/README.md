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
