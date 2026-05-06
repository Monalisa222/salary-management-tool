class Employee < ApplicationRecord
  validates :full_name, presence: true
  validates :job_title, presence: true
  validates :country, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save :normalize_email

  private

  def normalize_email
    self.email = email.downcase.strip
  end
end
