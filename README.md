# End-to-End Maintenance Data Pipeline

## Project Overview
This project is a complete end-to-end Data Engineering pipeline designed to process, store, and analyze predictive maintenance telemetry data (AI4I 2020 dataset). By leveraging a Modern Data Stack, the pipeline transforms raw machine sensor data into actionable business intelligence, enabling proactive maintenance strategies and reducing machine downtime.

The project demonstrates the integration of distributed processing, cloud storage, modern data warehousing, and analytics engineering best practices.

## Tech Stack & Architecture
- **Data Processing & Profiling:** Apache Spark (PySpark)
- **Containerization:** Docker
- **Cloud Data Lake (Silver Layer):** AWS S3
- **Data Warehouse:** Snowflake
- **Data Transformation (Gold Layer):** dbt (Data Build Tool)

## Pipeline Workflow

1. **Extract & Profile (PySpark):** Raw machine data is ingested and profiled using PySpark within a Dockerized Jupyter environment to identify anomalies and missing values.
2. **Clean & Load (PySpark to AWS S3):** Column names are standardized, metadata (e.g., processing timestamps) is added, and the cleaned data is written directly to an AWS S3 bucket in highly optimized **Parquet** format (Silver Layer).
3. **Staging & Warehousing (Snowflake):** An external stage is configured in Snowflake to securely connect to AWS S3. The Parquet files are then bulk-loaded into the `raw_data` schema using the `COPY INTO` command with pattern matching.
4. **Transform & Model (dbt):** dbt connects to Snowflake to build the final **Gold Layer**. It executes SQL transformations to aggregate data, calculating critical metrics such as:
   - Total machine failures per machine type (L, M, H).
   - Failure rate percentages.
   - Average operational metrics (Air Temperature, Rotational Speed) during failures.

## Repository Structure

```text
predictive-maintenance-pipeline/
│
├── README.md                      # Project documentation
├── docker-compose.yml             # Docker infrastructure setup
├── data_profiling.ipynb           # Exploratory Data Analysis & Profiling
├── uploading_dataset.ipynb        # PySpark cleaning and AWS S3 ingestion
└── gold_failure_analysis.sql # dbt model for business insights
