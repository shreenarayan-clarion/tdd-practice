FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    city Faker::Address.city
    phone Faker::Number.number(10)
    password Faker::Internet.password
  end
end
