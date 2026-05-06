# Architecture Notes

## System Overview

The application is split into two parts:

- Backend: Ruby on Rails API
- Frontend: React with Vite

## Backend Responsibilities

- Employee CRUD APIs
- Salary insight APIs
- Validation and error handling
- Pagination
- Data normalization
- Seed generation

## Frontend Responsibilities

- HR dashboard
- Employee table
- Add/Edit/Delete employee UI
- Salary insights dashboard
- API error handling

## Backend Structure

```text
app/controllers/api/v1
app/services/employees
app/services/salary_insights
app/models
spec/requests
spec/models