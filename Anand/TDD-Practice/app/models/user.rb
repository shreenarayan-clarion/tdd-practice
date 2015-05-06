class User < ActiveRecord::Base
  #########Associations#############
  has_many :posts, dependent: :destroy

  #########Validations##############
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :city, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

  ##########callback methods#########
  before_save { email.downcase! }

end
