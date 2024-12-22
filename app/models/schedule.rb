class Schedule < ApplicationRecord
  belongs_to :doctor
  has_many :working_days

  validate :validate_working_days_limit

  private

  def validate_working_days_limit
    errors.add(:working_days, "can't be more than 7") if working_days.size > 7
  end
end
