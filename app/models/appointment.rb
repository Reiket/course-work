class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :working_hour

  enum status: { pending: 0, confirmed: 1, completed: 2 }

  validates :status, presence: true
  validates :time, presence: true
  validates :working_hour_id, presence: true
  validates :doctor_id, presence: true
  validates :patient_id, presence: true
  # validates :validate_doctor_schedule

  scope :visited, -> { where('time <= ?', Time.now) }
  scope :unvisited, -> { where('time >= ?', Time.now) }

  def validate_doctor_schedule
    if doctor.present? && date.present? && time.present?
      unless doctor.available_at?(date, time)
        errors.add(:base, "Цей час не доступний для прийому лікарем")
      end
    end
  end

  def timeout_check
    update(status: 'completed') if self.time <= Time.now
  end
end
