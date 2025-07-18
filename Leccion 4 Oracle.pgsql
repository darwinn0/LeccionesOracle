-- LECCION 4
-- DIAPOSIRIVA 4.1

SELECT (319.0 / 29) + 12;

SELECT last_name
 FROM employees
 WHERE LOWER(last_name) = 'abel';

SELECT last_name
 FROM employees 
 WHERE UPPER(last_name) = 'ABEL';

SELECT last_name
 FROM employees
 WHERE INITCAP(last_name) = 'Abel';

SELECT REPLACE('Hola mundo, hola PostgreSQL', 'hola', 'adiós');

SELECT REPLACE(last_name,'a','*')
 FROM employees;

SELECT LOWER(last_name)|| 
LOWER(SUBSTR(first_name,1,1))
 AS "User Name"
 FROM employees;

SELECT LOWER (last_name)||LOWER(SUBSTR(first_name,1,1)) 
FROM employees;

SELECT first_name, last_name, salary, department_id
 FROM employees
 WHERE department_id= 10;

 --SELECT first_name, last_name, salary, department_id
 --FROM employees
 --WHERE department_id=:enter_dept_id;

--SELECT *
 --FROM  employees
 --WHERE last_name = :l_name;

-- Diapositiva 4.2

SELECT city, MOD(location_id,2) 
AS "Mod Demo"
 FROM locations;

-- Diapositiva 4.3
SELECT CURRENT_TIMESTAMP;

SELECT last_name, hire_date + 60
 FROM employees;

SELECT
    last_name,
    EXTRACT(DAY FROM (NOW() - hire_date)) / 7 AS "Semanas Trabajadas"
FROM
    employees;

SELECT
    (CURRENT_DATE + INTERVAL '1 day' * ((7 - EXTRACT(DOW FROM CURRENT_DATE) + 6) % 7)) AS "Next Saturday";

SELECT
    hire_date,
    DATE_TRUNC('month', hire_date) AS "Mes Redondeado"
FROM
    employees
WHERE
    department_id = 50;

SELECT last_name, hire_date+ 60
 FROM employees;

SELECT
    last_name,
    EXTRACT(DAY FROM (NOW() - hire_date)) / 7 AS "Semanas Trabajadas"
FROM
    employees;

SELECT
    employee_id,
    hire_date,
    -- TENURE: Equivalente a ROUND(MONTHS_BETWEEN(SYSDATE, hire_date))
    -- Calculamos los meses completos transcurridos
    FLOOR(EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) * 12 + EXTRACT(MONTH FROM AGE(CURRENT_DATE, hire_date))) AS TENURE,

    -- REVIEW: Equivalente a ADD_MONTHS(hire_date, 6)
    (hire_date + INTERVAL '6 months') AS REVIEW,

    -- NEXT_DAY(hire_date, 'FRIDAY'): Equivalente en PostgreSQL
    (hire_date + INTERVAL '1 day' * ((5 - EXTRACT(DOW FROM hire_date) + 7) % 7)) AS "NEXT_FRIDAY",

    -- LAST_DAY(hire_date): Equivalente en PostgreSQL
    (DATE_TRUNC('month', hire_date) + INTERVAL '1 month' - INTERVAL '1 day')::date AS LAST_DAY_OF_MONTH

FROM
    employees
WHERE
    -- MONTHS_BETWEEN (SYSDATE, hire_date) > 36
    -- Condición para filtrar por empleados con más de 36 meses de antigüedad
    (EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) * 12 + EXTRACT(MONTH FROM AGE(CURRENT_DATE, hire_date))) > 36;

