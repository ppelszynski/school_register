require 'rails_helper'

feature 'school class requests' do
  context 'user is a school admin' do
    scenario 'can not accept application when class is full' do
      school_admin = create(:user, :school_creator)
      school = create(:school, name: 'Example School', admin: school_admin)
      school_class = create(:school_class, school: school, name: 'IT Class', slots: 1)
      create(:user, :student, school_class: school_class)
      create(:school_class_request, user: create(:user, :candidate), school_class: school_class)

      sign_in school_admin

      visit school_school_class_path school, school.school_class

      click_on 'Confirm'

      expect(page).to show_notification 'No more free slots left.'
      expect(page).to have_table_row 'Pending'
    end
  end
end
