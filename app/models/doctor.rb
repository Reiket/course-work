class Doctor < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :appointments
  has_many :ratings
  has_one :schedule

  validates :name, presence: true, length: { maximum: 255 }
  validates :surname, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true
  validates :position, presence: true, length: { maximum: 255 }
  validates :experience, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :satisfied_patients_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  def refresh_satisfied_clients
    self.update(satisfied_patients_count: 0)

    self.ratings.each do |rate|
      self.update(satisfied_patients_count: satisfied_patients_count + 1) if rate.score > 3
    end
  end
end
