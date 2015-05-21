require 'spec_helper'
include CreatePeople

feature "the creation process" do
  scenario "create me" do
    create_people
    expect(page).to have_content 'Person was successfully created.'
    visit person_path(Person.last)
    click_link 'Create post'
    expect(page).to have_content 'New post'
    within("#new_post") do
      fill_in 'post_title', :with => 'First post'
      fill_in 'post_description', :with => 'This is a test. This is a test.'
    end
    click_button 'Create Post'
    expect(page).to have_content 'Post was successfully created.'
  end
end