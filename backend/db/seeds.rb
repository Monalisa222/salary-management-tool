first_names = File.readlines(
  Rails.root.join("db/seed_data/first_names.txt"),
  chomp: true
)

last_names = File.readlines(
  Rails.root.join("db/seed_data/last_names.txt"),
  chomp: true
)

countries = [ "India", "USA", "Canada", "Germany", "UK" ]

job_titles = [
  "Software Engineer",
  "Senior Software Engineer",
  "HR Manager",
  "Product Manager",
  "QA Engineer",
  "DevOps Engineer"
]

departments = [
  "Engineering",
  "HR",
  "Product",
  "QA",
  "Operations"
]

BATCH_SIZE = 1000
TOTAL_RECORDS = 10_000

now = Time.current

TOTAL_RECORDS.times.each_slice(BATCH_SIZE) do |batch|
  employees = batch.map do |index|
  first_name = first_names.sample
  last_name = last_names.sample
  job_title = job_titles.sample
  country = countries.sample

    {
      full_name: "#{first_name} #{last_name}",
      job_title: job_title.to_s.strip.titleize,
      country: country.to_s.strip.upcase,
      salary: rand(30_000..200_000),
      email: "employee#{index + 1}@example.com".downcase,
      department: departments.sample,
      joining_date: rand(5.years).seconds.ago.to_date,
      active: true,
      created_at: now,
      updated_at: now
    }
  end

  Employee.insert_all(employees)
end

puts "Seeded #{Employee.count} employees"
