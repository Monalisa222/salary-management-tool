module SalaryInsights
  class JobTitleStatsService
    def initialize(country:, job_title:)
      @country = country
      @job_title = job_title
    end

    def call
      employees = Employee.all
      employees = Employee.where(country: @country) if @country.present?
      employees = Employee.where(job_title: @job_title) if @job_title.present?

      {
        country: @country || "All Countries",
        job_title: @job_title || "All Job Titles",
        minimum_salary: employees.minimum(:salary),
        maximum_salary: employees.maximum(:salary),
        average_salary: employees.average(:salary)&.to_f,
        employee_count: employees.count
      }
    end
  end
end
