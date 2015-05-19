class Invoice < ActiveRecord::Base

	# Relations
  belongs_to :purchase_order
  has_many   :device_transactions
  has_many :uploads, as: :attachable
  accepts_nested_attributes_for :device_transactions, :allow_destroy => true
  accepts_nested_attributes_for :uploads, :allow_destroy => true
  
  # Validations
  validates :purchase_order_id, :on_date, presence: true
  validates :purchase_order_id,  uniqueness: true
  validate :valid_dates

  # Callback
  before_create :generate_identifier
  after_destroy :nullify_transactions
   
  private 

  # This method will generate unique identifier everytime considering last identifier 
  def generate_identifier
    if Invoice.exists?
      identifier = Invoice.last.identifier
      identifier = (identifier.gsub("INV", "").to_i + 1).to_s.prepend("INV")
    else
      identifier = "INV1"
    end
    self.identifier = identifier
  end

  # Custom Validation method for restrict date of invoice not to be less then current date and purchase order date
  def valid_dates
    purchase_order = PurchaseOrder.find(purchase_order_id)
    current_date= Date.today
    if self.on_date.present? 
      self.errors.add :on_date, "Invoice date can't be future" if self.on_date > current_date
      self.errors.add :on_date, "Invoice date should be onwards #{purchase_order.on_date}" if self.on_date < purchase_order.on_date
    end
  end

  # Nullify Invoice data from transactions table
  def nullify_transactions
    device_transactions.update_all(invoice_id: nil, invoice_title: nil, invoice_description: nil, invoice_price: nil, invoice_quantity: nil, invoice_notes: nil)
  end
 
end
