-- 🔥 Problem: Investment Growth Tracking
-- In a financial company, each investor starts with an initial investment amount. Over time, their investment grows through multiple interest rate updates, each applied sequentially. Each update increases the current investment value by a percentage.

-- 🎯 Task
-- 👉 Write a SQL query to compute:
-- id, name, initial_investment, current_value
-- Rules:
-- Apply all percentage increases sequentially
-- If no updates → value remains same
-- Final result should be rounded to 1 decimal place
-- Order by id


CREATE TABLE investors (
    id INT,
    name VARCHAR(50),
    initial_investment INT);
INSERT INTO investors VALUES
(1, 'Alice', 10000),
(2, 'Bob', 20000),
(3, 'Charlie', 15000),
(4, 'David', 12000),
(5, 'Eva', 18000);

CREATE TABLE investment_updates (
    investor_id INT,
    update_date DATE,
    percent_increase INT);
INSERT INTO investment_updates VALUES
(1, '2023-01-01', 10),
(1, '2023-06-01', 5),
(2, '2023-02-01', 20),
(3, '2023-01-15', 10),
(3, '2023-03-15', 10),
(3, '2023-05-15', 5),
(4, '2023-04-01', 50),
(5, '2023-02-10', 10),
(5, '2023-08-10', 10);

select * from investors;
select * from investment_updates;

with recursive cte as(
select investor_id, percent_increase,
row_number() over(partition by investor_id order by update_date) as rn
from investment_updates),
cte1 as(
select id, name, initial_investment, initial_investment as current_investment, 0 as rn
from investors
union all
select c1.id, c1.name, c1.initial_investment, c1.current_investment * (1 + c.percent_increase/100.0) as current_investment, c1.rn+1
from cte1 as c1 inner join cte as c on c1.id = c.investor_id and c.rn = c1.rn+1),
cte2 as(
select *,
row_number() over(partition by id order by rn desc) as final_rn
from cte1)
select id, name, initial_investment, current_investment as current_value from cte2 where final_rn = 1;