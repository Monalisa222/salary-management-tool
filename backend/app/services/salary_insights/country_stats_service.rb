module SalaryInsights
  class CountryStatsService
    def initialize(country)
      @country = country
    end

    def call
      employees = Employee.where(country: @country)

      {
        country: @country,
        minimum_salary: employees.minimum(:salary),
        maximum_salary: employees.maximum(:salary),
        average_salary: employees.average(:salary)&.to_f,
        employee_count: employees.count
      }
    end
  end
end
