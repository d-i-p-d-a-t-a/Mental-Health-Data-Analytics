CREATE DATABASE MentalHealthDB;
GO
USE MentalHealthDB;
GO

CREATE SCHEMA raw;
GO
CREATE SCHEMA stg;
GO
CREATE SCHEMA rpt;
GO

-- Raw Table: Matches your screenshot exactly
CREATE TABLE raw.MentalHealth (
    age INT,
    gender VARCHAR(50),
    employment_status VARCHAR(100),
    work_environment VARCHAR(100),
    mental_health_history VARCHAR(10),
    seeks_treatment VARCHAR(10),
    stress_level FLOAT,
    sleep_hours FLOAT,
    physical_activity_days INT,
    depression_score INT,
    anxiety_score INT,
    social_support_score INT,
    productivity_score FLOAT,
    mental_health_risk VARCHAR(50)
);


select * from raw.MentalHealth;
