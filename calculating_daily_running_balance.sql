-- Daily Account Balance with Transactions
-- 📘 Scenario
-- You have an account with:
-- 1. Initial balance, 2. Daily transactions (credit/debit)
-- Each day’s balance depends on:
-- Previous day’s balance + today’s transaction
-- 👉 For each account, calculate:
-- Daily running balance, Based on previous day’s balance
-- output columns should include - account_id, txn_date, balance

CREATE TABLE accounts (
    account_id INT,
    initial_balance INT);
INSERT INTO accounts VALUES
(1, 1000),
(2, 2000);

drop table if exists transactions;
CREATE TABLE transactions (
    account_id INT,
    txn_date DATE,
    amount INT);
INSERT INTO transactions VALUES
(1, '2023-01-01', 200),
(1, '2023-01-02', -100),
(1, '2023-01-03', 300),
(2, '2023-01-01', -500),
(2, '2023-01-02', 200);

select * from accounts;
select * from transactions;

select a.account_id, t.txn_date, a.initial_balance + 
sum(t.amount) over(partition by a.account_id order by t.txn_date rows between unbounded preceding and current row) as running_balance
from accounts as a inner join transactions as t on a.account_id = t.account_id;