require 'spec_helper' 
RSpec.describe "Login Page", :type => :request do

  it "displays the user's email after successful login" do    
    visit '/users'
  end
end