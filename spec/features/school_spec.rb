require 'rails_helper'

feature 'schools' do
  context 'user is an admin' do
    scenario 'can create school' do
      admin = create(:user, :admin)

      sign_in admin

      visit root_path

      click_on 'Schools'
      click_on 'Add school'

      fill_in 'Name', with: 'X'

      click_button 'Create school'

      expect(page).to have_css('li', text: 'Name is too short (minimum is 2 characters)')

      fill_in 'Name', with: 'New School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Create school'

      expect(page).to have_table_row('New School')
      expect(page).to have_table_row('City 1')
      expect(page).to show_notification('School created.')
    end

    scenario 'can see all schools' do
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

      school = create(:school, name: 'New School', admin: user)

      sign_in admin

      visit root_path

      click_on 'Schools'

      expect(page).to have_table_row('New School')

      click_on 'New School'

      click_link 'Edit'

      fill_in 'Name', with: 'Edited School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Update school'

      expect(page).to have_css('h1', text: 'Edited School')

      visit schools_path
    end

    scenario 'can delete any school' do
      admin = create(:user, :admin)
      user = create(:user)

      school = create(:school, name: 'Falling School', admin: user)

      sign_in admin

      visit root_path

      click_on 'Schools'

      expect(page).to have_table_row('Falling School')

      click_on 'Falling School'

      click_link 'Delete'

      accept_alert

      expect(page).to show_notification('School deleted.')
      expect(page).not_to have_table_row('Falling School')
    end
  end

  context 'user is a school admin' do
    scenario 'can create school' do
      user = create(:user, :school_creator)

      sign_in user

      visit schools_path

      click_on 'Add school'

      fill_in 'Name', with: 'My School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'public', from: 'school[status]'

      click_button 'Create school'

      expect(page).to show_notification('School created.')
      expect(page).to have_table_row('My School')
      expect(page).to have_table_row('City 1')
    end

    scenario 'can see only own schools' do
      user = create(:user, :school_creator)
      create(:school, name: 'School 1', admin: user)
      create(:school, name: 'School 2')

      sign_in user

      visit schools_path

      expect(page).to have_table_row('School 1')
      expect(page).not_to have_table_row('School 2')
    end

    scenario 'can show only own school' do
      user = create(:user, :school_creator)

      school_1 = create(:school, name: 'Own School', admin: user)
      school_2 = create(:school)

      sign_in user

      visit school_path school_1

      expect(page).to have_css('h1', text: 'Own School')

      visit school_path school_2

      expect(page).to show_notification('You are not authorized to do this!')
    end

    scenario 'can edit only own school' do
      user = create(:user, :school_creator)

      school_1 = create(:school, name: 'New School', admin: user)
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

    scenario 'can delete only own school' do
      user = create(:user, :school_creator)
      school = create(:school, name: 'My School', admin: user)

      sign_in user

      visit root_path

      click_on 'Schools'
      click_on 'My School'

      click_link 'Delete'

      accept_alert

      expect(page).to show_notification('School deleted.')
      expect(page).not_to have_table_row('Falling School')
    end
  end
end
