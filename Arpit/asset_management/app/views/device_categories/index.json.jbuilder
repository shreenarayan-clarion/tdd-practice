json.array!(@assets_categories) do |assets_category|
  json.extract! assets_category, :id, :name, :description, :parent_id
  json.url assets_category_url(assets_category, format: :json)
end
