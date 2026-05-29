-- Problem Statement: Monthly Customer Retention Analysis
-- You are given an orders table containing customer purchase transactions across multiple months spanning from November 2025 to March 2026.
-- The table structure is:
-- order_id → unique order identifier
-- customer_id → unique customer identifier
-- order_date → date of purchase
-- amount → order amount
-- Your task is to analyze customer retention behavior on a month-over-month basis. Calculate the total number of retained customers for every month.

drop table if exists orders;
CREATE TABLE orders (
    order_id INT,
    customer_id VARCHAR(10),
    order_date DATE,
    amount DECIMAL(10,2));
INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(101, 'C001', '2025-11-03', 1200),
(102, 'C002', '2025-11-08', 800),
(103, 'C003', '2025-11-12', 1500),
(104, 'C004', '2025-11-18', 950),
(105, 'C001', '2025-12-02', 2000),
(106, 'C002', '2025-12-06', 1100),
(107, 'C005', '2025-12-10', 700),
(108, 'C003', '2025-12-15', 1700),
(109, 'C006', '2025-12-20', 1300),
(110, 'C001', '2026-01-04', 2500),
(111, 'C002', '2026-01-07', 900),
(112, 'C004', '2026-01-11', 2100),
(113, 'C005', '2026-01-16', 750),
(114, 'C007', '2026-01-21', 1000),
(115, 'C001', '2026-02-03', 3000),
(116, 'C003', '2026-02-06', 1600),
(117, 'C004', '2026-02-10', 1250),
(118, 'C005', '2026-02-14', 1800),
(119, 'C007', '2026-02-18', 1400),
(120, 'C001', '2026-03-02', 2200),
(121, 'C002', '2026-03-05', 950),
(122, 'C003', '2026-03-09', 1750),
(123, 'C006', '2026-03-15', 1450),
(124, 'C007', '2026-03-20', 1600);

select * from orders;

select date_format(t1.order_date,'%Y-%m') as yy_mm, count(distinct t2.customer_id) as retained_customers_cnt
from orders as t1
left join orders as t2 on t1.customer_id = t2.customer_id and 
period_diff(date_format(t1.order_date,'%Y%m'),date_format(t2.order_date,'%Y%m')) = 1
group by yy_mm;