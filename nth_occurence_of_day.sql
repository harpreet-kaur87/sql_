-- Problem Statement : Finding the Nth Occurrence of a Weekday
-- Given today’s date, determine the Nth upcoming occurrence of a specified day of the week (e.g., 3rd Friday from today).

set @n = 3;
set @day_name = 'Friday';

with recursive cte as(
select current_date() as dt
union all
select dt + interval 1 day
from cte where dt < current_date() + interval 30 day),
cte1 as(
select dt, dayname(dt) as dy_name,
row_number() over(order by dt) as rn
 from cte
where dayname(dt) = @day_name)
select dt, dy_name from cte1 where rn = @n;
