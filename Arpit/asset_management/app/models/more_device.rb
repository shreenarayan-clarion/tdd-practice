class MoreDevice < Device
	belongs_to :device
  attr_accessor :model_number , :serial_number, :device_id
  validates :serial_number, :model_number, uniqueness: true
end