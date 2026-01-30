-- Problem Statement : Efficient Pair Generation Using ROW_NUMBER and Self Joins

-- We are given a table containing a list of teams:
-- The requirement is to generate all unique team pair combinations such that:
-- A team should not be paired with itself
-- Duplicate mirror pairs should be avoided
-- (e.g., Hyderabad–Mumbai and Mumbai–Hyderabad should appear only once)
-- Each valid pair should appear exactly one time

create table teams(team_name varchar(20));
insert into teams values
('Hyderabad'),
('New Delhi'),
('Chandigarh'),
('Bengaluru'),
('Mumbai'),
('Chennai'),
('Kolkata');


with cte as(
select *,
row_number() over(order by team_name) as rn
from teams)
select t1.team_name as team_1, t2.team_name as team_2
from cte as t1
join cte as t2
on  t1.rn > t2.rn
order by t1.team_name, t2.team_name;
