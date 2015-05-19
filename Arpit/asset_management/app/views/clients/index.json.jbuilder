json.array!(@clients) do |client|
  json.extract! client, :id, :name, :projects, :deleted_at
  json.url client_url(client, format: :json)
end
