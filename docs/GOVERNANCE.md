# Data Governance & Standards

This document defines the governance rules that ensure consistency, correctness, and long-term maintainability
of the analytics warehouse.

Governance is enforced through **layer contracts, naming standards, and ownership rules**, rather than
tool-specific controls.

---

## Naming Conventions

- All schemas, tables, views, and columns use `snake_case`
- Layer intent is explicit and visible through schema and object naming
- Object names are descriptive, not abbreviated

### Layer Prefixes

Each layer uses a consistent prefix to make intent immediately clear:

- `raw_*`   — source-of-truth ingestion
- `stg_*`   — structural normalization
- `ref_*`   — source-specific business shaping
- `core_*`  — conformed analytical entities
- `mart_*`  — analytics-serving datasets

This ensures layer responsibility is always visible in queries, lineage tools, and downstream BI systems.

---

## Grain & Modeling Rules

- Every fact-like dataset has an explicitly defined grain
- Grain is documented at the model level (file-level comments)
- Core layer models remain at the **lowest meaningful analytical grain**
- Consumption-focused aggregations are introduced in the marts layer

This prevents accidental double-counting and inconsistent metric interpretation.

---

## Metric Ownership & Definition

- Business metrics are defined **once** and reused downstream
- Metric logic lives in the refined layer and is integrated downstream for enterprise use.
- Marts may aggregate metrics but do not redefine business meaning

This design prevents metric drift across dashboards, reports, and teams.

---

## Change Management

Changes are intentionally absorbed at the earliest appropriate layer:

- Source schema changes are handled in the staging layer
- Source-specific business rule changes occur in the refined layer
- Cross-source or enterprise logic changes occur in the core layer
- Marts are kept as stable as possible to avoid breaking downstream consumers

This approach minimizes blast radius when upstream systems change.

---

## Data Quality Expectations

Each layer enforces data quality appropriate to its responsibility:

- **Staging**
  - Type enforcement
  - Null handling
  - Basic structural validation

- **Refined**
  - Business validity checks
  - Status normalization
  - Flag and indicator consistency

- **Core**
  - Conformed definitions
  - Stable grain enforcement

- **Marts**
  - Assume upstream correctness
  - Focus on performance and usability

Data quality is treated as a **design concern**, not a downstream reporting fix.

---

## Governance Philosophy

- Governance is embedded in structure, not enforced retroactively
- Contracts between layers are explicit and stable
- Correctness is prioritized over convenience
- Performance optimization does not compromise business meaning

