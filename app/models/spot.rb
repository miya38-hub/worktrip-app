class Spot < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  enum :category, {
    coworking: 0,
    hotel: 1,
    library: 2
  }

  validates :name,presence: true
  validates :category, inclusion: { in: categories.keys }
  validates :address, presence: true
end
