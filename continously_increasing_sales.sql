-- 📊 Problem Statement: Identify Products with Continuously Increasing Sales
-- You are given a table named sales that records daily sales transactions for multiple products.

-- Table Schema
-- sale_id – Unique identifier for each sale
-- sale_date – Date of the sale
-- product_id – Identifier for the product
-- sales – Sales amount for that transaction

-- Objective
-- Write a SQL query to identify all product IDs whose sales are strictly increasing over time.

-- Requirements
-- For each product_id, consider sales ordered by sale_date (and sale_id to break ties if needed).
-- A product qualifies only if each day’s sales are greater than the previous day’s sales.
-- Return only those product_ids that satisfy this condition for all their records.

drop table if exists sales;
CREATE TABLE sales (
    sale_id INT,
    sale_date DATE,
    product_id INT,
    sales DECIMAL(10, 2));
INSERT INTO sales (sale_id, sale_date, product_id, sales) VALUES
(1, '2024-01-01', 101, 100.00),
(2, '2024-01-02', 101, 150.00),
(3, '2024-01-03', 101, 200.00),
(4, '2024-01-04', 101, 250.00),
(5, '2024-01-01', 102, 300.00),
(6, '2024-01-02', 102, 280.00),
(7, '2024-01-03', 102, 290.00),
(8, '2024-01-04', 102, 310.00),
(9,  '2024-01-01', 103, 50.00),
(10, '2024-01-02', 103, 75.00),
(11, '2024-01-03', 103, 125.00),
(12, '2024-01-04', 103, 180.00),
(13, '2024-01-01', 104, 400.00),
(14, '2024-01-02', 104, 390.00),
(15, '2024-01-03', 104, 395.00),
(16, '2024-01-04', 104, 420.00);

select * from sales;

-- using self join
select s1.product_id
from sales as s1
left join sales as s2 on s1.product_id = s2.product_id and s1.sale_date > s2.sale_date
and s1.sales < s2.sales
group by s1.product_id having count(s2.product_id) = 0;

-- second approach using window function
with cte as(
select *,
row_number() over(partition by product_id order by sale_date,sale_id) as day_rn,
dense_rank() over(partition by product_id order by sales,sale_id) as sales_rn
from sales)
select product_id
from cte group by product_id having sum(case when day_rn = sales_rn then 0 else 1 end) = 0;
