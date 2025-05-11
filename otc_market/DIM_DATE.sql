{{config(materialized='table')}}

WITH RECURSIVE date_cte AS (
    SELECT CAST('2020-01-01' AS timestamp) AS date_value
    UNION ALL
    SELECT date_value + interval '1 day'
    FROM date_cte
    WHERE date_value + interval '1 day' <= CAST('2024-12-31' AS timestamp)
)

SELECT
    date_value AS date_id,
    CAST(EXTRACT(YEAR FROM date_value) AS INTEGER) AS year_number,
    CAST(EXTRACT(QUARTER FROM date_value) AS INTEGER) AS quarter_number,
    CAST(EXTRACT(MONTH FROM date_value) AS INTEGER) AS month_number,
    CAST(EXTRACT(DAY FROM date_value) AS INTEGER) AS day_number,
    CAST(FLOOR((EXTRACT(DAY FROM date_value) - 1)/7) AS INTEGER) + 1 AS week_of_month,
    CAST(EXTRACT(WEEK FROM date_value) AS INTEGER) AS week_of_year,
    TO_CHAR(date_value, 'Month') AS month_name,
    CAST(DAYNAME(date_value) AS VARCHAR) AS day_name,
FROM date_cte