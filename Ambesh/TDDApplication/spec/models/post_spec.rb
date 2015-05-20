require 'spec_helper'

describe Post do

  describe "database schema" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:content).of_type(:text) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
  
  describe "Associations" do
    it { should belong_to(:user) }
  end
  
  describe "Validations" do
	  it { should validate_presence_of(:title) }
	  it { should ensure_length_of(:title).is_at_least(5) }
	  it { should validate_presence_of(:content) }
	  it { should ensure_length_of(:content).is_at_least(10) }
  end

  describe "creation" do
    context "valid attributes" do
      it "should be valid" do
        post = FactoryGirl.build(:post)
        post.should be_valid
      end
    end

    context "invalid attributes" do
      it "should not be valid" do
        post = FactoryGirl.build(:invalid_post)
        post.should_not be_valid
      end
    end
  end
  
  let(:user) { FactoryGirl.create(:user) }
  before { @post = Post.new(title: Faker::Name.title, content: "This is test", user_id: user.id) }
  subject { @post }

  describe "when content is nil" do
    before { @post.content = nil }
    it { should_not be_valid }
  end

  describe "when content is more than 150 character" do
    before { @post.content = "Hello" * 50 }
    it { should_not be_valid }
  end
end