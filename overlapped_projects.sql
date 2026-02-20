-- Advanced SQL Problem – Detect Overlapping Project Assignments
-- You are given a table that stores employee project assignments.
-- Each employee may work on multiple projects, and some projects may overlap in time.
-- Write a SQL query to:
-- 1. Identify all overlapping project pairs
-- For the same employee.
-- 2. Return the following columns:
-- emp_name, project_1, project_2, overlap_start_date, overlap_end_date

DROP TABLE IF EXISTS project_assignments;
CREATE TABLE project_assignments (
    assignment_id int,
    emp_name VARCHAR(50),
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE);
INSERT INTO project_assignments VALUES
(1, 'Amit', 'Alpha',   '2024-01-01', '2024-03-31'),
(2, 'Amit', 'Beta',    '2024-03-15', '2024-06-30'),
(3, 'Amit', 'Gamma',   '2024-07-01', '2024-09-30'),
(4, 'Neha', 'Delta',   '2024-02-01', '2024-04-30'),
(5, 'Neha', 'Epsilon', '2024-05-01', '2024-07-31'),
(6, 'Rohit', 'Zeta',   '2024-01-01', '2024-12-31'),
(7, 'Rohit', 'Eta',    '2024-06-01', '2024-08-31');


select * from project_assignments;

select t1.emp_name, t1.project_name as project_1, t2.project_name as project_2,
greatest(t1.start_date,t2.start_date) as overlap_start_date,
least(t1.end_date,t2.end_date) as overlap_end_date
from project_assignments as t1
join project_assignments as t2
on t1.emp_name = t2.emp_name and t1.start_date <= t2.end_date
and t2.start_date <= t1.end_date
and t1.assignment_id < t2.assignment_id;
