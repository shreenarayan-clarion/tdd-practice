class Admin < ActiveRecord::Base

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable

  has_many :own_users, foreign_key: :created_by_id, class_name: 'Admin'
  has_many :categories
  has_many :product_images
  has_many :products
  belongs_to :created_by, class_name: 'Admin'
  enum role: {super_admin: 1, admin: 2, affiliate: 3}

  validates :name, presence: true
  validates :name, length: { minimum: 0, maximum: 50 }, if: "name.present?"
  validates :email, format: {with: /\A([\w-]+(?:\.[\w-]+)*([\+]?[0-9]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)\Z/ } 
  #validates :password, format: {with: /\A[a-zA-Z0-9\S]{8,}\Z/ }

  def role?(type)
    self.role == type
  end
end
