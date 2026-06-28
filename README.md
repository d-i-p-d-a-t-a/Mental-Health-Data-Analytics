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


-**|**ColumnName**	|**TotalRows**| **NonNullCount** |	**MinValue** |	**MaxValue** |	**AvgValue**|	**UniqueValues**|         | Age	          | 4457        |	4457	           |   18	         | 65	           |   41	        |48
   |Depression_Score|	4457	      | 4457	           |   0	         | 30	           |   15	        |31

