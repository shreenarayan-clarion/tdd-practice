require 'rails_helper'

describe User do
  
  before do
    @user =  FactoryGirl.create(:user)    
  end
  
  subject { @user }

  it { should respond_to(:name) }
  it { is_expected.to respond_to(:name) }  ## Latest ###
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:microposts) }
  
  # ### see how shoulda matchers make your validation clean and easy ###
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_uniqueness_of(:email) }
 
 
  it { should have_many(:microposts)}
   
  context "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  context "when password is not present" do
    before do
      @user = FactoryGirl.build(:user, name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
end
