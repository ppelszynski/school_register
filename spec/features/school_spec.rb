require 'rails_helper'

feature 'schools' do
  context 'user is an admin' do
    scenario 'can create school' do
      admin = create(:user, :admin)

      sign_in admin

      visit schools_path

      click_on 'Add school'

      fill_in 'Name', with: 'New School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Create school'

      expect(page).to have_table_row('New School')
      expect(page).to show_notification('School created.')
    end

    scenario 'sees all schools' do
      admin = create(:user, :admin)
      create(:school, name: 'School 1', admin: admin)
      create(:school, name: 'School 2')

      sign_in admin

      visit schools_path

      expect(page).to have_table_row('School 1')
      expect(page).to have_table_row('School 2')
    end

    scenario 'can edit any school' do
      admin = create(:user, :admin)
      user = create(:user)
      school = create(:school, name: 'New School', admin_id: user.id)

      sign_in admin

      visit school_path school

      click_link 'Edit'

      fill_in 'Name', with: 'Edited School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Update school'

      expect(page).to have_css('h1', text: 'Edited School')
    end

    scenario 'can delete any school' do
      admin = create(:user, :admin)
      user = create(:user)

      school = create(:school, name: 'Falling School', admin_id: user.id)

      sign_in admin

      visit school_path school

      click_link 'Delete'

      expect(page).not_to have_css('h1', text: 'Falling School')
    end
  end

  context 'user is a school admin' do
    scenario 'can create school' do
      user = create(:user, :school_admin)

      sign_in user

      visit schools_path

      click_on 'Add school'

      fill_in 'Name', with: 'My School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Create school'

      expect(page).to have_table_row('My School')
      expect(page).to show_notification('School created.')
    end

    scenario 'sees only own schools' do
      user_1 = create(:user, :school_admin)
      user_2 = create(:user, email: 'another@email.com')
      school_1 = create(:school, name: 'School 1', admin_id: user_1.id)
      school_2 = create(:school, name: 'School 2', admin_id: user_2.id)

      sign_in user_1

      visit schools_path

      expect(page).to have_table_row('School 1')
      expect(page).not_to have_table_row('School 2')
    end

    scenario 'can show only own school' do
      user = create(:user, :school_admin)

      school_1 = create(:school, name: 'Own School', admin: user)
      school_2 = create(:school)

      sign_in user

      visit school_path school_1

      expect(page).to have_css('h1', text: 'Own School')

      visit school_path school_2

      expect(page).to show_notification('You are not authorized to do this!')
    end

    scenario 'can edit own school' do
      user = create(:user, :school_admin)
      school_1 = create(:school, name: 'New School', admin_id: user.id)
      school_2 = create(:school)

      sign_in user

      visit school_path school_1

      click_link 'Edit'

      fill_in 'Name', with: 'Edited School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Update school'

      expect(page).to have_css('h1', text: 'Edited School')
      expect(page).to show_notification('Edited succesfully.')

      visit edit_school_path school_2

      expect(page).to show_notification('You are not authorized to do this!')
    end

    scenario 'can delete own school' do
      user = create(:user)
      school = create(:school, admin: user)

      sign_in user

      visit school_path school

      click_link 'Delete'

      expect(page).not_to have_css('h1', text: 'Falling School')
    end
  end
end
