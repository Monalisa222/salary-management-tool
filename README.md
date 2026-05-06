# Salary Management Tool

A full-stack salary management platform built for HR teams to manage employee salary records and view compensation insights across countries and job titles.

---

# Tech Stack

## Backend
- Ruby on Rails API
- PostgreSQL
- RSpec
- Kaminari

## Frontend
- React
- Vite
- Tailwind CSS
- Axios

---

# Features

## Employee Management
- Add employee
- View employees
- Update employee
- Delete employee

## Salary Insights
- Minimum salary by country
- Maximum salary by country
- Average salary by country
- Average salary by job title in a country
- Salary distribution by country

---

# Architecture

## Backend Structure

app/controllers/api/v1
app/services/employees
app/services/salary_insights
spec/models
spec/requests

## Frontend Structure

src/api
src/components
src/layouts
src/pages

-----------
# Running Backend

cd backend
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s

## Backend runs on

http://localhost:3000

------------

# Running Frontend

cd frontend
npm install
npm run dev

## Frontend runs on

http://localhost:5173

-----------

## Running Tests

cd backend
bundle exec rspec
