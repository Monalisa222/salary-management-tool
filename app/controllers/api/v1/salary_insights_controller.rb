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
      distribution = SalaryInsights::DistributionService.new(country: params[:country]).call
      render json: { data: distribution }
    else
      render json: { error: "No employees found for country #{params[:country]}" }, status: :not_found
    end
  end
end
