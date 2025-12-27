# Data Governance & Standards

This document defines the governance rules that ensure consistency, correctness,
and long-term maintainability of the analytics warehouse.

Governance is enforced through **architectural contracts, layer responsibilities,
and naming standards**, rather than tool-specific controls.

These rules apply uniformly across all brands, source systems, and domains
modeled within the warehouse.

---

## Naming Conventions

- All schemas, tables, views, and columns use `snake_case`
- Layer intent is explicit and visible through schema and object naming
- Object names are descriptive and business-oriented, not abbreviated

### Layer Prefixes

Each layer uses a consistent prefix to make responsibility immediately clear:

- `raw_*` — source-of-truth ingestion
- `stg_*` — structural normalization
- `ref_*` — brand-level business shaping
- `core_*` — cross-brand, conformed analytical entities
- `mart_*` — analytics-serving datasets

This ensures layer responsibility is always visible in queries,
lineage tools, and downstream BI systems.

---

## Grain & Modeling Rules

- Every fact-like dataset has an explicitly defined grain
- Grain is documented at the model level (file-level comments)
- **Core layer models remain at the lowest meaningful analytical grain**
- **Consumption-focused aggregations are introduced only in the marts layer**

These rules prevent accidental double-counting and ensure consistent
metric interpretation across brands and tools.

---

## Metric Ownership & Definition

- Business metrics are defined once and reused downstream
- **Metric logic lives in the refined layer at the brand level**
- Metrics are integrated across brands in the core layer
- Marts may aggregate metrics but do not redefine business meaning

This design prevents metric drift while allowing brands to evolve
independently within a stable enterprise framework.

---

## Change Management

Changes are intentionally absorbed at the earliest appropriate layer:

- Source schema changes are handled in the staging layer
- Brand-specific business rule changes occur in the refined layer
- Cross-brand or enterprise logic changes occur in the core layer
- Marts are kept as stable as possible to avoid breaking downstream consumers

This approach minimizes blast radius when upstream systems or brands change.

---

## Data Quality Expectations

Each layer enforces data quality appropriate to its responsibility:

### Staging
- Type enforcement
- Null handling
- Basic structural validation

### Refined
- Business validity checks
- Status normalization
- Flag and indicator consistency

### Core
- Conformed definitions
- Stable grain enforcement
- Cross-brand consistency

### Marts
- Assume upstream correctness
- Focus on performance, usability, and accessibility

Data quality is treated as a **design responsibility**, not a downstream
reporting fix.

---

## Governance Philosophy

- Governance is embedded in structure, not enforced retroactively
- Contracts between layers are explicit, stable, and reviewable
- Correctness is prioritized over convenience
- Performance optimization never compromises business meaning

