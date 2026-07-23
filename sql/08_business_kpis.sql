/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   08_business_kpis.sql

   Purpose:
   - Generate fraud risk KPIs
   - Create management reporting metrics
   - Prepare dashboard data

   Database:
   PostgreSQL
========================================================== */


/* ==========================================================
   1. EXECUTIVE FRAUD SUMMARY

   Main business metrics
========================================================== */

SELECT

    COUNT(*) AS total_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS total_transaction_value,


    SUM(fraud_flag) AS total_fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate_percentage,


    ROUND(
        SUM(
            CASE
                WHEN fraud_flag = 1
                THEN amount
                ELSE 0
            END
        ),
        2
    ) AS fraud_amount_loss,


    ROUND(
        AVG(amount),
        2
    ) AS average_transaction_value


FROM transactions_clean;




/* ==========================================================
   2. FRAUD VS BUSINESS VALUE

   How much money is impacted by fraud?
========================================================== */

SELECT


    'Total Business Value' AS metric,

    ROUND(
        SUM(amount),
        2
    ) AS value


FROM transactions_clean


UNION ALL


SELECT


    'Fraud Loss Amount',


    ROUND(
        SUM(amount),
        2
    )


FROM transactions_clean


WHERE fraud_flag = 1;




/* ==========================================================
   3. TRANSACTION TYPE KPI

   Used for dashboard charts
========================================================== */


SELECT


    transaction_type,


    COUNT(*) AS total_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS transaction_value,


    SUM(fraud_flag) AS fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate



FROM transactions_clean


GROUP BY transaction_type


ORDER BY fraud_rate DESC;




/* ==========================================================
   4. FRAUD LOSS CONTRIBUTION

   Which transaction types create losses?
========================================================== */


SELECT


    transaction_type,


    ROUND(
        SUM(amount),
        2
    ) AS fraud_loss,


    ROUND(

        SUM(amount)*100.0 /

        (
            SELECT SUM(amount)
            FROM transactions_clean
            WHERE fraud_flag = 1
        ),

        2

    ) AS contribution_percentage



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY transaction_type


ORDER BY fraud_loss DESC;




/* ==========================================================
   5. RISK PERFORMANCE SCORECARD

   Dashboard summary
========================================================== */


SELECT


    COUNT(*) AS transactions,


    SUM(fraud_flag) AS fraud_cases,


    COUNT(DISTINCT sender_account)
        AS unique_senders,


    COUNT(DISTINCT receiver_account)
        AS unique_receivers,


    ROUND(
        AVG(amount),
        2
    ) AS avg_transaction_amount



FROM transactions_clean;




/* ==========================================================
   6. TOP FRAUD MONTH / TIME PERIOD

   Identify peak fraud periods
========================================================== */

SELECT


    step,


    COUNT(*) AS fraud_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS fraud_amount



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY step


ORDER BY fraud_amount DESC


LIMIT 10;




/* ==========================================================
   7. SYSTEM DETECTION PERFORMANCE

   Compare actual fraud vs flagged fraud

========================================================== */


SELECT


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS actual_fraud,


    SUM(system_flagged_fraud) AS system_detected_fraud,


    ROUND(

        SUM(system_flagged_fraud)*100.0 /

        NULLIF(SUM(fraud_flag),0),

        2

    ) AS detection_percentage



FROM transactions_clean;




/* ==========================================================
   END OF BUSINESS KPI ANALYSIS
========================================================== */
