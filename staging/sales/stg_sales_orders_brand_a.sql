-- staging.sales.stg_orders_brand_a
-- Structural normalization for Brand A sales orders

SELECT
    order_id,
    customer_id,
    CAST(order_date AS DATE)      AS order_date,
    LOWER(status)                 AS status,
    CAST(gross_amount AS NUMERIC) AS gross_amount,
    CAST(discount_amount AS NUMERIC) AS discount_amount,
    created_at,
    updated_at
FROM raw.sales.raw_sales_orders_brand_a
WHERE order_id IS NOT NULL;
