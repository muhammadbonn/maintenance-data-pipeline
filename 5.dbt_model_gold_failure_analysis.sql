{{ config(materialized='table') }}

SELECT 
    type AS machine_type,
    COUNT(udi) AS total_machines,
    SUM(machine_failure) AS total_failures,
    ROUND((SUM(machine_failure) / COUNT(udi)) * 100, 2) AS failure_rate_percentage,
    ROUND(AVG(air_temperature_k), 2) AS avg_air_temperature,
    ROUND(AVG(rotational_speed_rpm), 2) AS avg_rotational_speed
FROM 
    {{ target.database }}.raw_data.ai4i2020_silver
GROUP BY 
    type
ORDER BY 
    failure_rate_percentage DESC