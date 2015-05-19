class Product < ActiveRecord::Base

  validates :name, :image, presence: true
  validates :shopify_product_id, :base_price, presence: true, if: "parent_id.blank?"
  validates :name, length: { minimum: 0, maximum: 50 }, if: "name.present?"

  belongs_to :admin
  belongs_to :parent, class_name: 'Product'
  has_many :components, foreign_key: :parent_id, class_name: 'Product'
  has_many :product_images

  before_validation :set_default_parameter

  scope :child_products, -> { where('parent_id IS NOT NULL') }
  scope :parent_products, -> { where('parent_id IS NULL') }

  private

  def set_default_parameter
    if self.parent_id.present?
      self.shopify_product_id = self.parent.shopify_product_id
      self.base_price = self.parent.base_price
    end
  end
end
