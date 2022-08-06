class Like < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  has_one :question, through: :answer
  validates :user_id, uniqueness: { scope: :answer_id }
end
