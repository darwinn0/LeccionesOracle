CREATE TABLE f_staffs (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO f_staffs (first_name, last_name) VALUES
('Sarah', 'Doe'),
('Ben', 'Miller'),
('Mark', 'Tuttle');

CREATE TABLE wf_countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    airports INTEGER NOT NULL
);

INSERT INTO wf_countries (country_name, airports) VALUES
('Canada', 5),
('Republic of Costa Rica', 2),
('Republic of Cape Verde', 1),
('Greenland', 0),
('Dominican Republic', 4),
('State of Eritrea', 3);

CREATE TABLE jobs (
    job_id CHARACTER VARYING(20) PRIMARY KEY, 
    job_title VARCHAR(50) NOT NULL,
    min_salary NUMERIC(10, 2),
    max_salary NUMERIC(10, 2)
);


INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
('IT_PROG', 'Programmer', 6000.00, 12000.00),
('SA_REP', 'Sales Representative', 8000.00, 15000.00),
('AD_PRES', 'President', 20000.00, 40000.00);

SELECT first_name, last_name, job_id, job_title
 FROM employees NATURAL JOIN jobs
 WHERE department_id > 50;

SELECT first_name, last_name, job_id, job_title
 FROM employees NATURAL JOIN jobs
 WHERE department_id> 60;

SELECT department_name, city
 FROM departments NATURAL JOIN 
locations;

INSERT INTO locations (location_id, city, state_province, country_id)
VALUES
(1000, 'Tegucigalpa', 'Francisco Morazán', 'HN'),
(1100, 'San Pedro Sula', 'Cortés', 'HN'),
(1200, 'La Ceiba', 'Atlántida', 'HN'),
(1300, 'Comayagua', 'Comayagua', 'HN'),
(1400, 'Santa Rosa de Copán', 'Copán', 'HN');

SELECT * FROM employees;

SELECT last_name, department_name
 FROM employees CROSS JOIN 
departments;

-- diapositiva 6.2

SELECT first_name, last_name, department_id, department_name
 FROM employees JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
 FROM employees JOIN departments USING (department_id)
 WHERE last_name = 'Davies';

SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id);

SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id);

SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id)
 WHERE last_name LIKE 'D%';

CREATE TABLE job_grades (
    grade_level VARCHAR(2) PRIMARY KEY, 
    lowest_sal NUMERIC(10, 2),
    highest_sal NUMERIC(10, 2)
);


INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000.00, 2999.00),
('B', 3000.00, 5999.00),
('C', 6000.00, 9999.00),
('D', 10000.00, 14999.00),
('E', 15000.00, 24999.00),
('F', 25000.00, 40000.00);

SELECT
    e.last_name,
    e.salary,
    jg.grade_level,
    jg.lowest_sal,
    jg.highest_sal
FROM
    employees e 
JOIN
    job_grades jg ON (e.salary BETWEEN jg.lowest_sal AND jg.highest_sal);

SELECT last_name, department_name AS "Department", city
 FROM employees JOIN departments USING (department_id)
 JOIN locations USING (location_id);

-- diapositiva 6.3

SELECT e.last_name, d.department_id, 
d.department_name
 FROM employees e LEFT OUTER JOIN 
departments d 
ON (e.department_id = 
d.department_id);

SELECT e.last_name, d.department_id, 
d.department_name
 FROM employees e RIGHT OUTER JOIN 
departments d 
ON (e.department_id = 
d.department_id);

SELECT e.last_name, d.department_id, d.department_name
 FROM employees e FULL OUTER JOIN departments d 
ON (e.department_id= d.department_id);

CREATE TABLE job_history (
    employee_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id CHARACTER VARYING(20) NOT NULL, 
    department_id INTEGER NOT NULL,
    PRIMARY KEY (employee_id, start_date), 
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id), 
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
);

-- diapositiva 6.4
 SELECT worker.last_name || ' works for ' || manager.last_name
 AS "Works for"
 FROM employees worker JOIN employees manager
 ON (worker.manager_id = manager.employee_id);

