class CreateSchoolClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :school_classes do |t|
      t.string :name, null: false, default: ''
      t.string :symbol, null: false, default: ''
      t.boolean :is_full, null: false, default: 'false'
      t.integer :slots, null: false, default: 30
      t.integer :slots, null: false, default: 30
      t.references :school, null: false
      t.integer :school_year, default: ''
      t.timestamps
    end
  end
end
