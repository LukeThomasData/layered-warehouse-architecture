-- core.sales.fact_sales
-- Canonical sales fact at order grain

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    gross_amount,
    discount_amount,
    net_revenue,
    is_completed
FROM refined.sales.ref_orders;
