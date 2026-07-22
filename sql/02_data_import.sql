/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   02_data_import.sql

   Purpose:
   - Import PaySim dataset
   - Load raw transaction data
========================================================== */



-- Clear previous data if re-running

TRUNCATE TABLE paysim_raw;



-- Import PaySim CSV file

COPY paysim_raw
FROM 'C:/archive/paysim_transactions.csv.csv'
DELIMITER ','
CSV HEADER;



-- Check imported records

SELECT 
    COUNT(*) AS total_records
FROM paysim_raw;



-- Preview data

SELECT *
FROM paysim_raw
LIMIT 10;
