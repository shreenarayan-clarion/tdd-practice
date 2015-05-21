require 'spec_helper'
include CreatePeople

feature "the creation process" do
  scenario "create me" do
    visit people_path
    click_link 'New Person'
    within("#new_person") do
      fill_in 'person_name', :with => 'Test user 1'
      fill_in 'person_email', :with => 'test@example.com'
    end
    click_button 'Create Person'
    expect(page).to have_content 'Person was successfully created.'
  end
end

feature "the edit process" do
  scenario "edit me" do
    create_people
    expect(page).to have_content 'Person was successfully created.'
    # visit people_path
    visit edit_person_path(Person.last)
    expect(page).to have_content 'Editing person'
    within(".edit_person") do
      fill_in 'person_name', :with => 'Test user 2'
      fill_in 'person_email', :with => 'test2@example.com'
    end
    click_button 'Update Person'
    expect(page).to have_content 'Person was successfully updated.'
  end
end

feature "the delete process" do
  scenario "delete me" do
    create_people
    expect(page).to have_content 'Person was successfully created.'
    visit people_path
    within all("tr").last do
      accept_alert do
        click_link 'Destroy'
      end
    end
    sleep(3)
    expect(page).to have_content 'Person was successfully deleted.'
  end
end

