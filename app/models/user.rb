class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :spots, dependent: :destroy

  has_one_attached :profile_image
  
  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end
