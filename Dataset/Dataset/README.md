# PaySim Dataset

## Overview

This project uses the PaySim Synthetic Financial Dataset for Fraud Detection.

The dataset simulates financial transactions from a mobile payment system and is used to analyze fraudulent transaction patterns.

## Dataset Information

- Dataset: PaySim Synthetic Financial Dataset
- Records: 6,362,620 transactions
- Columns: 11
- Target Column: isFraud

## Columns

| Column | Description |
|---|---|
| step | Time step |
| type | Transaction type |
| amount | Transaction amount |
| nameOrig | Sender account |
| oldbalanceOrg | Sender balance before transaction |
| newbalanceOrig | Sender balance after transaction |
| nameDest | Receiver account |
| oldbalanceDest | Receiver balance before transaction |
| newbalanceDest | Receiver balance after transaction |
| isFraud | Fraud indicator |
| isFlaggedFraud | System flagged fraud |

## Note

The original CSV file is not stored in GitHub because of its large size. It is downloaded separately and used for SQL analysis.
