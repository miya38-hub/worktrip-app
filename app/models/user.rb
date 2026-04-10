class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :profile_image
  
  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.guest
    find_or_create_by!(email_address: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
