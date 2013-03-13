class FixEventrole < ActiveRecord::Migration
  def up
  	rename_column :attendances, :eventrole, :role
  	remove_column :events, :user_id
  end

  def down
  end
end
