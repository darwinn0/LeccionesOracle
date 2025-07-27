-- Leccion 13
-- Diapositiva 13.1
-- Creacion de tablas

SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public' AND table_name = 'jobs'
ORDER BY
    ordinal_position;

CREATE SCHEMA IF NOT EXISTS mary; 

CREATE TABLE mary.students (
    student_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    height NUMERIC(5, 2),            
    year_in_school INTEGER,         
    date_of_birth DATE,             
    email VARCHAR(100) UNIQUE        
);


/*
 CREATE TABLE table
 (column data type [DEFAULT expression],
 (column data type [DEFAULT expression],
 (……[ ] );
 */

CREATE TABLE my_cd_collection (
    cd_number INTEGER,               
    title VARCHAR(20),               
    artist VARCHAR(20),             
    purchase_date DATE DEFAULT CURRENT_DATE 
);

CREATE TABLE my_friends (
    first_name VARCHAR(20),  
    last_name VARCHAR(30),   
    email VARCHAR(30),       
    phone_num VARCHAR(12),   
    birth_date DATE          
);

CREATE TABLE emp_load (
    employee_number CHAR(5),
    employee_dob VARCHAR(20),       
    employee_last_name VARCHAR(20),
    employee_first_name VARCHAR(15),
    employee_middle_name VARCHAR(15),
    employee_hire_date DATE
);

/*COPY emp_load (employee_number, employee_dob, employee_last_name, employee_first_name, employee_middle_name, employee_hire_date)
FROM '/ruta/al/archivo/info.dat' 
WITH (
    FORMAT 'text',                
    DELIMITER E'\t',             
    NULL AS '',                  

); */

CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SERVER file_server FOREIGN DATA WRAPPER file_fdw;

/*CREATE FOREIGN TABLE emp_load (
    employee_number CHAR(5),
    employee_dob VARCHAR(20),
    employee_last_name VARCHAR(20),
    employee_first_name VARCHAR(15),
    employee_middle_name VARCHAR(15),
    employee_hire_date VARCHAR(10) -- Cargar como VARCHAR y luego castear si es necesario
)
SERVER file_server
OPTIONS (
    filename '/ruta/al/archivo/info.dat', -- ¡IMPORTANTE! Ruta real en el servidor
    format 'text',
    delimiter E'\t', -- O ','
    null ' ' -- Cómo se representan los NULLs en el archivo
    -- Para el formato de fecha "mm/dd/yyyy", lo más común es cargarla como VARCHAR(10)
    -- y luego, al consultarla, usar TO_DATE(employee_hire_date, 'MM/DD/YYYY')
); */

SELECT
    tablename,   
    indexname,   
    tablespace,  
    indexdef     
FROM
    pg_indexes
WHERE
    schemaname = 'public' 
ORDER BY
    tablename, indexname;

-- Diapositiva 13.2
-- Uso de tipos de datos

CREATE TABLE time_ex1 (
    exact_time TIMESTAMP 
);

 INSERT INTO time_ex1
 VALUES ('10-Jun-2017 10:52:29.123456');

 INSERT INTO time_ex1
 VALUES (CURRENT_DATE);

INSERT INTO time_ex1
VALUES (NOW()); 

SELECT * 
FROM time_ex1;

