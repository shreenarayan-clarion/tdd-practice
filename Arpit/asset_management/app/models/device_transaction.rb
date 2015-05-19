class DeviceTransaction < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :device_category
  belongs_to :device_request
  belongs_to :purchase_order
  belongs_to :quotation

  before_save :update_invoice, if: "self.quotation_id.present?"
  
  #Validations
  # validates_presence_of :quotation_title#, scope: [:device_request_id, :vendor_id], message: "Title cant be blank"

  validates_format_of :request_title,:invoice_title,:purchase_title,:quotation_title, with: VALID_NAME, message: "Title is not valid."
  validates_uniqueness_of :request_title, case_sensitive: false, scope: [:device_request_id, :vendor_id], message: "Title should be unique", allow_blank: true
  validates_uniqueness_of :quotation_title, case_sensitive: false, scope: [:quotation_id,:vendor_id], message: "Title should be unique", allow_blank: true
  validates_uniqueness_of :purchase_title, case_sensitive: false, scope: [:purchase_order_id,:vendor_id], message: "Title should be unique", allow_blank: true
  validates_uniqueness_of :invoice_title, case_sensitive: false, scope: [:invoice_id,:vendor_id], message: "Title should be unique",allow_blank: true
  validates_length_of :request_title, :quotation_title, :purchase_title, :invoice_title, maximum: 35, message: "Title shoude be less than 35 character.", allow_blank: true
  validates_length_of :request_description, :quotation_description, :purchase_description, :invoice_description, maximum: 255, message: "Description shoude be less than 255 character.", allow_blank: true
  validates_length_of :quotation_notes, :purchase_notes, :invoice_notes, maximum: 255, message: "Notes shoude be less than 255 character.", allow_blank: true
  validates_numericality_of :request_quantity, :invoice_quantity,:purchase_quantity,:quotation_quantity, greater_than: 0, less_than_or_equal_to: 1000, only_integer: true, message: "Quantity shoude be between 0 to 1000", allow_blank: true
  validates_numericality_of :invoice_price, :purchase_price, :quotation_price, greater_than_or_equal_to: 0, only_integer: true, message: "Price should be possitive value", allow_blank: true

  # validation_fields = {"request_quantity"=>"Request Quantity","invoice_quantity"=>"Invoice Quantity"}
  # validation_fields.each do |key,value|
  #   validates_numericality_of key.to_sym,  greater_than: 0, less_than_or_equal_to: 1000, only_integer: true, :message => "Quantity shoude be between 1 to 1000"
  # end

  # Calculate subtotal
  def purchase_subtotal
    (self.purchase_quantity.to_f * self.purchase_price.to_f).round(2)
  end

  def quotation_subtotal
    (self.quotation_quantity.to_f * self.quotation_price.to_f).round(2)
  end

   def update_invoice
    self.invoice_title = self.purchase_title
    self.invoice_description = self.purchase_description
    self.invoice_quantity = self.purchase_quantity
  end

end
