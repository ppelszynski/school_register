require 'rails_helper'

feature 'schools', type: :feature do
  context 'user is an superuser' do
    scenario 'can create school' do
      user = create(:user)

      sign_in user

      visit new_school_path

      fill_in 'Name', with: 'Last School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'statusSelect'

      click_button 'Create school'

      expect(School.last.name).to eq 'Last School'
    end

    scenario 'sees his own schools' do
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
      user = create(:user)
      school = create(:school, name: 'New School' admin_id: user.id)

      sign_in user

      visit edit_school_path school

      fill_in 'Name', with: 'Last School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'statusSelect'

      click_button 'Update school'

      expect(school.last.name).to eq 'Last School'
    end

    scenario 'can delete own school' do
      user = create(:user)

      sign_in user

      visit new_school_path

      fill_in 'Name', with: 'Last School'
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'statusSelect'

      click_button 'Create school'

      expect(School.last.name).to eq 'Last School'
    end
  end
end

# feature 'schools' do
#   context 'when user is an admin' do
#   end

#   context 'when user is not an admin' do
#     scenario 'user can see own schools' do
#       visit root_path
#     end

#     scenario 'user can create a new schoool' do
#     end

#     scenario "user can't close school during school year" do
#     end
#   end
# end

# describe SchoolController do
#   describe '#CREATE' do
#     context 'when user is an admin' do
#       it 'can create a new school' do

#       end
#     end

#     context 'when user is a student' do
#       it 'cannot create a new school' do

#       end
#     end
#   end
# end
