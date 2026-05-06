require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    subject { build(:employee) }

    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it do
      should validate_numericality_of(:salary)
        .is_greater_than(0)
    end

    it "is invalid with a negative salary" do
      employee = build(:employee, salary: -1000)
      expect(employee).not_to be_valid
      expect(employee.errors[:salary]).to include("must be greater than 0")
    end

    it "is invalid with a zero salary" do
      employee = build(:employee, salary: 0)
      expect(employee).not_to be_valid
      expect(employee.errors[:salary]).to include("must be greater than 0")
    end
  end

  describe "callbacks" do
    it "normalizes email before saving" do
      employee = build(:employee, email: "John.Doe@example.com")
      employee.save
      expect(employee.email).to eq("john.doe@example.com")
    end
  end

  describe "database indexes" do
    it { should have_db_index(:country) }
    it { should have_db_index(:job_title) }
    it { should have_db_index(:salary) }
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index([ :country, :job_title ]) }
  end
end
