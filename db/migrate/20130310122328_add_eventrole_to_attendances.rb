class AddEventroleToAttendances < ActiveRecord::Migration
  def change
  	add_column :attendances, :eventrole, :string
  end
end
