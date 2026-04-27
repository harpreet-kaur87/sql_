-- Problem Statement : Cumulative Sum Using Self Join
-- You are given a sales table containing order_id, order_date, and sale_amount.
-- 👉 Write a SQL query to calculate the monthly sales total and then compute a cumulative (running) total over months across years, without using window functions.

-- Constraints:
-- Aggregate sales by year and month
-- Compute running total in chronological order
-- Use a self-join approach

drop table if exists sales;
CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    sale_amount DECIMAL(10,2));
INSERT INTO sales VALUES
(1, '2025-11-05', 1500.00),
(2, '2025-11-15', 2300.50),
(3, '2025-11-25', 1800.75),
(4, '2025-12-03', 2000.00),
(5, '2025-12-18', 2750.25),
(6, '2025-12-28', 3200.00),
(7, '2026-01-07', 2100.00),
(8, '2026-01-16', 2600.80),
(9, '2026-01-29', 3000.00),
(10, '2026-02-04', 1900.00),
(11, '2026-02-14', 2400.60),
(12, '2026-02-26', 3100.00);

select * from sales;

-- with self join
with cte as(
select year(order_date) as yy, month(order_date) as mm, sum(sale_amount) as total_sales
from sales group by yy,mm order by yy,mm)
select c1.yy, c1.mm, sum(c2.total_sales) as cum_sum
from cte as c1 
join cte as c2 on c2.yy * 100 + c2.mm <= c1.yy * 100 + c1.mm
group by c1.yy, c1.mm order by c1.yy, c1.mm ;


-- with window function
with cte as (
select year(order_date) as yy, month(order_date) as mm, sum(sale_amount) as total_sales
from sales group by year(order_date), month(order_date) order by year(order_date), month(order_date))
select yy, mm,
sum(total_sales) over(order by yy,mm) as running_sum
from cte;
