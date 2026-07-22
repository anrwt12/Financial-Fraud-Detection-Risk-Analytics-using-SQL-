# PaySim Dataset

## Overview

This project uses the **PaySim Synthetic Financial Dataset for Fraud Detection**.

PaySim is a synthetic mobile money transaction dataset created to simulate real-world financial transactions. It is widely used for fraud detection research and analytics because it contains realistic transaction behavior and fraudulent activity patterns.

The dataset is used in this project to build a **Financial Fraud Detection & Risk Analytics System using SQL**, including data cleaning, exploratory analysis, fraud pattern identification, customer risk analysis, and business reporting.

---

## Dataset Source

The original dataset is available on Kaggle:

[PaySim Synthetic Financial Dataset - Kaggle](https://www.kaggle.com/datasets/ealaxi/paysim1)

---

## Dataset Information

| Attribute       | Details                            |
| --------------- | ---------------------------------- |
| Dataset Name    | PaySim Synthetic Financial Dataset |
| Source          | Kaggle                             |
| Domain          | FinTech / Mobile Banking           |
| Records         | 6,362,620 transactions             |
| Columns         | 11                                 |
| File Name       | paysim_transactions.csv            |
| Target Variable | isFraud                            |

---

## Dataset Columns

| Column         | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| step           | Time step representing transaction hour                        |
| type           | Transaction type (CASH_IN, CASH_OUT, DEBIT, PAYMENT, TRANSFER) |
| amount         | Transaction amount                                             |
| nameOrig       | Sender account ID                                              |
| oldbalanceOrg  | Sender balance before transaction                              |
| newbalanceOrig | Sender balance after transaction                               |
| nameDest       | Receiver account ID                                            |
| oldbalanceDest | Receiver balance before transaction                            |
| newbalanceDest | Receiver balance after transaction                             |
| isFraud        | Fraud transaction indicator (Target Variable)                  |
| isFlaggedFraud | System flagged fraud indicator                                 |

---

## Download Instructions

The original dataset is not stored in this repository because GitHub has file size limitations.

Download the dataset from Kaggle:

[Download PaySim Dataset](https://www.kaggle.com/datasets/ealaxi/paysim1)

After downloading:

1. Extract the ZIP file.
2. Rename the CSV file:

```
paysim_transactions.csv
```

3. Place the file inside:

```
Financial-Fraud-Detection-Risk-Analytics-using-SQL-
│
└── Dataset/
    └── paysim_transactions.csv
```

---

## Usage in Project

The dataset is used for:

* Data exploration and profiling
* Transaction volume analysis
* Fraud rate analysis
* Fraud pattern detection
* Customer risk segmentation
* Transaction monitoring rules
* SQL-based fraud analytics
* Business insight generation

---

## Important Note

This dataset is **synthetically generated** and does not contain real customer information.

It is used only for educational purposes, portfolio projects, and analytical demonstrations.
