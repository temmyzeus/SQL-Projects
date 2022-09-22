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

**Solution 3**
```sql
SELECT 
	dept_id,
	salary
FROM (
	SELECT
		dept_id,
		salary,
		COUNT(*) OVER(PARTITION BY dept_id, salary) AS count_dups
	FROM emp_Salary
) AS s
WHERE count_dups > 1;
```

# Double Joins (https://www.youtube.com/watch?v=8glk10JlvKE)

**Creation Script**
```sql
create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 12000,4,37);
insert into emp
values (4, 'Rohit', 100, 14000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 20000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',500,7000,6,50);

```

**Solution**
```sql
SELECT
	emp.emp_id as employee_id,
	emp.emp_name as employee_name,
	mng.emp_name as manager_name,
	mng_mng.emp_name as senior_manager
FROM emp emp
LEFT JOIN emp mng
ON emp.manager_id = mng.emp_id
LEFT JOIN emp mng_mng
ON mng.manager_id = mng_mng.emp_id
ORDER BY emp.emp_id;

-- Use left join incase someone does not have a manager
```
