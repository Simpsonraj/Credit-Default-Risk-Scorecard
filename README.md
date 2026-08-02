# 📊 Credit Default Risk Scorecard

An end-to-end Credit Default Risk Scorecard project built using **Python, SQL, Machine Learning, and Business Analytics** to predict loan defaults and support data-driven lending decisions.

---

## 📌 Project Overview

Financial institutions lose millions every year due to borrower defaults. This project develops a **Credit Risk Scorecard** that predicts whether a borrower is likely to default using historical credit data.

The project covers the complete analytics lifecycle:

- Data Cleaning
- Exploratory Data Analysis (EDA)
- Feature Engineering
- Scorecard Development
- Logistic Regression Modeling
- Risk Segmentation
- Business Recommendations

---

## 🎯 Business Objective

Develop a credit scorecard that enables lenders to:

- Predict borrower default risk
- Identify high-risk customers before loan approval
- Reduce financial losses
- Improve lending decisions
- Create interpretable credit scores

---

## 🛠️ Tech Stack

- Python
- Pandas
- NumPy
- Scikit-learn
- Matplotlib
- SQL
- Jupyter Notebook
- Git
- GitHub

---

## 📂 Project Structure

```
Credit-Default-Risk-Scorecard
│
├── notebooks/
│   ├── 01_EDA.ipynb
│   ├── 02_Feature_Engineering.ipynb
│   ├── 02_Model_Scorecard.ipynb
│   └── 03_Scorecard_Model.ipynb
│
├── dashboard/
│   ├── 01_target_distribution.png
│   ├── 02_default_by_age.png
│   ├── 03_default_by_utilisation.png
│   ├── 04_scorecard_bands.png
│   ├── 05_feature_importance.png
│   └── 06_confusion_matrix.png
│
├── data/
│   ├── cs-training.csv
│   ├── band_summary.csv
│   └── model_metrics.json
│
├── sql/
│   └── risk_segmentation.sql
│
├── report/
│   └── Risk_Strategy_Recommendation.md
│
├── requirements.txt
├── README.md
└── LICENSE
```

---

# 📈 Dataset Overview

- **Total Borrowers:** 150,000
- **Default Rate:** 6.7%
- **Class Imbalance:** 1 : 14

---

# 📊 Key Business Insights

### Age-Based Risk

- 18–25: **11.2%**
- 26–35: **11.1%**
- 36–45: **8.8%**
- 46–55: **7.6%**
- 56–65: **4.6%**
- 65+: **2.4%**

**Insight:** Younger borrowers exhibit significantly higher default risk.

---

### Credit Utilisation Risk

| Utilisation | Default Rate |
|-------------|-------------:|
| Low | 2.2% |
| Medium | 6.7% |
| High | 13.3% |
| Very High | 22.4% |

**Key Finding**

Borrowers with **90%+ credit utilisation** default approximately **10× more often** than borrowers with utilisation below 30%.

---

### Most Important Predictors

- 30–59 Days Past Due
- 90+ Days Late Payments
- Credit Utilisation Rate
- 60–89 Days Past Due
- Total Late Payments

---

## 🤖 Machine Learning Model

**Algorithm**

- Logistic Regression

**Performance**

- ROC-AUC Score: **0.8338**

The model provides strong discrimination between default and non-default borrowers while remaining highly interpretable for scorecard development.

---

## 📌 Business Recommendations

- Decline applications with consistently poor repayment history.
- Closely review applicants with high credit utilisation.
- Prioritize low-risk borrowers for faster approvals.
- Use score bands to automate lending decisions.
- Monitor medium-risk customers through periodic reviews.

---

## 🚀 How to Run

### Clone Repository

```bash
git clone https://github.com/Simpsonraj/Credit-Default-Risk-Scorecard.git
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Launch Jupyter Notebook

```bash
jupyter notebook
```

Run the notebooks in the following order:

1. 01_EDA.ipynb
2. 02_Feature_Engineering.ipynb
3. 02_Model_Scorecard.ipynb
4. 03_Scorecard_Model.ipynb

---

## 📷 Dashboard Preview

The repository includes visualizations covering:

- Target Variable Distribution
- Default Rate by Age
- Credit Utilisation Analysis
- Credit Score Distribution
- Feature Importance
- Confusion Matrix

---

## 🎯 Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- Feature Engineering
- Logistic Regression
- Credit Scorecard Development
- SQL Analytics
- Risk Segmentation
- Business Analytics
- Data Visualization
- Machine Learning Model Evaluation

---

## 👤 Author

**Simpson Raj**

Aspiring Data Analyst | Python | SQL | Power BI | Machine Learning | Business Analytics

---

## ⭐ If you found this project useful

Please consider giving the repository a ⭐ on GitHub.
