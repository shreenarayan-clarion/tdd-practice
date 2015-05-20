FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :new_user, class: :user do
    sequence(:name) { |n| "Arvind#{n}" }
    sequence(:email) { |n| "arvind.vyas#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :micropost do
    content "First Post"
  end

end