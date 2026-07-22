/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   06_customer_risk_analysis.sql

   Purpose:
   - Customer level fraud analysis
   - Identify risky accounts
   - Analyze customer transaction behaviour

   Database:
   PostgreSQL
========================================================== */


/* ==========================================================
   1. CUSTOMER TRANSACTION SUMMARY

   Business Question:
   Which customers handle the highest transaction volume?
========================================================== */

SELECT

    sender_account,

    COUNT(*) AS total_transactions,

    ROUND(SUM(amount),2) AS total_transaction_amount,

    ROUND(AVG(amount),2) AS average_transaction_amount


FROM transactions_clean


GROUP BY sender_account


ORDER BY total_transaction_amount DESC


LIMIT 20;



/* ==========================================================
   2. CUSTOMERS WITH MOST FRAUD CASES

   Business Question:
   Which accounts are repeatedly involved in fraud?
========================================================== */

SELECT

    sender_account,

    COUNT(*) AS fraud_transactions,

    ROUND(SUM(amount),2) AS total_fraud_amount,


    ROUND(
        AVG(amount),
        2
    ) AS average_fraud_transaction



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY sender_account


ORDER BY fraud_transactions DESC


LIMIT 20;



/* ==========================================================
   3. HIGHEST FRAUD LOSS CUSTOMERS

   Business Question:
   Which customers caused the highest fraud value?
========================================================== */

SELECT

    sender_account,

    COUNT(*) AS fraud_cases,

    ROUND(
        SUM(amount),
        2
    ) AS fraud_loss



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY sender_account


ORDER BY fraud_loss DESC


LIMIT 20;



/* ==========================================================
   4. CUSTOMER FRAUD RATE

   Business Question:
   Which customers have suspicious activity rate?
========================================================== */


SELECT


    sender_account,


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS fraud_transactions,


    ROUND(

        SUM(fraud_flag)*100.0/COUNT(*),

        2

    ) AS fraud_rate_percentage



FROM transactions_clean


GROUP BY sender_account


HAVING COUNT(*) > 10


ORDER BY fraud_rate_percentage DESC


LIMIT 20;



/* ==========================================================
   5. CUSTOMER RISK SEGMENTATION

   Create analyst-friendly risk categories

========================================================== */


SELECT


    sender_account,


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS fraud_cases,


    CASE

        WHEN SUM(fraud_flag) >= 5
        THEN 'HIGH RISK'


        WHEN SUM(fraud_flag) BETWEEN 1 AND 4
        THEN 'MEDIUM RISK'


        ELSE 'LOW RISK'


    END AS customer_risk_level



FROM transactions_clean


GROUP BY sender_account


ORDER BY fraud_cases DESC;



/* ==========================================================
   6. ACCOUNTS EMPTYING BALANCE

   Business Question:
   Detect accounts transferring entire balance

========================================================== */


SELECT


    sender_account,


    COUNT(*) AS suspicious_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS total_amount



FROM transactions_clean


WHERE

    sender_old_balance > 0

AND sender_new_balance = 0


GROUP BY sender_account


ORDER BY total_amount DESC


LIMIT 20;



/* ==========================================================
   7. CUSTOMER TRANSACTION TYPE BEHAVIOUR

   Business Question:
   How do risky customers transact?
========================================================== */


SELECT


    sender_account,


    transaction_type,


    COUNT(*) AS transactions,


    SUM(fraud_flag) AS fraud_cases



FROM transactions_clean


GROUP BY

    sender_account,

    transaction_type


HAVING SUM(fraud_flag) > 0


ORDER BY fraud_cases DESC;



/* ==========================================================
   END OF CUSTOMER RISK ANALYSIS
========================================================== */
