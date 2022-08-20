class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :content, presence: true, length: { minimum: 5 }
  
  def liked_by(user)
    Like.find_by(user_id: user.id, answer_id: id)
  end
end
