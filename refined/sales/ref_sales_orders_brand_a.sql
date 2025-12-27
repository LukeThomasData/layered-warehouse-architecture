-- refined.sales.ref_orders_brand_a
-- Canonical sales definition for Brand A
-- Reconciles Brand A sales data across operational systems
-- and applies brand-specific business logic

SELECT
    order_id,
    customer_id,
    order_date,

    CASE
        WHEN status IN ('completed', 'shipped')
        THEN 'completed'
        ELSE 'open'
    END AS order_status,

    gross_amount,
    discount_amount,

    gross_amount - discount_amount AS net_revenue,

    CASE
        WHEN status IN ('completed', 'shipped') THEN 1
        ELSE 0
    END AS is_completed
FROM staging.sales.stg_orders;
