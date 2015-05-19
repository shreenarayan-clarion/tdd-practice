require 'rails_helper'

feature "Device Index" do
  let(:user) { FactoryGirl.create(:user) }
  let(:device) { FactoryGirl.create(:device) }
  let(:deactivated_device) { FactoryGirl.create(:deactivated_device)}

  scenario "logged in user access devices listing page" do
    page.set_rack_session(user_id: user.id)
    visit "/devices"
    expect(page).to have_content("Hi, parth@example.com")
  end

  # it "displays list of devices" do
  #   #post "/users/sign_in", :username => user.email, :password => user.password
  #   visit '/devices'
  # end
end