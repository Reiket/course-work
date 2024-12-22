class Rating < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :score, presence: true, inclusion: { in: 1..5, message: "Повинно бути від 1 до 5" }
  validates :review, presence: true, length: { maximum: 255 }
end
