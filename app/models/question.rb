class Question < ApplicationRecord
  belongs_to :owner, calss_name: User, foreign_key: :user_id
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :likes, through: :answers
  default_scope -> { order(created_at: :desc) }
  
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
  
  def interested_by(user)
    Interest.find_by(user_id: user.id, question_id: id)
  end
end
