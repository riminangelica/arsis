class RemoveRoleColumnFromAttendance < ActiveRecord::Migration
  def up
  	remove_column :attendances, :role
  end

  def down
  end
end
