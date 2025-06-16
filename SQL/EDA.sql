-- Count how many clients exist
SELECT
count(*)
FROM bank_marketing.clients;



-- Preview contact types used
SELECT
DISTINCT contact FROM bank_marketing.contacts;

-- Check subscription distribution
SELECT Y,
COUNT(*)
FROM bank_marketing.subscription
GROUP BY Y;


-- Get each client's contact duration and subscription outcome

SELECT
    c.client_id,
    con.duration,
    s.Y
FROM bank_marketing.clients AS c
JOIN bank_marketing.contacts AS con USING (client_id)
JOIN bank_marketing.subscription AS s USING (client_id)
WHERE y = 'no'
ORDER BY con.duration DESC ;


-- Join economic data with campaigns

SELECT
    c.client_id,
    c.job,
    e.Emp_var_rate,
    ca.campaign,
    s.Y
FROM bank_marketing.clients AS c
JOIN bank_marketing.economics AS e USING(client_id)
JOIN bank_marketing.campaigns AS ca USING(client_id)
JOIN bank_marketing.subscription AS s USING(client_id)
WHERE Emp_var_rate > 1 AND y = 'yes'
ORDER BY campaign DESC;



-- What job types are most likely to subscribe?
SELECT 
    cl.job,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.clients cl
JOIN bank_marketing.subscription s USING (client_id)
GROUP BY cl.job
ORDER BY subscription_rate DESC;



SELECT
    cl.job,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients cl 
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY cl.job
ORDER BY subscription_rate DESC;


-- Does contact duration affect subscription?
SELECT 
    CASE 
        WHEN duration < 100 THEN 'Short'
        WHEN duration BETWEEN 100 AND 300 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.contacts con
JOIN bank_marketing.subscription s USING (client_id)
GROUP BY duration_category
ORDER BY subscription_rate DESC;



SELECT
    CASE 
        WHEN duration < 1660 THEN 'Short'
        WHEN duration BETWEEN 1660 AND 3320 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate
FROM bank_marketing.contacts AS con
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY  duration_category
ORDER BY subscription_rate DESC;




SELECT
    Mnth,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) total,
    ROUND(COUNT(*) FILTER(WHERE s.Y = 'yes')* 100.0 / COUNT(*) , 2) AS subscription_rate
FROM bank_marketing.contacts AS c
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Mnth
ORDER BY subscription_rate DESC;


SELECT
loan,
count(*)
FROM bank_marketing.clients
GROUP BY loan;


SELECT
Housing,
count(*)
FROM bank_marketing.clients
GROUP BY housing;



SELECT
"Default",
count(*)
FROM bank_marketing.clients
GROUP BY "Default";


SELECT
    Age,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Age
ORDER BY subscription_rate DESC;


SELECT
    min(Age),
    max(age)
FROM bank_marketing.clients;


SELECT
    CASE 
        WHEN c.age BETWEEN 17 AND 30 THEN 'Yound Adults'
        WHEN c.age BETWEEN 31 AND 55 THEN 'Adults'
        WHEN c.age BETWEEN 56 AND 75 THEN 'Middle-Aged Adults'
        ELSE 'Seniors/Elderly'
    END AS age_groups,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate
FROM bank_marketing.clients AS c
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY age_groups
ORDER BY subscription_rate DESC;




WITH client_age_groups AS (
    SELECT
    c.client_id,
    c.marital,
    CASE
        WHEN c.age BETWEEN 17 AND 30 THEN 'Young Adults'
        WHEN c.age BETWEEN 31 AND 55 THEN 'Adults'
        WHEN c.age BETWEEN 56 AND 70 THEN 'Middle-Aged Adults'
        ELSE 'Seniors/Elderly'
    END AS age_groups
FROM bank_marketing.clients AS c       
)

SELECT
    cag.marital,
    cag.age_groups,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM client_age_groups AS cag
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY cag.age_groups , cag.marital
ORDER BY subscription_rate  DESC ;


