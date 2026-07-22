/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File: 02_data_import.sql

   Purpose:
   Load PaySim CSV data into PostgreSQL raw table
========================================================== */


COPY paysim_raw
FROM 'C:/archive/paysim_transactions.csv.csv'
DELIMITER ','
CSV HEADER;
