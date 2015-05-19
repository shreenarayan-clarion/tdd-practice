json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :identifier, :purchase_order_id, :on_date
  json.url invoice_url(invoice, format: :json)
end
