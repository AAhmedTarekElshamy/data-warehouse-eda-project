/*
===============================================================================
Data Segmentation
===============================================================================
Purpose:
    - Segment customers into VIP, Regular, and New based on lifespan and spend.
===============================================================================
*/

WITH CustomerMetrics AS (
    SELECT 
        customer_key,
        SUM(sales_amount) AS total_spending,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan_months
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY customer_key
)
SELECT 
    CASE 
        WHEN lifespan_months >= 12 AND total_spending > 5000 THEN 'VIP'
        WHEN lifespan_months >= 12 AND total_spending <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    COUNT(customer_key) AS total_customers,
    SUM(total_spending) AS total_sales
FROM CustomerMetrics
GROUP BY 
    CASE 
        WHEN lifespan_months >= 12 AND total_spending > 5000 THEN 'VIP'
        WHEN lifespan_months >= 12 AND total_spending <= 5000 THEN 'Regular'
        ELSE 'New'
    END;
