require 'rails_helper'

feature 'User sign in', type: :feature do
  scenario 'correctly login user' do
    create(:user)
    visit new_user_session_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    expect(current_path).to eq root_path
  end
end
