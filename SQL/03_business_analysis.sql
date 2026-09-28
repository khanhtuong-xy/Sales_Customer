-- =========================================================
-- SALES & CUSTOMER BI PROJECT
-- FILE: 03_business_analysis.sql
-- PURPOSE: Business performance analysis
-- =========================================================

USE SalesCustomerBI;
GO


-- =========================================================
-- 1. PRODUCT PERFORMANCE
-- =========================================================

SELECT
    p.product_type,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.quantity) AS units_sold,

    SUM(f.quantity * p.unit_price) AS revenue,

    SUM(f.quantity * f.unit_cost) AS total_cost,

    SUM(
        f.quantity * (p.unit_price - f.unit_cost)
    ) AS profit,

    100.0 *
    SUM(f.quantity * (p.unit_price - f.unit_cost))
    / NULLIF(SUM(f.quantity * p.unit_price), 0)
        AS profit_margin_pct,

    AVG(
        CAST(f.rating AS DECIMAL(10,2))
    ) AS avg_rating,

    100.0 *
    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    )
    / COUNT(DISTINCT f.order_id)
        AS cancellation_rate_pct

FROM fact_order f

JOIN dim_product p
    ON f.product_id = p.product_id

GROUP BY
    p.product_type

ORDER BY
    revenue DESC;
GO


-- =========================================================
-- 2. CUSTOMER PERFORMANCE
-- =========================================================

SELECT
    c.customer_id,
    c.age,
    c.gender,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.quantity) AS units_purchased,

    SUM(f.quantity * p.unit_price) AS revenue,

    SUM(
        f.quantity * (p.unit_price - f.unit_cost)
    ) AS profit,

    AVG(
        CAST(f.rating AS DECIMAL(10,2))
    ) AS avg_rating

FROM fact_order f

JOIN dim_customer c
    ON f.customer_id = c.customer_id

JOIN dim_product p
    ON f.product_id = p.product_id

GROUP BY
    c.customer_id,
    c.age,
    c.gender

ORDER BY
    revenue DESC;
GO


-- =========================================================
-- 3. SHIPPING PERFORMANCE
-- =========================================================

SELECT
    s.shipping_type,
    s.shipping_category,
    s.shipping_cost_level,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.quantity) AS units_sold,

    SUM(f.quantity * p.unit_price) AS revenue,

    SUM(
        f.quantity * (p.unit_price - f.unit_cost)
    ) AS profit,

    100.0 *
    SUM(f.quantity * (p.unit_price - f.unit_cost))
    / NULLIF(SUM(f.quantity * p.unit_price), 0)
        AS profit_margin_pct,

    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    100.0 *
    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    )
    / COUNT(DISTINCT f.order_id)
        AS cancellation_rate_pct

FROM fact_order f

JOIN dim_shipping s
    ON f.shipping_id = s.shipping_id

JOIN dim_product p
    ON f.product_id = p.product_id

GROUP BY
    s.shipping_type,
    s.shipping_category,
    s.shipping_cost_level

ORDER BY
    cancellation_rate_pct DESC;
GO


-- =========================================================
-- 4. PAYMENT PERFORMANCE
-- =========================================================

SELECT
    p.payment_method,
    p.payment_type,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.quantity) AS units_sold,

    SUM(f.quantity * pr.unit_price) AS revenue,

    SUM(
        f.quantity * (pr.unit_price - f.unit_cost)
    ) AS profit,

    100.0 *
    SUM(f.quantity * (pr.unit_price - f.unit_cost))
    / NULLIF(SUM(f.quantity * pr.unit_price), 0)
        AS profit_margin_pct,

    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    100.0 *
    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    )
    / COUNT(DISTINCT f.order_id)
        AS cancellation_rate_pct

FROM fact_order f

JOIN dim_payment p
    ON f.payment_id = p.payment_id

JOIN dim_product pr
    ON f.product_id = pr.product_id

GROUP BY
    p.payment_method,
    p.payment_type

ORDER BY
    revenue DESC;
GO


-- =========================================================
-- 5. SHIPPING × PAYMENT RISK ANALYSIS
-- =========================================================

SELECT
    s.shipping_type,
    p.payment_method,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    100.0 *
    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    )
    / NULLIF(COUNT(DISTINCT f.order_id), 0)
        AS cancellation_rate_pct,

    SUM(f.quantity * pr.unit_price) AS revenue,

    SUM(
        f.quantity * (pr.unit_price - f.unit_cost)
    ) AS profit,

    100.0 *
    SUM(f.quantity * (pr.unit_price - f.unit_cost))
    / NULLIF(SUM(f.quantity * pr.unit_price), 0)
        AS profit_margin_pct

FROM fact_order f

JOIN dim_shipping s
    ON f.shipping_id = s.shipping_id

JOIN dim_payment p
    ON f.payment_id = p.payment_id

JOIN dim_product pr
    ON f.product_id = pr.product_id

GROUP BY
    s.shipping_type,
    p.payment_method

ORDER BY
    cancellation_rate_pct DESC;
GO


-- =========================================================
-- 6. MONTHLY SALES & PROFIT TREND
-- =========================================================

SELECT
    DATEFROMPARTS(
        YEAR(f.purchase_date),
        MONTH(f.purchase_date),
        1
    ) AS month_start,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.quantity) AS units_sold,

    SUM(f.quantity * p.unit_price) AS revenue,

    SUM(
        f.quantity * (p.unit_price - f.unit_cost)
    ) AS profit,

    100.0 *
    SUM(f.quantity * (p.unit_price - f.unit_cost))
    / NULLIF(SUM(f.quantity * p.unit_price), 0)
        AS profit_margin_pct,

    100.0 *
    SUM(
        CASE
            WHEN f.Status = 'cancelled' THEN 1
            ELSE 0
        END
    )
    / COUNT(DISTINCT f.order_id)
        AS cancellation_rate_pct

FROM fact_order f

JOIN dim_product p
    ON f.product_id = p.product_id

GROUP BY
    YEAR(f.purchase_date),
    MONTH(f.purchase_date)

ORDER BY
    month_start;
GO