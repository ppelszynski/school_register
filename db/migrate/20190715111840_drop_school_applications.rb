class DropSchoolApplications < ActiveRecord::Migration[5.2]
  def change
    drop_table :school_applications
  end
end
