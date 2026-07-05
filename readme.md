Customer Churn & Loyalty Analytics

An end-to-end analytics project that identifies which customers are likely to churn, quantifies the revenue at risk, and recommends targeted retention actions — built on top of ANALYSISSI, a data ingestion and cleaning pipeline I built previously.

Problem

Customer churn directly erodes recurring revenue. This project analyzes a telecom customer base to answer three questions a business actually cares about:


What is our churn rate, and how much revenue is at risk?
Why are customers churning — which segments are most exposed?
Who, specifically, should we act on first?


Data

Telco Customer Churn Dataset (IBM sample, via Kaggle) — 7,043 customer records, 21 columns covering demographics, contract/account details, service subscriptions, and churn outcome.

Source: https://www.kaggle.com/datasets/blastchar/telco-customer-churn

To reproduce: download the CSV from the link above and place it in data/raw/.

Approach

1. Ingestion & Cleaning — Raw customer data was ingested and cleaned using ANALYSISSI's automated pipeline (Pandas-based), loading structured output into a PostgreSQL database.

2. Feature Engineering (SQL) — Built a customer_features table directly in Postgres, deriving tenure buckets, total services subscribed, cleaned churn labels, and contract/payment flags. See /sql.

3. Insight Queries (SQL) — Wrote seven analytical queries covering overall churn rate, churn by contract type/payment method/tenure/service count, revenue at risk, and a high-value at-risk customer segment for targeting. See /sql.

4. Dashboard (Power BI) — Built an interactive one-page dashboard with KPI cards, segment-level churn breakdowns, and a live at-risk customer list. See /dashboard.

5. Predictive Modeling (Python) — Trained and evaluated classification models (logistic regression, random forest) to predict churn probability per customer, using precision/recall/AUC given class imbalance, with feature importance analysis. See /notebooks.

6. Business Recommendation — Translated findings into a one-page memo with a quantified retention recommendation. See /memo.

Key Findings


(Fill in once your SQL queries are run — e.g.) Month-to-month contract customers churn at X%, compared to Y% for two-year contracts.
(e.g.) Customers subscribed to fewer than 2 services churn at nearly 2x the rate of customers with 5+ services.
(e.g.) Total monthly revenue at risk from currently-active, likely-to-churn customers: **X∗∗,or∗∗X**, or **
X∗∗,or∗∗Y annualized**.


Model Results

ModelPrecisionRecallAUCLogistic RegressionTBDTBDTBDRandom ForestTBDTBDTBD

Top predictive features: (fill in from your feature importance chart, e.g. contract type, tenure, monthly charges).

Dashboard dashboard.png

tified in the at-risk segment query with a proactive retention offer; estimated annual revenue protected: $X.

Repository Structure

customer-churn-analytics/
├── sql/                  # Feature engineering + insight queries
├── notebooks/            # EDA, model training, evaluation
├── dashboard/            # Power BI file + screenshot
├── memo/                 # One-page business recommendation
├── data/                 # Dataset download instructions (raw data not committed)
└── requirements.txt

Tech Stack
Python (Pandas, scikit-learn, matplotlib) · SQL (PostgreSQL) · Power BI · Flask (via ANALYSISSI)


This project builds on ANALYSISSI, a full-stack data management tool I built (Flask, PostgreSQL, Pandas) that handles the ingestion and cleaning layer used here.
