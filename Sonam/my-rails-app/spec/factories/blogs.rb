FactoryGirl.define do
  factory :blog do
    title "Sonam shah"
    content Faker::Name.title
    user_id 1
  end
  factory :invalid_blog, class: Blog do
    title ""
    content Faker::Name.title
  end	
end
