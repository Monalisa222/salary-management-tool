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
      stats = SalaryInsights::JobTitleStatsService.new(
        country: params[:country],
        job_title: params[:job_title]
      ).call
      render json: { data: stats }
    else
      render json: { error: "No employees found for country #{params[:country]} and job title #{params[:job_title]}" }, status: :not_found
    end
  end

  def distribution
    employees = Employee.where(country: params[:country])

    if employees.exists?
      distribution = {
        '0-50000' => employees.where(salary: 0..50_000).count,
        '50001-100000' => employees.where(salary: 50_001..100_000).count,
        '100001-150000' => employees.where(salary: 100_001..150_000).count,
        '150001+' => employees.where('salary >= ?', 150_001).count
      }
      render json: { data: { country: params[:country], distribution: distribution } }
    else
      render json: { error: "No employees found for country #{params[:country]}" }, status: :not_found
    end
  end
end
