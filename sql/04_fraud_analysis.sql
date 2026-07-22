/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   04_fraud_analysis.sql

   Purpose:
   - Exploratory fraud analysis
   - Identify fraud patterns
   - Generate business insights
========================================================== */



/* ==========================================================
   1. Overall Transaction Summary
========================================================== */

SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount),2) AS total_transaction_amount,
    ROUND(AVG(amount),2) AS average_transaction_amount
FROM transactions_clean;



/* ==========================================================
   2. Overall Fraud Performance
========================================================== */

SELECT
    COUNT(*) AS total_transactions,

    SUM(CASE 
        WHEN fraud_flag = 1 THEN 1 
        ELSE 0 
    END) AS fraud_transactions,

    ROUND(
        100.0 * SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage

FROM transactions_clean;



/* ==========================================================
   3. Fraud Transactions by Transaction Type
========================================================== */

SELECT

    transaction_type,

    COUNT(*) AS total_transactions,

    SUM(CASE 
        WHEN fraud_flag = 1 THEN 1 
        ELSE 0 
    END) AS fraud_cases,


    ROUND(
        100.0 *
        SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage

FROM transactions_clean

GROUP BY transaction_type

ORDER BY fraud_rate_percentage DESC;



/* ==========================================================
   4. Fraud Amount Analysis
========================================================== */

SELECT

    SUM(amount) AS total_amount,

    SUM(
        CASE 
            WHEN fraud_flag = 1 THEN amount 
            ELSE 0 
        END
    ) AS fraud_amount_loss

FROM transactions_clean;



/* ==========================================================
   5. Top Fraudulent Transactions
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
   6. Fraud by Transaction Amount Category
========================================================== */

SELECT

    transaction_value_category,

    COUNT(*) AS total_transactions,

    SUM(CASE 
        WHEN fraud_flag = 1 THEN 1 
        ELSE 0 
    END) AS fraud_cases

FROM transactions_clean

GROUP BY transaction_value_category

ORDER BY fraud_cases DESC;



/* ==========================================================
   7. High Risk Transaction Types
========================================================== */

SELECT

    transaction_type,

    COUNT(*) AS risky_transactions

FROM transactions_clean

WHERE transaction_risk_category = 'RISKY_TRANSACTION'

GROUP BY transaction_type;
