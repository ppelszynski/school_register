require 'rails_helper'

feature 'User sign in', type: :feature do
  scenario 'correctly login user' do
    user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to show_notification('Signed in successfully.')
  end
end
