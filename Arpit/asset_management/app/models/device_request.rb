class DeviceRequest < ActiveRecord::Base
  belongs_to :device_category
  belongs_to :vendor
  has_many :uploads, as: :attachable
  has_many :quotations
  has_many :device_transactions, dependent: :destroy
  has_many :vendors, through: :device_transactions
  has_many :requested_transactions, -> { where device_transactions: { parent_id: nil } }, class_name: 'DeviceTransaction' 
  attr_accessor :vendor_ids
  accepts_nested_attributes_for :quotations, :allow_destroy => true
  accepts_nested_attributes_for :requested_transactions, :allow_destroy => true
  accepts_nested_attributes_for :device_transactions, :allow_destroy => true
  accepts_nested_attributes_for :uploads, :allow_destroy => true
  

  #Call Back
  before_create :generate_identifier
  after_create :create_relevant_records

  #Validations
  validates :on_date, presence: true
  validate :validate_transactions
  validate :validate_request_date

  def update_relevant_records
    vendor_ids = (self.vendor_ids||[]).reject{|s| s.blank?}
    transations = requested_transactions
    new_transactions = []
    transations.each do |rt|
      parent_id = nil
      vendor_ids.each do |vendor_id|
        t_obj = rt.dup
        t_obj.vendor_id = vendor_id
        t_obj.parent_id = parent_id
        t_obj.save(validate: false)
        parent_id = t_obj.id if vendor_ids.first == vendor_id
        new_transactions << t_obj
      end
    end
    self.device_transactions.where.not(id: new_transactions.map(&:id)).delete_all
  end

  def edit?
    self.quotations.blank?
  end

  private

  def generate_identifier
    if DeviceRequest.exists?
      identifier = DeviceRequest.last.identifier
      identifier = (identifier.gsub("REQ", "").to_i + 1).to_s.prepend("REQ")
    else
      identifier = "REQ1"
    end
    self.identifier = identifier
  end

  def create_relevant_records
    vendor_ids = (self.vendor_ids||[]).reject{|s| s.blank?}
    new_transactions = self.device_transactions.where(vendor_id: nil)
    vendor_ids.each do |vendor_id|
      if vendor_ids.last == vendor_id
        new_transactions.update_all(vendor_id: vendor_id)
      else
        new_transactions.each do |t|
          t_obj = t.dup
          t_obj.vendor_id = vendor_id
          t_obj.parent_id = t.id
          t_obj.save(validate: false)
        end
      end
    end      
  end

  def validate_transactions
    request_titles = requested_transactions.map(&:request_title)
    if request_titles.size != request_titles.uniq.size
      titles = []
      requested_transactions.each do |dt|
        dt.valid?
        if titles.include?(dt.request_title)
          dt.errors.add(:request_title, "Title should be unique")
        end
        titles << dt.request_title
      end
      errors.add(:base, "Title should be unique")
    end
  end

  def validate_request_date
    errors.add(:on_date, "Request Date can't be future") if self.on_date.present? && self.on_date.to_date > Date.today
  end
end
