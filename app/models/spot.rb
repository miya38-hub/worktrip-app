class Spot < ApplicationRecord
  belongs_to :user

  enum :category, {
    coworking: 0,
    hotel: 1,
    library: 2
  }

  validates :name,presence: true
  validates :address, presence: true
end
