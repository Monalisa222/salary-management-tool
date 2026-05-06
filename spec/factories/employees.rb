FactoryBot.define do
  factory :employee do
    full_name { Faker::Name.name }
    job_title { Faker::Job.title }
    country { Faker::Address.country }
    salary { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
    email { Faker::Internet.unique.email }
    department { Faker::Commerce.department }
    joining_date { Faker::Date.backward(days: 365) }
    active { true }
  end
end
