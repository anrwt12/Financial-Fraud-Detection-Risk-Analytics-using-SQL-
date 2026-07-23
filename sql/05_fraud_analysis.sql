/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   05_fraud_analysis.sql

   Purpose:
   - Analyze fraud patterns
   - Identify transaction behaviour
   - Generate business insights

   Database:
   PostgreSQL
========================================================== */


/* ==========================================================
   1. OVERALL FRAUD SUMMARY

   Business Question:
   What is the overall fraud situation?
========================================================== */

SELECT

    COUNT(*) AS total_transactions,

    SUM(amount) AS total_transaction_value,

    SUM(fraud_flag) AS total_fraud_transactions,

    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate_percentage,


    ROUND(
        SUM(CASE 
            WHEN fraud_flag = 1 
            THEN amount 
            ELSE 0 
        END),
        2
    ) AS total_fraud_amount


FROM transactions_clean;



/* ==========================================================
   2. FRAUD VS NORMAL TRANSACTION DISTRIBUTION

   Business Question:
   How much of activity is fraudulent?
========================================================== */


SELECT

    CASE

        WHEN fraud_flag = 1
        THEN 'Fraud'

        ELSE 'Normal'

    END AS transaction_status,


    COUNT(*) AS transactions,

    ROUND(
        SUM(amount),
        2
    ) AS total_amount


FROM transactions_clean


GROUP BY fraud_flag;



/* ==========================================================
   3. FRAUD BY TRANSACTION TYPE

   Business Question:
   Which transaction types are most risky?
========================================================== */


SELECT


    transaction_type,


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS fraud_transactions,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate,


    ROUND(
        SUM(
            CASE
            WHEN fraud_flag=1
            THEN amount
            ELSE 0
            END
        ),
        2
    ) AS fraud_amount



FROM transactions_clean


GROUP BY transaction_type


ORDER BY fraud_rate DESC;



/* ==========================================================
   4. TOP 20 HIGHEST FRAUD VALUE TRANSACTIONS

   Business Question:
   Which transactions caused highest losses?
========================================================== */


SELECT

    transaction_id,

    transaction_type,

    amount,

    sender_account,

    receiver_account


FROM transactions_clean


WHERE fraud_flag = 1


ORDER BY amount DESC


LIMIT 20;



/* ==========================================================
   5. FRAUD TREND BY TIME STEP

   Business Question:
   When does fraud happen most?
========================================================== */


SELECT


    step,


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate



FROM transactions_clean


GROUP BY step


ORDER BY step;



/* ==========================================================
   6. TOP SENDERS INVOLVED IN FRAUD

   Business Question:
   Which accounts are linked with fraud?
========================================================== */


SELECT


    sender_account,


    COUNT(*) AS fraud_transactions,


    SUM(amount) AS fraud_amount



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY sender_account


ORDER BY fraud_amount DESC


LIMIT 20;



/* ==========================================================
   7. TOP RECEIVERS INVOLVED IN FRAUD

   Business Question:
   Which receiving accounts receive fraudulent money?
========================================================== */


SELECT


    receiver_account,


    COUNT(*) AS fraud_transactions,


    SUM(amount) AS fraud_received_amount



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY receiver_account


ORDER BY fraud_received_amount DESC


LIMIT 20;



/* ==========================================================
   8. FRAUD AMOUNT DISTRIBUTION

   Business Question:
   Are fraudulent transactions usually high value?
========================================================== */


SELECT


    CASE

        WHEN amount < 10000 THEN 'Low'

        WHEN amount < 100000 THEN 'Medium'

        ELSE 'High'

    END AS amount_category,


    COUNT(*) AS fraud_transactions,


    SUM(amount) AS fraud_amount



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY amount_category


ORDER BY fraud_amount DESC;



/* ==========================================================
   END OF FRAUD ANALYSIS
========================================================== */
