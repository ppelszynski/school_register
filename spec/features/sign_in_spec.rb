require 'rails_helper'

feature 'User sign in', type: :feature do
  scenario 'user can log in' do
    user = create(:user, email: 'user@example.com', password: 'password', password_confirmation: 'password')

    visit new_user_session_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to show_notification('Signed in successfully.')
  end
end
