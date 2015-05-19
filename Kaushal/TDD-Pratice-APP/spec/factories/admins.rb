FactoryGirl.define do
  factory :super_admin, class: Admin do
    name Faker::Name.name
    email Faker::Internet.free_email
    password 'password'
    password_confirmation 'password'
    role 'super_admin'
    confirmed_at Time.now
    invitation_token nil
    invitation_accepted_at Time.now
  end

  factory :admin, class: Admin do
    name Faker::Name.name
    email Faker::Internet.free_email
    password 'password'
    password_confirmation 'password'
    role 'admin'
    confirmed_at Time.now
    invitation_token nil
    invitation_accepted_at Time.now    
  end
end
