-- Write a SQL query using ONLY SELF JOINS to find all pairs of customers who have purchased exactly the same set of unique product_ids.

CREATE TABLE sales (
    customer_id INT,
    product_id INT,
    purchase_date DATE);
INSERT INTO sales (customer_id, product_id, purchase_date) VALUES
(1, 101, '2024-01-01'),
(1, 102, '2024-01-02'),
(1, 103, '2024-01-03'),
(2, 101, '2024-01-01'),
(2, 102, '2024-01-04'),
(3, 101, '2024-01-02'),
(3, 103, '2024-01-05'),
(4, 104, '2024-01-01'),
(5, 101, '2024-01-03'),
(5, 102, '2024-01-06'),
(5, 103, '2024-01-07');

select * from sales;

with cte as(
select customer_id, count(distinct product_id) as cnt, group_concat(distinct product_id order by product_id) as grp
from sales group by customer_id)
select concat(c1.customer_id, ', ',c2.customer_id) as customer_pairs
from cte as c1
join cte as c2 on c1.cnt = c2.cnt and c1.grp = c2.grp and c2.customer_id > c1.customer_id;