require 'rails_helper'

feature 'User sign up', type: :feature do
  scenario 'can sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to show_notification('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')

    expect(page).to show_notification
    expect(User.find_by(email: 'newuser@example.com').has_role?(:school_creator)).to be(true)
  end
end
