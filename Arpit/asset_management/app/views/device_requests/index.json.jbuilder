json.array!(@device_requests) do |device_request|
  json.extract! device_request, :id, :title, :description, :device_category_id, :vendor_id, :on_date
  json.url device_request_url(device_request, format: :json)
end
