json.array!(@devices) do |device|
  json.extract! device, :id, :invoice_id, :vendor_id, :serial_number, :model_number, :ip_address, :status, :status_date, :branch_id, :warranty, :provider, :client_name, :devices_category_id, :parent_id, :employee_id, :deleted_at
  json.url device_url(device, format: :json)
end
