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
  end

  describe "callbacks" do
    it "normalizes email before saving" do
      employee = build(:employee, email: "John.Doe@example.com")
      employee.save
      expect(employee.email).to eq("john.doe@example.com")
    end
  end
end
