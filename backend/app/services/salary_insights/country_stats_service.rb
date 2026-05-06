module SalaryInsights
  class CountryStatsService
    def initialize(country)
      @country = country
    end

    def call
      employees = Employee.all
      employees = Employee.where(country: @country) if @country.present?

      {
        country: @country || "All Countries",
        minimum_salary: employees.minimum(:salary),
        maximum_salary: employees.maximum(:salary),
        average_salary: employees.average(:salary)&.to_f,
        employee_count: employees.count
      }
    end
  end
end
