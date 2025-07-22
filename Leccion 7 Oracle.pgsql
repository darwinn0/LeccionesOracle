-- diapositiva 7.1
SELECT employees.last_name, employees.job_id, jobs.job_title
 FROM employees, jobs 
WHERE employees.job_id = jobs.job_id;

SELECT employees.last_name, departments.department_name
 FROM employees, departments
 WHERE employees.department_id= departments.department_id;

SELECT last_name, e.job_id, job_title
 FROM employees e, jobs j 
WHERE e.job_id= j.job_id
 AND department_id= 80;

SELECT
    e.last_name,
    e.job_id, 
    j.job_title
FROM
    employees e 
INNER JOIN
    jobs j ON e.job_id = j.job_id 
WHERE
    e.department_id = 80; 

SELECT employees.last_name, departments.department_name
 FROM employees, departments;

SELECT employees.last_name, employees.job_id, jobs.job_title
 FROM employees, jobs 
WHERE employees.job_id = jobs.job_id
 AND employees.department_id = 80;

 SELECT last_name, city
 FROM employees e, departments d, 
locations l
 WHERE e.department_id = d.department_id
 AND d.location_id = l.location_id;

-- diapositiva 7.2
 SELECT last_name, city
 FROM employees e, departments d, 
locations l
 WHERE e.department_id = d.department_id
 AND d.location_id = l.location_id;

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e 
LEFT OUTER JOIN
    departments d ON e.department_id = d.department_id; 

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e 
RIGHT OUTER JOIN
    departments d ON e.department_id = d.department_id;


SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
FULL OUTER JOIN
    departments d ON e.department_id = d.department_id;

/* SELECT table1.column, table2.column
 FROM table1, table2
 WHERE table1.column = table2.column(+);

 SELECT table1.column, table2.column
 FROM table1, table2
 WHERE table1.column(+) = table2.column; 

 SELECT table1.column, table2.column
 FROM table1, table2
 NEVER table1.column(+) = table2.column(+);

estos son ejemplos de sintaxis que aparece en la diapositiva */

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e 
LEFT OUTER JOIN
    departments d ON e.department_id = d.department_id; 

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e 
RIGHT OUTER JOIN
    departments d ON e.department_id = d.department_id; 


SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e 
FULL OUTER JOIN
    departments d ON e.department_id = d.department_id;

