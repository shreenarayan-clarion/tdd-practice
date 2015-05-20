require 'spec_helper'

describe "posts" do
	before do
    @post = FactoryGirl.create(:post)
	end

  describe "GET /posts" do
    it "display some posts" do
    	visit posts_path
    	page.should have_content @post.title
    end

    it "CREATE /posts" do
      visit posts_path
      visit new_post_path
    	fill_in 'post[title]', with: 'go to bed'
      fill_in 'post[content]', with: 'go to work'
    	click_button 'Create Post'
    	page.should have_content 'go to work'
      page.should have_content 'Post was successfully created.'
    end
  end

  describe "UPDATE /posts" do
  	it "edits a post" do
  		visit posts_path
  		visit edit_post_path(@post)
  		find_field('post[title]').value.should == @post.title
  		fill_in 'post[title]', with: 'updated Post'
  		click_button('Update Post')
  		page.should have_content 'updated Post'
      page.should have_content 'Post was successfully updated.'
  	end

  	it "should not update an empty post" do
  		visit posts_path
      visit edit_post_path(@post)
  		fill_in 'post[title]', with: ''
  		click_button('Update Post')
      path = current_path + '/edit'
  		path.should  == edit_post_path(@post)
  		page.should have_content "Title can't be blank"
  	end
  end

  describe "DELETE /posts" do
  	it "should Destroy a post" do
  		visit posts_path
      # save_and_open_page
  		find("#post_#{@post.id}").click_link 'Destroy'
  		page.should have_no_content @post.title
  	end
  end
end