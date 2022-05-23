class Question < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_many :answers, dependent: :destroy
  
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
end
