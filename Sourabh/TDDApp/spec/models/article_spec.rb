require 'spec_helper'

describe Article do
	context "valid attributes" do
      it "should be valid" do
        article = FactoryGirl.build(:article)
        article.should be_valid
      end

 it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(5) }
  it { should validate_presence_of(:content) }

  it { should ensure_length_of(:content).is_at_least(10) }


  before { @blog = Blog.new(title: Faker::Name.title, content: "This is test", user_id: user.id) }

  subject { @blog }

   it "is invalid without content" do
    article = FactoryGirl.build(:article, content: nil)
    expect(article).to have(2).errors_on(:content)
  end

  it "is invalid without title" do
    article = FactoryGirl.build(:article, title: nil)
    expect(article).to have(2).errors_on(:title)
  end

  it "is valid with a title, description" do
    expect(FactoryGirl.build(:article)).to be_valid
  end


  describe "when content is nil" do
    before { @article.content = nil }
    it { should_not be_valid }
  end

  describe "when content is more than 150 character" do
    before { @article.content = "Hello" * 50 }
    it { should_not be_valid }
  end

end
