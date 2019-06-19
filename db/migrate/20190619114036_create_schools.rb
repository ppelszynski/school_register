class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :adress
      t.string :phone_number
      t.string :status
      t.boolean :closed

      t.timestamps
    end
  end
end
