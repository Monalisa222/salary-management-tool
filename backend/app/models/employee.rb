class Employee < ApplicationRecord
  validates :full_name, presence: true
  validates :job_title, presence: true
  validates :country, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :normalize_attributes

  private

  def normalize_attributes
    self.full_name = full_name.strip.titleize
    self.job_title = job_title.strip.titleize
    self.country = country.strip.upcase
    self.email = email.strip.downcase
  end
end
