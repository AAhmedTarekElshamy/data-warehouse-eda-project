/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - Compare total sales and orders across dimensions (Category, Country, Customer).
===============================================================================
*/

-- Total Sales & Orders by Product Category
SELECT 
    p.category,
    SUM(f.sales_amount) AS total_sales,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_sales DESC;

-- Total Sales by Country
SELECT 
    c.country,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sales DESC;
