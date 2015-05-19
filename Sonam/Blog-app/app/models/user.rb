class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blogs, dependent: :destroy

  #########Validations##############
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :city, presence: true
  validates :phone, presence: true
end
