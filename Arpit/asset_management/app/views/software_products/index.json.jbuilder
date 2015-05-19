json.array!(@software_products) do |software_product|
  json.extract! software_product, :id, :name, :description, :assets_category_id, :version, :license, :license_no
  json.url software_product_url(software_product, format: :json)
end
