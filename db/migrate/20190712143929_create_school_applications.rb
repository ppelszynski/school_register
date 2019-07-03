class CreateSchoolApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :school_applications do |t|
      t.references :school_class, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
