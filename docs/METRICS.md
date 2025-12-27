# Sales Metrics Reference

This document defines the core sales metrics exposed through the analytics warehouse.
Metric definitions are **authoritative** and intended to be reused consistently across
dashboards, reports, and downstream analytics.

Metrics are **defined at the brand level**, integrated into **canonical enterprise models**,
and **materialized for consumption** through analytics marts.

---

## Metric Scope

This repository models a single **Sales domain across multiple brands**.
Metrics defined here demonstrate naming, ownership, and definition patterns
rather than exhaustive coverage.

All metrics follow the architectural and governance contracts defined in
ARCHITECTURE.md and GOVERNANCE.md.

---

## Gross Revenue

**Definition**  
Total revenue recorded for completed sales before discounts, returns,
or adjustments.

**Calculation**  
`SUM(gross_amount)`

**Defined At**  
Brand-level refined layer

**Available In**  
Marts layer

---

## Net Revenue

**Definition**  
Revenue after discounts, credits, or adjustments have been applied.

**Calculation**  
`gross_amount - discount_amount`

**Defined At**  
Brand-level refined layer

**Available In**  
Marts layer

---

## Order Count

**Definition**  
Total number of completed sales orders.

**Calculation**  
`COUNT(DISTINCT order_id)`

**Defined At**  
Brand-level refined layer

**Integrated In**  
Core layer

**Available In**  
Marts layer

---

## Average Order Value (AOV)

**Definition**  
Average net revenue per completed order.

**Calculation**  
`net_revenue / order_count`

**Derived In**  
Marts layer (consumption-only calculation)

**Available In**  
Marts layer

---

## Sales Conversion Rate (Optional)

**Definition**  
Percentage of sales opportunities that result in a completed order.

**Calculation**  
`completed_orders / total_opportunities`

**Defined At**  
Brand-level refined layer (when opportunity data exists)

**Integrated In**  
Core layer

**Available In**  
Marts layer

**Notes**  
Included to demonstrate extensibility when additional operational systems
(e.g. CRM opportunities) are introduced.

---

## Metric Governance Rules

- Metric definitions are owned centrally and reused downstream
- Business meaning is defined once and never reinterpreted in BI tools
- Brand-specific metric logic lives in the refined layer
- Cross-brand consistency is enforced in the core layer
- Marts expose metrics for consumption but do not redefine calculations
- Any changes to metric definitions must occur upstream of the marts layer

These rules prevent metric drift and ensure consistent interpretation
across brands, teams, and analytics tools.

