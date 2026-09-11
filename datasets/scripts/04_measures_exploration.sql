/*
===============================================================================
Measures Exploration
===============================================================================
Purpose:
    - Calculate core summary metrics across sales and order quantities.
===============================================================================
*/

SELECT 
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    AVG(sales_amount) AS avg_sales_amount,
    COUNT(DISTINCT order_number) AS total_orders,
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales;
