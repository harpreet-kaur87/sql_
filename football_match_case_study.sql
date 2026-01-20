-- Problem Statement : Football Match Points Table
-- You are given a table that stores the results of football matches played between two teams. Each record represents one match, including the home team, away team, and the match result.
-- 'home' → Home team won the match
-- 'away' → Away team won the match
-- 'draw' → Match ended in a draw

-- Write an SQL query to generate a points table that shows the performance of each team.
-- For each team, return the following details:
-- 1. Total matches played
-- 2. Matches won
-- 3. Matches drawn
-- 4. Matches lost
-- 5. Total points earned

-- Points System
-- Win → 2 points
-- Draw → 1 point (to each team)
-- Loss → 0 points

CREATE TABLE football_matches(
    home_team   VARCHAR(20),
    away_team   VARCHAR(20),
    result      VARCHAR(20));
INSERT INTO football_matches VALUES ('Brazil', 'Argentina', 'home');
INSERT INTO football_matches VALUES ('Germany', 'France', 'away');
INSERT INTO football_matches VALUES ('Spain', 'Italy', 'draw');
INSERT INTO football_matches VALUES ('Brazil', 'Germany', 'away');
INSERT INTO football_matches VALUES ('France', 'Italy', 'draw');
INSERT INTO football_matches VALUES ('Argentina', 'Brazil', 'draw');

select * from football_matches;

with cte as(
select home_team as team,
(case when result = 'home' then home_team end) as winning_flag,
(case when result = 'draw' then home_team end) as draw_flag
from football_matches
union all
select away_team as team,
(case when result = 'away' then away_team end) as winning_flag,
(case when result = 'draw' then away_team end) as draw_flag
from football_matches)
select team, count(*) as total_matches_played, count(winning_flag) as matches_won, count(draw_flag) as matches_drawn,
count(*) - (count(winning_flag)+count(draw_flag)) as matches_lost,
(2*count(winning_flag)+1*count(draw_flag)) as total_points
from cte group by team;