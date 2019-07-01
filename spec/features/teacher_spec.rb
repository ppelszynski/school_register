require 'rails_helper'
include ActiveJob::TestHelper

feature 'teachers' do
  context 'user is an school admin' do
    scenario 'can invite new teacher' do
      school_admin = create(:user, :school_creator)
      school = create(:school, name: 'Example school', admin: school_admin)

      sign_in school_admin

      visit root_path

      click_on 'Schools'
      click_on 'Example school'
      click_on 'Teachers'
      click_on 'Add teacher'

      fill_in 'Email', with: 'teacher@email.com'
      fill_in 'First name', with: 'Zenon'
      fill_in 'Last name', with: 'Martyniuk'

      click_button 'Invite user'

      expect(page).to show_notification('Invitation sent.')

      expect(page).to have_table_row('teacher@email.com')
      expect(page).to have_table_row('unconfirmed')
    end
  end

  context 'user is a teacher' do
    scenario 'must confirm account from email' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)

      clear_emails

      sign_in school_admin

      visit school_teachers_path school

      click_on 'Add teacher'

      fill_in 'Email', with: 'teacher@email.com'
      fill_in 'First name', with: 'Zenon'
      fill_in 'Last name', with: 'Martyniuk'

      perform_enqueued_jobs do
        click_button 'Invite user'
      end

      sign_out school_admin

      email = open_email('teacher@email.com')
      email.click_link('Confirm your email.')

      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Set password'

      expect(page).to show_notification('Your email adress has been successfully confirmed.')
    end
  end
end
