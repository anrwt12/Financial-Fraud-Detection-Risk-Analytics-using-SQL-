/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   03_data_cleaning.sql

   Purpose:
   - Clean PaySim raw transaction data
   - Remove invalid records
   - Create analytics-ready transaction table

   Database:
   PostgreSQL
========================================================== */


-- Remove previous table if exists

DROP TABLE IF EXISTS transactions_clean;



/*
   Create cleaned transaction table

   One row = one financial transaction
*/

CREATE TABLE transactions_clean AS

SELECT

    ROW_NUMBER() OVER() AS transaction_id,

    step,

    type AS transaction_type,

    amount,

    nameOrig AS sender_account,

    oldbalanceOrg AS sender_old_balance,

    newbalanceOrig AS sender_new_balance,

    nameDest AS receiver_account,

    oldbalanceDest AS receiver_old_balance,

    newbalanceDest AS receiver_new_balance,

    isFraud AS fraud_flag,

    isFlaggedFraud AS system_flagged_fraud


FROM paysim_raw



-- Remove invalid transactions

WHERE amount > 0

AND nameOrig IS NOT NULL

AND nameDest IS NOT NULL;



/*
 Data quality checks
*/


-- Total cleaned records

SELECT COUNT(*) AS cleaned_transactions
FROM transactions_clean;



-- Fraud cases

SELECT 
    SUM(fraud_flag) AS fraud_transactions
FROM transactions_clean;



-- Check missing values

SELECT

COUNT(*) FILTER (WHERE sender_account IS NULL) AS missing_sender,

COUNT(*) FILTER (WHERE receiver_account IS NULL) AS missing_receiver,

COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount

FROM transactions_clean;



-- Sample cleaned data

SELECT *
FROM transactions_clean
LIMIT 10;



/*
 Index creation for faster analysis
*/

CREATE INDEX idx_transactions_clean_fraud
ON transactions_clean(fraud_flag);


CREATE INDEX idx_transactions_clean_type
ON transactions_clean(transaction_type);


CREATE INDEX idx_transactions_clean_amount
ON transactions_clean(amount);


CREATE INDEX idx_transactions_clean_sender
ON transactions_clean(sender_account);


