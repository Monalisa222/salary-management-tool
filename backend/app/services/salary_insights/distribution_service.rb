module SalaryInsights
  class DistributionService
    def initialize(country:)
      @country = country
    end

    def call
      employees = Employee.all
      employees = Employee.where(country: @country) if @country.present?

      {
        country: @country || "All Countries",
        distribution: {
          "0-50000" => employees.where(salary: 0..50_000).count,
          "50001-100000" => employees.where(salary: 50_001..100_000).count,
          "100001-150000" => employees.where(salary: 100_001..150_000).count,
          "150001+" => employees.where("salary >= ?", 150_001).count
        }
      }
    end
  end
end
