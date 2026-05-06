module SalaryInsights
  class JobTitleStatsService
    def initialize(country:, job_title:)
      @country = country
      @job_title = job_title
    end

    def call
      employees = Employee.where(country: @country, job_title: @job_title)

      {
        job_title: @job_title,
        minimum_salary: employees.minimum(:salary),
        maximum_salary: employees.maximum(:salary),
        average_salary: employees.average(:salary)&.to_f,
        employee_count: employees.count
      }
    end
  end
end
