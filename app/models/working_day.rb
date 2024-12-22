class WorkingDay < ApplicationRecord
  belongs_to :schedule
  has_many :working_hours

  enum status: { workday: 0, day_off: 1 }

  def toggle_status
    if workday?
      update(status: :day_off)
    elsif day_off?
      update(status: :workday)
    end
  end
end
