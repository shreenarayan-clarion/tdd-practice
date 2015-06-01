json.array!(@product_comps) do |product_comp|
  json.extract! product_comp, :id
  json.url product_comp_url(product_comp, format: :json)
end
