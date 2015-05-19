class Transfer < ActiveRecord::Base
  belongs_to :transferable, polymorphic: true
  belongs_to :from_location, class_name: "Branch", foreign_key: "from_location_id"
  belongs_to :to_location, class_name: "Branch", foreign_key: "to_location_id"
  belongs_to :transferee, class_name: "Employee"

  # Validations
  validates :from_location_id, :to_location_id, :transferable_type, :transferable_id, :transfer_date, :transferee, presence: true

  # Custom validation to validate transfer date
  validate :validate_transfer_date

  # scope to closer transfer date
  scope :closest_date, -> (t_id, t_type, id) { where(transferable_id: t_id).
                                               where(transferable_type: t_type).
                                               where('id NOT IN (?)', id).
                                               order(transfer_date: :desc) }

  # scope to get resources(Employee/Device)
  scope :latest_transfer, -> (t_id, t_type) {where(transferable_id: t_id, transferable_type: t_type).order(transfer_date: :desc).first}
  scope :resources, -> (resource) { where(transferable_type: resource).order(transfer_date: :desc) }

  def transferable_join_date
    self.transferable_type == 'Employee' ? self.transferable.join_date : self.transferable.purchase_date
  end

  private
    def validate_transfer_date
      max_device_assign_date = self.transferable.device_assignments.map(&:assign_date).max
      errors.add(:transfer_date, "Can't greater than last assignment date(#{max_device_assign_date})") if max_device_assign_date.present? && self.transfer_date.present? && self.transfer_date > max_device_assign_date
      if self.transferable_type == "Employee"
        errors.add(:transfer_date, "Can't transfer Employee before joining date #{self.transferable.join_date.to_date}") if self.transfer_date.to_date < self.transferable.join_date.to_date
      else
        errors.add(:transfer_date, "Can't transfer Device before purchase date #{self.transferable.purchase_date.to_date}") if self.transfer_date.to_date < self.transferable.purchase_date.to_date
      end
      if self.new?
        min_transfer_date =  Transfer.where(transferable: self.transferable, transferable_id: self.transferable_id).order(transfer_date: :desc).first.try(:transfer_date)
        min_transfer_date += 1 if min_transfer_date.present?
        max_transfer_date = Date.today
      else
        min_transfer_date = Transfer.closest_date(self.transferable_id, self.transferable_type, self.id).where('transfer_date < ?', self.transfer_date_was).first.try(:transfer_date)
        min_transfer_date += 1 if min_transfer_date.present?
        max_transfer_date = Transfer.closest_date(self.transferable_id, self.transferable_type, self.id).where('transfer_date > ?', self.transfer_date_was).last.try(:transfer_date) 
        max_transfer_date -= 1 if max_transfer_date.present?
      end
      min_date = min_transfer_date.present? ? min_transfer_date : self.transferable_join_date
      max_date = max_transfer_date.present? ? max_transfer_date : Date.today
      if min_date == max_date
        errors.add(:transfer_date, "#{self.transferable_type} must transfer onwords #{min_date.to_date-1}") if self.transfer_date < min_date || self.transfer_date > max_date
      else
        errors.add(:transfer_date, "#{self.transferable_type} must transfer between #{min_date.to_date} to #{max_date.to_date}") if self.transfer_date < min_date || self.transfer_date > max_date
      end
    end

end
