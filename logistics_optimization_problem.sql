-- 🚚 Logistics Optimization Problem (Delivery Routes)

-- Problem Statement
-- Each row in the deliveries table represents a shipment between warehouses:
-- depart_time: when the shipment leaves
-- arrival_time: when it arrives
-- from_warehouse: starting warehouse code
-- to_warehouse: destination warehouse code

-- Each row in the warehouses table contains: warehouse_code, city_name
-- Each warehouse belongs to exactly one city.

-- Business Requirement
-- A package needs to be shipped from Chicago to Seattle in the shortest possible time.

-- Rules:
-- The package can start from any warehouse in Chicago.
-- It must end at any warehouse in Seattle.
-- It can have at most one intermediate transfer.
-- A transfer is valid only if:
-- The first delivery arrives on or before the second one departs.
-- The second delivery must start from the same warehouse where the first one ended.
-- Transfers are allowed even if:
-- arrival_time = depart_time (exact match allowed).

-- Write an SQL query to return:
-- start_city, transfer_city (NULL if direct), end_city, total_time_minutes

CREATE TABLE warehouses (
    warehouse_code VARCHAR(10),
    city_name VARCHAR(100));
INSERT INTO warehouses VALUES
('W1', 'Chicago'),
('W2', 'Chicago'),
('W3', 'Denver'),
('W4', 'Dallas'),
('W5', 'Seattle'),
('W6', 'Seattle');

drop table if exists deliveries;
CREATE TABLE deliveries (
    delivery_id INT,
    from_warehouse VARCHAR(10),
    to_warehouse VARCHAR(10),
    depart_time DATETIME,
    arrival_time DATETIME);
INSERT INTO deliveries VALUES
(1, 'W1', 'W5', '2025-07-01 08:00', '2025-07-01 20:00'),
(2, 'W1', 'W3', '2025-07-01 09:00', '2025-07-01 11:00'),
(3, 'W3', 'W5', '2025-07-01 11:15', '2025-07-01 15:00'),
(4, 'W2', 'W4', '2025-07-01 07:00', '2025-07-01 10:00'),
(5, 'W4', 'W6', '2025-07-01 10:30', '2025-07-01 18:00');

select * from warehouses;
select * from deliveries;

with cte as(
	select d.*, depart.city_name as departure_city, arrival.city_name as arrival_city
	from deliveries as d
	inner join warehouses as depart on d.from_warehouse = depart.warehouse_code
	inner join warehouses as arrival on d.to_warehouse =  arrival.warehouse_code),
cte1 as(
	select t1.departure_city as start_city, t1.arrival_city as transfer_city, t2.arrival_city as end_city,
	timestampdiff(minute,t1.depart_time,t2.arrival_time)/60 as total_time_taken
	from cte as t1 inner join cte as t2 on t1.to_warehouse = t2.from_warehouse and 
	t1.arrival_time <= t2.depart_time
	where t1.departure_city = 'Chicago' and t2.arrival_city = 'Seattle'
	union all
	select departure_city as start_city, null as transfer_city, arrival_city as end_city,
	timestampdiff(minute,depart_time,arrival_time)/60 as total_time_taken
	from cte where departure_city = 'Chicago' and arrival_city = 'Seattle')
select * from cte1 order by total_time_taken limit 1;