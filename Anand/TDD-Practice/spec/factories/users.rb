FactoryGirl.define do
  factory :user do
    name  "Rails Application"
    city  "Ahmedabad"
    email "Anand.Tripathi@gmail.com"
    password "8character"
    password_confirmation "8character"
  end

  factory :invalid_user, class: :user do
    name ""
    email "wrong_email"
    password "8character"
    password_confirmation "8character"
  end
end