FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    address "Kormangala,banglore,karnataka-560095"
    contact_no Faker::Number.number(10)
    password Faker::Internet.password
  end
end
