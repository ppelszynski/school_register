require 'rails_helper'

feature 'schools', type: :feature do
  context 'user is an admin' do
    scenario 'can create school' do
      admin = create(:user, :admin)

      sign_in admin

      visit new_school_path

      fill_in 'Name', with: 'New School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'school[status]'

      click_button 'Create school'

      expect(page).to have_css('h1', text: 'New School')
    end

    scenario 'sees all schools' do
      admin = create(:user, :admin)
      user = create(:user, email: 'another@email.com')
      school_1 = create(:school, admin_id: admin.id)
      school_2 = create(:school, admin_id: user.id)

      sign_in admin

      visit schools_path

      expect(page).to have_css('*', text: school_1.name)
      expect(page).to have_css('*', text: school_2.name)
    end

    scenario 'can edit any school' do
      admin = create(:user, :admin)
      user = create(:user)
      school = create(:school, name: 'New School', admin_id: user.id)

      sign_in admin

      visit edit_school_path school

      fill_in 'Name', with: 'Edited School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'school[status]'

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
    context 'with own schools he' do
      scenario 'sees schools' do
        user_1 = create(:user)
        user_2 = create(:user, email: 'another@email.com')
        school_1 = create(:school, admin_id: user_1.id)
        school_2 = create(:school, admin_id: user_2.id)

        sign_in user_1

        visit schools_path

        expect(page).to have_css('*', text: school_1.name)
        expect(page).not_to have_css('*', text: school_2.name)
      end

      scenario 'can edit own school' do
        user = create(:user, :admin)
        school = create(:school, name: 'New School', admin_id: user.id)

        sign_in user

        visit edit_school_path school

        fill_in 'Name', with: 'Edited School'
        fill_in 'Adress', with: 'City 1'
        fill_in 'Phone number', with: '123456789'
        select 'Public', from: 'school[status]'

        click_button 'Update school'

        expect(page).to have_css('h1', text: 'Edited School')
      end

      scenario 'can delete own school' do
        user = create(:user)
        school = create(:school, name: 'Falling School', admin_id: user.id)

        sign_in user

        visit school_path school

        click_link 'Delete'

        expect(page).not_to have_css('h1', text: 'Falling School')
      end
    end

    context 'with other schools' do
      scenario 'can not create school' do
        user = create(:user)

        sign_in user

        visit new_school_path

        expect(page).to have_css('h1', text: 'You are not authorized to edit this school!')
      end

      scenario "can not edit someone else's school" do
        user_1 = create(:user, :admin)
        user_2 = create(:user)
        school = create(:school, name: 'Not mine School', admin_id: user_2.id)

        sign_in user_1

        visit edit_school_path school

        expect(page).to have_css('*', text: 'You are not authorized to edit this school!')
      end

      scenario "can't' delete someone else's school" do
        user_1 = create(:user)
        user_2 = create(:user)

        school = create(:school, name: "Neighbour's School", admin_id: user_2.id)

        sign_in user_1

        visit school_path school

        expect(page).to have_css('*', text: 'You are not authorized to see this school!')
      end
    end
  end
end
