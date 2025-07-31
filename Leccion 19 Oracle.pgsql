-- Leccion 19

/* Ejemplos que aprarecen en la diapositiva
 LOWER(column name|expression)
 UPPER(column name|expression)
 INITCAP(column name|expression) 

 */

SELECT TO_CHAR(12345.67, '99,999.99'); 
SELECT TO_CHAR(500, '$999');  

SELECT DATE_TRUNC('month', '2023-07-22'::date); 
SELECT DATE_TRUNC('year', '2023-07-22'::date);

SELECT EXTRACT(MONTH FROM AGE('2023-07-22'::date, '2023-01-15'::date)) + (EXTRACT(YEAR FROM AGE('2023-07-22'::date, '2023-01-15'::date)) * 12); -- Resultado: 6
SELECT (EXTRACT(YEAR FROM '2023-07-22'::date) - EXTRACT(YEAR FROM '2023-01-15'::date)) * 12
     + (EXTRACT(MONTH FROM '2023-07-22'::date) - EXTRACT(MONTH FROM '2023-01-15'::date));

SELECT ROUND(123.456, 2);  
SELECT ROUND(123.456, 0);   
SELECT ROUND(123.456);      
SELECT ROUND(125.456, -1);  

SELECT 'Hola' || ' Mundo';             
SELECT first_name || ' ' || last_name FROM employees; 
SELECT CONCAT('Hola', ' ', 'Mundo', '!'); 

SELECT SUBSTR('PostgreSQL', 1, 4);   
SELECT SUBSTR('PostgreSQL', 5);     

SELECT LENGTH('PostgreSQL');         
SELECT LENGTH('España');             

SELECT POSITION('SQL' IN 'PostgreSQL');   
SELECT STRPOS('PostgreSQL', 'gre');     
SELECT POSITION('XYZ' IN 'PostgreSQL');   

SELECT LPAD('abc', 5, '*');    
SELECT LPAD('123', 6, '0');    
SELECT LPAD('abc', 2);         

SELECT TRIM('   Hola Mundo   ');            
SELECT TRIM(BOTH '*' FROM '***Texto***');     
SELECT TRIM(LEADING 'x' FROM 'xxxMensaje'); 
SELECT TRIM(TRAILING '.' FROM 'Archivo.txt.');   
   
SELECT COALESCE(commission_pct, 0) AS actual_commission FROM employees;


SELECT REPLACE('Mi cadena de prueba', 'cadena', 'texto'); 
SELECT REPLACE('banana', 'a', 'o');                       
SELECT REPLACE('ABC-123-DEF', '-', 'sf');

SELECT
    CASE
        WHEN commission_pct IS NOT NULL THEN 'Con Comisión'
        ELSE 'Sin Comisión'
    END AS employee_commission_status
FROM employees;

SELECT
    CASE
        WHEN salary IS NOT NULL THEN salary * 1.1
        ELSE 0
    END AS adjusted_salary
FROM employees;

/*Cross join */
SELECT last_name, department_name
 FROM employees CROSS JOIN departments;

/* Natural join */
 SELECT employee_id, last_name, department_name
 FROM employees NATURAL JOIN departments;

/* join on*/
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

/* Join using*/
SELECT employee_id, last_name, department_name
 FROM employees JOIN departments
 USING (department_id);

 /*Join on  */
 SELECT e.employee_id, e.last_name, d.department_id, 
d.location_id
 FROM employees e JOIN departments d
 ON (e.department_id = d.department_id);

 /* Right Outer Join*/
 SELECT e.employee_id, e.last_name, e.department_id, 
d.department_name
 FROM employees e RIGHT OUTER JOIN departments d
 ON (e.department_id= d.department_id);

 /*Left Outer Join */
 SELECT e.employee_id, e.last_name, e.department_id, 
d.department_name
 FROM employees e LEFT OUTER JOIN departments d
 ON (e.department_id= d.department_id);

 /*Full Outer Join */
 SELECT e.employee_id, e.last_name, e.department_id, 
d.department_name
 FROM employees e FULL OUTER JOIN departments d
 ON (e.department_id = d.department_id);


SELECT 
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank,
    first_name,
    last_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

SELECT e1.first_name, e1.last_name, e2.avg_salary
FROM employees e1,
     (SELECT department_id, AVG(salary) AS avg_salary
      FROM employees
      GROUP BY department_id) e2
WHERE e1.department_id = e2.department_id
  AND e1.employee_id <= 5;

SELECT 'PostgreSQL function equivalents:' AS info;
SELECT 'SUBSTR → SUBSTRING, INSTR → POSITION, NVL → COALESCE' AS conversions;
SELECT 'ROWNUM → ROW_NUMBER() OVER(), DECODE → CASE WHEN' AS advanced_conversions;
