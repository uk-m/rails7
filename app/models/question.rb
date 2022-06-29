class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :saves
  has_many :saved_users, through: :saves, source: :user
  default_scope -> { order(created_at: :desc) }
  
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
  
  def saved_by(user)
    Save.find_by(user_id: user.id, question_id: id)
  end
end
