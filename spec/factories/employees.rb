FactoryBot.define do
  factory :employee do
    full_name { "MyString" }
    job_title { "MyString" }
    country { "MyString" }
    salary { "9.99" }
    email { "MyString" }
    department { "MyString" }
    joining_date { "2026-05-06" }
    active { false }
  end
end
