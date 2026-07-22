/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   03_data_cleaning.sql

   Purpose:
   - Transform raw PaySim data
   - Create analysis-ready transaction table
========================================================== */


DROP TABLE IF EXISTS transactions_clean;


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

    isFlaggedFraud AS system_flagged_fraud,


    CASE
        WHEN amount >= 100000 THEN 'HIGH_VALUE'
        WHEN amount >= 10000 THEN 'MEDIUM_VALUE'
        ELSE 'LOW_VALUE'
    END AS transaction_value_category,


    CASE
        WHEN type IN ('TRANSFER','CASH_OUT')
        THEN 'RISKY_TRANSACTION'
        ELSE 'NORMAL_TRANSACTION'
    END AS transaction_risk_category


FROM paysim_raw;



-- Indexes for faster analysis

CREATE INDEX idx_transactions_type
ON transactions_clean(transaction_type);


CREATE INDEX idx_transactions_fraud
ON transactions_clean(fraud_flag);


CREATE INDEX idx_transactions_amount
ON transactions_clean(amount);



-- Validation checks

SELECT COUNT(*) AS total_transactions
FROM transactions_clean;


SELECT *
FROM transactions_clean
LIMIT 5;
