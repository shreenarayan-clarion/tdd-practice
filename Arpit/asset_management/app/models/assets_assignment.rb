class AssetsAssignment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :employee

  scope :assign_emp_on_date, -> (asset_id, on_date) {where("asset_id = ? and assign_date <= ?", asset_id, on_date.to_date).order(assign_date: :desc, updated_at: :desc)}

  def self.create_assignment(asset_id, employee_id, on_date = Date.today)
    if assign_emp_on_date(asset_id, on_date).first.try(:employee_id) != employee_id
      record = find_or_create_by(employee_id: employee_id, asset_id: asset_id, assign_date: on_date.to_date)
      record.update(updated_at: DateTime.now) if record.created_at != DateTime.now
   end
  end

  def branch
    self.asset.try(:branch)
  end
end

