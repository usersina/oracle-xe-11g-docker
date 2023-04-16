CREATE OR REPLACE TRIGGER max_employees BEFORE
    INSERT ON employees FOR EACH ROW
DECLARE
    max_emp_count  NUMBER := 107;
    curr_emp_count NUMBER;
BEGIN
    SELECT
        COUNT(*) INTO curr_emp_count
    FROM
        employees;
    IF (curr_emp_count + 1 >= max_emp_count) THEN
        raise_application_error(-20001, 'Too many employees');
    END IF;
END;
/

-- Insert an employee
INSERT INTO employees(
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    manager_id,
    department_id
) VALUES (
    99,
    'John',
    'Doe',
    'john@doe.com',
    '515.123.4567',
    '17-JUN-03',
    'AD_PRES',
    100000,
    100,
    90
);