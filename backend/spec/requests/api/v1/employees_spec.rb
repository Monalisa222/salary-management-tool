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

      body = JSON.parse(response.body)
      expect(body["data"]["full_name"]).to eq("John Doe")
      expect(body["data"]["job_title"]).to eq("Software Engineer")
      expect(body["data"]["country"]).to eq("USA")
      expect(body["data"]["salary"]).to eq("120000.0")
      expect(body["data"]["email"]).to eq("john.doe@example.com")
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

  describe "GET /api/v1/employees" do
    context "with pagination" do
      before do
        create_list(:employee, 15)
      end

      it "returns paginated list of employees" do
        get "/api/v1/employees", params: { page: 1, per_page: 10 }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body["data"].length).to eq(10)
        expect(body["meta"]["current_page"]).to eq(1)
        expect(body["meta"]["next_page"]).to eq(2)
        expect(body["meta"]["prev_page"]).to eq(nil)
        expect(body["meta"]["total_pages"]).to eq(2)
        expect(body["meta"]["total_count"]).to eq(15)
      end

      it "returns data when no params are provided" do
        get "/api/v1/employees"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body["data"].length).to eq(10)
        expect(body["meta"]["current_page"]).to eq(1)
        expect(body["meta"]["next_page"]).to eq(2)
        expect(body["meta"]["prev_page"]).to eq(nil)
        expect(body["meta"]["total_pages"]).to eq(2)
        expect(body["meta"]["total_count"]).to eq(15)
      end
    end

    context "with filtering" do
      it "filter employees by country and job_title" do
        create_list(:employee, 5, country: "USA", job_title: "Software Engineer")
        create_list(:employee, 5, country: "Canada", job_title: "Product Manager")

        get "/api/v1/employees", params: { country: "USA", job_title: "Software Engineer" }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body["data"].length).to eq(5)
        expect(body["data"].first["country"]).to eq("USA")
        expect(body["data"].first["job_title"]).to eq("Software Engineer")
      end
    end
  end

  describe "GET /api/v1/employees/:id" do
    let(:employee) { create(:employee) }

    it "returns the employee" do
      get "/api/v1/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      expect(body["data"]["id"]).to eq(employee.id)
      expect(body["data"]["full_name"]).to eq(employee.full_name)
      expect(body["data"]["job_title"]).to eq(employee.job_title)
      expect(body["data"]["country"]).to eq(employee.country)
      expect(body["data"]["salary"]).to eq(employee.salary.to_s)
      expect(body["data"]["email"]).to eq(employee.email)
    end

    it "returns not found for non-existent employee" do
      get "/api/v1/employees/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /api/v1/employees/:id" do
    let(:employee) { create(:employee) }
    let(:valid_attributes) do
      {
        full_name: "Jane Doe",
        job_title: "Senior Software Engineer",
        country: "USA",
        salary: 150000,
        email: "jane.doe@example.com"
      }
    end

    it "updates the employee" do
      put "/api/v1/employees/#{employee.id}", params: { employee: valid_attributes }

      expect(response).to have_http_status(:ok)
      employee.reload
      expect(employee.full_name).to eq(valid_attributes[:full_name])
      expect(employee.job_title).to eq(valid_attributes[:job_title])
      expect(employee.country).to eq(valid_attributes[:country])
      expect(employee.salary).to eq(valid_attributes[:salary])
      expect(employee.email).to eq(valid_attributes[:email])
    end

    it "returns not found for non-existent employee" do
      put "/api/v1/employees/999999", params: { employee: valid_attributes }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/v1/employees/:id" do
    let!(:employee) { create(:employee) }

    it "deletes the employee" do
      expect {
        delete "/api/v1/employees/#{employee.id}"
      }.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns not found for non-existent employee" do
      delete "/api/v1/employees/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
