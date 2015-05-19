FactoryGirl.define do
  factory :product do
    shopify_product_id "2342342"
    name 'Single Popsocket'
    base_price 323.23
    image Faker::Avatar.image
    description 'Testing'
    active true
    admin_id 1
  end

end
