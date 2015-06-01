module Features
  module SessionHelpers
    def sign_up_with(user_name, email, password)
      visit '/users/new'
      fill_in 'user_name', with: user_name
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Create my account'
    end

    def sign_in
      user = create(:user)
      visit 'session/new'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Sign in'
    end
  end
end