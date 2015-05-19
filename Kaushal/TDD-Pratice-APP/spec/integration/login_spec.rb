require 'rails_helper'

RSpec.describe "Login Page", :type => :request do
  before(:all) do
    @admin = FactoryGirl.create(:super_admin)
  end
  it "displays the user's email after successful login" do
    visit '/user/admins/sign_in'
    within("#new_admin") do
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content @admin.email
    expect(page).to have_content 'Signed in successfully.'
  end
end