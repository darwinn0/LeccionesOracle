-- diapositiva 8.1

SELECT MAX(salary)
 FROM employees;

SELECT MAX(salary)
 FROM employees;

SELECT
    last_name,
    first_name
FROM
    employees
WHERE
    salary = (SELECT MIN(salary) FROM employees); 

SELECT * FROM wf_countries;

ALTER TABLE wf_countries
ADD COLUMN life_expect_at_birth NUMERIC(5, 2); 

UPDATE wf_countries
SET life_expect_at_birth = 75.50
WHERE country_id = 1; 

UPDATE wf_countries
SET life_expect_at_birth = 81.25
WHERE country_name = 'Canada';

SELECT MIN("life_expect_at_birth") AS "Lowest Life Exp" FROM "wf_countries";


 SELECT MIN(country_name)
 FROM wf_countries;

SELECT MIN(hire_date)
 FROM employees;

SELECT MAX(life_expect_at_birth) 
AS "Highest Life Exp"
 FROM wf_countries;

 SELECT MAX(country_name)
 FROM wf_countries;

SELECT MAX(hire_date)
 FROM employees; 

ALTER TABLE wf_countries
ADD COLUMN area NUMERIC(15, 2); 

ALTER TABLE wf_countries
ADD COLUMN region_id INTEGER;

UPDATE wf_countries
SET
    area = 110000.00, 
    region_id = 29    
WHERE country_id = 1; 

UPDATE wf_countries
SET
    area = 24000.50,
    region_id = 29
WHERE country_name = 'Canada'; 

SELECT SUM(area)
 FROM wf_countries
 WHERE region_id = 29;

SELECT SUM(salary)
 FROM employees
 WHERE department_id = 80; 

SELECT SUM(area) 
FROM wf_countries;

SELECT SUM (salary)
 FROM employees
 WHERE department_id= 80;

SELECT SUM(area) 
FROM wf_countries;

SELECT SUM (salary)
 FROM employees
 WHERE department_id= 80;

 SELECT AVG(commission_pct)
 FROM employees;

SELECT MAX(salary), MIN(salary), MIN(employee_id)
 FROM employees
 WHERE department_id = 60;

-- diapositiva 8.2

 SELECT COUNT(job_id)
 FROM employees;

 SELECT commission_pct
 FROM employees;

SELECT COUNT(commission_pct)
 FROM employees;

SELECT COUNT(*) 
FROM employees
 WHERE hire_date < '01-Jan-1996';

SELECT COUNT(*) 
FROM employees
 WHERE hire_date < '01-Jan-1996';

SELECT job_id
 FROM employees;

SELECT DISTINCT job_id
 FROM employees;

SELECT DISTINCT job_id,   
department_id
 FROM employees;

 SELECT DISTINCT job_id,   
department_id
 FROM employees;

SELECT SUM(salary)
 FROM employees
 WHERE department_id = 80;

SELECT SUM(DISTINCT salary)
 FROM employees
 WHERE department_id = 80;

 SELECT COUNT (DISTINCT 
job_id)
 FROM employees;

 SELECT COUNT (DISTINCT salary)
 FROM employees;

SELECT AVG(commission_pct)
 FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;

SELECT AVG(commission_pct)
 FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
 FROM employees;

