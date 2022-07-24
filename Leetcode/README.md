# Leetcode SQL Study Plan 1

## Questions
#### 595. Big Countries https://leetcode.com/problems/big-countries/
Solution:

```sql
SELECT 
    name, population, area
FROM 
    World
WHERE 
    (area >= 3000000) OR (population >= 25000000);
```

OR

```sql
SELECT 
    name, population, area
FROM 
    World
WHERE 
    area >= 3000000

UNION

SELECT
    name, population, area
FROM 
    World
WHERE 
    population >= 25000000
;
```

####1757. Recyclable and Low Fat Products https://leetcode.com/problems/recyclable-and-low-fat-products/

```sql
SELECT product_id
FROM Products
WHERE (low_fats = "Y") AND (recyclable = "Y");
```
