class Spot < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum :category, {
    coworking: 0,
    hotel: 1,
    library: 2,
    cafe: 3,
    family_restaurant: 4,
    lounge: 5
  }

  validates :name, presence: true
  validates :address, presence: true
  validates :category, inclusion: { in: categories.keys }

  validate :name_or_address_unique

  geocoded_by :address
  after_validation :geocode

  def name_or_address_unique
    return if name.blank? || address.blank?

    scope = Spot.where.not(id: id)

    if scope.where(name: name.strip).exists?
      errors.add(:name, "は既に登録されています")
    end

    if scope.where(address: address.strip).exists?
      errors.add(:address, "は既に登録されています")
    end
  end

  def category_i18n
    I18n.t("enums.spot.category.#{category}")
  end

  def favorites_count
    favorites.count
  end

  def weekly_favorites_count
    favorites.where(created_at: 1.week.ago..Time.current).count
  end
end
