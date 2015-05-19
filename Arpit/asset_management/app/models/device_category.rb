class DeviceCategory < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  belongs_to :parent, class_name: "DeviceCategory"
  has_many :devices
  has_many :software_products
  
  # Validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME }
  validates :description, presence: true, format: { with: VALID_DESCRIPTION }
  validate :validate_assosiated_devices_and_sw, :on => :update

  # Parent Device Categories
  scope :parent_device_categories, ->(*id) { active.where(parent_id: nil).where.not(id: id) }

  private

  def validate_assosiated_devices_and_sw
  	if deleted_at.present?
  		cat_sw_and_assets_size = devices.active.size + software_products.active.size   
  		errors.add(:name,"You can not delete this category") if cat_sw_and_assets_size > 0 		
  	end	
  end

end
