class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name, null: false, default: ''
      t.string :adress, null: false, default: ''
      t.string :phone_number, null: false, default: ''
      t.string :status, null: false, default: ''
      t.boolean :is_closed, null: false, default: 'false'
      t.references :admin, null: false

      t.timestamps
    end
  end
end
