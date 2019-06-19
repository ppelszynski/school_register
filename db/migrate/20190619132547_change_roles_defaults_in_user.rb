class ChangeRolesDefaultsInUser < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :roles, []
  end
end
