-- Leccion 20 

UPDATE copy_departments
 SET department_id = 140;

CREATE TABLE dept
 AS select * FROM departments;

DROP TABLE IF EXISTS emp CASCADE;
DROP TABLE IF EXISTS dept CASCADE;

CREATE TABLE dept
AS SELECT * FROM departments;

ALTER TABLE dept
ADD CONSTRAINT dept_pk PRIMARY KEY (department_id);

CREATE TABLE emp
AS SELECT * FROM employees;

ALTER TABLE emp
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES dept(department_id)
ON DELETE CASCADE;

SELECT COUNT(*) AS "Num employees" 
FROM employees;

DELETE FROM dept
WHERE department_id = 10;

SELECT COUNT(*) AS "Num employees" 
FROM employees; 

DROP SEQUENCE IF EXISTS ct_seq CASCADE;
CREATE SEQUENCE ct_seq
START WITH 1000
INCREMENT BY 1;

ALTER TABLE employees
ADD COLUMN phone_number VARCHAR(25); 


CREATE INDEX emp_indx ON emp(employee_id DESC, 
UPPER(SUBSTRING(first_name, 1, 1) || ' ' || last_name));

SELECT 
    grantee,
    privilege_type,
    is_grantable
FROM information_schema.table_privileges
WHERE table_name = 'emp'
AND table_schema = CURRENT_SCHEMA();

SELECT 'Table operations completed successfully' AS status;

SELECT employee_id, first_name, last_name, department_id
FROM emp 
WHERE employee_id >= 1000;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS emp_count
FROM dept d
LEFT JOIN emp e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;