-- Leccion 9

-- diapositiva 9.1
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY, -- Un ID único para cada estudiante
    height NUMERIC(5, 2),          -- Altura del estudiante (ej. 1.75 metros o 175.5 cm)
    year_in_school INTEGER         -- Año escolar del estudiante (ej. 10, 11, 12)
);

INSERT INTO students (height, year_in_school) VALUES
(170.5, 10),
(165.2, 10),
(180.0, 10),
(172.8, 11),
(175.0, 11),
(168.9, 11),
(185.1, 12),
(178.4, 12),
(171.0, 12),
(160.0, 10);

SELECT AVG(height) FROM students WHERE year_in_school = 10;
 SELECT AVG(height) FROM students WHERE year_in_school = 11;
 SELECT AVG(height) FROM students WHERE year_in_school = 12;

SELECT department_id, AVG(salary)
 FROM employees
 GROUP BY department_id
 ORDER BY department_id;

SELECT department_id, AVG(salary)
 FROM employees
 GROUP BY department_id
 ORDER BY department_id;

SELECT MAX(salary)
 FROM employees
 GROUP BY department_id;

 SELECT department_id, MAX(salary)
 FROM employees
 GROUP BY department_id;

SELECT
    job_id,
    AVG(salary) AS average_salary 
FROM
    employees
GROUP BY
    job_id;

SELECT
    COUNT(country_name),
    region_id
FROM
    wf_countries
GROUP BY
    region_id
ORDER BY
    region_id;

SELECT COUNT(*), region_id
 FROM wf_countries
 GROUP BY region_id
 ORDER BY region_id;

SELECT department_id, MAX(salary)
 FROM employees
 WHERE last_name!= 'King'
 GROUP BY department_id;

ALTER TABLE wf_countries
ADD COLUMN population BIGINT; 

UPDATE wf_countries
SET population = 331800000 
WHERE country_id = 1;

UPDATE wf_countries
SET population = 10000000 
WHERE country_name = 'Honduras';

SELECT region_id, ROUND(AVG(population)) AS population
 FROM wf_countries
 GROUP BY region_id
 ORDER BY region_id;

CREATE TABLE wf_spoken_languages (
    country_id INTEGER NOT NULL, 
    language_id INTEGER NOT NULL,  
    PRIMARY KEY (country_id, language_id), 
    FOREIGN KEY (country_id) REFERENCES wf_countries(country_id)

);

INSERT INTO wf_spoken_languages (country_id, language_id) VALUES
(1, 101), 
(1, 102), 
(2, 101), 
(3, 103), 
(3, 104); 

SELECT country_id, COUNT(language_id) AS "Number of 
languages"
 FROM wf_spoken_languages
 GROUP BY country_id;

SELECT department_id, job_id, 
count(*)
 FROM employees
 WHERE department_id > 40
 GROUP BY department_id, job_id;

SELECT department_id, job_id, 
count(*)
 FROM employees
 WHERE department_id > 40
 GROUP BY department_id, job_id;


SELECT
    AVG(salary) AS avg_salary
FROM
    employees
GROUP BY
    department_id;

SELECT
    department_id,
    MAX(salary) AS max_salary_in_department
FROM
    employees
GROUP BY
    department_id
HAVING
    COUNT(*) > 1; 


 SELECT department_id,MAX(salary)
 FROM employees
 GROUP BY department_id
 HAVING COUNT(*)>1
 ORDER BY department_id;



 SELECT region_id,
 ROUND(AVG(population))
 FROM wf_countries
 GROUP BY region_id
 HAVING MIN(population)>300000
 ORDER BY region_id;


-- diapositiva 9.2

 SELECT AVG(height) FROM students;

 SELECT AVG(height) FROM students WHERE year_in_school = 10;
 SELECT AVG(height) FROM students WHERE year_in_school = 11;
 SELECT AVG(height) FROM students WHERE year_in_school = 12;

 SELECT department_id, job_id, SUM(salary)
 FROM employees
 WHERE department_id< 50
 GROUP BY ROLLUP (department_id, job_id);

 SELECT department_id, job_id, SUM(salary)
 FROM employees
 WHERE department_id < 50
 GROUP BY ROLLUP (department_id, job_id);

 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE department_id< 50
 GROUP BY (department_id, job_id);

 SELECT department_id, job_id, SUM(salary)
 FROM employees
 WHERE department_id< 50
 GROUP BY CUBE (department_id, job_id);

SELECT department_id, job_id, manager_id, SUM(salary)
 FROM employees
 WHERE department_id < 50
 GROUP BY GROUPING SETS
 ((job_id, manager_id),(department_id, job_id),
 (department_id, manager_id));

SELECT department_id, job_id, SUM(salary),
 GROUPING(department_id) AS "Dept sub total",
 GROUPING(job_id) AS "Job sub total"
 FROM employees
 WHERE department_id< 50
 GROUP BY CUBE (department_id, job_id);

-- diapositiva 9.3
-- uso de operadores set

CREATE TABLE A (
    A_ID INTEGER PRIMARY KEY 
);

CREATE TABLE B (
    B_ID INTEGER PRIMARY KEY 
);

INSERT INTO A (A_ID) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO B (B_ID) VALUES
(4),
(5),
(6),
(7),
(8);

SELECT a_id
 FROM a
 UNION
 SELECT b_id
 FROM b; 

SELECT a_id
 FROM a
 UNION  ALL 
SELECT b_id
 FROM b; 

SELECT a_id
 FROM a
 INTERSECT
 SELECT b_id
 FROM b;

SELECT A_ID
FROM A
EXCEPT
SELECT B_ID
FROM B;

SELECT
    hire_date,
    employee_id,
    job_id
FROM
    employees

UNION

SELECT
    CAST(NULL AS DATE), 
    employee_id,
    job_id
FROM
    job_history;


SELECT
    hire_date,
    employee_id,
    job_id
FROM
    employees

UNION

SELECT
    CAST(NULL AS DATE),
    employee_id,
    job_id
FROM
    job_history

ORDER BY
    employee_id; 

SELECT
    hire_date,
    employee_id,
    job_id
FROM
    employees

UNION

SELECT
    CAST(NULL AS DATE), 
    employee_id,
    job_id
FROM
    job_history

ORDER BY
    employee_id; 

SELECT hire_date, employee_id, CAST(NULL AS DATE) start_date, 
CAST(NULL AS DATE) end_date, job_id, department_id
 FROM   employees
 UNION
 SELECT CAST(NULL AS DATE), employee_id, start_date, end_date, 
job_id, department_id
 FROM job_history
 ORDER BY employee_id;


