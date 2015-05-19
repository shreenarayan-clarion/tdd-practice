require "rails_helper"

RSpec.describe DevicesController, :type => :controller do
    
  # This will let user to be created for the device controller
  let(:user) { FactoryGirl.create(:user) }
  let(:device) { FactoryGirl.create(:device) }
  let(:deactivated_device) { FactoryGirl.create(:deactivated_device)}

  # This section will create a user and get sign in for every tests for the controller 
  before(:each) do
    sign_in :user, user
  end

  # This is a controller method index
  describe "GET #index" do 

    it "populates active devices" do
      get :index
      expect(assigns(:devices)).to match_array([device])
    end

    it "populates deactivated devices" do
      get :index, deleted: 'true'
      expect(assigns(:devices)).to match_array([deactivated_device])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template("index")
    end

  end 
  
  # This method handles show method which requires object to be created and passed on 
  # id will be device
  describe "GET #show" do 
    it "assigns the requested device to @device" do
      get :show, id: device
      expect(assigns(:device)).to match(device)
    end

    it "renders the :show template" do
      get :show, id: device
      expect(response).to render_template("show")
    end
  end 
end