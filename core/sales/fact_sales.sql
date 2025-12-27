-- core.sales.fact_sales
-- Enterprise-wide canonical sales fact at order grain
-- Integrates multiple brands into a single analytical contract

SELECT
    'brand_a' AS brand_key,
    order_id,
    customer_id,
    order_date,
    order_status,
    gross_amount,
    discount_amount,
    net_revenue,
    is_completed
FROM refined.sales.ref_orders  -- existing Brand A

UNION ALL

SELECT
    'brand_b' AS brand_key,
    order_id,
    customer_id,
    order_date,
    order_status,
    gross_amount,
    discount_amount,
    net_revenue,
    is_completed
FROM refined.sales.ref_orders_brand_b;

