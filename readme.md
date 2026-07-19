# Customer Churn & Loyalty Analytics

An end-to-end analytics project that identifies **which customers are likely to churn**, quantifies **revenue at risk**, and recommends **targeted retention actions** — built on top of ANALYSISSI, a data ingestion and cleaning pipeline I built previously.

---

## 📌 Problem

Customer churn directly erodes recurring revenue. This project analyzes a telecom customer base to answer three questions a business actually cares about:

- **What** is our churn rate, and how much revenue is at risk?
- **Why** are customers churning — which segments are most exposed?
- **Who**, specifically, should we act on first?

---

## 📊 Data

**[Telco Customer Churn Dataset](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)** (IBM sample, via Kaggle)
- 7,043 customer records
- 21 columns covering demographics, contract/account details, service subscriptions, and churn outcome

**To reproduce:** download the CSV from the link above and place it in `data/raw/`.

---

## 🔧 Approach

| Step | Description | Location |
|---|---|---|
| 1. Ingestion & Cleaning | Raw customer data ingested and cleaned via ANALYSISSI's automated pipeline (Pandas-based), loaded into a PostgreSQL database | — |
| 2. Feature Engineering (SQL) | Built a `customer_features` table in Postgres — tenure buckets, total services subscribed, cleaned churn labels, contract/payment flags | `/sql` |
| 3. Insight Queries (SQL) | Seven analytical queries covering churn rate, churn by contract/payment/tenure/service count, revenue at risk, and a high-value at-risk segment | `/sql` |
| 4. Dashboard (Power BI) | Interactive one-page dashboard with KPI cards, segment-level churn breakdowns, and a live at-risk customer list | `/dashboard` |
| 5. Predictive Modeling (Python) | Trained and evaluated classification models (logistic regression, random forest) to predict churn probability per customer; evaluated with precision/recall/AUC given class imbalance, plus feature importance analysis | `/notebooks` |
| 6. Business Recommendation | One-page memo translating findings into a quantified retention recommendation | `/memo` |

---

## 🎯 Key Findings

**Revenue at risk from churned customers:**

| Monthly | Annual |
|---|---|
| $139,130.85 | $1,669,570.20 |

**Segment drivers:**
- Month-to-month contract customers churn at **42.71%**, vs. **11.27%** for two-year contracts
- Customers subscribed to fewer than 2 services churn at **~2x the rate** of customers with 5+ services
- **$456.12K** in total monthly revenue is currently at risk from active at-risk customers

---

## 🧠 Model Results

```
                            precision    recall  f1-score   support

Predicted would not Churn       0.85      0.89      0.87      1290
    Predicted would Churn       0.66      0.57      0.61       471

                 accuracy                           0.81      1761
                macro avg       0.75      0.73      0.74      1761
             weighted avg       0.80      0.81      0.80      1761
```

**Top predictive features:** contract type, tenure, monthly charges

---

## 📈 Dashboard

![Dashboard](dashboard/dashboard.PNG)

---

## 📁 Repository Structure

```
customer-churn-analytics/
├── sql/                  # Feature engineering + insight queries
├── notebooks/            # EDA, model training, evaluation
├── dashboard/            # Power BI file + screenshot
├── data/                 # Dataset download instructions (raw data not committed)
└── requirements.txt
```

---

## 🛠 Tech Stack

**Python** (Pandas, scikit-learn, matplotlib) · **SQL** (PostgreSQL) · **Power BI** · **Flask** (via ANALYSISSI)