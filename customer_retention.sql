-- Calculate the number of customers retained in the immediate next month using SQL, ensuring the logic works correctly across different order dates within a month.

drop table if exists sales;
CREATE TABLE sales (
    order_id     INT,
    customer_id  INT,
    order_date   DATE,
    order_amount INT
);
INSERT INTO sales VALUES
(1, 101, '2021-01-05', 220),
(2, 101, '2021-02-07', 180),
(3, 101, '2021-03-09', 240),
(4, 101, '2021-04-11', 200),
(5, 102, '2021-01-12', 150),
(6, 102, '2021-03-15', 170),
(7, 103, '2021-02-01', 300),
(8, 103, '2021-03-03', 310),
(9, 104, '2021-02-18', 90),
(10, 105, '2021-01-25', 400),
(11, 105, '2021-02-26', 420),
(12, 105, '2021-03-27', 380),
(13, 105, '2021-04-28', 410),
(14, 105, '2021-05-29', 450),
(15, 106, '2021-03-10', 200),
(16, 106, '2021-04-12', 210),
(17, 107, '2021-04-05', 130),
(18, 108, '2021-05-08', 160);

select date_format(t1.order_date,'%Y-%m') as dd, count(distinct t2.customer_id) as retained_customers
from sales as t1
left join sales as t2 
on t1.customer_id = t2.customer_id and date_format(t1.order_date,'%Y-%m') = date_format(date_add(t2.order_date,interval 1 month),'%Y-%m') group by dd;

