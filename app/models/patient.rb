class Patient < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :appointments
  has_many :ratings
  belongs_to :user

  enum gender: { male: 0, female: 1}, _suffix: :gender

  validates :name, presence: true, length: { minimum: 2 }
  validates :surname, presence: true
  validates :birthday, presence: true
  validates :residence, presence: true
  validates :phone_number, presence: true
  validates :gender, presence: true
  validates :user_id, presence: true

  validate :validate_age

  private

  def validate_age
    if birthday.present? && birthday > (Date.today - 12.years)
      errors.add(:birthday, "Вам повинно бути більше 12 років!")
    end
  end
end
