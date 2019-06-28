require 'rails_helper'

feature 'User sign up', type: :feature do
  scenario 'correctly login user' do
    visit new_user_registration_path

    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(current_path).to eq root_path
    expect(User.find_by(email: 'newuser@example.com').has_role?(:school_admin)).to be(true)
  end
end
