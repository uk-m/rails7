class User < ApplicationRecord
  has_secure_password
  
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 20 },
    format: {
      with: /\A[a-z0-9]+\z/,
      message: 'は小文字英数字で入力してください'
    }
  validates :password,
    length: { minimum: 8 }
end
