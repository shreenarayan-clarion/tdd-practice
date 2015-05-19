json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :transferable_id, :transferable_type, :from_location, :to_location, :transfer_date, :transferee
  json.url transfer_url(transfer, format: :json)
end
