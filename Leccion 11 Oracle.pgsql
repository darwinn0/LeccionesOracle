-- Leccion 11 
-- Diapositiva 11.1
-- Garantia de resultados de consultas de calidad

SELECT
    SUBSTR(first_name, 1, 1) || '. ' || last_name AS "Employee Name", -- Primera inicial del nombre y apellido
    salary AS "Salary",
    CASE
        WHEN commission_pct IS NULL THEN 'No'
        ELSE 'Yes'
    END AS "Commission" -- Lógica para mostrar 'No' o 'Yes' según commission_pct
FROM
    employees;

