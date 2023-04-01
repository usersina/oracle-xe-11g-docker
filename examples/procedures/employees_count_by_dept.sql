SET serveroutput on;

-- Get the number of employees in a department
CREATE OR REPLACE PROCEDURE employees_count (
    department_id IN departments.department_id%type
) IS
    empcount NUMBER;
BEGIN
    SELECT
        COUNT(*) INTO empcount
    FROM
        employees
    WHERE
        department_id = department_id;
    dbms_output.put_line('Number of employees in department '
        || department_id
        || ' is '
        || empcount);
END employees_count;
/

--Call the procedure
BEGIN
    employees_count(10);
END;