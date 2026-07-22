/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File: 01_schema.sql

   Purpose:
   Create raw PaySim dataset table

   Database:
   PostgreSQL
========================================================== */


DROP TABLE IF EXISTS paysim_raw;


CREATE TABLE paysim_raw
(
    step INT,

    type VARCHAR(20),

    amount NUMERIC(15,2),

    nameOrig VARCHAR(50),

    oldbalanceOrg NUMERIC(15,2),

    newbalanceOrig NUMERIC(15,2),

    nameDest VARCHAR(50),

    oldbalanceDest NUMERIC(15,2),

    newbalanceDest NUMERIC(15,2),

    isFraud INT,

    isFlaggedFraud INT
);
