class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  validates :content, presence: true, length: { minimum: 5 }
end
