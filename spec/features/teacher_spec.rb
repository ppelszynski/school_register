require 'rails_helper'

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
  end
end
