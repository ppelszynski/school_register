class RenameUserIdInSchools < ActiveRecord::Migration[5.2]
  def change
    rename_column :schools, :user_id, :admin_id
  end
end
