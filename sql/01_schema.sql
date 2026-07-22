/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   01_schema.sql

   Purpose:
   - Create raw data table
   - Create cleaned transaction table
   - Create fraud analytics tables
   - Prepare database for risk analysis

   Database:
   PostgreSQL
========================================================== */



/* ==========================================================
   1. RAW PAYSIM DATA TABLE

   Stores original Kaggle dataset
========================================================== */


DROP TABLE IF EXISTS paysim_raw;


CREATE TABLE paysim_raw (

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



/* ==========================================================
   2. CLEAN TRANSACTION TABLE

   Analysis-ready transaction table
========================================================== */


DROP TABLE IF EXISTS transactions_clean;


CREATE TABLE transactions_clean (

    transaction_id BIGSERIAL PRIMARY KEY,

    step INT,

    transaction_type VARCHAR(20),

    amount NUMERIC(15,2),


    sender_account VARCHAR(50),

    receiver_account VARCHAR(50),


    sender_old_balance NUMERIC(15,2),

    sender_new_balance NUMERIC(15,2),


    receiver_old_balance NUMERIC(15,2),

    receiver_new_balance NUMERIC(15,2),


    fraud_flag INT DEFAULT 0,

    system_flagged_fraud INT DEFAULT 0,


    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



/* ==========================================================
   3. TRANSACTION FEATURES TABLE

   Stores engineered fraud indicators
========================================================== */


DROP TABLE IF EXISTS transaction_features;


CREATE TABLE transaction_features (

    transaction_id BIGINT PRIMARY KEY,


    transaction_hour INT,


    amount_category VARCHAR(20),


    balance_change NUMERIC(15,2),


    account_drained_flag INT,


    risky_transaction_flag INT,


    suspicious_amount_flag INT,


    FOREIGN KEY(transaction_id)
    REFERENCES transactions_clean(transaction_id)

);



/* ==========================================================
   4. RISK SCORE TABLE

   Fraud scoring engine output
========================================================== */


DROP TABLE IF EXISTS transaction_risk_score;


CREATE TABLE transaction_risk_score (

    transaction_id BIGINT PRIMARY KEY,


    risk_score INT,


    risk_level VARCHAR(20),


    risk_reason TEXT,


    FOREIGN KEY(transaction_id)
    REFERENCES transactions_clean(transaction_id)

);



/* ==========================================================
   5. FRAUD ALERT TABLE

   Transactions requiring investigation
========================================================== */


DROP TABLE IF EXISTS fraud_alerts;


CREATE TABLE fraud_alerts (

    alert_id BIGSERIAL PRIMARY KEY,


    transaction_id BIGINT,


    alert_type VARCHAR(100),


    risk_level VARCHAR(20),


    alert_status VARCHAR(20)
    DEFAULT 'OPEN',


    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,


    FOREIGN KEY(transaction_id)
    REFERENCES transactions_clean(transaction_id)

);



/* ==========================================================
   INDEXES

   Improve performance on 6.3 million rows
========================================================== */


CREATE INDEX idx_raw_fraud
ON paysim_raw(isFraud);



CREATE INDEX idx_transaction_type
ON transactions_clean(transaction_type);



CREATE INDEX idx_transaction_amount
ON transactions_clean(amount);



CREATE INDEX idx_transaction_fraud
ON transactions_clean(fraud_flag);



CREATE INDEX idx_alert_risk
ON fraud_alerts(risk_level);



/* ==========================================================
   END OF SCHEMA
========================================================== */
