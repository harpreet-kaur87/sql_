-- 🧩 Problem Statement
-- You are given a table categories that stores product categories in a hierarchical structure using parent_id.

-- 👉 Task:
-- Write a SQL query to display:
-- Each parent category
-- Along with all its subcategories (direct + indirect)

CREATE TABLE categories (
    category_id INT,
    category_name VARCHAR(50),
    parent_id INT);
INSERT INTO categories (category_id, category_name, parent_id) VALUES
(1, 'Electronics', NULL),
(2, 'Mobiles', 1),
(3, 'Smartphones', 2),
(4, 'Feature Phones', 2),
(5, 'Laptops', 1),
(6, 'Gaming Laptops', 5),
(7, 'Ultrabooks', 5),
(8, 'Fashion', NULL),
(9, 'Men', 8),
(10, 'Women', 8),
(11, 'Accessories', 9),
(12, 'Shoes', 10);

select * from categories;

with recursive cte as(
select category_id, category_name, parent_id, category_name as parent_name
from categories where parent_id is null
union all
select c.category_id, c.category_name, c.parent_id, p.parent_name
from categories as c inner join cte as p on c.parent_id = p.category_id)
select parent_name, category_name as child_name from cte where category_name <> parent_name
order by parent_name, child_name;