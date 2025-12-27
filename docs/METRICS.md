# Sales Metrics Reference

This document defines the core sales metrics exposed through the analytics warehouse.
Metric definitions are **authoritative** and are intended to be reused consistently across
dashboards, reports, and downstream analytics.

Metrics are defined in the refined layer, integrated into canonical analytical models downstream,
and materialized in the marts layer to support performant, consistent consumption across analytics tools.

---

## Metric Scope

This repository models a single Sales domain and source system. Metrics defined here
demonstrate naming, ownership, and definition patterns rather than exhaustive coverage.

---

## Gross Revenue

**Definition**  
Total revenue recorded for completed sales before discounts, returns, or adjustments.

**Calculation**  
`SUM(gross_amount)`

**Availability**  
Marts layer

---

## Net Revenue

**Definition**  
Revenue after discounts, credits, or adjustments have been applied.

**Calculation**  
`gross_amount - discount_amount`

**Availability**  
Marts layer

---

## Order Count

**Definition**  
Total number of completed sales orders.

**Calculation**  
`COUNT(DISTINCT order_id)`

**Availability**  
Marts layer

---

## Average Order Value (AOV)

**Definition**  
Average net revenue per completed order.

**Calculation**  
`net_revenue / order_count`

**Availability**  
Marts layer

---

## Sales Conversion Rate (Optional)

**Definition**  
Percentage of sales opportunities that result in a completed order.

**Calculation**  
`completed_orders / total_opportunities`

**Availability**  
Marts layer

**Notes**  
Included to demonstrate extensibility when additional source systems
(e.g., CRM opportunities) are introduced.

---

## Metric Governance Rules

- Metric definitions are owned centrally and reused downstream
- Business meaning is defined once and not reinterpreted in BI tools
- Marts expose metrics for consumption but do not redefine calculations
- Any changes to metric definitions must occur upstream of the marts layer

These rules prevent metric drift and ensure consistent interpretation across teams.
