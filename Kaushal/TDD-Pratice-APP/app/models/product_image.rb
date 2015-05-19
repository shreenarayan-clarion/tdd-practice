class ProductImage < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :image, :presence => true,
  :content_type => { :content_type => ["image/jpeg","image/png"] },
  :size => { :in => 0..5.megabytes }
  validates :product, presence: true

  belongs_to :product
  belongs_to :admin
  belongs_to :category
end
