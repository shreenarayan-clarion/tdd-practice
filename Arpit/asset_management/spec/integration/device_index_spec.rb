require 'rails_helper'
require 'authentication_helpers'


RSpec.describe "Devices listing", :type => :request do
  include AuthenticationHelpers
  before(:each) do
    @current_user = FactoryGirl.create(:user) 
    login(@current_user)
  end
  let(:device) { FactoryGirl.create(:device) }
  let(:deactivated_device) { FactoryGirl.create(:deactivated_device)}

  scenario "logged in user access devices listing page" do
    expect(page).to have_content 'parth@example.com'
    visit "/devices"
    expect(page).to have_content ' Devices'
  end

  # it "displays list of devices" do
  #   #post "/users/sign_in", :username => user.email, :password => user.password
  #   visit '/devices'
  # end
end