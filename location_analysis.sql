-- 📦 Problem Statement – Logistics Network Analysis
-- A logistics company tracks package movements between distribution centers. Each record represents a package being transferred from one center to another. Some packages move through multiple hubs before reaching their final delivery center.

-- Your task:
-- For each package, determine:
-- The origin center (where the package journey started)
-- The final delivery center (where the package journey ended)
-- The origin center is the one that never appears as a to_center for that package.
-- The final delivery center is the one that never appears as a from_center for that package.
-- output columns
-- package_id, origin_center, final_delivery_center

CREATE TABLE package_movements (
    package_id VARCHAR(10),
    from_center VARCHAR(50),
    to_center VARCHAR(50));
INSERT INTO package_movements (package_id, from_center, to_center) VALUES
    ('P1', 'New York Hub', 'Chicago Hub'),
    ('P1', 'Chicago Hub', 'Denver Hub'),
    ('P1', 'Denver Hub', 'Los Angeles Hub'),
    ('P2', 'Mumbai Hub', 'Hyderabad Hub'),
    ('P2', 'Hyderabad Hub', 'Bangalore Hub'),
    ('P3', 'Delhi Hub', 'Jaipur Hub'),
    ('P3', 'Jaipur Hub', 'Ahmedabad Hub'),
    ('P3', 'Ahmedabad Hub', 'Pune Hub');

select * from package_movements;

select s.package_id,
max(case when e.package_id is null then s.from_center end) as origin_center,
max(case when e1.package_id is null then s.to_center end) as final_delivery_center
from package_movements as s
left join package_movements as e on s.package_id = e.package_id and s.from_center = e.to_center
left join package_movements as e1 on s.package_id = e1.package_id and s.to_center = e1.from_center
group by s.package_id;
