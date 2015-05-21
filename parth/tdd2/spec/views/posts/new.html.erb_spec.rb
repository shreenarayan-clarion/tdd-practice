require 'spec_helper'

describe "posts/new" do
  before(:each) do
    @person = create(:person)
    @post = @person.posts.create(:title => "MyString", :description => "This is a test. This is a test.")
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", person_posts_path(@person), "post" do
      assert_select "input#post_title[name=?]", "post[title]"
      assert_select "textarea#post_description[name=?]", "post[description]"
    end
  end
end
