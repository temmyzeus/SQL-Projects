# Hacker Rank Problems

## Occupations (https://www.hackerrank.com/challenges/occupations/problem)

**Solution 1**

```sql
WITH base_pivot AS (
    SELECT
        name,
        occupation,
        ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name ASC) AS row_number
    FROM occupations
    ),
pivot_2 AS (
    SELECT
        row_number,
        MAX(CASE WHEN occupation = 'Doctor' THEN name ELSE NULL END) AS Doctor,
        MAX(CASE WHEN occupation = 'Professor' THEN name ELSE NULL END) AS Professor,
        MAX(CASE WHEN occupation = 'Singer' THEN name ELSE NULL END) AS Singer,
        MAX(CASE WHEN occupation = 'Actor' THEN name ELSE NULL END) AS Actor
    FROM base_pivot
    GROUP BY row_number
    ORDER BY Doctor, Professor, Singer, Actor
    )
    
SELECT 
    CASE WHEN Doctor is NULL THEN 'NULL' ELSE Doctor END,
    CASE WHEN Professor is NULL THEN 'NULL' ELSE Professor END,
    CASE WHEN Singer is NULL THEN 'NULL' ELSE Singer END,
    CASE WHEN Actor is NULL THEN 'NULL' ELSE Actor END
FROM pivot_2;
```
**Solution 2**
```sql
WITH base_pivot AS (
    SELECT
        name,
        occupation,
        ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name ASC) AS row_number
    FROM occupations
    ),
pivot_2 AS (
    SELECT
        row_number,
        MAX(CASE occupation WHEN 'Doctor' THEN name ELSE NULL END) AS Doctor,
        MAX(CASE occupation WHEN 'Professor' THEN name ELSE NULL END) AS Professor,
        MAX(CASE occupation WHEN 'Singer' THEN name ELSE NULL END) AS Singer,
        MAX(CASE occupation WHEN 'Actor' THEN name ELSE NULL END) AS Actor
    FROM base_pivot
    GROUP BY row_number
    ORDER BY Doctor, Professor, Singer, Actor
    )
    
SELECT 
    CASE WHEN Doctor is NULL THEN 'NULL' ELSE Doctor END,
    CASE WHEN Professor is NULL THEN 'NULL' ELSE Professor END,
    CASE WHEN Singer is NULL THEN 'NULL' ELSE Singer END,
    CASE WHEN Actor is NULL THEN 'NULL' ELSE Actor END
FROM pivot_2;
```
