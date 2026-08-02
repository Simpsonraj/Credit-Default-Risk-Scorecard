-- ============================================================
-- Credit Default Risk Scorecard — SQL Analysis
-- Author: Simpson Gundlapally
-- Dataset: Give Me Some Credit (150,000 borrowers)
-- Model ROC-AUC: 0.8338
-- ============================================================

-- ── 1. PORTFOLIO OVERVIEW ────────────────────────────────────
SELECT
    COUNT(*)                                             AS total_borrowers,
    SUM(SeriousDlqin2yrs)                               AS total_defaults,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)              AS default_rate_pct,
    ROUND(AVG(age), 1)                                  AS avg_age,
    ROUND(AVG(MonthlyIncome), 0)                        AS avg_monthly_income,
    ROUND(AVG(RevolvingUtilizationOfUnsecuredLines)*100,1) AS avg_utilisation_pct
FROM cs_training;

-- ── 2. DEFAULT RATE BY AGE BAND ──────────────────────────────
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '65+'
    END                                                  AS age_band,
    COUNT(*)                                             AS borrower_count,
    SUM(SeriousDlqin2yrs)                               AS defaults,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)              AS default_rate_pct,
    ROUND(AVG(MonthlyIncome), 0)                        AS avg_income
FROM cs_training
WHERE age >= 18
GROUP BY age_band
ORDER BY default_rate_pct DESC;

-- ── 3. DEFAULT RATE BY UTILISATION BAND ──────────────────────
SELECT
    CASE
        WHEN RevolvingUtilizationOfUnsecuredLines <= 0.30 THEN 'Low (0-30%)'
        WHEN RevolvingUtilizationOfUnsecuredLines <= 0.60 THEN 'Medium (30-60%)'
        WHEN RevolvingUtilizationOfUnsecuredLines <= 0.90 THEN 'High (60-90%)'
        ELSE 'Very High (90%+)'
    END                                                  AS utilisation_band,
    COUNT(*)                                             AS borrower_count,
    SUM(SeriousDlqin2yrs)                               AS defaults,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)              AS default_rate_pct,
    ROUND(AVG(DebtRatio), 4)                            AS avg_debt_ratio
FROM cs_training
WHERE RevolvingUtilizationOfUnsecuredLines BETWEEN 0 AND 1
GROUP BY utilisation_band
ORDER BY default_rate_pct DESC;

-- ── 4. SCORECARD DECISION BANDS ──────────────────────────────
WITH scored AS (
    SELECT
        CreditScore,
        ActualDefault,
        DefaultProbability,
        CASE
            WHEN CreditScore BETWEEN 300 AND 500 THEN 'DECLINE'
            WHEN CreditScore BETWEEN 501 AND 600 THEN 'MANUAL REVIEW'
            WHEN CreditScore BETWEEN 601 AND 700 THEN 'CONDITIONAL APPROVE'
            ELSE 'APPROVE'
        END AS decision,
        CASE
            WHEN CreditScore BETWEEN 300 AND 500 THEN '300-500'
            WHEN CreditScore BETWEEN 501 AND 600 THEN '501-600'
            WHEN CreditScore BETWEEN 601 AND 700 THEN '601-700'
            ELSE '701-850'
        END AS score_band
    FROM scored_applicants
)
SELECT
    score_band,
    decision,
    COUNT(*)                                            AS applicant_count,
    SUM(ActualDefault)                                  AS actual_defaults,
    ROUND(AVG(ActualDefault) * 100, 1)                 AS default_rate_pct,
    ROUND(AVG(CreditScore), 0)                         AS avg_credit_score,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct_of_portfolio
FROM scored
GROUP BY score_band, decision
ORDER BY
    CASE decision
        WHEN 'DECLINE'             THEN 1
        WHEN 'MANUAL REVIEW'       THEN 2
        WHEN 'CONDITIONAL APPROVE' THEN 3
        ELSE 4
    END;

-- ── 5. LATE PAYMENT IMPACT ANALYSIS ──────────────────────────
SELECT
    NumberOfTimes90DaysLate                            AS times_90_days_late,
    COUNT(*)                                           AS borrower_count,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)            AS default_rate_pct,
    ROUND(AVG(MonthlyIncome), 0)                      AS avg_income
FROM cs_training
WHERE NumberOfTimes90DaysLate <= 10
GROUP BY NumberOfTimes90DaysLate
ORDER BY NumberOfTimes90DaysLate;

-- ── 6. INCOME SEGMENTATION ────────────────────────────────────
SELECT
    CASE
        WHEN MonthlyIncome < 3000  THEN 'Under $3K'
        WHEN MonthlyIncome < 6000  THEN '$3K-$6K'
        WHEN MonthlyIncome < 10000 THEN '$6K-$10K'
        WHEN MonthlyIncome < 20000 THEN '$10K-$20K'
        ELSE 'Over $20K'
    END                                                AS income_band,
    COUNT(*)                                           AS borrower_count,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)            AS default_rate_pct,
    ROUND(AVG(DebtRatio), 3)                          AS avg_debt_ratio,
    ROUND(AVG(NumberOfOpenCreditLinesAndLoans), 1)    AS avg_open_credit_lines
FROM cs_training
WHERE MonthlyIncome IS NOT NULL
GROUP BY income_band
ORDER BY default_rate_pct DESC;

-- ── 7. HIGH RISK SEGMENT ──────────────────────────────────────
-- Borrowers hitting multiple risk criteria simultaneously
SELECT
    COUNT(*)                                           AS high_risk_count,
    ROUND(AVG(SeriousDlqin2yrs) * 100, 2)            AS actual_default_rate_pct,
    ROUND(AVG(age), 1)                                AS avg_age,
    ROUND(AVG(MonthlyIncome), 0)                      AS avg_income,
    ROUND(AVG(DebtRatio), 3)                          AS avg_debt_ratio
FROM cs_training
WHERE
    RevolvingUtilizationOfUnsecuredLines > 0.9
    AND NumberOfTimes90DaysLate > 0
    AND age < 35;
