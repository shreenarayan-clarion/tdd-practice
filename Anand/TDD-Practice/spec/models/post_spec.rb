require 'spec_helper'

describe Post do
  let(:post) { FactoryGirl.create(:post) }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:content).is_at_least(10) }
  it { is_expected.to validate_length_of(:content).is_at_most(250) }

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
