require 'spec_helper'

describe Account do
  

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = Account.new(content: "arv", user_id: user.id) }

  subject { @account }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should be_valid }

  describe "when user is not present" do
    before { @account.user_id = nil }
    it { should_not be_valid }
  end

  describe "when content is nil" do
    before { @account.content = nil }
    it { should_not be_valid }
  end

  describe "when content is more than 140 character" do
    before { @account.content = "Hello" * 30 }
    it { should_not be_valid }
  end

end
