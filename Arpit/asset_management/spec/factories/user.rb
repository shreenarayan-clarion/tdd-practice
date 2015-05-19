# This will guess the Device class
FactoryGirl.define do

  factory :branch , class: Branch do
    name 'ADC'
  end

  factory :employee, class: Employee do
    branch
    first_name "Device1"
    last_name "Cat1 Description"
    email "parth@example.com"
    employee_number "740"
    designation DESIGNATIONS[2]
    technology TECHNOLOGIES[1]
    department DEPARTMENTS[1]
    join_date Random.rand(5..500).days.ago
  end

  factory :user, class: User do
    employee
    email "parth@example.com"
    password "test1234"
    password_confirmation "test1234"
  end
  #employee1 = Employee.create!(first_name: "Parth", last_name: "Mewada", 
  #email: "parth@example.com", employee_number: 740, designation: DESIGNATIONS[2], 
  #technology: TECHNOLOGIES[1], department: DEPARTMENTS[1], branch_id: branch1.id, join_date: Random.rand(5..500).days.ago, join_date: rand(30..600).days.ago)
  #user1 = User.create!(email: employee1.email, password: "test1234", password_confirmation: "test1234", employee_id: employee1.id)
end