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

#### 1757. Recyclable and Low Fat Products https://leetcode.com/problems/recyclable-and-low-fat-products/

```sql
SELECT product_id
FROM Products
WHERE (low_fats = "Y") AND (recyclable = "Y");
```

#### 584. Find Customer Referee https://leetcode.com/problems/find-customer-referee/
```sql
SELECT name
FROM Customer
WHERE (referee_id != 2) OR (referee_id IS NULL);
```

#### 183. Customers Who Never Order https://leetcode.com/problems/customers-who-never-order/
```sql
SELECT name as Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.id IS NULL;
```
#### 1873. Calculate Special Bonus https://leetcode.com/problems/calculate-special-bonus/
```sql
SELECT
    employee_id,
    CASE WHEN (MOD(employee_id, 2) = 1) AND (name NOT LIKE "M%") THEN (salary * 1.0)
        ELSE 0 END AS bonus
FROM Employees
ORDER BY employee_id;
```
