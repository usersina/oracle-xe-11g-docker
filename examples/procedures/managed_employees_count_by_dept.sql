-- Number of managed employees by department
CREATE OR REPLACE PROCEDURE managed_employees_ct (
    arg_department_id IN NUMBER
) IS
    managed_emp_count NUMBER;
BEGIN
    SELECT
        COUNT(*) INTO managed_emp_count
    FROM
        employees emps
        INNER JOIN employees managers
        ON emps.employee_id = managers.manager_id
    WHERE
        managers.department_id = arg_department_id;
    dbms_output.put_line('Number of managed employees: '
        || managed_emp_count);
END managed_employees_ct;
/

BEGIN
    managed_employees_ct(60);
END;