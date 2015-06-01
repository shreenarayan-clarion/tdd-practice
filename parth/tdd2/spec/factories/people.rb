FactoryGirl.define do
  factory :person do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    factory :person_with_posts do |person|
      posts { create_list :post, 3 }
    end
  end

end
