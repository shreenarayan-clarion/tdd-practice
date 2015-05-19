class Device < ActiveRecord::Base
 
  # Association
  belongs_to :invoice
  belongs_to :vendor
  belongs_to :branch
  belongs_to :device_category
  belongs_to :employee
  belongs_to :parent, class_name: "Device"
  belongs_to :client
  has_many :device_assignments
  has_many :transfers, as: :transferable, dependent: :destroy
  has_many :employees, through: :device_assignments
  has_many :child_devices, class_name: 'Device', foreign_key: :parent_id

  has_many :more_devices, :dependent => :destroy
  accepts_nested_attributes_for :more_devices, :allow_destroy => true


  # Validation
  validates :device_identifier, :serial_number, :model_number, :device_category_id,  presence: true
  validates :serial_number, uniqueness: true
  validate :check_purchase_date, :check_valid_status
  validates :device_identifier, format: { with: VALID_NAME }

  #Call Back
  before_save :update_child_devices
  before_update :check_lifetime_warranty
  after_update :release_resources

  # Constant for devices status #
  def self.status
    { instock: "In Stock", scrap: "Scrap", faulty: "Faulty", returned: "Returned", assigned: "Assigned" }
  end

  def name
    "#{device_identifier} - #{serial_number}"
  end

 # Constant for provider #
  def self.provider
    Client.active.map { |e| [e.name,e.id] }.unshift(['Clarion',''])
  end

  self.status.keys.each do |s|
    scope s.to_sym, -> { where(status: s) }
  end

  # scope to get unassigned devices
  scope :unassigned, -> { where(status: 'instock') }

  # scope to get parent devices
  scope :parent_devices, ->(*id) { active.where(parent_id: nil).where.not(id: id) }

  # scope to get childern devices
  scope :child_devices, ->(*id) { where(parent_id: id) }

  # Class method for search devices#
  def self.search(search)
    where(%q[ lower(device_identifier) LIKE :keyword OR model_number LIKE :keyword],:keyword=>"%#{search}%".downcase).active
  end

  def current_employee(on_date = Date.today)
    assignment_on_date(on_date).try(:employee) if self.status == 'assigned'
  end

  def assignment_on_date(on_date = Date.today)
    self.device_assignments.where("assign_date <= ?", on_date).order(assign_date: :desc, updated_at: :desc).first
  end

  def to_status
    Device.status[self.status.to_sym]
  end

  def self.test_uniquness(params)
    if params[:id].present?
      Device.where.not(id: params[:id]).where(serial_number: params[:serial_number]).present? ? false : true
    else
      Device.where(serial_number: params[:serial_number]).present? ? false : true
    end
  end

  def add_more_devices(more_device_params)
    more_device_params.values.each do |device_param|
      d = dup
      d.model_number = device_param[:model_number]
      d.serial_number = device_param[:serial_number]
      d.save
    end  if more_device_params
  end

  def assigned?
    self.device_assignments.where(unassign_date: nil).present?
  end

  private

  #Update child devices as per changes in parent device
  def update_child_devices
    if self.parent_id.blank? && !['assigned', 'instock'].include?(self.status)
      params_attr = {status: 'instock', parent_id: nil} 
    else
      params_attr = {status: self.status, parent_id: self.id}
    end
    self.child_devices.update_all(params_attr)
  end

  def check_lifetime_warranty
    if lifetime_warranty == true 
      self.warranry_year = nil  
      self.warranry_month= nil 
    end
  end

  def release_resources
    if deleted_at.present?
      device_assignments.where(unassign_date: nil).update_all(unassign_date: DateTime.now)
    end
  end

  def check_purchase_date
    errors.add(:purchase_date, "Purcharse Date can't be future") if self.purchase_date.present? && self.purchase_date.to_date > Date.today
  end

  #Check status validation as per parent device
  def check_valid_status
    if self.parent_id.present?
      errors.add(:parent_id, 'Assoicated Device is invalid') if self.child_devices.size > 0
      errors.add(:parent_id, 'Assoicated Device should be In-Stock or Assigned') unless ['instock', 'assigned'].include?(self.parent.status)
      errors.add(:status, 'Status should be equal to Assoicated Device') if self.status != self.parent.status
      errors.add(:branch_id, 'Branch should be as per Assoicated Device') if self.branch_id.present? && self.branch_id != self.parent.branch_id
    else
      if self.parent_id_was.present? && self.status == 'assigned'
        errors.add(:parent_id, "Assoicated Device can't be blank")   
        errors.add(:status, "Assigned status can't select without Assoicated Device")
      end
      errors.add(:status, "Assigned status is invalid") if self.status == 'assigned' && !self.assigned?
    end
  end
end
