-- Leccion 12 
-- Diapositiva 12.1
-- Sentencias INSERT

CREATE TABLE copy_employees
AS (SELECT * FROM employees);

CREATE TABLE copy_departments
 AS (SELECT * FROM departments);

SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public' AND table_name = 'copy_employees'
ORDER BY
    ordinal_position;

SELECT * FROM copy_employees;

SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public' AND table_name = 'copy_departments'
ORDER BY
    ordinal_position;

 SELECT * FROM copy_departments;

INSERT INTO copy_departments
 (department_id, department_name, manager_id, location_id)
 VALUES (200,'Human Resources', 205, 1500);

 INSERT INTO copy_departments
 VALUES 
(210,'Estate Management', 102, 1700);

ALTER TABLE copy_employees
ADD COLUMN phone_number VARCHAR(20); 

INSERT INTO copy_employees (employee_id, first_name, last_name, phone_number, hire_date, job_id, salary)
VALUES
(302, 'Grigorz', 'Polanski', '8586667641', '2017-06-15', 'IT_PROG', 4200);

INSERT INTO copy_employees
 (employee_id, first_name, last_name, phone_number, 
hire_date, 
job_id, salary)
 VALUES
 (302,'Grigorz','Polanski', '8586667641', '15-Jun-2017',  
'IT_PROG',4200);

ALTER TABLE copy_employees
ADD COLUMN email VARCHAR(100); 

INSERT INTO copy_employees
 (employee_id, first_name, last_name, email, phone_number,    
hire_date, job_id, salary)
 VALUES
 (302,'Grigorz','Polanski', 'gpolanski', '', '15-Jun-2017', 'IT_PROG',4200);

INSERT INTO copy_employees
 (employee_id, first_name, last_name, email, phone_number,
hire_date,
job_id, salary)
 VALUES
 (304,'Test',USER, 't_user', 4159982010, CURRENT_DATE,
'ST_CLERK',2500);

SELECT first_name, TO_CHAR(hire_date,'Month, fmdd, yyyy')
 FROM employees
 WHERE employee_id = 101;

 INSERT INTO copy_employees
 (employee_id, first_name, last_name, email, phone_number, 
hire_date,job_id, salary)
 VALUES
 (301,'Katie','Hernandez', 'khernandez','8586667641', 
TO_DATE('July 8, 2017', 'Month fmdd, yyyy'),
 'MK_REP',4200);

INSERT INTO copy_employees
 (employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id, salary)
 VALUES
 (303,'Angelina','Wright', 'awright','4159982010', 
TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),
 'MK_REP', 3600); 

SELECT first_name, last_name, 
TO_CHAR(hire_date, 'dd-Mon-YYYY HH24:MI') As "Date and Time"
 FROM copy_employees
 WHERE employee_id = 303;

CREATE TABLE sales_reps (
    id INTEGER PRIMARY KEY,      
    name VARCHAR(50),               
    salary NUMERIC(10, 2),         
    commission_pct NUMERIC(4, 2)    
);

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

TRUNCATE TABLE sales_reps; 

INSERT INTO sales_reps (id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees;

-- Diapositiva 12.2
-- Actualizacion de valores de columna y suprecion de filas 

 UPDATE copy_employees
 SET phone_number = '123456'
 WHERE employee_id = 303;

 UPDATE copy_employees
 SET phone_number = '654321', last_name = 'Jones'
 WHERE employee_id >= 303;

 UPDATE copy_employees
 SET phone_number= '654321', last_name= 'Jones';

 UPDATE copy_employees
 SET salary = (SELECT salary
 FROM copy_employees
 WHERE employee_id = 100)
 WHERE employee_id = 101;

 UPDATE copy_employees
 SET salary = (SELECT salary
 FROM copy_employees
 WHERE employee_id= 100)
 WHERE employee_id = 101;

UPDATE copy_employees
 SET salary = (SELECT salary
 FROM copy_employees
 WHERE employee_id= 205), 
job_id= (SELECT job_id
 FROM copy_employees
 WHERE employee_id= 205)
 WHERE employee_id = 206;

 UPDATE  copy_employees
 SET salary  = (SELECT salary
 FROM employees
 WHERE employee_id = 205)
 WHERE employee_id = 202;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30) DEFAULT 'Desconocido' NOT NULL;

UPDATE copy_employees ce
SET department_name = d.department_name
FROM departments d
WHERE ce.department_id = d.department_id;

DELETE from copy_employees
 WHERE employee_id = 303;

