require 'spec_helper' 

feature "Add Users" do  
  scenario "With valid attributes" do
    visit users_url 
    expect{ click_link 'New User' 
            fill_in 'user_name', with: "John Smith" 
            fill_in 'user_email', with: "johnsmith@gmail.com"
            fill_in 'user_password', with: "password1234"
            click_button "Save" 
            }.to change(User,:count).by(1) 
    page.should have_content "User was successfully created."
    page.should have_content "John Smith" 
    page.should have_content "johnsmith@gmail.com" 
  end  
end


# require 'spec_helper'

# feature "User creation", type: :features do

#   background do
#     visit "/"
#     click_link "New User"
#     sleep(2)
#   end

#   scenario "With valid attributes" do

#     within('New User') do
#       fill_in "user_name", with: Faker::Name.name
#       fill_in "user_email", with: Faker::Internet.email
#       fill_in "user_password", with: "password"      
#     end

#     click_button "Save"
#     expect(page).to have_text("User was successfully created.")
#   end

#   # scenario "With invalid information" do

#   #   within('.new_user') do
#   #     fill_in "user_name", with: Faker::Name.name
#   #   end

#   #   click_button "Create User"
#   #   expect(page).to have_css("#error_explanation")
#   #   expect(page).to have_text("Email can't be blank")
#   # end
# end