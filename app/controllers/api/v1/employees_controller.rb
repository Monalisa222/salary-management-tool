class Api::V1::EmployeesController < ApplicationController
  def index
    employees = Employee.order(created_at: :desc).page(page).per(per_page)
    render json: { data: employees, meta: pagination_dict(employees) }
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: { data: employee }, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary, :email, :department, :joining_date, :active)
  end

  def page
    value = params.fetch(:page, 1).to_i
    value.positive? ? value : 1
  end

  def per_page
    value = params.fetch(:per_page, 10).to_i
    value = 10 unless value.positive?
    [value, 100].min
  end

  def pagination_dict(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end

end
