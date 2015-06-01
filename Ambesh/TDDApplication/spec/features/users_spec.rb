require 'spec_helper'

feature "Regestration", type: :features do

  background do
    visit "/"
    click_link "Registration"
  end
  
  it "regestration with valid data" do
    within('.new_user') do
      fill_in "user_email", with: Faker::Internet.email
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
    end
    click_button "Sign up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  it "regestration with invalid data" do
    within('.new_user') do
      fill_in "user_email", with: Faker::Internet.email
    end
    click_button "Sign up"
    expect(page).to have_text("Password can't be blank")
  end
end

feature "Regestration", type: :features do
  
  let(:user) { FactoryGirl.create(:user) }
  
  background do
    visit "/"
    click_link "Login"
  end

  it "should allow a registered user to sign in" do
    within('.new_user') do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
    end
    click_button "Log in"
    page.should have_content("Signed in successfully.")
  end

  it "should not allow an unregistered user to sign in" do
    within('.new_user') do
      fill_in "user_email", with: "wrong@email.id"
      fill_in "user_password", with: user.password
    end
    click_button "Log in"
    page.should_not have_content("Signed in successfully.")
  end
end