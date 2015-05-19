json.array!(@quotations) do |quotation|
  json.extract! quotation, :id, :identifier, :device_request_id, :on_date
  json.url quotation_url(quotation, format: :json)
end
