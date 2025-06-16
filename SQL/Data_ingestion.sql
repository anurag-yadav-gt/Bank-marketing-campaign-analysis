CREATE DATABASE Bank_marketing;


-- Storing tables in sql 

CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    Age INT,
    Job VARCHAR(50),
    Marital VARCHAR(20),
    Education VARCHAR(50),
    "Default" VARCHAR(3), -- Default is a reserved keyword 
    Housing VARCHAR(3),
    loan VARCHAR(3)
);

DROP table clients;

ALTER TABLE clients 
ALTER COLUMN "Default" TYPE VARCHAR(50);

ALTER TABLE clients 
ALTER COLUMN Housing TYPE VARCHAR(50);

ALTER TABLE clients 
ALTER COLUMN loan TYPE VARCHAR(50);


CREATE TABLE contacts (
    contact_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    Contact VARCHAR(20),
    Mnth VARCHAR(10),
    Day_of_week VARCHAR(10),
    Duration INT
);

DROP table contacts;

DROP TABLE if exists contacts;



CREATE TABLE campaigns (
    Campaign_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    Campaign INT,
    Pdays INT,
    Previous INT,
    Poutcome VARCHAR(20)
);

drop table campaigns;

CREATE TABLE economics (
    Econ_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    Emp_var_rate FLOAT,
    Cons_price_idx FLOAT,
    Cons_conf_idx FLOAT,
    Euribor3m FLOAT,
    Nr_employed FLOAT
);

drop table economics;

CREATE TABLE subscription (
    client_id INT PRIMARY KEY REFERENCES clients(client_id),
    Y VARCHAR(3)
);


drop table subscription;


-- Let's populate our empty tables 



COPY clients
FROM 'd:\Python 2.0\Project 2\clients.csv'
WITH (FORMAT csv, HEADER true , DELIMITER ',' , ENCODING 'UTF8');


COPY contacts(client_id, Contact, Mnth , Day_of_week, Duration)
FROM 'd:\Python 2.0\Project 2\contacts.csv'
WITH (FORMAT csv, HEADER true , DELIMITER ',' , ENCODING 'UTF8');


COPY campaigns(client_id,Campaign,Pdays,Previous,Poutcome)
FROM 'd:\Python 2.0\Project 2\campaigns.csv'
WITH (FORMAT csv, HEADER true , DELIMITER ',' , ENCODING 'UTF8');


COPY economics(client_id,Emp_var_rate,Cons_price_idx,Cons_conf_idx,Euribor3m,Nr_employed)
FROM 'd:\Python 2.0\Project 2\economics.csv'
WITH (FORMAT csv, HEADER true , DELIMITER ',' , ENCODING 'UTF8');


COPY subscription
FROM 'd:\Python 2.0\Project 2\subscription.csv'
WITH (FORMAT csv, HEADER true , DELIMITER ',' , ENCODING 'UTF8');


--  For inquiring data types of columns
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'economics';



-- Move All Tables to a Named Schema

CREATE SCHEMA IF NOT EXISTS Bank_marketing;


ALTER TABLE clients SET SCHEMA Bank_marketing;
ALTER TABLE contacts SET SCHEMA Bank_marketing;
ALTER TABLE campaigns SET SCHEMA Bank_marketing;
ALTER TABLE economics SET SCHEMA Bank_marketing;
ALTER TABLE subscription SET SCHEMA Bank_marketing;



SELECT *
FROM bank_marketing.clients;




DROP SCHEMA bank_marketing CASCADE;