FactoryGirl.define do
  factory :product_image do
    product_id 1 
    category_id 1
    image Rack::Test::UploadedFile.new("#{Rails.root.to_s}/public/default_images/Featured_single_SIDE.76.png", 'image/png')
    admin_id 1
  end

end
