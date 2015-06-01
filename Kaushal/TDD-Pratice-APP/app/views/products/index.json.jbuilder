json.array!(@products) do |product|
  json.extract! product, :id, :id, :shopify_product_id, :name, :base_price, :image, :description, :active, :admin_id
  json.url product_url(product, format: :json)
end
