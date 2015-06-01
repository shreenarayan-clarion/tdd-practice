FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end
FactoryGirl.define do
  factory :user, :class => 'User' do
    name "Sapna Prajapati"
    email "sapna.prajapati@clariontechnologies.co.in"
    password "p@ssw0rd"
    admin false
  end  
  factory :user_new, class: User do
    name { FFaker::Name.name }
    email 
    password "p@ssw0rD"
    admin false 
  end
  factory :invalid_user, class: User do
    name ""
    email "sapna.prajapati@clariontechnologies.co.in"
    password "p@s"
    admin false
  end
end
