class User < ActiveRecord::Base
	has_many :posts

	validates :name, presence: true, length: { maximum: 50 }
	validates :lastname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

  validates :password,  presence: true, confirmation: true, length: { minimum: 6 }
  has_secure_password

  before_save { email.downcase! }
  before_create :create_remember_token
end
