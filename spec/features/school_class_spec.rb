require 'rails_helper'

feature 'school classes' do
  context 'user is a school admin' do
    scenario 'can create school class' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)

      sign_in school_admin

      visit school_path school

      click_on 'Classes'

      click_on 'New class'

      fill_in 'Name', with: 'Math class'
      fill_in 'Symbol', with: 'IIIA'
      fill_in 'Slots', with: '25'

      click_on 'Create class'

      expect(page).to have_table_row ['Math class', 'IIIA']
      expect(page).to show_notification 'Class created.'
    end

    scenario 'can show school class' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)
      create(:school_class, name: 'Example Class', school: school)

      sign_in school_admin

      visit school_path school

      click_on 'Classes'

      click_on 'Example Class'

      expect(page).to have_css('h1', text: 'Example Class')
    end

    scenario 'can edit school class' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)
      school_class = create(:school_class, name: 'Example Class', symbol: 'IIIA', school: school)

      sign_in school_admin

      visit school_school_class_path school, school_class

      click_on 'Edit'

      fill_in 'Name', with: 'Edited Class'
      fill_in 'Symbol', with: 'IIIB'
      fill_in 'Slots', with: '25'

      click_on 'Update class'

      expect(page).to show_notification 'Edited succesfully.'
      expect(page).to have_table_row ['Edited Class class', 'IIIB']
      expect(page).not_to have_table_row ['Example Class', 'IIIA']
    end

    scenario 'can delete school class' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)
      school_class = create(:school_class, name: 'Example Class', school: school)

      sign_in school_admin

      visit school_school_class_path school, school_class

      click_on 'Delete'

      accept_dialog_box

      expect(page).to show_notification 'Class deleted.'
      expect(page).not_to have_table_row ['Example Class', 'IIIA']
    end

    scenario 'can search pending students' do
      school_admin = create(:user, :school_creator)
      school = create(:school, admin: school_admin)
      school_class_1 = create(:school_class, name: 'Example Class', school: school)
      school_class_2 = create(:school_class, name: 'Another School Class')
      candidate_1 = create(:user, last_name: 'Johnson', city: 'Los Santos')
      candidate_2 = create(:user, last_name: 'Vercetii', city: 'Vice City')
      candidate_3 = create(:user, last_name: 'Bellic', city: 'Liberty City')

      create(:school_class_request, user: candidate_1, school_class: school_class_1)
      create(:school_class_request, user: candidate_2, school_class: school_class_2)
      create(:school_class_request, user: candidate_3, school_class: school_class_2)

      sign_in school_admin

      visit school_school_class_path school, school_class_1

      expect(page).to have_css '#filtered_last_name', text: 'Johnson'
      expect(page).to have_css '#filtered_last_name', text: 'Vercetii'
      expect(page).to have_css '#filtered_last_name', text: 'Bellic'

      fill_in 'q_last_name_cont', with: 'V'
      click_on 'Search'

      expect(page).to have_css '#filtered_last_name', text: 'Vercetii'

      expect(page).not_to have_css '#filtered_last_name', text: 'Johnson'
      expect(page).not_to have_css '#filtered_last_name', text: 'Bellic'

      fill_in 'q_last_name_cont', with: ''
      select 'Liberty City', from: 'q[city_eq]'
      click_on 'Search'

      expect(page).to have_css '#filtered_last_name', text: 'Bellic'
      expect(page).to have_css '#filtered_city', text: 'Liberty City'

      expect(page).not_to have_css '#filtered_city', text: 'Los Santos'
      expect(page).not_to have_css '#filtered_city', text: 'Vice City'
    end
  end
end
