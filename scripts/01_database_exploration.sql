/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - Explore the structure of the database, including all tables and views.
    - Inspect columns, data types, and system metadata within the Gold Schema.
===============================================================================
*/

-- 1. Retrieve a list of all tables and views in the database
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'gold'
ORDER BY TABLE_NAME;


-- 2. Retrieve all columns and data types for all tables in the Gold schema
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY TABLE_NAME, ORDINAL_POSITION;


-- 3. Retrieve distinct list of foreign keys / primary relationships (Metadata Inspection)
SELECT 
    t.name AS table_name,
    c.name AS column_name,
    ty.name AS data_type
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE SCHEMA_NAME(t.schema_id) = 'gold'
ORDER BY t.name, c.column_id;
