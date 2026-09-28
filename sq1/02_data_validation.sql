-- =========================================================
-- SALES & CUSTOMER BI PROJECT
-- FILE: 02_data_validation.sql
-- PURPOSE: Validate data quality and referential integrity
-- =========================================================

USE SalesCustomerBI;
GO


-- =========================================================
-- 1. CUSTOMER DATA VALIDATION
-- =========================================================

-- Check imported row count
SELECT COUNT(*) AS customer_import_rows
FROM dim_customer_import;


-- Check missing gender
SELECT *
FROM dim_customer_import
WHERE gender IS NULL;


-- Check duplicate Customer IDs
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM dim_customer_import
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Validate final customer count
SELECT COUNT(*) AS total_customers
FROM dim_customer;



-- =========================================================
-- 2. PRODUCT DATA VALIDATION
-- =========================================================

-- Check imported row count
SELECT COUNT(*) AS product_import_rows
FROM dim_product_import;


-- Check missing values
SELECT *
FROM dim_product_import
WHERE product_id IS NULL
   OR sku IS NULL
   OR product_type IS NULL
   OR unit_price IS NULL;


-- Check duplicate Product IDs
SELECT
    product_id,
    COUNT(*) AS record_count
FROM dim_product_import
GROUP BY product_id
HAVING COUNT(*) > 1;


-- Validate final product count
SELECT COUNT(*) AS total_products
FROM dim_product;



-- =========================================================
-- 3. PAYMENT DATA VALIDATION
-- =========================================================

-- Check missing values
SELECT *
FROM dim_payment_import
WHERE payment_id IS NULL
   OR payment_method IS NULL
   OR payment_type IS NULL;


-- Check duplicate Payment IDs
SELECT
    payment_id,
    COUNT(*) AS record_count
FROM dim_payment_import
GROUP BY payment_id
HAVING COUNT(*) > 1;


-- Validate final payment count
SELECT COUNT(*) AS total_payment_methods
FROM dim_payment;



-- =========================================================
-- 4. SHIPPING DATA VALIDATION
-- =========================================================

-- Check missing values
SELECT *
FROM dim_shipping_import
WHERE shipping_id IS NULL
   OR shipping_type IS NULL
   OR shipping_category IS NULL
   OR shipping_cost_level IS NULL;


-- Check duplicate Shipping IDs
SELECT
    shipping_id,
    COUNT(*) AS record_count
FROM dim_shipping_import
GROUP BY shipping_id
HAVING COUNT(*) > 1;


-- Validate final shipping count
SELECT COUNT(*) AS total_shipping_methods
FROM dim_shipping;



-- =========================================================
-- 5. FACT ORDER DATA VALIDATION
-- =========================================================

-- Check imported row count
SELECT COUNT(*) AS fact_import_rows
FROM fact_order_import;


-- Check duplicate Order IDs
SELECT
    order_id,
    COUNT(*) AS record_count
FROM fact_order_import
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check missing key fields
SELECT *
FROM fact_order_import
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR product_id IS NULL
   OR payment_id IS NULL
   OR shipping_id IS NULL
   OR purchase_date IS NULL;



-- =========================================================
-- 6. REFERENTIAL INTEGRITY CHECKS
-- =========================================================

-- Check unmatched Customer IDs
SELECT COUNT(*) AS unmatched_customer
FROM fact_order_import f
LEFT JOIN dim_customer c
    ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- Check unmatched Product IDs
SELECT COUNT(*) AS unmatched_product
FROM fact_order_import f
LEFT JOIN dim_product p
    ON f.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Check unmatched Payment IDs
SELECT COUNT(*) AS unmatched_payment
FROM fact_order_import f
LEFT JOIN dim_payment p
    ON f.payment_id = p.payment_id
WHERE p.payment_id IS NULL;


-- Check unmatched Shipping IDs
SELECT COUNT(*) AS unmatched_shipping
FROM fact_order_import f
LEFT JOIN dim_shipping s
    ON f.shipping_id = s.shipping_id
WHERE s.shipping_id IS NULL;



-- =========================================================
-- 7. FINAL MODEL VALIDATION
-- =========================================================

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT product_id) AS products,
    COUNT(DISTINCT payment_id) AS payment_methods,
    COUNT(DISTINCT shipping_id) AS shipping_methods
FROM fact_order;