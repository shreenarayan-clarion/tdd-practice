require 'spec_helper'

describe User do  
  subject { create(:user)} 

  its(:name)  { should == "Sapna Prajapati" }
  its(:email) { should == "sapna.prajapati@clariontechnologies.co.in" }
  it { should_not be_admin }

  it { should validate_length_of(:password).is_at_least(4) }

  describe "presence" do
    subject { User.new(name: "") }
    it { should validate_presence_of(:name) }
  end 

  context "a duplicate email address" do 
    let(:user) { create(:user) }
    subject { build(:user, email: user.email) } 
    it { should_not be_valid } 
  end

  context "a uniq email address" do 
    let(:user) { create(:user) }
    subject { build(:user, email: "sapna@gmail.com") } 
    it { should be_valid } 
  end 

end
