class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  
  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true
end
