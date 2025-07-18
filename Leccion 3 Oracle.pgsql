-- Leccion 3
-- Diapositiva 3.1

SELECT last_name, department_id, salary
 FROM employees
 WHERE department_id > 50 AND salary > 12000;

SELECT last_name, hire_date, job_id
 FROM employees
 WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%';

SELECT department_name, manager_id, location_id
 FROM departments
 WHERE location_id = 2500 OR manager_id=124;

SELECT department_name, location_id
 FROM departments
 WHERE location_id NOT IN (1700,1800);

SELECT last_name||' '||salary*1.05 AS "Employee Raise"
 FROM employees
 WHERE department_id IN(50,80) AND first_name LIKE 'C%' 
OR last_name LIKE '%s%';

SELECT last_name||' '||salary*1.05 
AS "Employee Raise", department_id, 
first_name
 FROM employees
 WHERE department_id IN(50,80) 
AND first_name LIKE 'C%' 
OR last_name LIKE '%s%';

-- Diapositiva 3.2

SELECT last_name, hire_date
 FROM employees
 ORDER BY hire_date;

SELECT last_name, hire_date
 FROM employees
 ORDER BY hire_date DESC;

SELECT last_name, hire_date 
AS "Date Started"
 FROM employees
 ORDER BY "Date Started";

SELECT employee_id, 
first_name
 FROM employees
 WHERE employee_id < 105
 ORDER BY last_name;

SELECT department_id, last_name
 FROM employees
 WHERE department_id <= 50 
ORDER BY department_id, 
last_name;

SELECT department_id, 
last_name
 FROM employees
 WHERE department_id <= 50 
ORDER BY department_id DESC, 
last_name;

-- Diapositiva 3.3
-- no hay sentencias para ejecutar