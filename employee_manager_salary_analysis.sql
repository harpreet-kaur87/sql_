-- Problem Statement 
-- Given a single Employees table with:
-- employee_id, employee_name, department, salary, manager_id
-- The goal was to retrieve employees who:
-- 1. Earn more than their direct manager
-- AND
-- 2️. Earn more than the average salary of employees in their department (excluding themselves)
-- 📌 Required Output Columns:
-- employee_id, employee_name, department, employee_salary, manager_name, manager_salary, department_avg_salary_excluding_self

drop table if exists employees;
CREATE TABLE employees (
    employee_id INT,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT NULL);
    INSERT INTO Employees VALUES
(1, 'Alice',   'HR',        90000,  NULL),
(2, 'Bob',     'HR',        60000,  1),
(3, 'Charlie', 'HR',        100000,  1),
(4, 'David',   'IT',        120000, NULL),
(5, 'Eve',     'IT',        80000,  4),
(6, 'Frank',   'IT',        75000,  4),
(7, 'Grace',   'IT',        70000,  5),
(8, 'Heidi',   'Finance',   110000, NULL),
(9, 'Ivan',    'Finance',   72000,  8),
(10,'Judy',    'Finance',   68000,  8);

select * from employees;

with salary_status as(
select e.employee_id, e.employee_name, e.department, e.salary as employee_salary, m.employee_name as direct_manager, m.salary as manager_salary
from employees as e
left join employees as m
on e.manager_id = m.employee_id),
dept_avg as(
select e1.employee_id, avg(e2.salary) as avg_salary_of_dept_excluding_self
from employees as e1 join employees as e2 on e1.department = e2.department and e1.employee_id <> e2.employee_id
group by e1.employee_id)
select s.employee_id, s.employee_name, s.department, s.employee_salary, s.direct_manager as manager_name, s.manager_salary, d.avg_salary_of_dept_excluding_self
from salary_status as s
join dept_avg as d on s.employee_id = d.employee_id
where s.employee_salary > s.manager_salary and s.employee_salary > d.avg_salary_of_dept_excluding_self;
