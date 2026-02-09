-- 📝 Problem Statement:
-- A common SQL analytics requirement is to calculate a cumulative sum over time, sometimes under constraints where window functions are not permitted. The objective was to compute a running total of sales for each record using only self joins, while maintaining correct business ordering.

drop table if exists sales;
CREATE TABLE sales (
    sale_id INT,
    sale_date DATE,
    product_name VARCHAR(50),
    price DECIMAL(10,2));
INSERT INTO sales VALUES
(1, '2024-01-05', 'Laptop', 5500.00),
(2, '2024-01-06', 'Mouse', 500.00),
(3, '2024-01-07', 'Keyboard', 1200.00),
(4, '2024-01-08', 'Laptop', 6000.00),
(5, '2024-01-09', 'Monitor', 1500.00),
(6, '2024-01-10', 'Mouse', 450.00),
(7, '2024-01-11', 'Laptop', 5800.00),
(8, '2024-01-12', 'Keyboard', 1100.00),
(9, '2024-01-13', 'Monitor', 1600.00);

select * from sales;

select s1.sale_id, s1.sale_date, s1.product_name, s1.price, sum(s2.price) as cum_sum
from sales as s1
join sales as s2
on s1.sale_date >= s2.sale_date
group by s1.sale_id, s1.sale_date, s1.product_name, s1.price 
order by s1.sale_id, s1.sale_date;
