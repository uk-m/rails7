class User < ApplicationRecord
  has_secure_password
  
  validates :name,
    presence: true,
    length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { maximum: 30 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true
  validates :password, length: { minimum: 8 }
end
