class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  mount_uploader :image, image_uploader
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :liked_answers, through: :likes, source: :answer
  has_many :interests, dependent: :destroy
  has_many :interested_questions, through: :interests, source: :question
  
  validates :name, presence: true, length: { maximum: 25 }
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 40 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "画像ファイルを選択してください" },
                    size: { less_than: 5.megabytes,　message: "画像は5MBまでです" }
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end
  
  def session_token
    remember_digest || remember
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  private
  
    def downcase_email
      self.email = email.downcase
    end
end
