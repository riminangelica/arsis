class FixUserIdnum < ActiveRecord::Migration
  def up
  	rename_column :attendances, :user_idnum, :user_id
  end

  def down
  end
end
