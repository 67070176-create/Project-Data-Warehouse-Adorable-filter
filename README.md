# Project-Data-Warehouse-Adorable-filter

2rd data ingestion
# Data Ingestion & Seed Documentation (Person 2)

## Overview
This directory contains reference lookup datasets managed via `dbt seed`, alongside ingestion validation results.

## Seed Files
- **`promotions.csv`**: Contains campaign discount mappings.
- **`stores.csv`**: Maps store IDs to city locations.

## Verification Commands
Run these commands inside your dbt Docker container:

```bash
# Populate reference tables into PostgreSQL
dbt seed --full-refresh

# Inspect loaded seed data
dbt show --select promotions
dbt show --select stores

# Run quality checks on seeds
dbt test --select seed:*