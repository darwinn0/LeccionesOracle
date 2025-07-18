CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    city VARCHAR(30),
    state_province VARCHAR(25),
    country_id CHAR(2)
);

INSERT INTO LOCATIONS (location_id, city, state_province, country_id) VALUES (1, 'London', NULL, 'UK');
INSERT INTO LOCATIONS (location_id, city, state_province, country_id) VALUES (2, 'Oxford', NULL, 'UK');
INSERT INTO LOCATIONS (location_id, city, state_province, country_id) VALUES (3, 'Toronto', 'Ontario', 'CA');
INSERT INTO LOCATIONS (location_id, city, state_province, country_id) VALUES (4, 'Vancouver', 'British Columbia', 'CA');
INSERT INTO LOCATIONS (location_id, city, state_province, country_id) VALUES (5, 'New York', 'New York', 'US');

 SELECT department_name 
FROM  
 departments;

SELECT department_name 
FROM  
 departments;

SELECT salary
 FROM employees
 WHERE last_name LIKE
 'Smith';

SELECT * 
FROM countries;

SELECT country_id, country_name, region_id
 FROM countries;

SELECT location_id, city, state_province
 FROM locations;

SELECT last_name, salary, 
salary + 300
 FROM employees;

SELECT last_name, salary, 
12*salary +100
 FROM employees;

SELECT last_name, job_id, salary, commission_pct, 
salary*commission_pct
 FROM employees;

SELECT last_name AS name,  
commission_pct AS comm
 FROM employees;

CREATE TABLE DEPARTMENTS (
    department_id   SERIAL PRIMARY KEY,      -- SERIAL para IDs autoincrementales, NUMBER según DESC
    department_name VARCHAR(30) UNIQUE NOT NULL, -- VARCHAR2(30) según DESC, UNIQUE y NOT NULL es buena práctica
    manager_id      INTEGER,                 -- NUMBER según DESC
    location_id     INTEGER                  -- NUMBER según DESC
);

INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (10, 'Administration', NULL, NULL);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (20, 'Marketing', NULL, NULL);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (30, 'Shipping', 124, 1500); 
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (40, 'IT', NULL, NULL);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (50, 'Sales', 149, 2500); 

CREATE TABLE EMPLOYEES (
    employee_id    SERIAL PRIMARY KEY,      -- INTEGER según imagen, SERIAL para autoincremento
    first_name     VARCHAR(20),             -- character varying según imagen
    last_name      VARCHAR(25) NOT NULL,    -- character varying según imagen, NOT NULL es común para apellido
    email          VARCHAR(100) UNIQUE NOT NULL, -- No está explícitamente en la imagen de estructura, pero es muy común y esencial. Lo añado como buena práctica. Si no lo necesitas, puedes omitirlo.
    phone_number   VARCHAR(20),             -- Añadido como campo común, no en la imagen de estructura
    hire_date      DATE NOT NULL,           -- date según imagen, NOT NULL es común
    job_id         VARCHAR(10) NOT NULL,    -- character varying según imagen
    salary         NUMERIC(8, 2) NOT NULL,  -- numeric según imagen, NOT NULL es común
    commission_pct NUMERIC(2, 2),           -- numeric según imagen
    manager_id     INTEGER,                 -- integer según imagen
    department_id  INTEGER                  -- integer según imagen
);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (4, 'Ellen', 'Abel', 12000.00, 60, 'IT_PROG', 101, 0.05, '1999-06-17');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (2, 'Curtis', 'Davies', 0.00, 80, 'HR_REP', 102, 0.00, '1998-09-20');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (3, 'Lex', 'De Haan', 0.00, 80, 'SA_REP', 102, 0.10, '1998-09-20');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (5, 'Jane', 'Smith', 15000.00, NULL, 'HR_REP', 100, 0.00, '2000-03-01');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (9, 'Jane', 'Smith', 55000.00, 10, 'PU_CLERK', NULL, NULL, NULL); -- Nota: los datos para este registro parecen inconsistentes entre las imágenes, usaré los de image_4f30a1.png para salary, department_id y image_4f253b.png para manager_id, commission_pct, hire_date
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (1, 'Ellen', 'Abel', 0.00, 60, 'IT_PROG', 101, 0.15, '1999-06-17');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (7, 'Lex', 'De Haan', 15000.00, 80, 'SA_REP', 102, 0.10, '1999-05-24');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (8, 'Lex', 'De Haan', 20000.00, 80, 'SA_REP', 102, 0.10, '1999-05-24');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (6, 'Lex', 'De Haan', 20000.00, 80, 'SA_REP', 102, 0.10, '1999-05-24'); -- Duplicado de 8, pero presente en la imagen
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (10, 'Juan', 'López', 22500.00, 50, NULL, 103, NULL, '2001-01-15'); -- Datos de image_4f253b.png y image_4f30a1.png

-- Los siguientes son los "Manager" que aparecen solo en la imagen image_4f253b.png
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (100, 'Manager', 'Admin', 50000.00, NULL, 'AD_MGR', NULL, NULL, '1990-01-01');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (101, 'Manager', 'IT', 55000.00, NULL, 'IT_MGR', NULL, NULL, '1991-01-01');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (102, 'Manager', 'Sales', 60000.00, NULL, 'SA_MGR', NULL, NULL, '1992-01-01');
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, salary, department_id, job_id, manager_id, commission_pct, hire_date) VALUES (103, 'Manager', 'General', 65000.00, NULL, 'GEN_MGR', NULL, NULL, '1993-01-01');

