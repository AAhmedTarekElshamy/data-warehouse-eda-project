/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - Explore unique values and categorical attributes in Dimension tables.
    - Inspect product categories, subcategories, countries, and customer demographics.
===============================================================================
*/

-- 1. Retrieve unique list of Product Categories and Subcategories
SELECT DISTINCT 
    category,
    subcategory
FROM gold.dim_products
ORDER BY category, subcategory;


-- 2. Retrieve distinct list of Product Names
SELECT DISTINCT 
    product_name
FROM gold.dim_products
ORDER BY product_name;


-- 3. Retrieve unique Customer Countries / Regions
SELECT DISTINCT 
    country
FROM gold.dim_customers
ORDER BY country;


-- 4. Retrieve unique Customer Genders and Marital Statuses
SELECT DISTINCT 
    gender,
    marital_status
FROM gold.dim_customers;
