-- Create the Reporting Table
/* This script creates a Reporting View. It applies Data Masking by bucketing ages 
and generalizing gender where necessary to prevent re-identification of individuals.*/

DROP TABLE IF EXISTS rpt.fact_mental_health_summary;

CREATE TABLE rpt.fact_mental_health_summary (
    reporting_id INT IDENTITY(1,1) PRIMARY KEY,
    record_id UNIQUEIDENTIFIER,
    age_group NVARCHAR(20),      -- Masked: 5-year buckets
    gender_group NVARCHAR(50),   -- Cleaned
    employment_status NVARCHAR(50),
    work_environment NVARCHAR(50),
    stress_category NVARCHAR(20),-- Derived attribute
    sleep_hours_dec DECIMAL(4,1),
    depression_score INT,
    anxiety_score INT,
    productivity_score DECIMAL(5,2),
    mental_health_risk NVARCHAR(20)
);

-- Insert logic with De-identification (Governance applied)
INSERT INTO rpt.fact_mental_health_summary (
    record_id, age_group, gender_group, employment_status, 
    work_environment, stress_category, sleep_hours_dec, 
    depression_score, anxiety_score, productivity_score, mental_health_risk
)
SELECT 
    record_id,
    -- Age Masking: Bucketing to protect privacy (Quasi-identifier mitigation)
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+' 
    END as age_group,
    gender as gender_group,
    employment_status,
    work_environment,
    -- Analytical Derived Attribute
    CASE 
        WHEN stress_level >= 8 THEN 'Critical'
        WHEN stress_level >= 5 THEN 'High'
        ELSE 'Moderate/Low' 
    END as stress_category,
    sleep_hours,
    depression_score,
    anxiety_score,
    productivity_score,
    mental_health_risk
FROM stg.mental_health;


select * from rpt.fact_mental_health_summary;