-- staging.sales.stg_orders
-- Structural normalization only

SELECT
    order_id,
    customer_id,
    CAST(order_date AS DATE)      AS order_date,
    LOWER(status)                 AS status,
    CAST(gross_amount AS NUMERIC) AS gross_amount,
    CAST(discount_amount AS NUMERIC) AS discount_amount,
    created_at,
    updated_at
FROM raw.sales.orders
WHERE order_id IS NOT NULL;
