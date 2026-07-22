# Financial Fraud Detection & Risk Analytics using SQL

## Project Overview

Financial fraud is one of the biggest challenges faced by digital banking and fintech companies. This project analyzes millions of financial transactions to identify fraud patterns, understand risky customer behavior, and generate actionable business insights using SQL.

The project uses the **PaySim Synthetic Financial Dataset** to build an end-to-end fraud analytics workflow similar to what a Data Analyst or Risk Analyst would perform in a real financial organization.

The objective is to move beyond simple fraud identification and understand:

- Where fraud happens
- Why fraud happens
- Which transactions are high risk
- Which customers require monitoring
- How fraud impacts business operations


---

# Business Problem

Financial institutions process millions of transactions every day. Manual monitoring is not possible at this scale, so organizations need analytical systems that can identify suspicious activity and prioritize risky transactions.

This project answers important business questions:

- What percentage of transactions are fraudulent?
- Which transaction types contribute the most fraud?
- Which transactions create the highest financial risk?
- What transaction behaviors indicate fraud?
- Which customers or accounts need additional monitoring?
- How can fraud prevention strategies be improved?


---

# Dataset

## PaySim Synthetic Financial Dataset

Dataset Source:

Kaggle - Synthetic Financial Datasets For Fraud Detection (PaySim)

Dataset Link:

https://www.kaggle.com/datasets/ealaxi/paysim1


## Dataset Information

| Attribute | Details |
|---|---|
| Dataset Name | PaySim Synthetic Financial Dataset |
| Records | 6,362,620 Transactions |
| Columns | 11 |
| Domain | FinTech / Mobile Banking |
| Target Variable | isFraud |


## Dataset Columns

| Column | Description |
|---|---|
| step | Time step representing transaction time |
| type | Transaction type |
| amount | Transaction amount |
| nameOrig | Sender account ID |
| oldbalanceOrg | Sender balance before transaction |
| newbalanceOrig | Sender balance after transaction |
| nameDest | Receiver account ID |
| oldbalanceDest | Receiver balance before transaction |
| newbalanceDest | Receiver balance after transaction |
| isFraud | Fraud indicator |
| isFlaggedFraud | System detected fraud indicator |


---

# Technologies Used

## Database

- PostgreSQL


## SQL Skills Applied

- Database schema design
- Data import
- Data cleaning
- Data quality checks
- Data transformation
- Feature engineering
- Risk scoring
- Fraud rule creation
- Customer analysis
- KPI reporting
- SQL views


---

# Project Architecture

