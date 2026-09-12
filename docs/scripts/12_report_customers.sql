/*
===============================================================================
Customer Report View
===============================================================================
Purpose:
    - Consolidates key customer metrics, segments (VIP/Regular/New), and KPIs.
===============================================================================
*/

CREATE VIEW gold.report_customers AS
WITH customer_aggregates AS (
    SELECT 
        f.customer_key,
        COUNT(DISTINCT f.order_number) AS total_orders,
        SUM(f.sales_amount) AS total_sales,
        SUM(f.quantity) AS total_quantity,
        COUNT(DISTINCT f.product_key) AS total_products,
        MIN(f.order_date) AS first_order_date,
        MAX(f.order_date) AS last_order_date,
        DATEDIFF(month, MIN(f.order_date), MAX(f.order_date)) AS lifespan
    FROM gold.fact_sales f
    WHERE f.order_date IS NOT NULL
    GROUP BY f.customer_key
)
SELECT 
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    DATEDIFF(year, c.birthdate, GETDATE()) AS age,
    CASE 
        WHEN ca.lifespan >= 12 AND ca.total_sales > 5000 THEN 'VIP'
        WHEN ca.lifespan >= 12 AND ca.total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    ca.first_order_date,
    ca.last_order_date,
    ca.total_orders,
    ca.total_sales,
    ca.total_quantity,
    ca.total_products,
    ca.lifespan,
    DATEDIFF(month, ca.last_order_date, GETDATE()) AS recency_months,
    CASE WHEN ca.total_orders = 0 THEN 0 ELSE ca.total_sales / ca.total_orders END AS avg_order_value,
    CASE WHEN ca.lifespan = 0 THEN ca.total_sales ELSE ca.total_sales / ca.lifespan END AS avg_monthly_spend
FROM gold.dim_customers c
LEFT JOIN customer_aggregates ca ON c.customer_key = ca.customer_key;
