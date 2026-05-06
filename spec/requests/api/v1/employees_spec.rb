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

    it "returns errors for invalid attributes" do
      invalid_params = {
        employee: {
          full_name: "",
          job_title: "",
          country: "",
          salary: -1000,
          email: "invalid-email"
        } 
      }

      post "/api/v1/employees", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)

      expect(body["errors"]).to include("Full name can't be blank")
      expect(body["errors"]).to include("Job title can't be blank")
      expect(body["errors"]).to include("Country can't be blank")
      expect(body["errors"]).to include("Salary must be greater than 0")
      expect(body["errors"]).to include("Email is invalid")
    end
  end
end
