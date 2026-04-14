-- Problem Statement : Employee Hierarchy Salary Rollup
-- In an organization, employees report to managers forming a hierarchy.Each employee has a salary. A manager’s team salary includes:
-- Their own salary
-- Salary of all employees under them (direct + indirect)
-- For each employee, calculate:emp_id, name, total_team_salary (including all subordinates recursively)

drop table if exists employees;
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    manager_id INT,
    salary INT
);
INSERT INTO employees VALUES
(1, 'Alice', NULL, 100000),
(2, 'Bob', 1, 80000),
(3, 'Charlie', 1, 70000),
(4, 'David', 2, 50000),
(5, 'Eva', 2, 60000),
(6, 'Frank', 3, 40000),
(7, 'Grace', 4, 30000);

select * from employees;

with recursive cte as(
select emp_id as root_id, emp_id, salary from employees
union all
select c.root_id, e.emp_id, e.salary
from employees as e inner join cte as c on e.manager_id = c.emp_id)
select e.emp_id, e.name, sum(c.salary) as total_team_salary
from cte as c inner join employees as e on e.emp_id = c.root_id 
group by e.emp_id, e.name;
