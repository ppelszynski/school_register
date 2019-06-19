require 'rails_helper'

feature 'User can manage schools', type: :feature do
  context 'User creates schools' do
    let(:user) { create(:user) }
    let(:name) { 'Last School' }

    scenario 'correctly creates school' do
      sign_in user

      visit new_school_path

      fill_in 'Name', with: name
      fill_in 'Adress', with: 'City 1'
      fill_in 'Phone number', with: '123456789'
      select 'Public', from: 'statusSelect'

      click_button 'Create school'

      expect(School.last.name).to eq name
    end
  end

  context 'User sees schools', type: :feature do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user, email: "another@email.com") }
    let(:school_1) { create(:school), admin: user_1) }
    let(:school_2) { create(:school), admin: user_2) }

    scenario 'sees his own schools' do
      sign_in user_1

      visit schools_path

      expect(page).to have_css('*', text: school_1.name) 
      expect(page).not_to have_css('*', text: school_2.name) 
    end
  end
end
