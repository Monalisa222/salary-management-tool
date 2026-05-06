# Salary Management Tool - Planning Notes

## Goal

Build a minimal yet usable salary management tool for an HR Manager managing 10,000 employees.

## Core Features

- Add employee
- View employees
- Update employee
- Delete employee
- View salary insights by country
- View average salary by job title in a country
- View salary distribution as an additional HR metric

## Main Entities

### Employee

Fields:

- full_name
- email
- job_title
- country
- salary
- department
- joining_date
- active

## Engineering Approach

The application was built incrementally using TDD.

Each major feature followed:

1. Red - failing test first
2. Green - minimum implementation
3. Refactor - improve structure and maintainability

## Architecture Decisions

- Rails API backend for clean REST APIs
- React frontend for interactive HR dashboard
- PostgreSQL relational database
- Service objects for business logic
- Request specs for API behavior
- Kaminari for pagination
- Bulk insert for seeding 10,000 employees