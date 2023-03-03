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

## Weather Observation Station 18 (https://www.hackerrank.com/challenges/weather-observation-station-18/problem)
**Solution1 -> Uses CTE**
```sql
WITH coordinates AS (
    SELECT 
        MIN(lat_n) AS a,
        MIN(long_w) AS b,
        MAX(lat_n) AS c,
        MAX(long_w) AS d
    FROM station)
    
SELECT
    ROUND(ABS(a - c) + ABS(b - d), 4) AS manhattan_distance
FROM coordinates;
```
**Solution 2**
```sql
SELECT 
  ROUND(
    ABS(
      MIN(lat_n) - MAX(lat_n)
    ) + ABS(
      MIN(long_w) - MAX(long_w)
    ), 
    4
  ) AS manhattan_distance 
FROM 
  station;
```

## Weather Observation Station 19 (https://www.hackerrank.com/challenges/weather-observation-station-19/problem)
```sql
SELECT 
  ROUND(
    SQRT(
      POWER(
        MAX(lat_n) - MIN(lat_n), 
        2
      ) + POWER(
        MAX(long_w) - MIN(long_w), 
        2
      )
    ), 
    4
  ) 
FROM 
  station;
```

## Contest Leaderboard (https://www.hackerrank.com/challenges/contest-leaderboard/)
```sql
select
    s.hacker_id,
    h.name,
    total_Score
from (
    select
        hacker_id,
        sum(max_score) as total_score
    from (
        select 
            hacker_id,
            challenge_id,
            max(score) as max_score
        from submissions
        group by hacker_id, challenge_id
    ) a
    group by hacker_id
) s
inner join hackers h
on (s.hacker_id = h.hacker_id) and (s.total_score != 0)
order by total_score desc, hacker_id asc;
```

```sql
select
    s.hacker_id,
    h.name,
    total_Score
from (
    select
        hacker_id,
        sum(max_score) as total_score
    from (
        select 
            hacker_id,
            challenge_id,
            max(score) as max_score
        from submissions
        group by hacker_id, challenge_id
    ) a
    group by hacker_id
) s
inner join hackers h
on s.hacker_id = h.hacker_id
where (s.total_score != 0)
order by total_score desc, hacker_id asc;
```