SELECT worker.last_name, worker.manager_id, manager.last_name
 AS "Manager name"
 FROM employees worker JOIN employees manager
 ON (worker.manager_id = manager.employee_id);

WITH RECURSIVE EmployeeHierarchy AS (
    
    SELECT
        employee_id,
        last_name,
        job_id,
        manager_id,
        0 AS level 
    FROM
        employees
    WHERE
        employee_id = 100 

    UNION ALL

    
    SELECT
        e.employee_id,
        e.last_name,
        e.job_id,
        e.manager_id,
        eh.level + 1 AS level
    FROM
        employees e
    INNER JOIN
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    employee_id,
    last_name,
    job_id,
    manager_id
FROM
    EmployeeHierarchy;

WITH RECURSIVE EmployeeHierarchy AS (
    
    SELECT
        employee_id,
        last_name,
        manager_id,
        CAST(last_name AS VARCHAR(255)) AS full_hierarchy_path, 
        1 AS level 
    FROM
        employees
    WHERE
        last_name = 'Davies' 

    UNION ALL

    SELECT
        e.employee_id,
        e.last_name,
        e.manager_id,
        CAST(e.last_name || ' reports to ' || eh.last_name AS VARCHAR(255)) AS full_hierarchy_path,
        eh.level + 1 AS level
    FROM
        employees e
    INNER JOIN
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    full_hierarchy_path AS "Walk Top Down"
FROM
    EmployeeHierarchy
ORDER BY
    level, employee_id;

/* SELECT LEVEL, last_name ||                      
' reports to ' ||                      
PRIOR last_name
 AS "Walk Top Down"
 FROM employees
 START WITH last_name = 'King'
 CONNECT BY PRIOR               
employee_id = manager_id; */

WITH RECURSIVE EmployeeOrgChart AS (
    
    SELECT
        employee_id,
        last_name,
        manager_id,
        1 AS current_level 
    FROM
        employees
    WHERE
        last_name = 'Davies'

    UNION ALL

    SELECT
        e.employee_id,
        e.last_name,
        e.manager_id,
        eoc.current_level + 1 AS current_level 
    FROM
        employees e
    INNER JOIN
        EmployeeOrgChart eoc ON e.manager_id = eoc.employee_id
)
SELECT
    LPAD(last_name, LENGTH(last_name) + (current_level * 2) - 2, '_') AS "Org Chart"
FROM
    EmployeeOrgChart
ORDER BY
    current_level, employee_id; 

WITH RECURSIVE EmployeeOrgChart AS (
    SELECT
        employee_id,
        last_name,
        manager_id,
        1 AS hierarchy_level 
    FROM
        employees
    WHERE
        last_name = 'Davies' 

    UNION ALL

    SELECT
        e.employee_id,
        e.last_name,
        e.manager_id,
        eoc.hierarchy_level + 1 AS hierarchy_level 
    FROM
        employees e
    INNER JOIN
        EmployeeOrgChart eoc ON e.manager_id = eoc.employee_id
)
SELECT
    LPAD(last_name, LENGTH(last_name) + (hierarchy_level * 2) - 2, '_') AS "Org_Chart"
FROM
    EmployeeOrgChart
ORDER BY
    hierarchy_level, employee_id;

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        employee_id,
        last_name,
        manager_id
    FROM
        employees
    WHERE
        last_name = 'Kochhar'

    UNION ALL

    SELECT
        e.employee_id,
        e.last_name,
        e.manager_id
    FROM
        employees e
    INNER JOIN
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    last_name
FROM
    EmployeeHierarchy
WHERE
    last_name != 'Davies' 
ORDER BY
    last_name; 

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        employee_id,
        last_name,
        manager_id
    FROM
        employees
    WHERE
        last_name = 'Davies'

    UNION ALL

    
    SELECT
        e.employee_id,
        e.last_name,
        e.manager_id
    FROM
        employees e
    INNER JOIN
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    last_name
FROM
    EmployeeHierarchy
WHERE
    last_name != 'Higgins'
ORDER BY
    last_name; 

