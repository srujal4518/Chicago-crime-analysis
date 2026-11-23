create database crimes;
use crimes;
select * from crime limit 5;

-- 1
-- Yearly trend: How many crimes were reported each year, 
-- and what was the percentage change compared with the previous year? (GROUP BY, LAG)
with mycte as (
select year,count(*) as crimes_this_year
from crime group by year
),
mycte2 as (
select *,lag(crimes_this_year) over() as crimes_last_year from mycte
)
select *,(crimes_this_year-crimes_last_year) as difference,
concat(round((crimes_this_year - crimes_last_year) * 100.0 / crimes_last_year,2),'%') as percentage_change
from mycte2;




-- 2
-- Top crime types: What are the top 5 crime types (primary_type)
-- in each year? (window function with RANK or ROW_NUMBER)
with mycte as (
select year,primary_type,count(*) as total_crimes from crime 
group by year,primary_type
),
mycte2 as (
select *,dense_rank() over(partition by year order by total_crimes desc) as ranks from mycte
)
select * from mycte2 where ranks<=5
limit 10;


-- 3
-- Arrest rate by crime type: For each primary_type, what percentage of cases ended in an arrest? 
-- Show only types with more than 10,000 cases, sorted from highest to lowest rate. (GROUP BY, HAVING)
with mycte as (
select primary_type,count(*) as total_crimes,
sum(case when arrest=1 then 1 else 0 end) as arrested,
sum(case when arrest=0 then 1 else 0 end) as not_arrested
from crime group by primary_type
),
mycte2 as (
select * from mycte where total_crimes>10000 
order by arrested desc
)
select *,round((arrested*100.0)/total_crimes,2) as arrest_rate from mycte2;


-- 4
-- Peak hours: Which hour of the day has the most crimes,
-- and how does that change between weekdays and weekends? (date functions, CASE)
select hour(date) as crime_hour,
case when dayofweek(date) in (1,7) then 'weekend' else 'weekday' end as day_type,
count(*) as total_crimes  
from crime
group by crime_hour,day_type
order by day_type,total_crimes desc
limit 15;


-- 5
-- Seasonality: Which month has the highest number of crimes across 2016 to 2025? 
-- Leave out 2026 because the year is incomplete. (subquery or CTE, AVG)
with mycte as (
select monthname(date) as month_name,count(*) as total_crimes from crime
where date between '2016-01-01' and '2025-12-31'
group by monthname(date)
)
select *,dense_rank() over(order by total_crimes desc) as ranks from mycte;



-- 6 
-- Domestic share by district: For each police district, what percentage of crimes were domestic-related? 
-- Which 5 districts have the highest share? (conditional aggregation)
select district,count(*) as total_crimes,
sum(case when domestic = true then 1 else 0 end) AS domestic_crimes,
round(sum(case when domestic = true then 1 else 0 end) * 100.0/ count(*),2) as domestic_percentage
from crime
where district is not null
group by district
order by domestic_percentage desc
limit 15;




-- 7 
-- Hotspot locations: What are the 10 most common location_description values for THEFT, 
-- and how many are arrested for each? (WHERE, GROUP BY, ORDER BY)
with mycte as (
select location_description,count(*) as total_thefts,
sum(case when arrest=1 then 1 else 0 end) as arrested
from crime
where primary_type='THEFT'
group by location_description
),
mycte2 as (
select *,dense_rank() over(order by total_thefts desc) as ranks from mycte
)
select * from mycte2 where ranks<=10;


-- 8
-- Pandemic impact: Compare the number of crimes in 2019, 2020 and 2021 by crime type.
-- Which types dropped the most in 2020 versus 2019? (self-join or CASE pivot)
with mycte as (
select primary_type,
sum(case when year between 2016 and 2019 then 1 else 0 end) as pre_covid,
sum(case when year between 2020 and 2021 then 1 else 0 end) covid,
sum(case when year between 2022 and 2025 then 1 else 0 end) as post_covid
from crime
where year between 2016 and 2025
group by primary_type
)
select *,round(pre_covid/4.0,2) as pre_covid_yearly_avg,
round(covid/2.0,2) as covid_yearly_avg,
round(post_covid/4.0,2) as post_covid_yearly_avg
from mycte
limit 15;




-- 9. Crime description analysis
-- Find the top 5 most common description values for every primary_type, ranked by reported crime count.
with description_counts as (
select primary_type,description,count(*) as total_crimes
from crime
group by primary_type, description
),
ranked_descriptions as (
select *,dense_rank() over (partition by primary_type order by total_crimes desc) as crime_rank
from description_counts
)
select * from ranked_descriptions where crime_rank <= 5
order by primary_type, crime_rank
limit 15;



select count(*) from crime;