require 'spec_helper'

describe "aticles" do
	before do
    @article = FactoryGirl.create(:article)
	end

  describe "GET /articles" do
    it "display some artcles" do
    	visit articles_path
    	page.should have_content @article.title
    end

    it "CREATE /articles" do
      visit articles_path
      visit new_article_path
    	fill_in 'article[title]', with: 'Karo TDD'
      fill_in 'article[content]', with: 'its TDD practice now'
    	click_button 'Create Article'
    	page.should have_content 'its TDD practice now'
      page.should have_content 'article was successfully created.'
    end
  end

  describe "UPDATE /articles" do
  	it "edits a article" do
  		visit articles_path
  		visit edit_article_path(@article)
  		find_field('article[title]').value.should == @article.title
  		fill_in 'article[title]', with: 'updated article'
  		click_button('Update article')
  		page.should have_content 'updated article'
      page.should have_content 'article was successfully updated.'
  	end

  	it "should not update an empty article" do
  		visit articles_path
      visit edit_article_path(@article)
  		fill_in 'article[title]', with: ''
  		click_button('Update article')
      path = current_path + '/edit'
  		path.should  == edit_article_path(@article)
  		page.should have_content "Title can't be blank"
  	end
  end

  describe "DELETE /articles" do
  	it "should Destroy a article" do
  		visit articles_path
      # save_and_open_page
  		find("#article_#{@article.id}").click_link 'Destroy'
  		page.should have_no_content @article.title
  	end
  end
end
