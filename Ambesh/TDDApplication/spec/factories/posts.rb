FactoryGirl.define do
  factory :post do
    title "Ambesh Kumar Mehta"
    content Faker::Name.title
    user_id 1
  end
  factory :invalid_post, class: Post do
    title ""
    content Faker::Name.title
  end	
end