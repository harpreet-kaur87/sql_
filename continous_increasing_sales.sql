use major;
-- Finding Continuously Increasing Products Using Self Joins
-- Find the products whose sales are continuously increasing day by day.

DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales(
    product_name VARCHAR(50),
    sale_date DATE,
    sale_amount INT);
INSERT INTO product_sales VALUES('Product A','2023-01-01',500);
INSERT INTO product_sales VALUES('Product A','2023-01-02',600);
INSERT INTO product_sales VALUES('Product A','2023-01-03',700);
INSERT INTO product_sales VALUES('Product B','2023-01-01',300);
INSERT INTO product_sales VALUES('Product B','2023-01-02',400);
INSERT INTO product_sales VALUES('Product B','2023-01-03',350);
INSERT INTO product_sales VALUES('Product C','2023-01-01',100);
INSERT INTO product_sales VALUES('Product C','2023-01-02',200);
INSERT INTO product_sales VALUES('Product C','2023-01-03',300);
INSERT INTO product_sales VALUES('Product C','2023-01-04',400);
INSERT INTO product_sales VALUES('Product D','2023-01-01',100);
INSERT INTO product_sales VALUES('Product D','2023-01-02',900);
INSERT INTO product_sales VALUES('Product D','2023-01-03',300);

select * from product_sales;

select t1.product_name
from product_sales as t1
left join product_sales as t2
on t1.product_name = t2.product_name
and t1.sale_date = date_add(t2.sale_date, interval 1 day)
and t1.sale_amount <= t2.sale_amount
group by t1.product_name having count(t2.product_name) = 0;
