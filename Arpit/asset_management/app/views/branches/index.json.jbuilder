json.array!(@branches) do |branch|
  json.extract! branch, :id, :name, :parent_id, :deleted_at
  json.url branch_url(branch, format: :json)
end
