class Employee < ActiveRecord::Base

  # Assosiations
  belongs_to :branch
  has_many :devices
  has_one :user
  has_many :device_assignments
  has_many :transfers, as: :transferable, dependent: :destroy

  # Validations
  uniqueness_msg = "has already been taken"
  uniqueness_fields = {"skype_id"=>"Skype ID","pandian_id"=>"Pandian Name","wiki_id"=>"Wiki ID","sapience_id"=>"Sapian ID","helpdesk_id"=>"Halp Desk ID","pm_tool_id"=>"PM Tool ID"}
  validates :first_name, :last_name, :email, :employee_number,:branch_id, presence: true
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,message: "Please enter valid email address" }
  validates :first_name, :last_name, format: { with: VALID_NAME }
  validates :employee_number, uniqueness: {message: "Employee ID #{uniqueness_msg}"}
  validates :email, uniqueness: {message: "Email #{uniqueness_msg}"}
  validate :valid_dates
  
  # CallBack
  after_update :release_resources

  # Uniqueness validations for all the fields
  uniqueness_fields.each do |key,value|
    validates key.to_sym ,uniqueness: {message: "#{value} #{uniqueness_msg}"},allow_blank: true
  end

  # Scopes
  scope :non_user_employees, -> {includes(:user).active.where('users.employee_id' => nil)}
  scope :branch_employees, -> (branch_id, emp_id) { where(branch_id: branch_id).where.not(id: emp_id)}
  scope :for_branch, -> (branch_id) { where(branch: branch_id) }


  # Method used for name combining first name and last name
  def name
    [ first_name, last_name ].compact.join(' ').titleize
  end

  # This method will give current devices of as per assignment date for those assigned devices
  def cureent_devices
    device_assignments.joins(:device).where(["assign_date <= ?", Date.today]).where("status = 'assigned'")
  end

  # Custom Validation method for restrict resig date to be always greater then join date
  def valid_dates

    if resign_date.present? && resign_date < join_date
      self.errors.add :resign_date, 'Resign Date must be after join date'
    end
  end

  private

  def release_resources
    if deleted_at.present?
      device_assignments.where(unassign_date: nil).update_all(unassign_date: DateTime.now) 
      devices.update_all(status: 'instock')
      user.try(:update,{employee_id: nil, deleted_at: Time.now})
    end
  end

end
