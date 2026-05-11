-- 📊 Problem Statement: Pareto Analysis on Product Sales
-- You are given a table product_sales that contains total sales made by different products.
-- 🎯 Task
-- Perform a Pareto analysis to identify the top-performing products that contribute to 80% of total sales.
-- Requirements:
-- Identify products that fall within the top 80% contribution
-- Output: product_id, product_name, total_sales, cumulative_sales

drop table if exists product_sales;
create table product_sales (
    product_id int,
    product_name varchar(50),
    total_sales decimal(10,2));
insert into product_sales (product_id, product_name, total_sales) values
(1, 'Laptop', 5000.00),
(2, 'Mobile', 4000.00),
(3, 'Headphones', 1500.00),
(4, 'Keyboard', 1000.00),
(5, 'Mouse', 800.00),
(6, 'Monitor', 3000.00),
(7, 'Printer', 1200.00),
(8, 'Tablet', 2500.00),
(9, 'Camera', 2200.00),
(10, 'Speaker', 900.00);

select * from product_sales;

with cte as(
select product_id, product_name, sum(total_sales) as total_product_sales from product_sales group by product_id, product_name),
cte1 as(
select *,
sum(total_product_sales) over() as overall_sales,
sum(total_product_sales) over(order by total_product_sales desc rows between unbounded preceding and current row) as cumulative_sales 
from cte)
select product_id, product_name, total_product_sales, cumulative_sales from cte1
where cumulative_sales <= overall_sales * 0.8;
