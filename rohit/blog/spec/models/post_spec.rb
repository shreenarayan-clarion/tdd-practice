require 'spec_helper'
describe Post do
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(5) }
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_least(10) }


  it "is invalid without content" do
		post = FactoryGirl.build(:post, content: nil)
		expect(post).to have(2).errors_on(:content)
	end

	it "is invalid without title" do
		post = FactoryGirl.build(:post, title: nil)
		expect(post).to have(2).errors_on(:title)
	end

	it "is valid with a title, description" do
		expect(FactoryGirl.build(:post)).to be_valid
	end
end
