/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - Calculate running totals for sales over time.
===============================================================================
*/

WITH MonthlySales AS (
    SELECT 
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_month,
        SUM(sales_amount) AS monthly_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
)
SELECT 
    order_month,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY order_month) AS running_total_sales
FROM MonthlySales;
