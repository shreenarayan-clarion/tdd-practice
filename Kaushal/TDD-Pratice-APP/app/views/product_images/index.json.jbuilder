json.array!(@product_images) do |product_image|
  json.extract! product_image, :id, :product_id, :category_id, :image_height, :image_width, :image_x, :image_y, :product_theme_id, :admin_id
  json.url product_image_url(product_image, format: :json)
end
