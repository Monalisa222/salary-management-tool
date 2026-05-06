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
end
