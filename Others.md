## By Ankit Bansal (https://www.youtube.com/watch?v=TvqKpz9RO-A&t=162s)
**Create**
```sql
CREATE TEMP TABLE emp_salary
(
    emp_id INTEGER,
    name VARCHAR(20),
    salary VARCHAR(30),
    dept_id INTEGER

INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');
```

**Solution 1**
```sql
WITH sal_dept_dup AS (
	SELECT 
		dept_id, salary
	FROM emp_salary
	GROUP BY dept_id, salary
	HAVING COUNT(1) > 1
	ORDER BY dept_id
)

SELECT
	es.*
FROM emp_salary es
INNER JOIN sal_dept_dup sdd
ON (es.dept_id = sdd.dept_id) AND (es.salary = sdd.salary);
```

**Solution 2**
```sql
WITH sal_dept_dup AS (
	SELECT 
		dept_id, salary
	FROM emp_salary
	GROUP BY dept_id, salary
	HAVING COUNT(1) > 1
	ORDER BY dept_id
)

SELECT
	es.*
FROM emp_salary es
LEFT JOIN sal_dept_dup sdd
ON (es.dept_id = sdd.dept_id) AND (es.salary = sdd.salary)
WHERE (sdd.dept_id IS NOT NULL) AND (sdd.salary IS NOT NULL);
```

**Solution 2 Tweak** 
```sql
WITH sal_dept_dup AS (
	SELECT 
		dept_id, salary
	FROM emp_salary
	GROUP BY dept_id, salary
	HAVING COUNT(1) = 1
	ORDER BY dept_id
)

SELECT
	es.*
FROM emp_salary es
LEFT JOIN sal_dept_dup sdd
ON (es.dept_id = sdd.dept_id) AND (es.salary = sdd.salary)
WHERE (sdd.dept_id IS NULL) AND (sdd.salary IS NULL);
```
