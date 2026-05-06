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

      expect(body['data']['country']).to eq('INDIA')
      expect(body['data']['minimum_salary']).to eq('50000.0')
      expect(body['data']['maximum_salary']).to eq('90000.0')
      expect(body['data']['average_salary']).to eq(70000.0)
      expect(body['data']['employee_count']).to eq(3)
    end
  end

  describe 'GET /api/v1/salary_insights/job_title' do
    before do
      create(:employee, job_title: 'Software Engineer', salary: 80000, email: 'a@example.com', country: 'USA')
      create(:employee, job_title: 'Software Engineer', salary: 120000, email: 'b@example.com', country: 'USA')
      create(:employee, job_title: 'Product Manager', salary: 110000, email: 'c@example.com', country: 'USA')
      create(:employee, job_title: 'Software Engineer', salary: 90000, email: 'd@example.com', country: 'India')
      create(:employee, job_title: 'Software Engineer', salary: 250000, email: 'e@example.com', country: 'USA')
    end

    it 'returns salary insights for a job title' do
      get '/api/v1/salary_insights/job_title', params: {
        country: 'USA',
        job_title: 'Software Engineer'
      }

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['data']['job_title']).to eq('Software Engineer')
      expect(body['data']['average_salary']).to eq(150000.0)
      expect(body['data']['employee_count']).to eq(3)
    end
  end

  describe 'GET /api/v1/salary_insights/distribution' do
    before do
      create(:employee, salary: 50000, email: 'a@example.com', country: 'USA')
      create(:employee, salary: 70000, email: 'b@example.com', country: 'USA')
      create(:employee, salary: 90000, email: 'c@example.com', country: 'USA')
    end

    it 'returns salary distribution for a country' do
      get '/api/v1/salary_insights/distribution', params: {
        country: 'USA'
      }

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['data']['country']).to eq('USA')
      expect(body['data']['distribution']).to eq({
        '0-50000' => 1,
        '50001-100000' => 2,
        '100001-150000' => 0,
        '150001+' => 0
      })
    end
  end
end