DELETE FROM copy_employees
 WHERE  department_id =
 (SELECT department_id
 FROM   departments
 WHERE  department_name = 'Shipping');

SELECT d.manager_id
FROM employees d
GROUP BY d.manager_id
HAVING COUNT(d.employee_id) < 2;

UPDATE copy_employees
 SET last_name = (SELECT last_name
 FROM copy_employees
 WHERE employee_id = 999)
 WHERE employee_id = 101;

/*UPDATE employees SET department_id = 15
 WHERE employee_id = 100; */

DELETE FROM departments WHERE department_id= 10;

 UPDATE employees SET department_id = 10
 WHERE     department_id = 20;

SELECT
    e.employee_id,
    e.salary,
    d.department_name
FROM
    employees e
JOIN
    departments d USING (department_id)
WHERE
    e.job_id = 'ST_CLERK' AND d.location_id = 1500 
ORDER BY
    e.employee_id
FOR UPDATE; 

-- diapositiva 12.3
-- Valores defaul MERGE

CREATE TABLE my_employees (
    hire_date DATE DEFAULT CURRENT_DATE,
    first_name VARCHAR(15),           
    last_name VARCHAR(15)              
);

 INSERT INTO my_employees
 (hire_date, first_name, last_name)
 VALUES
 (DEFAULT, 'Angelina','Wright');

  INSERT INTO my_employees
 (first_name, last_name)
 VALUES
 ('Angelina','Wright');

 UPDATE my_employees
 SET hire_date = DEFAULT
 WHERE last_name = 'Wright';

/*MERGE INTO destination-table USING source-table
 ON matching-condition
 WHEN MATCHED THEN UPDATE
 SET ……
 WHEN NOT MATCHED THEN INSERT
 VALUES (……); */

 CREATE TABLE copy_empc (
    employee_id INTEGER PRIMARY KEY, 
    last_name VARCHAR(50),           
    department_id INTEGER
);

INSERT INTO copy_empc (employee_id, last_name, department_id) 
SELECT
    e.employee_id,
    e.last_name,
    e.department_id
FROM
    employees e
ON CONFLICT (employee_id) DO UPDATE SET
    last_name = EXCLUDED.last_name,      
    department_id = EXCLUDED.department_id;

INSERT INTO my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

CREATE TABLE copy_my_employees (
    hire_date DATE,                  
    first_name VARCHAR(15),          
    last_name VARCHAR(15)           
);

INSERT INTO copy_my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

CREATE TABLE all_calls (
    caller_id INTEGER,
    call_timestamp TIMESTAMP,
    call_duration INTEGER,
    call_format VARCHAR(10)
);

CREATE TABLE police_record_calls (
    caller_id INTEGER,
    call_timestamp TIMESTAMP,
    recipient_caller INTEGER 
);

CREATE TABLE short_calls (
    caller_id INTEGER,
    call_timestamp TIMESTAMP,
    call_duration INTEGER
);

CREATE TABLE long_calls (
    caller_id INTEGER,
    call_timestamp TIMESTAMP,
    call_duration INTEGER
);

CREATE TABLE calls (
    caller_id INTEGER,
    call_timestamp TIMESTAMP,
    call_duration INTEGER,
    call_format VARCHAR(10), 
    recipient_caller INTEGER 
);

INSERT INTO all_calls (caller_id, call_timestamp, call_duration, call_format)
SELECT
    caller_id,
    call_timestamp,
    call_duration,
    call_format
FROM
    calls
WHERE
    call_format IN ('tlk', 'txt', 'pic')
    AND call_timestamp::date = CURRENT_DATE; 

INSERT INTO police_record_calls (caller_id, call_timestamp, recipient_caller)
SELECT
    caller_id,
    call_timestamp,
    recipient_caller
FROM
    calls
WHERE
    call_format IN ('tlk', 'txt')
    AND call_timestamp::date = CURRENT_DATE;

INSERT INTO short_calls (caller_id, call_timestamp, call_duration)
SELECT
    caller_id,
    call_timestamp,
    call_duration
FROM
    calls
WHERE
    call_duration < 50
    AND call_format = 'tlk' 
    AND call_timestamp::date = CURRENT_DATE;


INSERT INTO long_calls (caller_id, call_timestamp, call_duration)
SELECT
    caller_id,
    call_timestamp,
    call_duration
FROM
    calls
WHERE
    call_duration >= 50
    AND call_format = 'tlk' 
    AND call_timestamp::date = CURRENT_DATE;

    