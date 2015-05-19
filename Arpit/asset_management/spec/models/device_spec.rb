require "rails_helper"


describe Device do
  
  #Before Every test of Device we create one object of Device
  before(:each) do
    @device = FactoryGirl.create(:device)
  end
  ########

  ####### Validation Test by shoulda_matchers ##########
  ######################################################
  present_fields = [:device_identifier, :serial_number, :model_number, :device_category_id]
  present_fields.each {|x| it { should validate_presence_of(x) }}
  it { should validate_uniqueness_of :serial_number } 
  it { should allow_value("device1324").for(:device_identifier) }
  date = (DateTime.now - 1 ).to_date
  it { should allow_value(date).for(:purchase_date) }

  ####### Relations by shoulda_matchers ##################
  #######################################################
  belongs_tables = [:invoice, :vendor,:branch, :device_category, :employee,:client, :parent]
  belongs_tables.each {|x| it { should belong_to(x) }}

  have_many_tables = [:device_assignments, :transfers, :employees, :child_devices]
  have_many_tables.each {|x| it { should have_many(x) }}

  
  it { should accept_nested_attributes_for(:more_devices) }

  #### Test class methods with ( . ) 
  describe "Class methods" do
    it ".status" do
      expect(Device.status[@device.status.to_sym]).to eq("In Stock")
    end
  end

  ### Test object methods 
  describe "Object Methods" do
    it "#name" do
      expect(@device.name).to eq("Monitor - 123")
    end

  end
end