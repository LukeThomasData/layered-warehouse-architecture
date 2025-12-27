# Enterprise Analytics Warehouse Architecture

## Overview

This repository demonstrates a layered enterprise analytics warehouse architecture designed to support
multiple operational source systems while maintaining metric consistency, data quality, and analytical performance.

The architecture separates **logical transformation layers (views)** from **physical serving layers (tables)**,
allowing upstream logic to remain flexible while downstream analytics benefit from optimized, materialized datasets.

This pattern reflects real-world implementations in modern cloud data warehouses such as BigQuery, Snowflake, Azure Synapse, and Amazon Redshift.

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
### Raw
**Purpose:** Source-of-truth ingestion  
**Format:** Tables  

- Ingested directly from operational source systems
- Minimal to no transformation
- Preserves source fidelity and historical accuracy
- Typically append-only
- Includes metadata such as load timestamps and source identifiers

**Example:**

### Staging
**Purpose:** Structural normalization  
**Format:** Views  

- Renames fields to warehouse naming standards (`snake_case`)
- Applies type casting and basic data cleansing
- Performs light filtering of records not needed downstream
- No joins
- No business logic

This layer exists to decouple downstream logic from source-system naming conventions and schema volatility.

**Example:**

### Refined
**Purpose:** Source-specific business shaping  
**Format:** Views  

- Applies business rules specific to a single source system
- Derives calculated fields
- Aligns source data to enterprise definitions
- Remains isolated per source system

Common examples include:
- Revenue normalization
- Status mapping
- Flag and indicator derivations

**Example:**

### Core
**Purpose:** Conformed, integrated business entities  
**Format:** Views  

- Combines refined data across one or more source systems
- Represents conformed business entities (facts, dimensions)
- Enforces consistent grain and business definitions
- Designed to scale to additional sources without rewriting downstream logic

This layer represents the canonical analytical model used across the organization.

**Example:**

### Marts
**Purpose:** Analytics-serving layer  
**Format:** Tables (materialized)  

- Materialized on a schedule (scheduled queries or stored procedures)
- Optimized for BI tools and ad-hoc analysis
- Contains aggregations and KPI-ready structures
- Balances data freshness with query performance

**Example:**

## View-Based Transformation Strategy
Layers 2–4 are implemented as views. Each materialization run for the marts layer always reflects the most
current upstream data available at execution time.

Benefits of this approach include:
- Clear separation of concerns
- Reduced duplication of transformation logic
- Faster iteration on business rules
- Simplified operational maintenance

## Scope of This Repository
This repository models a **single Sales domain and source system** end-to-end to demonstrate architectural
patterns, layer responsibilities, and design principles.

The structure, naming conventions, and layer contracts are intentionally designed to support additional
source systems (e.g., multiple CRMs or ERPs) without altering downstream consumption layers.

## Design Principles
- Transformation logic lives as close as possible to its appropriate layer
- Business definitions are enforced centrally and reused downstream
- Layers are additive and composable
- Performance optimization occurs at the serving layer, not the transformation layers
