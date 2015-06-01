# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day_old_post do
    content '1 day old'
    created_at 1.day.ago
  end
  
  factory :latest_post do
    content 'New Post'
    created_at 1.hour.ago
  end
end