SELECT
 education,
 COUNT(*) FILTER (WHERE Education  = 'unknown'),
 Count(*) 
 FROM bank_marketing.clients
GROUP BY education;

-- assessing the effect of various client's table column
SELECT
    education,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY education
ORDER BY subscription_rate DESC;


SELECT
    Marital,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Marital
ORDER BY subscription_rate DESC;


SELECT
    job,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY job
ORDER BY subscription_rate DESC;


SELECT
    "Default",
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY "Default"
ORDER BY subscription_rate DESC;

SELECT
    housing,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY housing
ORDER BY subscription_rate DESC;


SELECT
    loan,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY loan
ORDER BY subscription_rate DESC;


-- Evaluating effectivness


SELECT
    Day_of_week,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.contacts
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Day_of_week
ORDER BY subscription_rate DESC;


SELECT
    Mnth,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.contacts
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Mnth
ORDER BY subscription_rate DESC;


SELECT
    CASE
    WHEN duration BETWEEN 10 AND 1260 THEN 'short_calls'
    WHEN duration BETWEEN 1261 AND 2520 THEN 'medium_calls'
    ELSE 'long_call'
    END as call_duration,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.contacts
JOIN bank_marketing.campaigns AS cm USING (client_id)
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY call_duration , campaign
ORDER BY subscription_rate DESC;



SELECT
    contact,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.contacts
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY contact
ORDER BY subscription_rate DESC;



-- Time to assess campaign effectiveness

SELECT
    campaign,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.campaigns
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY campaign
ORDER BY campaign ;


SELECT
    Pdays,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.campaigns
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Pdays
ORDER BY subscription_rate DESC;


SELECT
    Previous,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.campaigns
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Previous
ORDER BY subscription_rate DESC;


SELECT
    Poutcome,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.campaigns
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Poutcome
ORDER BY subscription_rate DESC;

-- Evaluating macroeconmics indicators 

SELECT
    Emp_var_rate,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Emp_var_rate
ORDER BY subscription_rate DESC; -- when negative rate people are subscribing more 


SELECT
    Cons_price_idx,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Cons_price_idx
ORDER BY subscription_rate DESC;  -- same all over the places



SELECT
    Cons_conf_idx,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Cons_conf_idx
ORDER BY subscription_rate DESC; -- NO visible patterns



SELECT
    Euribor3m,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Euribor3m
ORDER BY subscription_rate DESC; -- again people are subscribing even if interest rates are low






SELECT
    ca.campaign,
    ca.Pdays,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.campaigns AS ca
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY ca.campaign , ca.Pdays
ORDER BY subscription_rate DESC; 

-- suggests that the less people were contacted the more the subscription rates were 
-- and the subscriber were mostly contacted in previous campaign too


DROP TABLE bank_marketing.clients_temp;


