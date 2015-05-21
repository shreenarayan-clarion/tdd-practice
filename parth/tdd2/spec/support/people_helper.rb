require 'spec_helper'

module CreatePeople

  def create_people
    visit people_path
    click_link 'New Person'
    current_path.should == new_person_path
    within("#new_person") do
      fill_in 'person_name', :with => FFaker::Name.name
      fill_in 'person_email', :with => FFaker::Internet.email
    end
    click_button 'Create Person'
  end

end
