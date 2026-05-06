class Api::V1::SalaryInsightsController < ApplicationController
  def country
    employees = Employee.where(country: params[:country])

    if employees.exists?
      stats = SalaryInsights::CountryStatsService.new(params[:country]).call
      render json: { data: stats }
    else
      render json: { error: "No employees found for country #{params[:country]}" }, status: :not_found
    end
  end

  def job_title
    employees = Employee.where(
      country: params[:country],
      job_title: params[:job_title]
    )

    if employees.exists?

      render json: {
        data: {
          country: params[:country],
          job_title: params[:job_title],
          average_salary: employees.average(:salary)&.to_f,
          employee_count: employees.count
        }
      }, status: :ok
    else
      render json: { error: "No employees found for country #{params[:country]} and job title #{params[:job_title]}" }, status: :not_found
    end
  end
end
