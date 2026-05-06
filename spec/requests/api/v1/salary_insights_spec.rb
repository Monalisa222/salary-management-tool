require 'rails_helper'

RSpec.describe 'Api::V1::SalaryInsights', type: :request do
  describe 'GET /api/v1/salary_insights/country' do
    before do
      create(:employee, country: 'India', salary: 50000, email: 'a@example.com')
      create(:employee, country: 'India', salary: 70000, email: 'b@example.com')
      create(:employee, country: 'India', salary: 90000, email: 'c@example.com')

      create(:employee, country: 'USA', salary: 200000, email: 'd@example.com')
    end

    it 'returns salary insights for a country' do
      get '/api/v1/salary_insights/country', params: {
        country: 'India'
      }

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['data']['country']).to eq('India')
      expect(body['data']['minimum_salary']).to eq('50000.0')
      expect(body['data']['maximum_salary']).to eq('90000.0')
      expect(body['data']['average_salary']).to eq(70000.0)
      expect(body['data']['employee_count']).to eq(3)
    end
  end
end
