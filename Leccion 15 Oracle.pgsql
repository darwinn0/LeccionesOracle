-- Leccion 15

/*esto es para la creacion de vistas
 CREATE [OR REPLACE] [FORCE| NOFORCE] VIEW view [(alias [, 
alias]...)] AS subquery
 [WITH CHECK OPTION [CONSTRAINT constraint]]
 [WITH READ ONLY [CONSTRAINT constraint]]; */

 ALTER TABLE employees
ADD COLUMN email VARCHAR(255); 

CREATE VIEW view_employees
AS SELECT employee_id,first_name, last_name, email
FROM employees
WHERE employee_id BETWEEN 100 and 124;

SELECT * 
FROM view_employees;

ALTER TABLE wf_countries
ADD COLUMN capitol VARCHAR(100);

ALTER TABLE wf_countries
ADD COLUMN location VARCHAR(100);


CREATE OR REPLACE VIEW view_euro_countries AS
SELECT country_id, region_id, country_name, capitol
FROM wf_countries
WHERE location ILIKE '%Europe';

SELECT * FROM view_euro_countries
 ORDER BY country_name;

/*CREATE OR REPLACE VIEW view_euro_countries
 AS SELECT country_id, country_name, capitol
 FROM wf_countries
 WHERE location LIKE '%Europe'; */

 CREATE TABLE wf_world_regions (
    region_id SERIAL PRIMARY KEY, -- Un identificador único para cada región
    region_name VARCHAR(100) UNIQUE NOT NULL, -- El nombre de la región (ej. 'Europe', 'Asia')
    description TEXT -- Una descripción opcional de la región
);

CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees
WHERE department_id = 50;

UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;

CREATE OR REPLACE VIEW view_dept50_readonly
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50;

SELECT 
    ROW_NUMBER() OVER (ORDER BY hire_date) AS "Longest employed", 
    last_name, 
    hire_date
FROM employees
ORDER BY hire_date
LIMIT 5;

CREATE OR REPLACE VIEW view_high_salary_employees
AS SELECT 
    department_id AS "Department ID", 
    MAX(salary) AS "Highest salary"
FROM employees
GROUP BY department_id;

SELECT * FROM view_high_salary_employees;

CREATE OR REPLACE VIEW view_it_employees
AS SELECT employee_id, first_name, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT_%';

SELECT * FROM view_it_employees
ORDER BY salary DESC;