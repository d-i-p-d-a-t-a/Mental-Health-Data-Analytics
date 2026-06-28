
-- Step 1: the Staging Table Structure
/* First, let's ensure your stg table uses the correct data types. 
 Execute this to drop and recreate your staging table: */

DROP TABLE IF EXISTS stg.mental_health;

CREATE TABLE stg.mental_health (
    record_id UNIQUEIDENTIFIER DEFAULT NEWID(),
    age INT,
    gender NVARCHAR(50),
    employment_status NVARCHAR(50),
    work_environment NVARCHAR(50),
    mental_health_history NVARCHAR(10), -- Changed from BIT to NVARCHAR
    seeks_treatment NVARCHAR(10),       -- Changed from BIT to NVARCHAR
    stress_level INT,
    sleep_hours DECIMAL(4,1),
    physical_activity_days INT,
    depression_score INT,
    anxiety_score INT,
    social_support_score INT,
    productivity_score DECIMAL(5,2),
    mental_health_risk NVARCHAR(20)
);



-- Step 2: Transformation Script
/* Now, run the insertion from raw to stg. 
We will explicitly cast the problematic columns 
to strings before trimming them. */

INSERT INTO stg.mental_health (
    age, gender, employment_status, work_environment, 
    mental_health_history, seeks_treatment, stress_level, 
    sleep_hours, physical_activity_days, depression_score, 
    anxiety_score, social_support_score, productivity_score, mental_health_risk
)
SELECT 
    CAST(age AS INT),
    TRIM(CAST(gender AS NVARCHAR(50))),
    TRIM(CAST(employment_status AS NVARCHAR(50))),
    TRIM(CAST(work_environment AS NVARCHAR(50))),
    TRIM(CAST(mental_health_history AS NVARCHAR(10))), -- Fixed bit error
    TRIM(CAST(seeks_treatment AS NVARCHAR(10))),       -- Fixed bit error
    CAST(stress_level AS INT),
    CAST(sleep_hours AS DECIMAL(4,1)),
    CAST(physical_activity_days AS INT),
    CAST(depression_score AS INT),
    CAST(anxiety_score AS INT),
    CAST(social_support_score AS INT),
    CAST(productivity_score AS DECIMAL(5,2)),
    TRIM(CAST(mental_health_risk AS NVARCHAR(20)))
FROM raw.mental_health_dataset;



-- Step3: Technical data profiling 
/* Run this to generate the stats required: */
-- General Profile
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT gender) as gender_count,
    AVG(age) as avg_age,
    AVG(depression_score) as avg_depression,
    MIN(sleep_hours) as min_sleep,
    MAX(sleep_hours) as max_sleep
FROM stg.mental_health;

-- Identify Outliers (e.g., extremely low sleep or very high stress)
SELECT * FROM stg.mental_health 
WHERE sleep_hours < 4 OR stress_level > 9;

-- Check for Duplicates (based on all attributes since there was no ID)
SELECT age, gender, depression_score, COUNT(*)
FROM stg.mental_health
GROUP BY age, gender, depression_score
HAVING COUNT(*) > 1;




-- Step 4: Data Quality Assessment (DQ)
/* (1. Completeness: mental_health_risk must not be NULL.
   (2. Validity: productivity_score must be between 0 and 100.
   (3. Accuracy: physical_activity_days cannot exceed 7. */

-- Data Quality Results
SELECT 'Null Risk Score' as Issue, COUNT(*) as Failures FROM stg.mental_health WHERE mental_health_risk IS NULL
UNION ALL
SELECT 'Invalid Productivity', COUNT(*) FROM stg.mental_health WHERE productivity_score < 0 OR productivity_score > 100
UNION ALL
SELECT 'Physical Activity Overflow', COUNT(*) FROM stg.mental_health WHERE physical_activity_days > 7;

/* -- Handling Strategy: In production, failed rows should be redirected to a rejected_records table, 
-- and an alert (email/Slack) should trigger if failure rates exceed 5%. */


