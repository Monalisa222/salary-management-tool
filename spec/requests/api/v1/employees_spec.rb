require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  describe "POST /api/v1/employees" do
    let(:valid_attributes) do
      {
        full_name: "John Doe",
        job_title: "Software Engineer",
        country: "USA",
        salary: 120000,
        email: "john.doe@example.com"
      }
    end

    it "creates a new employee" do
      expect {
        post "/api/v1/employees", params: { employee: valid_attributes }
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end
end
