class ChangeRolesInUser < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :roles, ['owner']
  end
end
