-- Update the salary of an individual employee by their id
CREATE OR REPLACE PROCEDURE update_salary (
    employee_id IN employees.employee_id%type,
    new_salary IN employees.salary%type
) IS
BEGIN
    UPDATE employees
    SET
        salary = new_salary
    WHERE
        employee_id = employee_id;
END update_salary;
/