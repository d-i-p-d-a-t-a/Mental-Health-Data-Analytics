# Mental-Health-Data-Analytics
- **I. Project Title & Overview**
A full synthetic dataset of 10,000 simulated survey responses related to mental health in the workplace. Each row represents an individual respondent, and each column captures a specific attribute such as demographics, employment status, workplace support, or mental health history.

- **II. Architecture Diagram**
<img width="1004" height="1444" alt="image" src="https://github.com/user-attachments/assets/9c7041df-c791-4bc8-bac0-610908392a2a" />

- **III. Data Ingestion**
Explain how you got the data.
Source: kaggle
Method: SQL (ETL Scripts)

- **IV. Data Transformation**
Explain the "Before" and "After."
Tools: (e.g., dbt, Spark, SQL)
Logic: Mention specific joins, aggregations, or handling of null values.
Tip: Link to the specific script in your /pipelines/transformation/ folder.

V. Data Profiling
This is where you prove you understand your data.
Show a few Summary Statistics (mean, median, null counts).
Visualization: "According to my profiling, 15% of the 'Email' column was missing, so I handled it by..."
Tip: If you used ydata-profiling or Pandas Profiling, upload the HTML report to the /docs/profiling/ folder and link it here.

- **VI. Data Governance and Privacy**
**A. Field Classification:**
Direct Identifiers: None (Names/Emails were not collected).
Quasi-Identifiers: age, gender. If combined with employment_status, a specific person in a small company could be identified.
Sensitive Attributes (PHI): mental_health_history, depression_score, anxiety_score. These are protected health indicators.

**B. Recommendations:**
Access Control: Use Column-Level Security in SQL Server to restrict access to depression_score to only HR/Medical Officers.
Masking: In the rpt layer, raw age is replaced by age_group (K-Anonymity).
Retention: Data should be purged or fully anonymized after 3 years to comply with typical corporate data privacy policies.
Audit Requirements: Enable SQL Server Audit to log any SELECT queries performed on the health score columns.

**C. Ownership & Stewardship:**
Data Owner: Chief People Officer (Responsible for the business impact).
Data Steward: Lead Data Engineer (Responsible for DQ rules and transformation logic).

**D. Privacy Risks:**
Re-identification Risk: A remote worker with a unique age (e.g., 64) and specific gender might be identified by colleagues.
Bias Risk: Using this data for automated promotion decisions could lead to illegal discrimination against those with high depression_scores.

- **VI. Data Profiling (The "Visuals")**
Since GitHub doesn't render HTML files directly, you have two options:
Screenshots: Take a screenshot of your most important profiling charts and put them directly in the README.
Markdown Tables: Create a "Data Health" table:
<img width="870" height="136" alt="image" src="https://github.com/user-attachments/assets/1053f2a4-2408-4208-8605-a8cac62ba221" />
<img width="356" height="136" alt="image" src="https://github.com/user-attachments/assets/f63357be-a0c6-436a-8fef-1d54b0f7d3cd" />

- **VII. Findings and Recommendations**
uncovering critical business insights regarding mental health risk profiles, productivity and stress distribution. Below are some key findings:
(1. Wellbeing risk peaks during early-career entry (18-24) and mid-to-late career stages (45-54), suggesting a need for targeted mentorship for younger staff and burnout prevention for mid-senior leadership.
(2. Our analysis confirms a distinct inverse relationship between depression scores and productivity.
(3. The 45-54 age demographic represents a "Productivity Gap" where the highest depression scores (15.22) align with a sharp drop in productivity (77.03).

Recommendations:
(1. Implement a Mid-Career Resilience Program specifically for the 45–54 age group. This should include senior-level burnout prevention workshops, "Sabbatical" eligibility, and specialized health screenings. Recovering the productivity lost in this experienced demographic represents the highest potential ROI for the organization.
(2. Launch an Early-Career Peer Support Network. High depression in entry-level staff often stems from isolation or "imposter syndrome." By pairing the 18–24 demographic with the more resilient 25–34 demographic (who show the lowest depression and highest productivity), the company can stabilize the mental health of its talent pipeline.
(3. Audit and update Mental Health Benefits to ensure they are identity-neutral and inclusive. Governance and privacy should be prioritized to maintain the trust of those in the "Prefer not to say" category. Ensuring that support is accessible and non-stigmatized for all gender identities is essential for maintaining the "Human Capital Resilience" identified in the study.

 these recommendations are backed by the Inverse Correlation found in your SQL reporting layer (rpt.fact_mental_health_summary), providing a direct link between the data quality and the business strategy.

