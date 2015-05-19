class Branch < ActiveRecord::Base

  # Associations
  has_many :employees
  has_many :devices
  belongs_to :parent, class_name: "Branch"
  has_many :transfers

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME }
  validate :validate_assosiated_devices_and_employee, :on => :update

  private
  def validate_assosiated_devices_and_employee
  	if deleted_at.present?
  		branch_assets_employees_size = devices.active.size + employees.active.size
  		errors.add(:name,"You can not delete this branch") if branch_assets_employees_size > 0 		
  	end	
  end

end
