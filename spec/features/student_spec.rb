require 'rails_helper'

feature 'student' do
  context 'user is a student' do
    scenario 'must create account before applying' do
      school_admin = create(:user, :school_creator)
      create(:school, name: 'Example school', admin: school_admin)

      visit root_path

      click_on 'Apply to schools'

      fill_in 'Email', with: 'student@email.com'
      fill_in 'First name', with: 'Muhammad'
      fill_in 'Last name', with: 'Ali'
      fill_in 'City', with: 'NY'
      fill_in 'Phone number', with: '123456789'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Sign as student'

      expect(page).to show_notification('A message with a confirmation link has been sent to your email address.')

      confirm_candidate

      visit new_user_session_path

      fill_in 'Email', with: 'student@email.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'

      expect(page).to show_notification('Signed in successfully.')
    end

    scenario 'can apply to school' do
      candidate = create(:user, :candidate)
      school_admin = create(:user, :school_creator)
      school = create(:school, name: 'Example School', admin: school_admin)
      school_class = create(:school_class, school: school, name: 'IT Class')

      sign_in candidate

      visit root_path

      click_on 'Apply to schools'
      click_on 'Example School'
      click_on 'Apply'

      accept_dialog_box

      expect(page).to show_notification('Applied successfully.')
    end
  end
end
