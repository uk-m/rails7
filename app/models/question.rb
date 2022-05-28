class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
end
