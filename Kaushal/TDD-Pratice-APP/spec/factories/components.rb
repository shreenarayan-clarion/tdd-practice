FactoryGirl.define do
  factory :component, class: Product do
    name 'Platform'
    image Faker::Avatar.image
    description 'Testing'
    active true
    admin_id 1
    parent_id 1
  end

end
