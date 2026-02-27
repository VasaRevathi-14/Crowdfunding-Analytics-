-- total no of projects based on outcome
select
state,
count(projectID) as Total_projects
from projects
group by state
order by Total_projects;
drop table projects;

-- total projects by location
select 
country,count(projectID) as total_projects
from projects
group by country
order by total_projects;

-- total projects by year,month, quarter
SELECT
    YEAR(FROM_UNIXTIME(created_at)) AS year,
    QUARTER(FROM_UNIXTIME(created_at)) AS quarter,
    MONTH(FROM_UNIXTIME(created_at)) AS month,
    COUNT(ProjectID) AS total_projects
FROM projects
GROUP BY year, quarter, month
ORDER BY year, quarter, month;

-- Successful Projects Amount Raised 
select
name as Project_name,
state,
sum(pledged) as Amount_raised
from projects
where state='successful'
group by Project_name
order by Amount_raised desc;

-- top 10 successful projects based on Amount raised
select
name as Project_name,
state,
sum(pledged) as Amount_raised
from projects
where state='successful'
group by Project_name
order by Amount_raised desc
limit 10;

-- succesful projects by Backers

select
name as project_name,
state,
sum(backers_count) as backers
from projects
where state='successful'
group by project_name 
order by backers desc;

-- top 10 successful projects by backers
select
name as project_name,
state,
sum(backers_count) as backers
from projects
where state='successful'
group by project_name
order by backers desc
limit 10;

-- Avg NUmber of Days for successful projects
select
avg(datediff(
 from_unixtime(deadline),
 from_unixtime(launched_at)) 
) as avg_days
from projects
where state='successful';

-- Percentage of Successful Projects overall
select
state,
   concat( round((COUNT(ProjectID) * 100.0 )/ (select count(ProjectID) from projects)),"%")
    as success_percentage
from projects
where state = 'Successful';

-- Percentage of Successful Projects by Year , Month 
select
YEAR(FROM_UNIXTIME(created_at)) AS year,
    QUARTER(FROM_UNIXTIME(created_at)) AS quarter,
    MONTH(FROM_UNIXTIME(created_at)) AS month,
    concat(round((COUNT(ProjectID)*100)/ (select count(projectID) from projects)),"%")
    as successful_Projects
from projects
group by year, quarter, month
order by successful_projects desc
limit 10;

select
state,
        case
			when goal < 5000 then '<5K'
            when goal between 5000 and 20000 then '5K–20K'
            when goal between 20001 and 100000 then '20K–100K'
            else '>100K'
            end as Goal_range
       from projects
       where state='successful'
       order by Goal_range desc;     
            

















