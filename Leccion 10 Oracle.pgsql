-- Leccion 10 
-- diapositiva 10.1
-- subconsultas

/* SELECT select_list
 FROM table
 WHERE expression operator
 (SELECT select_list
 FROM table); */

SELECT first_name, last_name, 
hire_date
 FROM employees
 WHERE hire_date > 
(SELECT hire_date
 FROM employees
 WHERE last_name = 'Davis'); 

 SELECT last_name
 FROM employees
 WHERE department_id = 
(SELECT department_id
 FROM employees
 WHERE last_name = 'Grant');

SELECT last_name
 FROM employees
 WHERE department_id = 
(SELECT department_id
 FROM employees
 WHERE last_name = 'Grant');

-- diapositiva 10.2
-- subconsultas de una sola fila

 SELECT last_name, job_id, department_id
 FROM employees
 WHERE department_id = 
(SELECT department_id
 FROM departments
 WHERE department_name = 'Sales')
 ORDER BY job_id;

SELECT * FROM locations;

 SELECT last_name, job_id, salary, department_id
 FROM employees
 WHERE job_id = 
(SELECT job_id
 FROM employees 
WHERE employee_id= 101)
 AND department_id = 
(SELECT department_id
 FROM departments 
WHERE location_id= 1400);

SELECT last_name, salary
 FROM employees
 WHERE salary < 
(SELECT AVG(salary)
 FROM employees);

 SELECT department_id, MIN(salary)
 FROM employees
 GROUP BY department_id
 HAVING MIN(salary) >
 (SELECT MIN(salary)
 FROM employees
 WHERE department_id= 50);

SELECT department_id, MIN(salary)
 FROM employees
 GROUP BY department_id
 HAVING MIN(salary) >
 (SELECT MIN(salary)
 FROM employees
 WHERE department_id= 50);


-- diapositiva 10.3
-- subconsultas de varias filas

 SELECT first_name, last_name
 FROM employees
 WHERE salary = 
(SELECT salary
 FROM employees
 WHERE department_id = 50);

SELECT first_name, last_name
 FROM employees
 WHERE salary = 
(SELECT salary
 FROM employees
 WHERE department_id = 50);

SELECT last_name, hire_date
 FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) IN
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=80);

SELECT last_name, hire_date
 FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) IN
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=80);

 SELECT last_name, hire_date
 FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) < ANY
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=80);

 SELECT last_name, hire_date FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) < ALL
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=80);

 SELECT last_name, 
employee_id
 FROM employees
 WHERE employee_id IN
 (SELECT manager_id
 FROM employees);

 SELECT last_name, employee_id
 FROM employees
 WHERE employee_id <= ALL
 (SELECT manager_id
 FROM employees);

 SELECT department_id, MIN(salary)
 FROM employees
 GROUP BY department_id
 HAVING MIN(salary) < ANY
 (SELECT salary
 FROM employees
 WHERE department_id IN (10,20))
 ORDER BY department_id;

 SELECT employee_id, manager_id, department_id
 FROM employees
 WHERE(manager_id,department_id) IN
 (SELECT manager_id,department_id
 FROM   
employees
 WHERE  employee_id IN (149,174))
 AND employee_id NOT IN (149,174);


SELECT employee_id, manager_id, department_id
 FROM employees
 WHERE(manager_id,department_id) IN
 (SELECT manager_id,department_id
 FROM 
  employees
 WHERE  employee_id IN (149,174))
 AND employee_id NOT IN (149,174);


SELECT
    employee_id,
    manager_id,
    department_id
FROM
    employees
WHERE
    manager_id IN (
        SELECT manager_id
        FROM employees
        WHERE employee_id IN (1, 10)
    )
    AND department_id IN (
        SELECT department_id
        FROM employees
        WHERE employee_id IN (1, 10)
    )
    AND employee_id NOT IN (149, 174);


SELECT  employee_id,
 manager_id, 
department_id
 FROM    employees
 WHERE  manager_id IN 
(SELECT  manager_id
 FROM    employees
 WHERE   employee_id IN   
(1, 10))
 AND    department_id IN 
(SELECT  department_id
 FROM    employees
 WHERE   employee_id IN  
(1, 10))
 AND employee_id NOT IN(149,174);


SELECT manager_id
FROM employees
WHERE employee_id IN (1, 10);

SELECT department_id
FROM employees
WHERE employee_id IN (1, 10);

SELECT first_name, last_name, 
job_id
 FROM employees
 WHERE job_id =
 (SELECT job_id
 FROM employees
 WHERE last_name = 'Davis');

SELECT first_name, last_name, 
job_id
 FROM employees
 WHERE job_id =
 (SELECT job_id
 FROM employees
 WHERE last_name = 'IT');

SELECT first_name, last_name, 
job_id
 FROM employees
 WHERE job_id IN
 (SELECT job_id
 FROM employees
 WHERE last_name = 'Sales');

SELECT * FROM employees;

-- Diapositiva 10.4
-- subconsultas correlacionadasSELECT o.first_name,o.last_name, 
SELECT o.first_name, o.last_name, o.salary
FROM employees o
WHERE o.salary > (
    SELECT AVG(i.salary)
    FROM employees i
    WHERE i.department_id = o.department_id
);

SELECT o.first_name,          
o.last_name, o.salary
 FROM employees o
 WHERE o.salary > 
(SELECT AVG(i.salary)
 FROM employees i
 WHERE i.department_id = 
o.department_id);

 SELECT o.first_name,          
o.last_name, o.salary
 FROM employees o
 WHERE o.salary > 
(SELECT AVG(i.salary)
 FROM employees i
 WHERE i.department_id = 
o.department_id);


SELECT last_name AS "Not a Manager"
 FROM 
  employees emp 
WHERE NOT EXISTS 
(SELECT * 
FROM employees mgr
 WHERE  mgr.manager_id = emp.employee_id);

 SELECT last_name AS "Not a Manager"
 FROM 
  employees emp 
WHERE emp.employee_id NOT IN 
(SELECT mgr.manager_id
 FROM employees mgr);

 SELECT last_name AS "Not a Manager"
 FROM   
employees emp 
WHERE emp.employee_id NOT IN 
(SELECT mgr.manager_id
 FROM employees mgr);


/* WITH 
subquery-name AS (subquery), 
subquery-name AS (subquery)
 SELECT  column-list
 FROM    
 {table | subquery-name | view}
 WHERE  condition is true;  */

WITH managers AS
 (SELECT DISTINCT manager_id
 FROM employees
 WHERE manager_id IS NOT NULL)
 SELECT last_name AS "Not a manager"
 FROM employees
 WHERE employee_id NOT IN
(SELECT *
FROM managers);

