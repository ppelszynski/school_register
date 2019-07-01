require 'rails_helper'

# wywalic i bleedy przetestowacw  schoool feature test
feature 'school form' do
  context 'wrong data is entered' do
    scenario 'correctly display errors' do
      user = create(:user)

      sign_in user

      visit new_schools_path

      fill_in 'Name', with: 'X'

      click_button 'Create school'

      expect(page).to have_css('li', text: 'Name is too short (minimum is 2 characters)')
    end
  end
end
