-- RAW LAYER
---- raw.sales.orders
---- Source-of-truth ingestion from the sales system
---- No transformations applied

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
FROM source_system.sales_orders;
