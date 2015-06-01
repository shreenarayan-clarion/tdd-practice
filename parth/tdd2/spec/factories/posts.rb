FactoryGirl.define do
  factory :post do
    # title FFaker::Lorem.characters(10)
    sequence(:title) { |n| "test#{n}" }
    description { FFaker::Lorem.sentence }
  end

end
