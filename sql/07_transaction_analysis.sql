/* ==========================================================
   Financial Fraud Detection & Risk Analytics using SQL

   File:
   07_transaction_analysis.sql

   Purpose:
   - Transaction behaviour analysis
   - Identify risky transaction patterns
   - Analyze fraud characteristics

   Database:
   PostgreSQL
========================================================== */



/* ==========================================================
   1. TRANSACTION TYPE PERFORMANCE ANALYSIS

   Business Question:
   Which transaction types create highest volume and risk?
========================================================== */


SELECT

    transaction_type,

    COUNT(*) AS total_transactions,

    ROUND(SUM(amount),2) AS total_transaction_value,

    ROUND(AVG(amount),2) AS average_transaction_amount,

    SUM(fraud_flag) AS fraud_transactions,

    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate_percentage


FROM transactions_clean


GROUP BY transaction_type


ORDER BY fraud_rate_percentage DESC;



/* ==========================================================
   2. FRAUD AMOUNT BY TRANSACTION TYPE

   Business Question:
   Which transaction types cause highest financial loss?
========================================================== */


SELECT

    transaction_type,

    COUNT(*) AS fraud_cases,

    ROUND(
        SUM(amount),
        2
    ) AS fraud_amount,


    ROUND(
        AVG(amount),
        2
    ) AS average_fraud_amount


FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY transaction_type


ORDER BY fraud_amount DESC;



/* ==========================================================
   3. HIGH VALUE TRANSACTION ANALYSIS

   Business Question:
   Are high-value transactions more risky?
========================================================== */


SELECT


    CASE

        WHEN amount < 10000
        THEN 'Low Value'


        WHEN amount BETWEEN 10000 AND 100000
        THEN 'Medium Value'


        ELSE 'High Value'


    END AS transaction_category,


    COUNT(*) AS total_transactions,


    SUM(fraud_flag) AS fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_rate



FROM transactions_clean


GROUP BY transaction_category


ORDER BY fraud_rate DESC;



/* ==========================================================
   4. TOP 20 LARGEST FRAUD TRANSACTIONS

   Business Question:
   Which transactions represent highest fraud exposure?
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
   5. SENDER BALANCE IMPACT ANALYSIS

   Business Question:
   How much balance is removed during transactions?
========================================================== */


SELECT


    transaction_type,


    ROUND(
        AVG(sender_old_balance),
        2
    ) AS average_old_balance,


    ROUND(
        AVG(sender_new_balance),
        2
    ) AS average_new_balance,


    ROUND(
        AVG(
            sender_old_balance -
            sender_new_balance
        ),
        2
    ) AS average_balance_change



FROM transactions_clean


GROUP BY transaction_type;



/* ==========================================================
   6. CASH OUT FRAUD ANALYSIS

   Business Question:
   Is CASH_OUT associated with fraud?
========================================================== */


SELECT


    transaction_type,


    COUNT(*) AS transactions,


    SUM(fraud_flag) AS fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_percentage



FROM transactions_clean


WHERE transaction_type = 'CASH_OUT'


GROUP BY transaction_type;



/* ==========================================================
   7. TRANSFER FRAUD ANALYSIS

   Business Question:
   Are transfers a major fraud channel?
========================================================== */


SELECT


    transaction_type,


    COUNT(*) AS transactions,


    SUM(fraud_flag) AS fraud_cases,


    ROUND(
        SUM(fraud_flag)*100.0/COUNT(*),
        2
    ) AS fraud_percentage



FROM transactions_clean


WHERE transaction_type = 'TRANSFER'


GROUP BY transaction_type;



/* ==========================================================
   8. DAILY TRANSACTION TREND

   Business Question:
   How transaction activity changes over time?
========================================================== */


SELECT


    step,


    COUNT(*) AS total_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS transaction_value,


    SUM(fraud_flag) AS fraud_cases



FROM transactions_clean


GROUP BY step


ORDER BY step;



/* ==========================================================
   9. FRAUD CONCENTRATION ANALYSIS

   Business Question:
   What percentage of fraud comes from risky transactions?
========================================================== */


SELECT


    transaction_type,


    COUNT(*) AS fraud_transactions,


    ROUND(
        SUM(amount),
        2
    ) AS fraud_value,


    ROUND(

        SUM(amount)*100.0 /

        (
            SELECT SUM(amount)
            FROM transactions_clean
            WHERE fraud_flag = 1
        ),

        2

    ) AS fraud_value_contribution_percentage



FROM transactions_clean


WHERE fraud_flag = 1


GROUP BY transaction_type


ORDER BY fraud_value DESC;



/* ==========================================================
   END OF TRANSACTION ANALYSIS
========================================================== */