SELECT
  job,
  marital,
  education,
  housing,
  loan,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
  ROUND(100.0 * SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.subscription s ON c.client_id = s.client_id
WHERE age > 70
GROUP BY job, marital, education, housing, loan
ORDER BY subscription_rate DESC;


SELECT
  CASE
    WHEN age < 30 THEN 'Under 30'
    WHEN age BETWEEN 30 AND 50 THEN '30-50'
    WHEN age BETWEEN 51 AND 70 THEN '51-70'
    ELSE 'Over 70'
  END AS age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
  ROUND(100.0 * SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.subscription s ON c.client_id = s.client_id
GROUP BY age_group
ORDER BY subscription_rate DESC;


SELECT
    cn.campaign,
  ROUND(AVG(cont.duration), 1) AS avg_duration,
  ROUND(100.0 * SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.contacts c
JOIN bank_marketing.campaigns cn ON USING (client_id)
JOIN bank_marketing.subscription s ON USING (client_id)
GROUP BY cn.campaign
ORDER BY subscription_rate DESC;



SELECT
  camp.campaign,
  camp.pdays,
  camp.poutcome,
  COUNT(*) AS total,
  SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
  ROUND(100.0 * SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.campaigns camp ON c.client_id = camp.client_id
JOIN bank_marketing.subscription s ON c.client_id = s.client_id
WHERE c.age > 70
GROUP BY camp.campaign, camp.pdays, camp.poutcome
ORDER BY poutcome DESC;





SELECT
  ROUND(e.euribor3m, 1) AS euribor,
  ROUND(AVG(e.emp_var_rate), 2) AS avg_emp_var,
  COUNT(*) AS total,
  SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
  ROUND(100.0 * SUM(CASE WHEN s.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.economics e ON c.client_id = e.client_id
JOIN bank_marketing.subscription s ON c.client_id = s.client_id
WHERE c.age > 70
GROUP BY e.euribor3m
ORDER BY euribor;




SELECT
    e.euribor3m AS euribor,
    AVG(e.emp_var_rate) AS avg_emp_var,
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.economics e USING(client_id)
JOIN bank_marketing.subscription s USING(client_id)
WHERE c.age > 70
GROUP BY e.euribor3m
ORDER BY subscription_rate DESC;


SELECT
job,
  CASE
    WHEN age < 26 THEN 'Young adults'
    WHEN age BETWEEN 27 AND 46 THEN 'Adults'
    WHEN age BETWEEN 47 AND 60 THEN 'Seniors'
    ELSE 'Elderly'
  END AS age_group,
  COUNT(*) FILTER (WHERE s.y = 'yes') AS  subscribers,
  COUNT(*) AS total_clients,
  ROUND(COUNT(*) FILTER(WHERE s.y = 'yes') * 100 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients c
JOIN bank_marketing.subscription s USING(client_id)
WHERE job = 'admin'
GROUP BY age_group ,job
ORDER BY subscription_rate;



SELECT 
job,
count(*) AS job_count
FROM bank_marketing.clients
GROUP BY job
ORDER BY job_count DESC ;






SELECT
job,
education,
COUNT(*) AS C
FROM bank_marketing.clients
-- WHERE job = 'admin'
GROUP BY job ,education
ORDER BY c DESC ;


-- imputating values based on other values in different column 
UPDATE bank_marketing.clients
SET education = 'university.degree'
WHERE education IS NULL AND job = 'admin.';


UPDATE bank_marketing.clients
SET education = 'university.degree'
WHERE education IS NULL AND job = 'management';

UPDATE bank_marketing.clients
SET education = 'basic.9y'
WHERE education IS NULL AND job = 'blue-collar';

UPDATE bank_marketing.clients
SET education = 'professional.course'
WHERE education IS NULL AND job = 'technician';

UPDATE bank_marketing.clients
SET education = 'high.school'
WHERE education IS NULL AND job = 'services';


UPDATE bank_marketing.clients
SET education = 'basic.4y'
WHERE education IS NULL AND job = 'retired';


UPDATE bank_marketing.clients
SET education = 'university.degree'
WHERE education IS NULL AND job = 'entrepreneur';


UPDATE bank_marketing.clients
SET education = 'basic.4y'
WHERE education IS NULL AND job = 'housemaid';



UPDATE bank_marketing.clients
SET education = 'university.degree'
WHERE education IS NULL AND job = 'unemployed';


UPDATE bank_marketing.clients
SET education = 'high.school'
WHERE education IS NULL AND job = 'student';


-- updating job  and education column 
UPDATE bank_marketing.clients
SET education = 
    CASE 
    WHEN job = 'Not specified' AND education = 'basic.4y' THEN 'blue-collar'
    WHEN job = 'Not specified' AND education = 'university.degree' THEN 'admin'
    WHEN job = 'Not specified' AND education = 'high.school' THEN 'services'
    WHEN job = 'Not specified' AND education = 'basic.9y' THEN 'blue-collar'
    WHEN job = 'Not specified' AND education = 'professional.course' THEN 'technician'
    END
    WHEN job IS NULL AND education = 'basic.6y' THEN 'blue-collar'
    WHEN job = 'admin' AND education  IS NULL THEN 'university.degree'
    end
WHERE education IS NULL;






UPDATE bank_marketing.clients
SET job = REPLACE(job, 'admin.' , 'admin')
WHERE job LIKE '%admin.%';



SELECT
education,job,
COUNT(*) AS C
FROM bank_marketing.clients
GROUP BY  education , job
ORDER BY c DESC ;


SELECT
marital,job,
COUNT(*) AS C
FROM bank_marketing.clients
GROUP BY  marital , job
ORDER BY c DESC ;

-- yeah might be wondering when we had to replace most of the values with 'married' Then why did'nt we 
-- use a single step , because these are based on their mod of job values 
UPDATE bank_marketing.clients 
SET marital = 
    CASE 
    WHEN marital = 'Not specified' AND job = 'admin' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'blue-collar' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'technician' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'services' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'unemployed' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'retired' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'self-employed' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'housemaid' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'management' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'entrepreneur' THEN 'married'
    WHEN marital = 'Not specified' AND job = 'student' THEN 'single'
    END 
WHERE marital = 'Not specified';

SELECT
housing,job,
COUNT(*) AS C
FROM bank_marketing.clients
GROUP BY  housing , job
ORDER BY c DESC ;

-- again we are gonna replace not specified based on their max values of their jobs

UPDATE bank_marketing.clients 
SET housing = 
    CASE 
    WHEN housing IS NULL AND job = 'blue-collar' THEN 'yes'
    WHEN housing IS NULL AND job = 'admin' THEN 'yes'
    WHEN housing IS NULL AND job = 'technician' THEN 'no'
    WHEN housing IS NULL AND job = 'services' THEN 'yes'
    WHEN housing IS NULL AND job = 'unemployed' THEN 'yes'
    WHEN housing IS NULL AND job = 'retired' THEN 'yes'
    WHEN housing IS NULL AND job = 'self-employed' THEN 'yes'
    WHEN housing IS NULL AND job = 'housemaid' THEN 'yes'
    WHEN housing IS NULL AND job = 'management' THEN 'yes'
    WHEN housing IS NULL AND job = 'entrepreneur' THEN 'yes'
    WHEN housing IS NULL AND job = 'student' THEN 'yes'
    END 
WHERE housing IS NULL;


SELECT
loan,job,
COUNT(*) AS C
FROM bank_marketing.clients
GROUP BY  loan, job
ORDER BY c DESC ;


-- One more time will replace with the adjacent values of max(job) column 

UPDATE bank_marketing.clients 
SET loan = 
    CASE 
    WHEN loan = 'Not specified' AND job = 'blue-collar' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'admin' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'technician' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'services' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'unemployed' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'retired' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'self-employed' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'housemaid' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'management' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'entrepreneur' THEN 'no'
    WHEN loan = 'Not specified' AND job = 'student' THEN 'no'
    END 
WHERE loan ='Not specified';


SELECT
"Default",job,
COUNT(*) AS C
FROM bank_marketing.clients
GROUP BY  job,"Default"
ORDER BY c DESC ;


-- will apply the same steps to eliminate the unspecified category from the column


UPDATE bank_marketing.clients 
SET "Default" = 
    CASE 
    WHEN "Default" = 'Not specified' AND job = 'blue-collar' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'admin' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'technician' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'services' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'unemployed' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'retired' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'self-employed' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'housemaid' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'management' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'entrepreneur' THEN 'no'
    WHEN "Default" = 'Not specified' AND job = 'student' THEN 'no'
    END 
WHERE "Default" ='Not specified';


SELECT
    CASE
        WHEN age BETWEEN 17 AND 26 'Young_adults',
        WHEN age BETWEEN 27 AND 46 THEN 'adults',
        WHEN age BETWEEN 47 AND 60 THEN 'Senior_adults',
        ELSE 'Elderly'
    END AS age_groups,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY age,employment
ORDER BY total DESC;



SELECT
    Cons_conf_idx,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY Cons_conf_idx
ORDER BY subscription_rate DESC;



SELECT
    emp_var_rate,
    euribor3m,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
WHERE emp_var_rate >= 1 AND euribor3m >= 1
GROUP BY emp_var_rate , euribor3m 
ORDER BY total DESC;



SELECT
    emp_var_rate,
    Cons_price_idx,
    euribor3m,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
WHERE emp_var_rate > 1 AND Cons_price_idx < 100 AND euribor3m > 1
GROUP BY emp_var_rate , Cons_price_idx , euribor3m
ORDER BY subscription_rate DESC;


SELECT
    emp_var_rate,
    euribor3m,
    Nr_employed,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
WHERE euribor3m < 4
GROUP BY euribor3m , emp_var_rate , Nr_employed
ORDER BY subscription_rate DESC ;


SELECT
Nr_employed,
count(nr_employed) as ec
FROM bank_marketing.economics
GROUP BY nr_employed
ORDER BY ec DESC;



WITH employed_groups AS (
    SELECT
    client_id,
    e.euribor3m,
    CASE
        WHEN e.nr_employed BETWEEN 4900 AND 5000 THEN 'low_emp'
        WHEN e.nr_employed BETWEEN 5000 AND 5200 THEN 'normal_emp'
        ELSE 'highly_emp'
    END AS employment
FROM bank_marketing.economics as E       
)

SELECT
    eg.employment,
    eg.euribor3m,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM employed_groups as eg
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY employment , euribor3m
ORDER BY subscription_rate DESC ;




SELECT
    emp_var_rate,
    Cons_price_idx,
    COUNT(*) FILTER (WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY emp_var_rate,Cons_price_idx
ORDER BY subscription_rate  ;



SELECT
cons_conf_idx,
count(cons_conf_idx) as ec
FROM bank_marketing.economics
GROUP BY cons_conf_idx
ORDER BY ec DESC;


SELECT
cons_price_idx,
count(cons_price_idx) as ec
FROM bank_marketing.economics
GROUP BY cons_price_idx
ORDER BY ec DESC;





WITH employed_groups AS (
    SELECT
    client_id,
    e.emp_var_rate,
    e.cons_price_idx,
    e.cons_conf_idx,
    CASE
        WHEN e.cons_price_idx BETWEEN 92 AND 93 THEN 'low_price'
        WHEN e.cons_price_idx BETWEEN 93 AND 94 THEN 'medium_price'
        ELSE 'high_price'
    END AS bucket_price
FROM bank_marketing.economics as E       
)

SELECT
    eg.emp_var_rate,
    eg.bucket_price,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM employed_groups as eg
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY  bucket_price , emp_var_rate
ORDER BY subscription_rate DESC ;


SELECT
    eg.emp_var_rate,
    eg.bucket_price,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM employed_groups as eg
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY  bucket_price , emp_var_rate
ORDER BY subscription_rate DESC ;


SELECT
    eg.emp_var_rate,
    eg.cons_conf_idx,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM employed_groups as eg
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY  bucket_price , emp_var_rate
ORDER BY subscription_rate DESC ;




WITH employed_groups AS (
    SELECT
    client_id,
    e.emp_var_rate,
    e.cons_conf_idx,
    CASE
        WHEN e.cons_conf_idx > -26 AND e.cons_conf_idx < -37 THEN 'low_conf'
        WHEN e.cons_conf_idx  > -37 AND e.cons_conf_idx < -43 THEN 'normal_conf'
        ELSE 'high_conf'
    END AS conf_level
FROM bank_marketing.economics as E       
)

SELECT
    eg.emp_var_rate,
    eg.conf_level,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM employed_groups as eg
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY emp_var_rate, conf_level
ORDER BY subscription_rate DESC;



SELECT
    emp_var_rate,
    cons_conf_idx,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM bank_marketing.economics
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY emp_var_rate, cons_conf_idx
ORDER BY emp_var_rate DESC;



SELECT
    sub.confidence_level,
   COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM (
  SELECT
    s.client_id,
    s.Y,
    CASE
      WHEN e.cons_conf_idx <= -40 THEN 'Very Low'
      WHEN e.cons_conf_idx BETWEEN -39.9 AND -20 THEN 'Low'
      WHEN e.cons_conf_idx BETWEEN -19.9 AND -10 THEN 'Moderate'
      WHEN e.cons_conf_idx BETWEEN -9.9 AND -1 THEN 'Mild'
      ELSE 'Neutral to High'
    END AS confidence_level
  FROM bank_marketing.economics AS e
  JOIN bank_marketing.subscription AS s USING(client_id)
) sub
GROUP BY confidence_level
ORDER BY subscription_rate DESC;


SELECT
    sq.nr_employed,
  sq.confidence_level,
  COUNT(*) FILTER(WHERE sq.Y = 'yes') AS subscribed,
  COUNT(*) AS total,
  ROUND(COUNT(*) FILTER (WHERE sq.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate
FROM (
  SELECT
    s.client_id,
    e.nr_employed,
    e.euribor3m,
    s.Y,
    CASE
      WHEN e.cons_conf_idx <= -51 THEN 'Very Low'
      WHEN e.cons_conf_idx BETWEEN -43 AND -37 THEN 'Low'
      WHEN e.cons_conf_idx BETWEEN -37 AND -26 THEN 'Moderate'
      ELSE 'Neutral to High'
    END AS confidence_level
  FROM bank_marketing.economics AS e
  JOIN bank_marketing.subscription AS s USING(client_id)
) AS sq -- Alias the subquery
GROUP BY sq.confidence_level, sq.nr_employed
ORDER BY subscription_rate DESC;



-- contacts table assessment



SELECT
    ca.contact,
    ca.mnth,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS subscription_rate 
FROM bank_marketing.contacts AS ca
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY ca.contact, ca.mnth 
ORDER BY subscription_rate DESC;






SELECT
duration,
count(*) as total
FROM bank_marketing.contacts
GROUP BY duration;





SELECT
    CASE
        WHEN c.campaign <= 1 THEN  '1'
        WHEN c.campaign > 1 and c.campaign <= 3 THEN '2-3'
        WHEN c.campaign > 3 and c.campaign <= 5 THEN '4-5'
        WHEN c.campaign > 5 and c.campaign <= 10 THEN '6-10'
        ELSE '10+'
    END campaign_level,
    COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS conversion_rate 
FROM bank_marketing.campaigns AS c    
JOIN  bank_marketing.subscription AS s USING (client_id)
GROUP BY campaign_level
ORDER BY conversion_rate DESC;





SELECT previous,
count(*) as count_p,
COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE s.Y = 'yes') * 100.0 / COUNT(*) , 2) AS conversion_rate 
FROM bank_marketing.campaigns AS c    
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY previous
ORDER BY conversion_rate DESC;



SELECT
age,
job,
COUNT(*) FILTER(WHERE s.Y = 'yes') AS subscribed,
COUNT(*) AS total,
ROUND(COUNT(*) FILTER (WHERE s.y = 'yes') * 100 / COUNT(*) , 2 ) AS conversion_rate
FROM bank_marketing.clients
JOIN bank_marketing.subscription AS s USING (client_id)
GROUP BY age, job
ORDER BY conversion_rate DESC;



SELECT 
DISTINCT previous
FROM bank_marketing.campaigns;




