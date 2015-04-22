require 'spec_helper'

describe Post do
  let(:post) { FactoryGirl.create(:post) }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:content).is_at_least(10) }
  it { should validate_length_of(:content).is_at_most(250) }

  describe "creation" do
    context "valid attributes" do
      it "should be valid" do
        post = FactoryGirl.build(:post)
        post.should be_valid
      end
    end

    context "invalid attributes" do
      it "should not be valid" do
        post = FactoryGirl.build(:post, title: "", content: "")
        post.should_not be_valid
      end
    end
  end
end
