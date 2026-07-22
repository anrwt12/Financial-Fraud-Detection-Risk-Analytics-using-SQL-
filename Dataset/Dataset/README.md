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


# PaySim Dataset

## Overview

This project uses the **PaySim Synthetic Financial Dataset for Fraud Detection**.

The dataset simulates mobile money transactions and is used to build a financial fraud detection and risk analytics system using SQL.

Dataset Source:

[Kaggle - Synthetic Financial Datasets For Fraud Detection (PaySim)](https://www.kaggle.com/datasets/ealaxi/paysim1)

---

## Dataset Information

| Attribute | Details |
|-----------|---------|
| Dataset Name | PaySim Synthetic Financial Dataset |
| Source | Kaggle |
| Records | 6,362,620 transactions |
| Columns | 11 |
| Domain | FinTech / Mobile Banking |
| Target Variable | `isFraud` |

---

## Dataset Columns

| Column | Description |
|--------|-------------|
| step | Time step representing transaction hour |
| type | Transaction type (CASH_IN, CASH_OUT, DEBIT, PAYMENT, TRANSFER) |
| amount | Transaction amount |
| nameOrig | Sender account ID |
| oldbalanceOrg | Sender balance before transaction |
| newbalanceOrig | Sender balance after transaction |
| nameDest | Receiver account ID |
| oldbalanceDest | Receiver balance before transaction |
| newbalanceDest | Receiver balance after transaction |
| isFraud | Fraud transaction indicator |
| isFlaggedFraud | System flagged fraud indicator |

---

## Download Instructions

1. Download the dataset from Kaggle:

https://www.kaggle.com/datasets/ealaxi/paysim1

2. Download:

