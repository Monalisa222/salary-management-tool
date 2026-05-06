# Tradeoff Notes

## Rails API + React

Rails API was selected for fast backend development, strong ActiveRecord support, and clean REST API implementation.

React was selected for building a responsive HR dashboard with reusable UI components.

## PostgreSQL

A relational database is suitable because employee salary data is structured and analytics queries depend on filtering and aggregation.

## Service Objects

Service objects add a small amount of structure, but improve maintainability as the application grows.

## Kaminari Pagination

Pagination prevents loading all 10,000 employees into memory at once.

## Bulk Seed Insert

`insert_all` was used instead of `create!` loops for better performance.

Tradeoff:

- `insert_all` skips model callbacks and validations
- seed data must be generated carefully before insert

## Salary Distribution Metric

Salary distribution was added as an extra metric because HR Managers need to understand salary spread, not only average values.

## Query Normalization

Country and job title values are normalized to avoid inconsistent analytics caused by lowercase or uppercase input.