-- raw.sales.raw_sales_orders_brand_b
-- Source-of-truth ingestion for Brand B sales orders
-- No transformations applied

SELECT
    order_id,
    customer_id,
    order_date,
    status,
    gross_amount,
    discount_amount,
    created_at,
    updated_at,
    _ingested_at
FROM source_system_brand_b.sales_orders;
