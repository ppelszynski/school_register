require 'rails_helper'
include ActiveJob::TestHelper

feature 'teachers' do
  context 'user is an school admin' do
    scenario 'can invite new teacher' do
      admin = create(:user, :school_admin)
      school = create(:school, admin: admin)

      sign_in admin

      visit school_teachers_path school
      click_on 'Add teacher'

      fill_in 'Email', with: 'teacher@email.com'
      fill_in 'First name', with: 'Zenon'
      fill_in 'Last name', with: 'Martyniuk'

      click_button 'Invite user'

      expect(page).to have_table_row('teacher@email.com')
      expect(page).to have_table_row('unconfirmed')
    end
  end

  context 'user is a teacher' do
    scenario 'must confirm account from email' do
      admin = create(:user, :school_admin)
      school = create(:school, admin: admin)
      teacher = create(:user, :teacher, email: 'teacher@email.com', school: school)

      clear_emails

      sign_in admin

      visit school_teachers_path school
      click_on 'Add teacher'

      fill_in 'Email', with: 'teacher@email.com'
      fill_in 'First name', with: 'Zenon'
      fill_in 'Last name', with: 'Martyniuk'

      click_button 'Invite user'

      sign_out admin

      email = open_email('teacher@email.com')
      email.click_link('Confirm your email.')

      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Set password'

      expect(page).to show_notification('Your email adress has been successfully confirmed.')
    end
  end
end
