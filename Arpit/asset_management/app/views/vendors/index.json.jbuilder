json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :name, :email, :address, :city, :state, :contact_number, :fax_number, :mobile_number, :website, :deleted_at
  json.url vendor_url(vendor, format: :json)
end
