-- Crear la tabla v2
CREATE TABLE v2 (
    "Nombre del Departamento" VARCHAR(50),
    "Lowest Salary" INTEGER,
    "Highest Salary" INTEGER,
    "Average Salary" INTEGER
);

INSERT INTO v2 ("Nombre del Departamento", "Lowest Salary", "Highest Salary", "Average Salary") VALUES
('Accounting', 8300, 12000, 10150),
('IT', 4200, 9000, 6400),
('Executive', 17000, 24000, 19333),
('Envío', 2500, 5800, 3500),
('Ventas', 8600, 11000, 10033),
('Marketing', 6000, 13000, 9500);

SELECT * FROM v2;

SELECT * FROM emp;

CREATE TABLE usr_tab_privs (
    grantee VARCHAR(50) NOT NULL,
    owner VARCHAR(50) NOT NULL,
    tablename VARCHAR(50) NOT NULL,
    grantor VARCHAR(50) NOT NULL,
    privilege VARCHAR(50) NOT NULL,
    grantable VARCHAR(3)
);

INSERT INTO usr_tab_privs (grantee, owner, tablename, grantor, privilege, grantable) VALUES
('admin', 'public', 'emp', 'postgres', 'SELECT', 'YES'),
('admin', 'public', 'emp', 'postgres', 'INSERT', 'NO'),
('admin', 'public', 'emp', 'postgres', 'UPDATE', 'NO'),
('user1', 'public', 'emp', 'postgres', 'SELECT', 'NO'),
('user2', 'public', 'dept', 'postgres', 'SELECT', 'YES');


SELECT *
FROM usr_tab_privs
WHERE tablename = 'emp';

