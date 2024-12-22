class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { patient: 0, doctor: 1 }, _suffix: :role

  has_one :patient
  has_one :doctor

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
end
