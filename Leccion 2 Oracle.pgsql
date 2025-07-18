-- LECCION 2

SELECT department_id || ' ' || department_name AS "DEPARTMENT_ID || DEPARTMENT_NAME"
FROM departments;

 SELECT department_id ||' '|| 
department_name  AS " Department Info "
 FROM departments;

SELECT first_name ||' '|| 
last_name AS "Employee Name"
 FROM employees;

SELECT last_name || ' has a monthly  
salary of ' || salary || ' 
dollars.' AS Pay 
FROM employees;

SELECT last_name ||' has a '|| 1 ||' year salary of '|| 
salary*12 || ' dollars.' AS Pay
 FROM employees;

SELECT employee_id
 FROM employees;
 
  SELECT DISTINCT employee_id
 FROM employees;
 
 -- dispositiva 2.2
 
 SELECT employee_id, first_name, 
last_name
 FROM employees;
 
 SELECT employee_id, first_name, 
last_name
 FROM employees
 WHERE employee_id = 8;
 
 SELECT employee_id, last_name, department_id
 FROM  employees
 WHERE department_id = 40;

 SELECT first_name, last_name
 FROM employees
 WHERE last_name = 'Lex';

SELECT last_name, salary
 FROM employees
 WHERE salary <= 3000;
 
 -- diapositiva 2.3
 
 SELECT last_name, salary
 FROM employees
 WHERE salary BETWEEN 9000 AND 11000;

 SELECT first_name, last_name
 FROM employees
 WHERE last_name = 'Lex';

SELECT last_name, salary
 FROM employees
 WHERE salary <= 3000;
 
 -- diapositiva 2.3
 
 SELECT last_name, salary
 FROM employees
 WHERE salary BETWEEN 9000 AND 11000;

SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT last_name, commission_pct
 FROM employees
 WHERE commission_pct IS NOT NULL;