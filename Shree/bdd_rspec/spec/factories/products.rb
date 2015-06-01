# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    price 1   
  end
  
  factory :invalid_product, class: Product do
    name nil
    price 1
  end
end
