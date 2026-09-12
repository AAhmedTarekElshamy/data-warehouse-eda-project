/*
===============================================================================
Performance Analysis
===============================================================================
Purpose:
    - Year-over-Year (YoY) growth comparison using LAG function.
===============================================================================
*/

WITH YearlySales AS (
    SELECT 
        YEAR(order_date) AS order_year,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
)
SELECT 
    order_year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY order_year) AS previous_year_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY order_year) AS yoy_growth,
    ROUND((total_sales - LAG(total_sales) OVER (ORDER BY order_year)) / NULLIF(LAG(total_sales) OVER (ORDER BY order_year), 0) * 100, 2) AS yoy_growth_percentage
FROM YearlySales;
