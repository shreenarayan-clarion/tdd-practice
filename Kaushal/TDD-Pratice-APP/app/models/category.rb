class Category < ActiveRecord::Base

  has_many :product_images
  belongs_to :admin

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :name, length: { minimum: 0, maximum: 50 }, if: "name.present?"
end
