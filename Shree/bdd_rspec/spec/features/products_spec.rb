require 'rails_helper'
 
feature 'Create product' do
  let!(:product) { FactoryGirl.create(:product) }
 
  scenario 'with valid parameters' do
    visit products_path
    click_link 'New Product'
    fill_in 'Name', with: product.name
    fill_in 'Price', with: product.price
    click_button 'Create Product'
    expect(page).to have_content "Product was successfully created."
  end

  scenario 'with invalid parameters' do  	
    visit products_path
    click_link 'New Product'
    fill_in 'Name', with: ''
    fill_in 'Price', with: '333'
    click_button 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end
end
