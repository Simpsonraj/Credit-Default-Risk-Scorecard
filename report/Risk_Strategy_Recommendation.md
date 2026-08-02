# Credit Default Risk Scorecard
## Risk Strategy Recommendation Report

**Author:** Simpson Gundlapally  
**Dataset:** Give Me Some Credit — Kaggle (150,000 borrowers)  
**Model:** Logistic Regression with class_weight='balanced'  
**Date:** July 2026

---

## Executive Summary

Analysis of 150,000 borrowers identified key predictors of credit default
and produced a scoring model with **ROC-AUC of 0.8338** — meaning the model
correctly distinguishes defaulters from non-defaulters 83.38% of the time.

The dataset carries a **6.68% overall default rate** with a 1:14 class
imbalance. The model was trained to handle this imbalance, prioritising
recall on the minority (default) class.

---

## Key Findings

### Finding 1 — Credit Utilisation is the Strongest Risk Signal
Borrowers with utilisation above 90% default at **10.1x the rate** of
borrowers with utilisation below 30%. This is the single most actionable
risk indicator available without a credit bureau pull.

| Utilisation Band | Default Rate | Decision Implication |
|-----------------|-------------|---------------------|
| Low (0-30%)     | ~2%          | Favourable signal    |
| Medium (30-60%) | ~5%          | Neutral              |
| High (60-90%)   | ~10%         | Elevated caution     |
| Very High (90%+)| ~20%         | Strong decline signal|

### Finding 2 — Late Payment History is Highly Predictive
Any history of 90+ day late payments dramatically increases default
probability. Borrowers with even one 90-day late payment show default
rates 3-5x higher than those with none.

### Finding 3 — Younger Borrowers Carry Higher Risk
Borrowers aged 18-25 and 26-35 show above-average default rates,
likely due to shorter credit history and lower income stability.
This does not imply age-based discrimination — it identifies segments
requiring additional verification steps.

---

## Scorecard Decision Framework

| Score Band | Decision | Default Rate | Recommended Action |
|-----------|----------|-------------|-------------------|
| 300–500   | **DECLINE** | 15.1% | Reject application. Revenue does not justify risk at this default rate. |
| 501–600   | **MANUAL REVIEW** | 1.7% | Flag for income verification, employment check, and recent payment history review. Approve conditionally. |
| 601–700   | **CONDITIONAL APPROVE** | 0% (sample) | Approve with reduced credit limit (50% of requested). Review after 6 months. |
| 701–850   | **APPROVE** | 0% (sample) | Standard terms. Full requested amount. |

---

## Top 3 Risk Predictors (Model Coefficients)

1. **Credit Utilisation Rate** — Strongest single predictor.
   Applicants above 90% utilisation should face mandatory review.

2. **90+ Days Late Payment History** — Any instance significantly
   elevates default probability regardless of other factors.

3. **Total Late Payments (all categories combined)** — Cumulative
   late payment behaviour is more predictive than any single
   late payment category.

---

## Recommended Business Actions

### Immediate (Implement Now)
- **Tighten eligibility criteria** for applicants with utilisation > 90%
  — require income verification before proceeding
- **Auto-decline** any applicant with 3+ instances of 90-day late payments
  in the past 2 years
- **Flag for manual review** all applicants aged under 25 with
  utilisation above 60%

### Medium Term (Next Quarter)
- Integrate the scorecard model into the application processing pipeline
- Set up monthly monitoring dashboard tracking default rate by score band
- Establish a feedback loop — compare predicted vs actual defaults
  after 6 months to recalibrate the model

### Strategic (6-12 Months)
- Build a separate scorecard for thin-file applicants (short credit history)
- Incorporate external bureau data (Experian/CIBIL scores) to improve
  the 501-600 band classification accuracy
- Develop a risk-adjusted pricing model — higher-risk approvals
  carry higher interest rates to compensate for elevated default risk

---

## Model Performance Summary

| Metric | Value |
|--------|-------|
| ROC-AUC Score | **0.8338** |
| Test Records | 30,000 |
| Default Recall | 74% |
| Non-Default Precision | 98% |
| Overall Accuracy | 76% |

The model prioritises **catching defaults (recall)** over false positives —
appropriate for a risk management context where a missed default costs
more than a false alarm.

---

## Limitations & Disclaimers

- Dataset is US-based (1999-2008). Income and debt figures may not
  directly translate to current Indian lending context.
- The scorecard should be recalibrated every 6-12 months as
  economic conditions change.
- This model is for portfolio-level strategy — individual lending
  decisions should incorporate additional human review.
- Fair lending laws require that age, gender, and protected attributes
  are not used as direct inputs to credit decisions.

---

*Report prepared by Simpson Gundlapally | github.com/Simpsonraj*
