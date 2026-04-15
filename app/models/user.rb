class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot

  has_one_attached :profile_image

  before_create :set_active_default

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.guest
    find_or_create_by!(email_address: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      user.is_active = true
    end
  end

  def favorited?(spot)
    favorites.exists?(spot_id: spot.id)
  end
  
  private

  def set_active_default
    self.is_active = true if is_active.nil?
  end

end