require 'spec_helper'

feature "User creation", type: :features do

  background do
    visit "/"
    click_link "New User"
    sleep(2)
  end

  scenario "With valid attributes" do

    within('.new_user') do
      fill_in "user_name", with: Faker::Name.name
      fill_in "user_city", with: Faker::Address.city
      fill_in "user_email", with: Faker::Internet.email
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
    end

    click_button "Create User"
    expect(page).to have_text("User was successfully created.")
  end

  scenario "With invalid information" do

    within('.new_user') do
      fill_in "user_name", with: Faker::Name.name
    end

    click_button "Create User"
    expect(page).to have_css("#error_explanation")
    expect(page).to have_text("Email can't be blank")
  end
end