# Enterprise Analytics Warehouse Architecture

## Overview

This repository demonstrates a layered enterprise analytics warehouse architecture designed to support
multiple operational source systems across multiple brands, while maintaining metric consistency,
data quality, and analytical performance.

The architecture separates **logical transformation layers (views)** from **physical serving layers (tables)**,
allowing upstream logic to remain flexible while downstream analytics benefit from optimized,
materialized datasets.

This pattern reflects real-world implementations in modern cloud data warehouses such as
BigQuery, Snowflake, Azure Synapse, and Amazon Redshift.

---

## Layered Model

The warehouse is organized into the following layers:

```text
raw (tables)
  ↓
staging (views)
  ↓
refined (views)
  ↓
core (views)
  ↓
marts (tables)


## Layer Definitions

### Raw Layer

**Purpose:** Source-of-truth ingestion  
**Format:** Tables  

- Ingested directly from operational source systems
- Minimal to no transformation
- Preserves source fidelity and historical accuracy
- Typically append-only
- Includes metadata such as load timestamps and source identifiers

**Examples:**
```sql
raw.sales.raw_sales_orders_brand_a
raw.sales.raw_sales_orders_brand_b

### Staging Layer

**Purpose:** Structural normalization  
**Format:** Views  

- Renames fields to warehouse naming standards (`snake_case`)
- Applies type casting and basic data cleansing
- Performs light filtering of records not needed downstream
- No joins
- No business logic

This layer exists to decouple downstream logic from source-system naming
conventions and schema volatility.

**Examples:**
- `staging.sales.stg_orders_brand_a`
- `staging.sales.stg_orders_brand_b`

### Refined Layer

**Purpose:** Brand-level business shaping and reconciliation  
**Format:** Views  

- Applies business rules specific to a single brand
- Reconciles that brand’s internal operational systems (ERP, CRM, etc.)
- Derives calculated fields and metrics
- Aligns brand data to enterprise definitions
- Remains isolated per brand

Common examples include:
- Revenue normalization
- Status standardization
- Flag and indicator derivations

**Examples:**
- `refined.sales.ref_orders_brand_a`
- `refined.sales.ref_orders_brand_b`

### Core Layer

**Purpose:** Cross-brand, conformed analytical entities  
**Format:** Views  

- Combines refined datasets across multiple brands
- Represents enterprise-wide facts and dimensions
- Enforces consistent grain and business definitions
- Introduces enterprise identifiers (e.g. `brand_key`)
- Designed to scale as new brands are added without rewriting downstream logic

This layer represents the canonical analytical model used across the organization.

**Example:**
- `core.sales.fact_sales`

### Marts Layer

**Purpose:** Analytics-serving layer  
**Format:** Tables (materialized)  

- Materialized on a schedule (scheduled queries or stored procedures)
- Optimized for BI tools and ad-hoc analysis
- Contains aggregations and KPI-ready structures
- Balances freshness with query performance
- Contains no business logic, only consumption shaping

**Example:**
- `marts.sales.mart_sales`

## View-Based Transformation Strategy

All transformation layers (**staging**, **refined**, **core**) are implemented as views.

The **marts** layer is materialized downstream of these views via
scheduled queries or stored procedures.

Each materialization run reflects the current canonical state
of upstream data at execution time.

### Benefits

- Clear separation of concerns
- Minimal duplication of transformation logic
- Faster iteration on business rules
- Simplified operational maintenance
- Stable downstream analytics contracts

## Scope of This Repository

This repository models a single Sales domain across multiple brands
to demonstrate architectural patterns, layer responsibilities,
and governance contracts.

The structure, naming conventions, and layer boundaries are intentionally
designed to support additional brands and operational systems
without altering downstream consumption layers.

## Design Principles

- Transformation logic lives as close as possible to its appropriate layer
- Brand-specific logic is isolated in the refined layer
- Enterprise integration occurs only in the core layer
- Business definitions are enforced centrally and reused downstream
- Layers are additive and composable
- Performance optimization occurs at the serving layer, not the transformation layers

## Production Implementation Note

In production environments, layers are commonly implemented using
execution-ordered schemas (e.g. `00_raw`, `01_staging`, `02_refined`)
and environment-specific database or pool naming conventions.

This repository omits those execution mechanics intentionally to focus on
architectural design patterns rather than platform-specific implementation details.
