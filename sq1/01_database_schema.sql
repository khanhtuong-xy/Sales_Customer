-- =========================================================
-- SALES & CUSTOMER BI PROJECT
-- FILE: 01_database_schema.sql
-- PURPOSE: Create dimensional model and load cleaned data
-- =========================================================

USE SalesCustomerBI;
GO


-- =========================================================
-- 1. DIM CUSTOMER
-- =========================================================

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(20)
);
GO


-- Handle missing gender before loading
UPDATE dim_customer_import
SET gender = 'none'
WHERE gender IS NULL;
GO


INSERT INTO dim_customer (
    customer_id,
    age,
    gender
)
SELECT
    customer_id,
    age,
    gender
FROM dim_customer_import;
GO


-- =========================================================
-- 2. DIM PRODUCT
-- =========================================================

CREATE TABLE dim_product (
    product_id NVARCHAR(50) PRIMARY KEY,
    sku NVARCHAR(50),
    product_type NVARCHAR(50),
    unit_price DECIMAL(10,2)
);
GO


INSERT INTO dim_product (
    product_id,
    sku,
    product_type,
    unit_price
)
SELECT
    product_id,
    sku,
    product_type,
    unit_price
FROM dim_product_import;
GO


-- =========================================================
-- 3. DIM PAYMENT
-- =========================================================

CREATE TABLE dim_payment (
    payment_id INT PRIMARY KEY,
    payment_method NVARCHAR(50),
    payment_type NVARCHAR(50)
);
GO


INSERT INTO dim_payment (
    payment_id,
    payment_method,
    payment_type
)
SELECT
    payment_id,
    payment_method,
    payment_type
FROM dim_payment_import;
GO


-- =========================================================
-- 4. DIM SHIPPING
-- =========================================================

CREATE TABLE dim_shipping (
    shipping_id INT PRIMARY KEY,
    shipping_type NVARCHAR(50),
    shipping_category NVARCHAR(50),
    shipping_cost_level NVARCHAR(50)
);
GO


INSERT INTO dim_shipping (
    shipping_id,
    shipping_type,
    shipping_category,
    shipping_cost_level
)
SELECT
    shipping_id,
    shipping_type,
    shipping_category,
    shipping_cost_level
FROM dim_shipping_import;
GO


-- =========================================================
-- 5. FACT ORDER
-- =========================================================

CREATE TABLE fact_order (
    order_id INT PRIMARY KEY,
    purchase_date DATETIME2,

    customer_id INT,
    product_id NVARCHAR(50),
    payment_id INT,
    shipping_id INT,

    loyalty NVARCHAR(50),
    Status NVARCHAR(50),
    orders_type NVARCHAR(50),

    rating INT,
    quantity INT,
    unit_cost DECIMAL(18,10),

    CONSTRAINT FK_fact_customer
        FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id),

    CONSTRAINT FK_fact_product
        FOREIGN KEY (product_id)
        REFERENCES dim_product(product_id),

    CONSTRAINT FK_fact_payment
        FOREIGN KEY (payment_id)
        REFERENCES dim_payment(payment_id),

    CONSTRAINT FK_fact_shipping
        FOREIGN KEY (shipping_id)
        REFERENCES dim_shipping(shipping_id)
);
GO


INSERT INTO fact_order (
    order_id,
    purchase_date,
    customer_id,
    product_id,
    payment_id,
    shipping_id,
    loyalty,
    Status,
    orders_type,
    rating,
    quantity,
    unit_cost
)
SELECT
    order_id,
    purchase_date,
    customer_id,
    product_id,
    payment_id,
    shipping_id,
    loyalty,
    Status,
    orders_type,
    rating,
    quantity,
    CAST(unit_cost AS DECIMAL(18,10))
FROM fact_order_import;
GO