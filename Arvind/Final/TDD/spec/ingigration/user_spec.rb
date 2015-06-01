require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    visit 'users/new'
    sign_up_with 'arvind', 'valid@example.com', 'password'
    expect(page).to have_content('valid@example.com')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid', 'invalid_email', 'password'
    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    sign_up_with 'arvind', 'valid@example.com', ''
    expect(page).to have_content('Sign in')
  end
end


