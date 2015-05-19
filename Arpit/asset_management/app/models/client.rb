class Client < ActiveRecord::Base

	# Relations 
	has_many :devices

  # Validations
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9,\s]*\z/ }
  validates :projects, format: { with: /\A[a-zA-Z0-9,\s]*\z/ }, allow_blank: true
  validate :validate_assosiated_devices, :on => :update

  private

  def validate_assosiated_devices
  	if deleted_at.present?
  		assets_size = devices.active.size 
  		errors.add(:name,"Please release all the devices of client.") if assets_size > 0 		
  	end	
  end

end
