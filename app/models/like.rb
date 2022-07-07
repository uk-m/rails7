class Like < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  has_one :question, through: :answer
  validates_uniqueness_of :answer_id, scope: :user_id
end
