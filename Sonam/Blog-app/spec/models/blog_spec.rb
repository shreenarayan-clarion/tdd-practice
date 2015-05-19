require 'spec_helper'

describe Blog do
  describe "creation" do
    context "valid attributes" do
      it "should be valid" do
        post = FactoryGirl.build(:blog)
        post.should be_valid
      end
    end

    context "invalid attributes" do
      it "should not be valid" do
        post = FactoryGirl.build(:blog, title: "")
        post.should_not be_valid
      end
    end
  end
  let(:user) { FactoryGirl.create(:user) }
  before { @blog = Blog.new(title: Faker::Name.title, content: "This is test", user_id: user.id) }

  subject { @blog }



  describe "when content is nil" do
    before { @blog.content = nil }
    it { should_not be_valid }
  end

  describe "when content is more than 150 character" do
    before { @blog.content = "Hello" * 50 }
    it { should_not be_valid }
  end

end