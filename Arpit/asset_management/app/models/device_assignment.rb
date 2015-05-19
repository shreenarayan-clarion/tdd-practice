class DeviceAssignment < ActiveRecord::Base

  after_save :update_device
  after_destroy :update_device

  belongs_to :device
  belongs_to :employee

  has_one :branch, through: :device
  has_one :device_category, through: :device

  validates :assign_date, :device_id, :employee_id, :branch_id, :device_category_id, presence: true
  validate :check_assign_date, if: 'assign_date.present? && device_id.present? && employee_id.present?'
  
  attr_accessor :device_category_id, :branch_id
  
  scope :assign_emp_on_date, -> (device_id, on_date) {where("device_id = ? and assign_date <= ? and unassign_date IS NULL", device_id, on_date.to_date).order(assign_date: :desc, updated_at: :desc)}
  scope :to_device, -> (device_id) {where("device_id = ?", device_id).order(assign_date: :desc, updated_at: :desc)}

  def self.create_assignment(device_id, employee_id, on_date = Date.today)
    if assign_emp_on_date(device_id, on_date).first.try(:employee_id) != employee_id
      record = find_or_create_by(employee_id: employee_id, device_id: device_id, assign_date: on_date.to_date)
      record.update(updated_at: DateTime.now, unassign_date: nil) if record.created_at != DateTime.now
      DeviceAssignment.where("device_id = ? AND id NOT IN (?) AND unassign_date IS NULL", device_id, record.id).update_all(unassign_date: DateTime.now)
    end
  end

  #Kaushal Kishor Sharma
  #Find out min assignment and unassignment date of device assignment as per previous assignment
  def min_assignment_dates
    assignments = DeviceAssignment.where("device_id = ? AND assign_date <= ? and unassign_date IS NOT NULL", self.device_id, (self.new? ? Date.today : self.assign_date_was)).where.not(id: self.id).order(assign_date: :desc, updated_at: :desc)
    unassignments = DeviceAssignment.where("device_id = ? AND unassign_date <= ? and unassign_date IS NOT NULL", self.device_id, (self.new? ? Date.today : self.unassign_date_was||(self.assign_date_was+1).to_time-1)).where.not(id: self.id).order(unassign_date: :desc, updated_at: :desc)
    min_assign = [(assignments.blank? ? self.device.purchase_date : assignments.first.assign_date), self.employee.join_date].max
    min_unassign = [(unassignments.blank? ? self.assign_date.to_time : unassignments.first.unassign_date), self.assign_date.to_time].max
    [min_assign.to_date, min_unassign.to_time]
  end

  #Kaushal Kishor Sharma
  #Find out max assignment and unassignment date of device assignment as per previous assignment
  def max_assignment_dates
    assignments = DeviceAssignment.where("device_id = ? AND assign_date >= ?", self.device_id, (self.new? ? Date.today : self.assign_date_was)).where.not(id: self.id).order(assign_date: :desc, updated_at: :desc)
    unassignments = DeviceAssignment.where("device_id = ? AND (unassign_date >= ? OR unassign_date IS NULL)", self.device_id, (self.new? ? Date.today : self.unassign_date_was||self.assign_date)).where.not(id: self.id).order(unassign_date: :asc, updated_at: :desc)
    max_assign = assignments.blank? ? Date.today : assignments.first.assign_date
    max_unassign = self.unassign_date_was.blank? || unassignments.blank? ? Time.now : unassignments.first.unassign_date||unassignments.select{|s| s.unassign_date.present?}.first.try(:unassign_date)||(max_assign == Date.today ? Time.now : (max_assign+1).to_time-1)
    [max_assign.to_date, max_unassign.to_time]
  end

  private

  #Kaushal Kishor Sharma
  #Manage all basic validation of assignment
  def check_assign_date
    if ['instock', 'assigned'].include?(self.device.try(:status))
      max_assignment = max_assignment_dates
      min_assignment = min_assignment_dates 
      max_assign_date, min_assign_date = max_assignment.first, min_assignment.first
      max_unassign_date, min_unassign_date = max_assignment.last, min_assignment.last

      if self.unassign_date.present?
        errors.add(:unassign_date, "Unassign date can't be future") if self.unassign_date > Time.now
        errors.add(:unassign_date, "Unassign date must be on or after assign date") if self.assign_date.to_time > self.unassign_date.to_time
        errors.add(:unassign_date, "Unassign date must be between #{min_unassign_date} to #{max_unassign_date}") if (min_unassign_date > self.unassign_date || self.unassign_date > max_unassign_date) && min_assign_date <= max_assign_date     
      else
        errors.add(:unassign_date, "Unassign date can't be blank") if self.unassign_date_was.present? && max_unassign_date.to_i != DateTime.now.to_i
      end
      errors.add(:device_id, "Device must be active") if (self.new? || (self.device_id != self.device_id_was)) && self.inactive?
      errors.add(:employee_id, "Employee must be active") if (self.new? || (self.employee_id != self.employee_id_was)) && self.inactive?
      errors.add(:assign_date, "Assign date can't be future") if self.assign_date.to_date > Date.today
      errors.add(:assign_date, "Assign date must be onwords Employee joining date(#{self.employee.join_date.to_date})") if self.employee_id.present? && self.assign_date.to_date < self.employee.join_date
      errors.add(:assign_date, "Assign date must be onwords purcharse date(#{self.device.purchase_date})") if self.assign_date.to_date < self.device.purchase_date.to_date
      if max_assign_date == min_assign_date && min_assign_date != self.assign_date
        errors.add(:assign_date, "Assign date must be on or after #{min_assign_date}")
      else
        errors.add(:assign_date, "Assign date must be between #{min_assign_date} to #{max_assign_date}") if min_assign_date > self.assign_date.to_date || self.assign_date.to_date > max_assign_date
      end
    elsif self.device_id.present?
      errors.add(:device_id, "Only In Stock or Assigned devices assign to employee")
    end
  end

  #Kaushal Kishor Sharma
  #Manage device status on update or delete of assignment of device
  def update_device
    assignments = DeviceAssignment.to_device(self.device_id).where(unassign_date: nil)
    if assignments.present?
      device_params = {status: 'assigned', employee_id: assignments.first.employee_id}
    else
      device_params = {status: 'instock', employee_id: nil}
    end
    self.device.update(device_params)
    Device.find(self.device_id_was).update(status: 'instock', employee_id: nil) if self.device_id != self.device_id_was && self.device_id_was.present?
  end
end
