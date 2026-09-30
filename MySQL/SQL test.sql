Use parks_and_recreation;

SELECT 
    first_name, last_name, birth_date
FROM
    employee_demographics;
    
SELECT DISTINCT
    gender
FROM
    employee_demographics;
    
Select * from employees.salaries;

Select * From employee_salary
Where first_name = "Leslie";

Select * From employee_salary
Where salary <= 50000;

SELECT 
    *
FROM
    employee_demographics
Where birth_date > '1985-01-01'
Or gender = "Male";


SELECT 
    *
FROM
    employee_demographics
Where (first_name = "Leslie" And age = 44) Or age > 55;

SELECT 
    *
FROM
    employee_demographics
Where first_name Like "a%";

SELECT 
    *
FROM
    employee_demographics
Where first_name Like "a__";

SELECT 
    *
FROM
    employee_demographics
Where birth_date Like "1989%";

SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation
FROM employee_salary
GROUP BY occupation;

SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY 5, 4;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

Select occupation, AVG(salary) as salary 
From employee_salary
Where occupation Like "%manager%" 
Group by occupation
Having salary > 75000;

SELECT *
FROM employee_demographics
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age desc
LIMIT 3;

SELECT 
    *
FROM
    employee_demographics
ORDER BY age DESC
LIMIT 2 , 1;

SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
Having Avg_age > 40;

Use parks_and_recreation

SELECT 
    ed.employee_id, age, occupation
FROM
    employee_demographics ed
        JOIN
    employee_salary es ON ed.employee_id = es.employee_id;
    
SELECT 
    *
FROM
    employee_salary sal
        LEFT JOIN
    employee_demographics dem ON dem.employee_id = sal.employee_id;
    
SELECT 
    *
FROM
    employee_salary sal
        RIGHT JOIN
    employee_demographics dem ON dem.employee_id = sal.employee_id;
    
SELECT 
    *
FROM
    employee_salary emp1
        JOIN
    employee_salary emp2 ON emp1.employee_id = emp2.employee_id;
    
SELECT 
    *
FROM
    employee_salary emp1
        JOIN
    employee_salary emp2 ON emp1.employee_id + 1 = emp2.employee_id;
    
SELECT 
    emp1.employee_id AS emp_santa,
    emp1.first_name AS santa_first_name,
    emp1.last_name AS santa_last_name,
    emp2.employee_id,
    emp2.first_name,
    emp2.last_name
FROM
    employee_salary emp1
        JOIN
    employee_salary emp2 ON emp1.employee_id + 1 = emp2.employee_id;
    
SELECT 
    dem.*, sal.dept_id, dept.department_name 
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
        JOIN
    parks_departments dept ON dept.department_id = sal.dept_id;
    
SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION SELECT 
    occupation, salary
FROM
    employee_salary;

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION SELECT 
    first_name, last_name
FROM
    employee_salary;
    
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'Old' as Label
FROM employee_demographics
WHERE age > 50;

SELECT 
    first_name, last_name, 'Old Lady' AS Label
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'Female' 
UNION SELECT 
    first_name, last_name, 'Old Man'
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'Male' 
UNION SELECT 
    first_name, last_name, 'Highly Paid Employee'
FROM
    employee_salary
WHERE
    salary >= 70000
ORDER BY first_name;

SELECT LENGTH('sky');

SELECT first_name, LENGTH(first_name) 
FROM employee_demographics;

SELECT UPPER('sky');

SELECT first_name, UPPER(first_name) 
FROM employee_demographics;

SELECT LOWER('sky');

SELECT first_name, LOWER(first_name) 
FROM employee_demographics;

SELECT TRIM('sky   ');

SELECT LTRIM('     I           love          SQL');

SELECT LTRIM('     I love SQL');

SELECT RTRIM('I love SQL    ');

SELECT LEFT('Alexander', 4);

SELECT first_name, LEFT(first_name,4) 
FROM employee_demographics;

SELECT RIGHT('Alexander', 6);

SELECT first_name, RIGHT(first_name,4) 
FROM employee_demographics;

SELECT SUBSTRING('Alexander', 2, 3);

SELECT birth_date, SUBSTRING(birth_date,1,4) as birth_year
FROM employee_demographics;

SELECT REPLACE(first_name,'a','z')
FROM employee_demographics;

SELECT LOCATE('x', 'Alexander');

SELECT LOCATE('e', 'Alexander');

SELECT first_name, LOCATE('a',first_name) 
FROM employee_demographics;

SELECT CONCAT('Alex', 'Freberg');

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END As age_bracket
FROM employee_demographics;

SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 50000 THEN salary + (salary * 0.05)
        WHEN salary >= 50000 THEN salary + (salary * 0.07)
    END AS new_salary,
    CASE
        WHEN dept_id = 6 THEN salary * .10
    END AS bonus
FROM
    employee_salary;
    
SELECT 
    *
FROM
    employee_demographics
WHERE
    employee_id IN (SELECT 
            employee_id
        FROM
            employee_salary
        WHERE
            dept_id = 1);
            
SELECT 
    first_name,
    salary,
    (SELECT 
            AVG(salary)
        FROM
            employee_salary) As avg_salary
FROM
    employee_salary;
    
SELECT AVG(max_age)
FROM (SELECT gender, MIN(age) as min_age, MAX(age) as max_age, COUNT(age) as count_age , AVG(age) as avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table;

SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.employee_id, dem.first_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary desc) rank_1,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary desc) dense_rank_2
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
WITH CTE_Example AS 
(
SELECT gender, SUM(salary) as sum_sal, MIN(salary) as min_sal, MAX(salary) as max_sal, 
COUNT(salary) as count_sal, AVG(salary) as avg_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example;

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary >= 50000
)
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;
    
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES ('Alex','Freberg','Lord of the Rings: The Twin Towers');

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM salary_over_50k;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

CALL large_salaries();

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

DELIMITER ;

CALL large_salaries2();

DROP procedure IF EXISTS `large_salaries3`;
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
    AND employee_id_param = employee_id;
END $$

DELIMITER ;



CALL large_salaries3(1);

DELIMITER $$

CREATE TRIGGER employee_insert2
AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name) VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$

DELIMITER ; 

SELECT * FROM employee_salary;

SELECT * FROM employee_demographics;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

SET SQL_SAFE_UPDATES = 0;

DELETE FROM employee_salary
WHERE employee_id = 13;

DELETE FROM employee_demographics
WHERE employee_id = 13;

DROP EVENT IF EXISTS delete_retirees;
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ;

SELECT * 
FROM employee_demographics;

Show Variables Like 'event%';