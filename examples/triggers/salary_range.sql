CREATE OR REPLACE TRIGGER salary_range_check BEFORE
    INSERT OR UPDATE ON employees FOR EACH ROW
DECLARE
    min_salary employees.salary%type;
    max_salary employees.salary%type;
BEGIN
    SELECT
        MIN(salary),
        MAX(salary) INTO min_salary,
        max_salary
    FROM
        employees;
    IF :new.salary < min_salary OR :new.salary > max_salary THEN
        raise_application_error(-20301, 'Salary out of range');
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