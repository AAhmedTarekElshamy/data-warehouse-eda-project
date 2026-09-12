/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - Rank products and customers using Window Functions (RANK, DENSE_RANK).
===============================================================================
*/

-- Top 5 Products by Sales
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS sales_rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- Top 10 Customers by Revenue Contribution
SELECT TOP 10
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_sales DESC;
