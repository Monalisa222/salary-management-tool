class Api::V1::SalaryInsightsController < ApplicationController
  def country
    employees = Employee.where(country: params[:country])

    if employees.exists?
      render json: {
        data: {
          country: params[:country],
          minimum_salary: employees.minimum(:salary),
          maximum_salary: employees.maximum(:salary),
          average_salary: employees.average(:salary)&.to_f,
          employee_count: employees.count
        }
      }
    else
      render json: { errors: ["No employees found for country #{params[:country]}"] }, status: :not_found
    end
  end
end