CREATE TABLE time_ex2 (time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2
VALUES (NOW());

 INSERT INTO time_ex2
 VALUES ('10-Jun-2017 10:52:29.123456 AM +2:00');

SELECT * 
FROM time_ex2;

CREATE TABLE time_ex3 (
    first_column TIMESTAMP WITH TIME ZONE, 
    second_column TIMESTAMP WITH TIME ZONE 
);

 INSERT INTO time_ex3
 (first_column, second_column)
 VALUES        
('15-Jul-2017 08:00:00 AM -07:00', '15-Nov-2007 08:00:00');

SELECT * 
FROM time_ex3;


CREATE TABLE time_ex4 (
    loan_duration1 INTERVAL YEAR TO MONTH, 
    loan_duration2 INTERVAL YEAR TO MONTH  
);

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (
    INTERVAL '120 MONTH',           
    INTERVAL '3 years 6 months'        
);

SELECT
    NOW() + loan_duration1 AS "120 months from now",
    NOW() + loan_duration2 AS "3 years 6 months from now"
FROM
    time_ex4;

CREATE TABLE time_ex5 (
    day_duration1 INTERVAL DAY TO SECOND, 
    day_duration2 INTERVAL DAY TO SECOND 
);

SELECT
    NOW() + day_duration1 AS "25 Days from now",
    TO_CHAR(NOW() + day_duration2, 'DD-Mon-YYYY HH:MI:SS') AS "precise days and time from now"
FROM
    time_ex5;


-- Diapositiva 13.3
-- Modificacion de una table_am_handler_in

ALTER TABLE my_cd_collection
ADD COLUMN release_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE my_friends
ADD COLUMN favorite_game VARCHAR(30);

CREATE TABLE mod_emp (
    last_name VARCHAR(20), 
    salary NUMERIC(8,2)    
);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(30);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(10);

ALTER TABLE mod_emp
ALTER COLUMN salary TYPE NUMERIC(10,2);

ALTER TABLE mod_emp
ALTER COLUMN salary TYPE NUMERIC(8,2);
ALTER TABLE mod_emp
ALTER COLUMN salary SET DEFAULT 50;   

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(10);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(30);

DROP TABLE copy_employees;

/*FLASHBACK TABLE copy_employees TO BEFORE DROP; */

CREATE TABLE user_recyclebin (
    id SERIAL PRIMARY KEY,
    original_name VARCHAR(255) NOT NULL,
    object_type VARCHAR(50) NOT NULL,
    operation VARCHAR(100) NOT NULL,
    dropped_by VARCHAR(100) DEFAULT CURRENT_USER,
    droptime TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    definition TEXT
);

INSERT INTO user_recyclebin (original_name, object_type, operation, definition)
VALUES (
    'idx_productos_nombre',
    'INDEX',
    'DROP INDEX',
    'CREATE INDEX idx_productos_nombre ON productos (nombre);' 
);

 COMMENT ON TABLE employees
 IS 'Western Region only';

CREATE TABLE employees_history (
    history_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    salary DECIMAL(10, 2),
    operation_type VARCHAR(10) NOT NULL, 
    version_start_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    version_end_time TIMESTAMP WITH TIME ZONE NULL
);

CREATE OR REPLACE FUNCTION track_employee_history()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        UPDATE employees_history
        SET version_end_time = NOW()
        WHERE employee_id = OLD.employee_id
          AND version_end_time IS NULL;

        -- Inserta la nueva versión
        INSERT INTO employees_history (employee_id, first_name, last_name, salary, operation_type, version_start_time)
        VALUES (OLD.employee_id, NEW.first_name, NEW.last_name, NEW.salary, 'UPDATE', NOW());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE employees_history
        SET version_end_time = NOW()
        WHERE employee_id = OLD.employee_id
          AND version_end_time IS NULL;

        INSERT INTO employees_history (employee_id, first_name, last_name, salary, operation_type, version_start_time, version_end_time)
        VALUES (OLD.employee_id, OLD.first_name, OLD.last_name, OLD.salary, 'DELETE', NOW(), NOW());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO employees_history (employee_id, first_name, last_name, salary, operation_type, version_start_time)
        VALUES (NEW.employee_id, NEW.first_name, NEW.last_name, NEW.salary, 'INSERT', NOW());
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employee_history_trigger
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW EXECUTE FUNCTION track_employee_history();

SELECT
    employee_id,
    first_name || ' ' || last_name AS "NAME",
    operation_type AS "OPERATION",
    version_start_time AS "START_DATE",
    version_end_time AS "END_DATE",
    salary
FROM
    employees_history
WHERE
    employee_id = 1
ORDER BY
    version_start_time;


 SELECT employee_id, salary
 FROM copy_employees
 WHERE employee_id = 1;

