DROP TABLE IF EXISTS "public"."departments";
-- Table Definition
CREATE TABLE "public"."departments" (
    "department_id" int4 NOT NULL,
    "department_name" varchar(30),
    "manager_id" int4,
    "location_id" int4,
    PRIMARY KEY ("department_id")
);

DROP TABLE IF EXISTS "public"."employees";
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS employees_employee_id_seq;

-- Table Definition
CREATE TABLE "public"."employees" (
    "employee_id" int4 NOT NULL DEFAULT nextval('employees_employee_id_seq'::regclass),
    "first_name" varchar(50) NOT NULL,
    "last_name" varchar(50) NOT NULL,
    "salary" numeric(10,2) NOT NULL DEFAULT 0.00,
    "department_id" int4,
    "job_id" varchar(50),
    "manager_id" int4,
    "commission_pct" numeric(4,2),
    CONSTRAINT "fk_department" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id") ON DELETE SET NULL,
    PRIMARY KEY ("employee_id")
);

DROP TABLE IF EXISTS "public"."locations";
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS locations_location_id_seq;

-- Table Definition
CREATE TABLE "public"."locations" (
    "location_id" int4 NOT NULL DEFAULT nextval('locations_location_id_seq'::regclass),
    "city" varchar(100) NOT NULL,
    "state_province" varchar(100),
    "country_id" varchar(2) NOT NULL,
    PRIMARY KEY ("location_id")
);

DROP TABLE IF EXISTS "public"."tusers";
-- Table Definition
CREATE TABLE "public"."tusers" (
    "name" varchar(100)
);


-- Indices
CREATE UNIQUE INDEX tusers_name_key ON public.tusers USING btree (name);

INSERT INTO "public"."departments" ("department_id", "department_name", "manager_id", "location_id") VALUES
(10, 'Administration', NULL, NULL),
(20, 'Marketing', NULL, NULL),
(30, 'Shipping', NULL, NULL),
(40, 'IT', NULL, NULL);
INSERT INTO "public"."employees" ("employee_id", "first_name", "last_name", "salary", "department_id", "job_id", "manager_id", "commission_pct") VALUES
(4, 'Ellen', 'Abel', 12000.00, NULL, 'IT_PROG', NULL, NULL),
(2, 'Curtis', 'Davies', 0.00, NULL, 'HR_REP', NULL, NULL),
(5, 'Curtis', 'Davies', 15000.00, NULL, 'HR_REP', NULL, NULL),
(7, 'Curtis', 'Davies', 15000.00, NULL, 'HR_REP', NULL, NULL),
(9, 'Jane', 'Smith', 55000.00, 10, 'PU_CLERK', NULL, NULL),
(1, 'Ellen', 'Abel', 0.00, NULL, 'IT_PROG', NULL, 0.15),
(3, 'Lex', 'De Haan', 0.00, NULL, 'SA_REP', NULL, 0.10),
(6, 'Lex', 'De Haan', 20000.00, NULL, 'SA_REP', NULL, 0.10),
(8, 'Lex', 'De Haan', 20000.00, NULL, 'SA_REP', NULL, 0.10);
INSERT INTO "public"."locations" ("location_id", "city", "state_province", "country_id") VALUES
(1, 'London', NULL, 'UK'),
(2, 'Oxford', NULL, 'UK'),
(3, 'Toronto', 'Ontario', 'CA'),
(4, 'Vancouver', 'British Columbia', 'CA'),
(5, 'New York', 'New York', 'US');
INSERT INTO "public"."tusers" ("name") VALUES
('Ana Ramírez'),
('Antonio Ramírez'),
('Andrea Ramírez'),
('Alejandro Ramírez'),
('Amanda Ramírez'),
('Arturo Ramírez'),
('Alicia Ramírez'),
('Andrés Ramírez'),
('Abigail Ramírez'),
('Adrián Ramírez'),
('Beatriz Torres'),
('Carlos Torres'),
('Daniel Torres'),
('Elena Torres'),
('Francisco Torres'),
('Gabriela Pérez'),
('Hugo Pérez'),
('Isabel Pérez'),
('José Pérez'),
('Karina Pérez'),
('Luis Martínez'),
('María Martínez'),
('Natalia Martínez'),
('Oscar Palma'),
('Patricia Palma'),
('Ricardo Palma'),
('Sofía González'),
('Tomás González'),
('Valeria González'),
('Zoe González');
