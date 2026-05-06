class EmployeeSearchQuery
  def initialize(scope: Employee.all, params: {})
    @scope = scope
    @params = params
  end

  def call
    employees = @scope

    employees = employees.where(country: @params[:country]) if @params[:country].present?
    employees = employees.where(job_title: @params[:job_title]) if @params[:job_title].present?

    employees
  end
end
