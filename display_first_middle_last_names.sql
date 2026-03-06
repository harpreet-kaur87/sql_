-- Problem Statement :
-- You are given a table bigbangtheory that contains the full names of characters from the TV show The Big Bang Theory.
-- Task
-- Write an SQL query to split the full name into three separate columns:
-- first_name, middle_name, last_name

-- Requirements
-- Extract the first word as first_name.
-- Extract the middle word as middle_name only if it exists.
-- Extract the last word as last_name if present.
-- If a person has only one or two names, the missing fields should return NULL.
-- Display the output with the following columns:
-- name | first_name | middle_name | last_name

create table bigbangtheory (name varchar(50));
insert into bigbangtheory values
('Sheldon Lee Cooper'),
('Leonard Leakey Hofstadter'),
('Howard Wolowitz'),
('Penny'),
('Rajesh Ramayan Koothrappali'),
('Amy Farrah Fowler'),
('Bernadette Maryann Rostenkowski-Wolowitz'),
('Stuart Bloom');

select * from bigbangtheory;

select name,
substring_index(name,' ',1) as first_name,
case 
	when name like '% % %' then	substring_index(substring_index(name,' ',2), ' ',-1) 
end as middle_name,
case
	when name like '% % %' then	substring_index(name,' ', -1)
    when name like '% %' then substring_index(name, ' ', -1) 
end as last_name
from bigbangtheory;