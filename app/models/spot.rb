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

  # ========================
  # 検索
  # ========================
  scope :search_by_word, ->(word) {
    where("spots.name LIKE ?", "%#{word}%") if word.present?
  }

  scope :filter_by_category, ->(category) {
    where(category: category) if category.present?
  }

  scope :filter_by_region, ->(region) {
    where("spots.address LIKE ?", "%#{region}%") if region.present?
  }

  scope :filter_by_wifi, ->(wifi) {
    where(wifi: wifi == "1") if wifi.present?
  }

  scope :filter_by_power, ->(power) {
    where(power_supply: power == "1") if power.present?
  }

  # ========================
  # カウント
  # ========================
  scope :with_counts, -> {
    left_joins(:favorites, :comments)
      .select("
        spots.*,
        COUNT(DISTINCT favorites.id) AS favorites_count,
        COUNT(DISTINCT comments.id) AS comments_count
      ")
      .group("spots.id")
  }

  # ========================
  # ソート
  # ========================
  scope :sort_spots, ->(sort) {
    case sort
    when "favorites"
      order("favorites_count DESC")
    when "comments"
      order("comments_count DESC")
    else
      order(created_at: :desc)
    end
  }

  # ========================
  # カスタムメソッド
  # ========================
  def favorites_count
    self[:favorites_count] || favorites.count
  end

  def weekly_favorites_count
    favorites.where(created_at: 1.week.ago..Time.current).count
  end

  def name_or_address_unique
    return if name.blank? || address.blank?

    scope = Spot.where.not(id: id)

    errors.add(:name, "は既に登録されています") if scope.where(name: name.strip).exists?
    errors.add(:address, "は既に登録されています") if scope.where(address: address.strip).exists?
  end

  def category_i18n
    I18n.t("enums.spot.category.#{category}")
  end
end