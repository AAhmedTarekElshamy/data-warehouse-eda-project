/*
===============================================================================
Date Range Exploration
===============================================================================
Purpose:
    - Determine the boundaries of historical data (First/Last Order Date).
    - Calculate total span of data in years and months.
===============================================================================
*/

SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(year, MIN(order_date), MAX(order_date)) AS total_years_span,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS total_months_span
FROM gold.fact_sales;
