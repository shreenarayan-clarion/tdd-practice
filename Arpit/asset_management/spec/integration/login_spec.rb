require 'rails_helper'

RSpec.describe "home page", :type => :request do
  before(:all) do
    user = FactoryGirl.create(:user)
  end
  it "displays the user's email after successful login" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_email', :with => 'parth@example.com'
      fill_in 'user_password', :with => 'test1234'
    end
    click_button 'Sign In'
    expect(page).to have_content 'parth@example.com'
    expect(page).to have_content 'Sign Out'
  end
end