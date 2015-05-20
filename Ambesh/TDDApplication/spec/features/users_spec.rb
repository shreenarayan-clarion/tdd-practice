require 'spec_helper'

feature "User creation", type: :features do

  background do
    visit "/"
    click_link "Sign up"
  end

  scenario "Regestration with valid data" do
    within('.new_user') do
      fill_in "user_email", with: Faker::Internet.email
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
    end
    click_button "Sign up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "Regestration with invalid data" do
    within('.new_user') do
      fill_in "user_email", with: Faker::Internet.email
    end
    click_button "Sign up"
    expect(page).to have_text("Password can't be blank")
  end

  feature "User creation", type: :features do
    # need to write for sign in
  end
end