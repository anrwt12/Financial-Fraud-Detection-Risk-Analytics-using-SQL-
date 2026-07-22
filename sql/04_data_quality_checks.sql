/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   04_data_quality_checks.sql

   Purpose:
   - Validate cleaned PaySim transaction data
   - Identify data quality issues before analysis

   Database:
   PostgreSQL
========================================================== */


/* ==========================================================
   1. TOTAL RECORD CHECK
========================================================== */

SELECT 
    COUNT(*) AS total_transactions
FROM transactions_clean;



/* ==========================================================
   2. CHECK NULL VALUES
========================================================== */

SELECT

    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS missing_transaction_id,

    COUNT(*) FILTER (WHERE transaction_type IS NULL) AS missing_transaction_type,

    COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,

    COUNT(*) FILTER (WHERE sender_account IS NULL) AS missing_sender,

    COUNT(*) FILTER (WHERE receiver_account IS NULL) AS missing_receiver

FROM transactions_clean;



/* ==========================================================
   3. DUPLICATE TRANSACTION CHECK
========================================================== */

SELECT

    sender_account,

    receiver_account,

    amount,

    step,

    COUNT(*) AS duplicate_count

FROM transactions_clean

GROUP BY

    sender_account,
    receiver_account,
    amount,
    step

HAVING COUNT(*) > 1

ORDER BY duplicate_count DESC;



/* ==========================================================
   4. NEGATIVE OR ZERO AMOUNT CHECK
========================================================== */

SELECT *

FROM transactions_clean

WHERE amount <= 0;



/* ==========================================================
   5. BALANCE CONSISTENCY CHECK

   Sender balance should not become negative
========================================================== */

SELECT *

FROM transactions_clean

WHERE sender_new_balance < 0;



/* ==========================================================
   6. FRAUD DISTRIBUTION CHECK
========================================================== */

SELECT

    fraud_flag,

    COUNT(*) AS transactions,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions_clean),
        2
    ) AS percentage

FROM transactions_clean

GROUP BY fraud_flag;



/* ==========================================================
   7. TRANSACTION TYPE DISTRIBUTION
========================================================== */

SELECT

    transaction_type,

    COUNT(*) AS total_transactions,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions_clean),
        2
    ) AS percentage

FROM transactions_clean

GROUP BY transaction_type

ORDER BY total_transactions DESC;



/* ==========================================================
   8. EXTREME VALUE CHECK

   Identify unusually large transactions
========================================================== */

SELECT

    transaction_id,

    transaction_type,

    amount,

    sender_account,

    receiver_account

FROM transactions_clean

ORDER BY amount DESC

LIMIT 20;



/* ==========================================================
   9. FRAUD AMOUNT EXPOSURE
========================================================== */

SELECT

    COUNT(*) AS fraud_transactions,

    ROUND(SUM(amount),2) AS total_fraud_amount,

    ROUND(AVG(amount),2) AS average_fraud_amount

FROM transactions_clean

WHERE fraud_flag = 1;



/* ==========================================================
   END OF DATA QUALITY CHECKS
========================================================== */
