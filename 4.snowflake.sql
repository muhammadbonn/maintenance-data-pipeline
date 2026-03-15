CREATE WAREHOUSE IF NOT EXISTS compute_wh WITH WAREHOUSE_SIZE='X-SMALL';
CREATE DATABASE IF NOT EXISTS maintenance_db;
USE DATABASE maintenance_db;

CREATE SCHEMA IF NOT EXISTS raw_data;
USE SCHEMA raw_data;

CREATE OR REPLACE TABLE ai4i2020_silver (
    udi INT,
    product_id STRING,
    type STRING,
    air_temperature_k FLOAT,
    process_temperature_k FLOAT,
    rotational_speed_rpm INT,
    torque_nm FLOAT,
    tool_wear_min INT,
    machine_failure INT,
    twf INT,
    hdf INT,
    pwf INT,
    osf INT,
    rnf INT,
    processed_at TIMESTAMP
);

--
CREATE OR REPLACE FILE FORMAT my_parquet_format
  TYPE = PARQUET
  COMPRESSION = SNAPPY;

--
CREATE OR REPLACE STAGE my_s3_stage
  URL = 's3://maintenance-bonn-2026/silver/ai4i2020_cleaned/'
  CREDENTIALS = (AWS_KEY_ID = '********' AWS_SECRET_KEY = '***********')
  FILE_FORMAT = my_parquet_format;

--
COPY INTO ai4i2020_silver
  FROM @my_s3_stage
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
  PATTERN = '.*\.parquet';
