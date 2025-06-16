--  let's begin with client table


-- Adding age_group column
ALTER TABLE bank_marketing.clients
ADD COLUMN age_group TEXT;

UPDATE bank_marketing.clients
SET age_group = CASE
    WHEN age BETWEEN 17 AND 28 THEN 'Young_adults'
    WHEN age BETWEEN 29 AND 46 THEN 'Adults'
    WHEN age BETWEEN 47 AND 60 THEN 'Senior_adults'
    ELSE 'Ederly'
END;


-- Adding financial_risk column

ALTER TABLE bank_marketing.clients
ADD COLUMN financial_risk TEXT;

UPDATE bank_marketing.clients
SET financial_risk = CASE
    WHEN "Default" = 'no' AND loan = 'no' AND housing = 'no' THEN 'low_risk'
    WHEN ("Default" = 'yes' OR loan = 'yes' OR housing = 'yes') THEN 'moderate_risk'
    ELSE 'unknown_risk'
END;


-- Ensuring proper execution..
SELECT 
DISTINCT age_group
FROM bank_marketing.clients;


SELECT
DISTINCT financial_risk
FROM bank_marketing.clients;



-- Time for enriching contacts table

ALTER TABLE bank_marketing.contacts
ADD COLUMN call_duration_band TEXT;


UPDATE bank_marketing.contacts
SET call_duration_band = CASE
    WHEN duration < 60 THEN '<1min'
    WHEN duration >= 60 AND duration < 180 THEN '1-3min'
    WHEN duration >= 180 AND duration < 300 THEN '3-5min'
    WHEN duration >= 300 AND duration < 600  THEN '5-10min'
    WHEN duration >= 600 AND duration <= 752 THEN '10+min'
    WHEN duration > 752 THEN 'outlier'
    ELSE 'unknown'
END;

-- ensuring the results
SELECT call_duration_band, COUNT(*)
FROM bank_marketing.contacts
GROUP BY call_duration_band
ORDER BY COUNT(*) DESC;


-- Let's move toward campaign table for envigoration


ALTER TABLE bank_marketing.campaigns
ADD COLUMN repeated_contacts TEXT;


UPDATE bank_marketing.campaigns
SET repeated_contacts =   CASE
        WHEN campaign <= 1 THEN  '1'
        WHEN campaign > 1 and campaign <= 3 THEN '2-3'
        WHEN campaign > 3 and campaign <= 5 THEN '4-5'
        WHEN campaign > 5 and campaign <= 10 THEN '6-10'
        ELSE '10+'
    END;


ALTER TABLE bank_marketing.campaigns
ADD COLUMN contacted_before TEXT;


UPDATE bank_marketing.campaigns
SET contacted_before = CASE
    WHEN pdays = 999 THEN 'not_contacted_recently'
    ELSE 'contacted_before'
END;


SELECT repeated_contacts, COUNT(*) FROM bank_marketing.campaigns GROUP BY 1;
SELECT contacted_before, COUNT(*) FROM bank_marketing.campaigns GROUP BY 1;



-- let's move towards economics table representing indicators of economy..

ALTER TABLE bank_marketing.economics
ADD COLUMN economic_sentiment TEXT;



UPDATE bank_marketing.economics
SET economic_sentiment = CASE
      WHEN cons_conf_idx <= -51 THEN 'Very Low'
      WHEN cons_conf_idx BETWEEN -43 AND -37 THEN 'Low'
      WHEN cons_conf_idx BETWEEN -37 AND -26 THEN 'Moderate'
      ELSE 'Neutral to High'
    END;



ALTER TABLE bank_marketing.economics
ADD COLUMN euirbor_band TEXT;

UPDATE bank_marketing.economics
SET euirbor_band = CASE
    WHEN euribor3m < 1 THEN 'low'
    WHEN euribor3m >= 1 AND euribor3m <= 3 THEN 'moderate'
    ELSE 'high'
END;


-- First, add two new columns if not already present
ALTER TABLE bank_marketing.economics 
ADD COLUMN nr_employed_stability TEXT;

ALTER TABLE bank_marketing.economics 
ADD COLUMN emp_var_rate_stability TEXT;

-- Now, update nr_employed_stability
UPDATE bank_marketing.economics
SET nr_employed_stability = CASE
    WHEN nr_employed >= 5200 THEN 'very_stable'
    WHEN nr_employed >= 5100 THEN 'stable'
    WHEN nr_employed >= 5000 THEN 'slightly_unstable'
    WHEN nr_employed >= 4900 THEN 'unstable'
    ELSE 'very_unstable'
END;

-- Update emp_var_rate_stability
UPDATE bank_marketing.economics
SET emp_var_rate_stability = CASE
    WHEN emp_var_rate >= 1.0 THEN 'very_stable'
    WHEN emp_var_rate >= 0.0 THEN 'stable'
    WHEN emp_var_rate >= -1.0 THEN 'slightly_unstable'
    WHEN emp_var_rate >= -3.0 THEN 'unstable'
    ELSE 'very_unstable'
END;


SELECT nr_employed_stability, COUNT(*) 
FROM bank_marketing.economics
GROUP BY 1
ORDER BY 1;

SELECT emp_var_rate_stability, COUNT(*) 
FROM bank_marketing.economics
GROUP BY 1
ORDER BY 1;




-- exporting tables into csv
SELECT *
FROM bank_marketing.clients;

SELECT *
FROM bank_marketing.contacts;

SELECT *
FROM bank_marketing.campaigns;

SELECT *
FROM bank_marketing.economics; 

SELECT *
FROM bank_marketing.subscription;

