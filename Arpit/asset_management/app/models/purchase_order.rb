class PurchaseOrder < ActiveRecord::Base

  # Associations
  belongs_to :quotation
  has_many :device_transactions
  has_one :invoice
  has_many :vendors, through: :device_transactions
  has_many :uploads, as: :attachable
  accepts_nested_attributes_for :device_transactions, :allow_destroy => true
  accepts_nested_attributes_for :invoice, :allow_destroy => true
  accepts_nested_attributes_for :uploads, :allow_destroy => true
  attr_accessor :vendor_id

  # Transactions nested attributes
  accepts_nested_attributes_for :device_transactions, :allow_destroy => true

  # Validations
  validates :on_date, :quotation_id, presence: true
  validate :validate_on_date

  # Callback
  before_create :generate_identifier
  after_destroy :nullify_transactions

  # To create transactions after purchase order creation
  def create_transactions(transactions)
    transactions.values.each do |val|
      device_transaction = DeviceTransaction.find(val[:id])
      device_transaction.update(val.merge(purchase_order_id:self.id))
    end
  end

  # To set purchase order attributes
  def set_purchase_order(device_transactions)
    device_transactions.each do |t|
      t.purchase_title = t.quotation_title
      t.purchase_description = t.quotation_description
      t.purchase_price = t.quotation_price
      t.purchase_quantity = t.quotation_quantity
    end
  end

  # To null transactions after purchase order destroy
  def nullify_transactions
    t = DeviceTransaction.where(purchase_order: self.id)
    t.update_all(purchase_order_id: nil, purchase_title: nil, purchase_description: nil, purchase_quantity: nil, purchase_price: nil, purchase_notes: nil)
  end

  def edit?
    self.invoice.blank?
  end

  private

  # To generate unique identifier everytime considering last identifier
  def generate_identifier
    if PurchaseOrder.exists?
      identifier = PurchaseOrder.last.identifier
      identifier = (identifier.gsub("PO", "").to_i + 1).to_s.prepend("PO")
    else
      identifier = "PO1"
    end
    self.identifier = identifier
  end

  # To validate purchase order date that should be after quotation date and before today's date
  def validate_on_date
    quotation = Quotation.find(self.quotation_id)
    current_date = Date.today
    if self.on_date.present?
      self.errors.add :on_date, "Purchase order date can't be future" if self.on_date > current_date
      self.errors.add :on_date, "Purchase order date should be onwards #{quotation.on_date}" if self.on_date < quotation.on_date
    end
  end
end
