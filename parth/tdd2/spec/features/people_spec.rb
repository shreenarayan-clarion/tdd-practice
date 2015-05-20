require 'spec_helper'


feature "the creation process" do
  scenario "create me" do
    visit people_path
    click_link 'New Person'
    # visit '/people/new'
    within("#new_person") do
      fill_in 'person_name', :with => 'Test user 1'
      fill_in 'person_email', :with => 'test@example.com'
    end
    click_button 'Create Person'
    expect(page).to have_content 'Person was successfully created.'
  end
end

feature "the edit process" do
  background do
    visit people_path
    click_link 'New Person'
    expect(current_path).to eq(new_person_path)
    within("#new_person") do
      fill_in 'person_name', :with => 'Test user 1'
      fill_in 'person_email', :with => 'test@example.com'
    end
    click_button 'Create Person'
  end
  scenario "edit me" do
    visit edit_person_path(Person.last)
    # click_link 'New Person'
    # # visit '/people/new'
    # within("#new_person") do
    #   fill_in 'person_name', :with => 'Test user 1'
    #   fill_in 'person_email', :with => 'test@example.com'
    # end
    # click_button 'Create Person'
    # expect(page).to have_content 'Person was successfully created.'

  end

end