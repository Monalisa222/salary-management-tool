class Api::V1::SalaryInsightsController < ApplicationController
  def country
    stats = SalaryInsights::CountryStatsService.new(normalize_country).call
    render json: { data: stats }
  end

  def job_title
    employees = Employee.where(
      country: normalize_country,
      job_title: normalize_job_title
    )

    if employees.exists?
      stats = SalaryInsights::JobTitleStatsService.new(
        country: normalize_country,
        job_title: normalize_job_title
      ).call
      render json: { data: stats }
    else
      render json: { error: "No employees found for country #{normalize_country} and job title #{normalize_job_title}" }, status: :not_found
    end
  end

  def distribution
    distribution = SalaryInsights::DistributionService.new(country: normalize_country).call
    render json: { data: distribution }
  end

  def normalize_country
    params[:country].to_s.strip.upcase
  end

  def normalize_job_title
    params[:job_title].to_s.strip.titleize
  end
end
