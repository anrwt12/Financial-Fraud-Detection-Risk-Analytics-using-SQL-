/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   05_views.sql

   Purpose:
   - Create analytical views
   - Prepare data for BI dashboards
========================================================== */



/* ==========================================================
   1. Monthly Fraud KPI View
========================================================== */


DROP VIEW IF EXISTS vw_monthly_fraud_kpi;


CREATE VIEW vw_monthly_fraud_kpi AS

SELECT

    step AS transaction_hour,

    COUNT(*) AS total_transactions,


    SUM(amount) AS total_amount,


    SUM(
        CASE 
            WHEN fraud_flag = 1 THEN 1 
            ELSE 0 
        END
    ) AS fraud_transactions,


    SUM(
        CASE
            WHEN fraud_flag = 1 THEN amount
            ELSE 0
        END
    ) AS fraud_amount,


    ROUND(
        100.0 *
        SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage


FROM transactions_clean

GROUP BY step;



/* ==========================================================
   2. Fraud By Transaction Type View
========================================================== */


DROP VIEW IF EXISTS vw_fraud_by_type;


CREATE VIEW vw_fraud_by_type AS

SELECT

    transaction_type,

    COUNT(*) AS total_transactions,


    SUM(
        CASE
            WHEN fraud_flag = 1 THEN 1
            ELSE 0
        END
    ) AS fraud_cases,


    SUM(
        CASE
            WHEN fraud_flag = 1 THEN amount
            ELSE 0
        END
    ) AS fraud_amount,


    ROUND(
        100.0 *
        SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage


FROM transactions_clean

GROUP BY transaction_type;



/* ==========================================================
   3. Risk Category View
========================================================== */


DROP VIEW IF EXISTS vw_transaction_risk;


CREATE VIEW vw_transaction_risk AS

SELECT

    transaction_risk_category,

    COUNT(*) AS transactions,

    SUM(
        CASE
            WHEN fraud_flag = 1 THEN 1
            ELSE 0
        END
    ) AS fraud_cases,


    ROUND(
        AVG(amount),
        2
    ) AS average_amount


FROM transactions_clean

GROUP BY transaction_risk_category;



/* ==========================================================
   4. Fraud Dashboard Summary
========================================================== */


DROP VIEW IF EXISTS vw_fraud_dashboard;


CREATE VIEW vw_fraud_dashboard AS

SELECT

    COUNT(*) AS total_transactions,


    SUM(amount) AS total_transaction_value,


    SUM(
        CASE
            WHEN fraud_flag = 1 THEN 1
            ELSE 0
        END
    ) AS total_fraud_cases,


    SUM(
        CASE
            WHEN fraud_flag = 1 THEN amount
            ELSE 0
        END
    ) AS total_fraud_amount,


    ROUND(
        100.0 *
        SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_percentage


FROM transactions_clean;
