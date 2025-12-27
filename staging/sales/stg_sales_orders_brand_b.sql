-- refined.sales.ref_orders_brand_b
-- Canonical sales definition for Brand B
-- This model reconciles Brand B sales data across its operational source systems
-- (e.g., CRM, ERP) and applies brand-specific business logic.

SELECT
    order_id,
    customer_id,
    CAST(order_date AS DATE) AS order_date,
    LOWER(status) AS status,
    CAST(gross_amount AS NUMERIC) AS gross_amount,
    CAST(discount_amount AS NUMERIC) AS discount_amount
FROM raw.sales.raw_sales_orders_brand_b
WHERE order_id IS NOT NULL;
