class ChangeClosedDefaultInSchool < ActiveRecord::Migration[5.2]
  def change
    change_column_default :schools, :closed, false
  end
end
