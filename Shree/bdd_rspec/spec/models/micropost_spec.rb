require 'rails_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = Micropost.new(content: "New Post", user_id: user.id) }

  subject { @micropost }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should be_valid }
  
  describe "when user is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when content is nil" do
    before { @micropost.content = nil }
    it { should_not be_valid }
  end
  
  describe "when content is more than 140 character" do
    before { @micropost.content = "Hello" * 30 }
    it { should_not be_valid }
  end
  
  describe "when content is less than 140 character" do
    before { @micropost.content = "Hello" * 10 }
    it { should be_valid }
  end
  
end