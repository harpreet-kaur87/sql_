-- 🚀 Problem: Detect Suspicious Transactions (Time-Based Self Join)
-- 🎯 Task
-- Identify suspicious transactions where:
-- 👉 A user makes multiple transactions within a short time window (e.g., 10 minutes)
-- 👉 AND the total amount within that window exceeds ₹50,000

-- ✅ Output should include:
-- user_id
-- txn_id (current transaction)
-- txn_time
-- total_amount_in_window

-- ⚠️ Rules
-- Consider current transaction + previous transactions within 10 minutes
-- Only include cases where:
-- Total amount > 50,000
-- Transactions must belong to the same user
-- Must solve using self join only
-- 👉 Only flag cases where number of transactions ≥ 3 in that window


drop table if exists transactions;
CREATE TABLE transactions (
    txn_id INT,
    user_id INT,
    txn_time TIMESTAMP,
    amount INT);
INSERT INTO transactions (txn_id, user_id, txn_time, amount) VALUES
(1, 101, '2024-01-01 10:00:00', 20000),
(2, 101, '2024-01-01 10:05:00', 15000),
(3, 101, '2024-01-01 10:08:00', 20000),
(4, 101, '2024-01-01 10:25:00', 30000),
(5, 102, '2024-01-01 11:00:00', 10000),
(6, 102, '2024-01-01 11:05:00', 15000),
(7, 103, '2024-01-01 12:00:00', 25000),
(8, 103, '2024-01-01 12:10:00', 30000),
(9, 104, '2024-01-01 13:00:00', 20000),
(10, 104, '2024-01-01 13:04:00', 20000),
(11, 104, '2024-01-01 13:09:00', 20000),
(12, 105, '2024-01-01 14:00:00', 60000);

select * from transactions;

select t1.user_id, t1.txn_id, t1.txn_time, sum(t2.amount) as total_amount_in_window, count(*) as cnt
from transactions as t1
join transactions as t2
on t1.user_id = t2.user_id and t2.txn_time between t1.txn_time - interval 10 minute and t1.txn_time
group by t1.user_id, t1.txn_id, t1.txn_time having sum(t2.amount) > 50000 and count(*) >= 3;