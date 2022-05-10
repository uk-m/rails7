class User < ApplicationRecord
  has_secure_password
  
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 20 }
  validates :password,
    length: { minimum: 8 }
end
