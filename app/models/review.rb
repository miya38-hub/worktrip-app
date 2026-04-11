class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :rating, presence: true

  validates :rating, :wifi_rating, :power_rating,
            :quietness_rating, :workability_rating,
            numericality: {in: 1..5}, allow_nil: true
end
