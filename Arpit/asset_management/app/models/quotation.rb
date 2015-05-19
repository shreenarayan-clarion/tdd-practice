class Quotation < ActiveRecord::Base

  # Relationships
  belongs_to :device_request
  has_many :device_transactions
  has_many :uploads, as: :attachable
  has_one :purchase_order
  accepts_nested_attributes_for :purchase_order, :allow_destroy => true
  accepts_nested_attributes_for :device_transactions, :allow_destroy => true
  accepts_nested_attributes_for :uploads, :allow_destroy => true
  attr_accessor :vendor_id

  # Validations
  validates :device_request_id, :on_date, presence: true
  validate :valid_dates

  # Callbacks
  before_create :generate_identifier
  after_destroy :nullify_transactions


  def update_transaction(quotation_datas)
    quotation_datas.each do |transaction_id, quotation_value|
      transaction = DeviceTransaction.find(transaction_id)
      transaction.update_attributes(quotation_id: id, quotation_title: quotation_value['quotation_title'], quotation_description: quotation_value['quotation_description'], quotation_price: quotation_value['quotation_price'], quotation_quantity: quotation_value['quotation_quantity'])
    end
  end

  def edit?
    self.purchase_order.blank?
  end


  private

  def generate_identifier
    if Quotation.exists?
      identifier = Quotation.last.identifier
      identifier = (identifier.gsub("QOT", "").to_i + 1).to_s.prepend("QOT")
    else
      identifier = "QOT1"
    end
    self.identifier = identifier
  end

  # Custom Validation method for restrict date of invoice not to be less then current date and purchase order date
  def valid_dates
    device_request = DeviceRequest.find(device_request_id)
    current_date = Date.today
    if self.on_date.present?
      self.errors.add :on_date, "Quotation date can't be future" if self.on_date > current_date
      self.errors.add :on_date, "Quotation date should be onwards #{device_request.on_date}" if self.on_date < device_request.on_date
    end
  end

  # Nullify quotations data from transactions table
  def nullify_transactions
    device_transactions.update_all(quotation_id: nil, quotation_title: nil, quotation_description: nil, quotation_price: nil, quotation_quantity: nil, quotation_notes: nil)
  end

end
