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
  end
end
